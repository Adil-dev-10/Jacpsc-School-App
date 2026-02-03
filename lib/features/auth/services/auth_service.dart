import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- User Model ---
class User {
  final String id;
  final String name;
  final String role; // 'student', 'teacher', 'staff'
  final String? profileImage;

  User({
    required this.id,
    required this.name,
    required this.role,
    this.profileImage,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'role': role,
    'profileImage': profileImage,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    role: json['role'],
    profileImage: json['profileImage'],
  );
}

// --- Auth State ---
class AuthState {
  final bool isLoading;
  final User? user;
  final String? error;

  AuthState({this.isLoading = false, this.user, this.error});

  bool get isAuthenticated => user != null;

  AuthState copyWith({bool? isLoading, User? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error, // Clear error if not provided
    );
  }
}

// --- Auth Controller (Riverpod 3.x Notifier) ---
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  static const _userKey = 'auth_user';

  @override
  AuthState build() {
    // Initialize with loading state and check session
    _checkSession();
    return AuthState(isLoading: true);
  }

  Future<void> _checkSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userString = prefs.getString(_userKey);
      if (userString != null) {
        state = AuthState(user: User.fromJson(jsonDecode(userString)));
      } else {
        state = AuthState(isLoading: false);
      }
    } catch (e) {
      state = AuthState(isLoading: false);
    }
  }

  Future<void> login(String id, String password, String userType) async {
    state = state.copyWith(isLoading: true, error: null);

    // Mock API Delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock Validation (Allow any password for demo)
    if (id.isNotEmpty && password.isNotEmpty) {
      final user = User(
        id: id,
        name: userType == 'student' ? 'Tanvir Ahmed' : 'Teacher Name',
        role: userType,
        profileImage: 'https://i.pravatar.cc/300', // Placeholder
      );

      // Persist
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(user.toJson()));

      state = AuthState(user: user);
    } else {
      state = state.copyWith(isLoading: false, error: 'Invalid ID or Password');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    state = AuthState(); // Reset state
  }
}
