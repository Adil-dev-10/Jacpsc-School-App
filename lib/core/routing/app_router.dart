import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/services/auth_service.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/public_landing_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/communication/screens/notices_screen.dart';
import '../../features/communication/screens/messenger_screen.dart';
import '../../features/communication/screens/feedback_screen.dart';
import '../../features/communication/screens/feedback_thankyou_screen.dart';
import '../../features/communication/screens/chat_conversation_screen.dart';
import '../../features/communication/screens/new_message_screen.dart';
import '../../features/communication/screens/create_new_group_screen.dart';
import '../../features/communication/screens/add_contact_screen.dart';
import '../../features/navigation/screens/menu_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/academic/screens/class_routine_screen.dart';
import '../../features/academic/screens/attendance_screen.dart';
import '../../features/academic/screens/academic_calendar_screen.dart';
import '../../features/academic/screens/syllabus_screen.dart';
import '../../features/academic/screens/result_screen.dart';
import '../../features/payment/screens/fees_screen.dart';
import '../../shared/screens/feature_in_progress_screen.dart';
import '../../features/public/screens/public_admission_screen.dart';
import '../../features/public/screens/public_result_screen.dart';
import '../../features/public/screens/public_gallery_screen.dart';
import '../../features/public/screens/public_notices_screen.dart';
import '../../features/public/screens/public_contact_screen.dart';
import '../../features/public/screens/public_faculty_screen.dart';
import '../../shared/screens/public_info_screen.dart';
import '../../features/academic/screens/book_list_screen.dart';
import '../../features/info/screens/about_screen.dart';
import '../../features/info/screens/staff_screen.dart';
import '../../features/info/screens/gallery_screen.dart';
import '../../features/info/screens/contact_screen.dart';
import '../../features/academic/screens/admission_info_screen.dart';
import '../../features/academic/screens/admission_result_screen.dart';

import '../../shared/widgets/app_bottom_nav_bar.dart';

// Global Key for Push over Bottom Nav
final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: _AuthListenable(ref),
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final isLoginRoute = state.uri.toString() == '/login';
      final isLandingRoute = state.uri.toString() == '/landing';
      final isSplashRoute = state.uri.toString() == '/';
      final isPublicRoute = state.uri.toString().startsWith('/public');

      // If not authenticated, allow splash, landing, login, and public routes
      if (!isAuthenticated) {
        if (isSplashRoute || isLandingRoute || isLoginRoute || isPublicRoute) {
          return null;
        }
        return '/landing';
      }

      // If authenticated, redirect splash/login/landing to home
      if (isSplashRoute || isLoginRoute || isLandingRoute) {
        return '/app/home';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/landing',
        builder: (context, state) => const PublicLandingScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

      // Public Pages (Accessible before login)
      GoRoute(
        path: '/public/admissions',
        builder: (context, state) => const PublicAdmissionScreen(),
      ),
      GoRoute(
        path: '/public/results',
        builder: (context, state) => const PublicResultScreen(),
      ),
      GoRoute(
        path: '/public/gallery',
        builder: (context, state) => const PublicGalleryScreen(),
      ),
      GoRoute(
        path: '/public/notices',
        builder: (context, state) => const PublicNoticesScreen(),
      ),
      GoRoute(
        path: '/public/contact',
        builder: (context, state) => const PublicContactScreen(),
      ),
      GoRoute(
        path: '/public/faculty',
        builder: (context, state) => const PublicFacultyScreen(),
      ),

      GoRoute(
        path: '/public/about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/public/events',
        builder: (context, state) => const PublicInfoScreen(
          title: 'Events',
          subtitle: 'Upcoming Activities',
          icon: Icons.event,
          color: Colors.orange,
          bgColor: Color(0xFFFFF7ED),
        ),
      ),

      // Authenticated Routes with Bottom Nav
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/notices',
                builder: (context, state) => const NoticesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/messages',
                builder: (context, state) => const MessengerScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/menu',
                builder: (context, state) => const MenuScreen(),
              ),
            ],
          ),
        ],
      ),

      // Other Authenticated Routes (Pushed on top of Shell)
      GoRoute(
        path: '/app/profile',
        parentNavigatorKey: rootNavigatorKey, // Push over shell
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/app/settings', // Assuming menu links to this
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/app/chat/:chatId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final chatId = state.pathParameters['chatId'] ?? '';
          final title = state.uri.queryParameters['title'] ?? 'Chat';
          return ChatConversationScreen(chatId: chatId, chatTitle: title);
        },
      ),
      GoRoute(
        path: '/app/new-message',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const NewMessageScreen(),
      ),
      GoRoute(
        path: '/app/new-group',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const CreateNewGroupScreen(),
      ),
      GoRoute(
        path: '/app/add-contact',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const AddContactScreen(),
      ),

      // Academic & Fees Routes
      GoRoute(
        path: '/app/routine',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ClassRoutineScreen(),
      ),
      GoRoute(
        path: '/app/attendance',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AttendanceScreen(),
      ),
      GoRoute(
        path: '/app/syllabus',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SyllabusScreen(),
      ),
      GoRoute(
        path: '/app/results',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const ResultScreen(),
      ),
      GoRoute(
        path: '/app/fees',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const FeesScreen(),
      ),

      // Placeholders for remaining menu items
      GoRoute(
        path: '/app/about',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const AboutScreen(),
      ),
      GoRoute(
        path: '/app/gallery',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const GalleryScreen(),
      ),
      GoRoute(
        path: '/app/events',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const AcademicCalendarScreen(),
      ),
      GoRoute(
        path: '/app/staff',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const StaffScreen(),
      ),
      GoRoute(
        path: '/app/feedback',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const FeedbackScreen(),
      ),
      GoRoute(
        path: '/app/feedback/thankyou',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const FeedbackThankYouScreen(),
      ),
      GoRoute(
        path: '/app/calendar',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const AcademicCalendarScreen(),
      ),
      GoRoute(
        path: '/app/books',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const BookListScreen(),
      ),
      GoRoute(
        path: '/app/contact',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const ContactScreen(),
      ),
      GoRoute(
        path: '/app/feedback',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const FeatureInProgressScreen(title: 'Feedback'),
      ),
      GoRoute(
        path: '/app/admission',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const AdmissionInfoScreen(),
      ),
      GoRoute(
        path: '/app/admission-result',
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const AdmissionResultScreen(),
      ),
    ],
  );
});

// Helper to convert Riverpod state change to Listenable for GoRouter
class _AuthListenable extends ChangeNotifier {
  final Ref ref;
  _AuthListenable(this.ref) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      notifyListeners();
    });
  }
}
