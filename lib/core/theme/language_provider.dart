import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// Supported Locales
const localeEnglish = Locale('en', 'US');
const localeBangla = Locale('bn', 'BD');

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final languageCode = prefs.getString('languageCode');
    if (languageCode == 'bn') {
      return localeBangla;
    }
    return localeEnglish;
  }

  void setLocale(Locale locale) {
    state = locale;
    ref
        .read(sharedPreferencesProvider)
        .setString('languageCode', locale.languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);

// Simple Localization Map for demo purposes
// In a real app, use intl or easy_localization package
final translations = {
  'en': {
    'settings': 'Settings',
    'account': 'Account',
    'security': 'Security',
    'notifications': 'Notification Settings',
    'appSettings': 'App Settings',
    'darkMode': 'Dark Mode',
    'language': 'Language',
    'fontSize': 'Font Size',
    'about': 'About',
    'privacyPolicy': 'Privacy Policy',
    'termsOfService': 'Terms of Service',
    'appVersion': 'App Version',
    'logOut': 'Log Out',
    'logOutConfirmation': 'Are you sure you want to log out?',
    'cancel': 'Cancel',
    'confirmLogOut': 'Log Out',
    'featureComingSoon': 'This feature is coming soon.',
    // Menu & Home
    'menu': 'Menu',
    'viewProfile': 'View Profile',
    'general': 'General',
    'schoolInfo': 'School Info',
    'gallery': 'Gallery',
    'events': 'Events',
    'staff': 'Teachers',
    'academic': 'Academic',
    'routine': 'Routine',
    'syllabus': 'Syllabus',
    'calendar': 'Calendar',
    'books': 'Books',
    'attendance': 'Attendance',
    'results': 'Results',
    'communication': 'Communication',
    'notices': 'Notices',
    'messages': 'Messages',
    'feedback': 'Feedback',
    'admissionFees': 'Admission & Fees',
    'fees': 'Fees',
    'admission': 'Admission',
    'quickAccess': 'QUICK ACCESS',
    'upcomingClasses': 'Upcoming Classes',
    'recentNotices': 'Recent Notices',
    'seeAll': 'See All',
    'viewAll': 'View All',
    'goodMorning': 'Good Morning,',
    'goodAfternoon': 'Good Afternoon,',
    'goodEvening': 'Good Evening,',
    'more': 'More',
    // Profile
    'digitalId': 'Digital ID',
    'editProfile': 'Edit Profile',
    'academicInfo': 'Academic Information',
    'class': 'Class',
    'section': 'Section',
    'rollNumber': 'Roll Number',
    'session': 'Session',
    'personalDetails': 'Personal Details',
    'bloodGroup': 'Blood Group',
    'dob': 'Date of Birth',
    'fatherName': 'Father\'s Name',
    'motherName': 'Mother\'s Name',
    'contactInfo': 'Contact Information',
    'phone': 'Phone',
    'email': 'Email',
    'address': 'Address',
    'gender': 'Gender',
  },
  'bn': {
    'settings': 'সেটিংস',
    'account': 'অ্যাকাউন্ট',
    'security': 'নিরাপত্তা',
    'notifications': 'নোটিফিকেশন সেটিংস',
    'appSettings': 'অ্যাপ সেটিংস',
    'darkMode': 'ডার্ক মোড',
    'language': 'ভাষা',
    'fontSize': 'ফন্ট সাইজ',
    'about': 'সম্পর্কে',
    'privacyPolicy': 'গোপনীয়তা নীতি',
    'termsOfService': 'সেবার শর্তাবলী',
    'appVersion': 'অ্যাপ সংস্করণ',
    'logOut': 'লগ আউট',
    'logOutConfirmation': 'আপনি কি নিশ্চিত যে আপনি লগ আউট করতে চান?',
    'cancel': 'বাতিল',
    'confirmLogOut': 'লগ আউট',
    'featureComingSoon': 'এই ফিচারটি শীঘ্রই আসছে।',
    // Menu & Home
    'menu': 'মেনু',
    'viewProfile': 'প্রোফাইল দেখুন',
    'general': 'সাধারণ',
    'schoolInfo': 'স্কুল তথ্য',
    'gallery': 'গ্যালারি',
    'events': 'ইভেন্ট',
    'staff': 'শিক্ষক',
    'academic': 'একাডেমিক',
    'routine': 'রুটিন',
    'syllabus': 'সিলেবাস',
    'calendar': 'ক্যালেন্ডার',
    'books': 'বই',
    'attendance': 'উপস্থিতি',
    'results': 'ফলাফল',
    'communication': 'যোগাযোগ',
    'notices': 'নোটিস',
    'messages': 'বার্তা',
    'feedback': 'মতামত',
    'admissionFees': 'ভর্তি ও ফি',
    'fees': 'ফি',
    'admission': 'ভর্তি',
    'quickAccess': 'কুইক এক্সেস',
    'upcomingClasses': 'আসন্ন ক্লাস',
    'recentNotices': 'সাম্প্রতিক নোটিস',
    'seeAll': 'সব দেখুন',
    'viewAll': 'সব দেখুন',
    'goodMorning': 'শুভ সকাল,',
    'goodAfternoon': 'শুভ অপরাহ্ন,',
    'goodEvening': 'শুভ সন্ধ্যা,',
    'more': 'আরও',
    // Profile
    'digitalId': 'ডিজিটাল আইডি',
    'editProfile': 'প্রোফাইল সম্পাদন',
    'academicInfo': 'একাডেমিক তথ্য',
    'class': 'ক্লাস',
    'section': 'সেকশন',
    'rollNumber': 'রোল নম্বর',
    'session': 'সেশন',
    'personalDetails': 'ব্যক্তিগত তথ্য',
    'bloodGroup': 'রক্তের গ্রুপ',
    'dob': 'জন্ম তারিখ',
    'fatherName': 'পিতার নাম',
    'motherName': 'মাতার নাম',
    'contactInfo': 'যোগাযোগের তথ্য',
    'phone': 'ফোন',
    'email': 'ইমেইল',
    'address': 'ঠিকানা',
    'gender': 'লিঙ্গ',
  },
};

String t(WidgetRef ref, String key) {
  final locale = ref.watch(localeProvider);
  final langCode = locale.languageCode == 'bn' ? 'bn' : 'en';
  return translations[langCode]?[key] ?? key;
}
