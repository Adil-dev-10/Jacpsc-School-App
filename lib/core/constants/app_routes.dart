/// Route path constants used for navigation.
class AppRoutes {
  AppRoutes._();

  // Public Routes (Pre-Login)
  static const String splash = '/';
  static const String publicHome = '/public';
  static const String publicAdmissions = '/public/admissions';
  static const String publicResults = '/public/results';
  static const String publicGallery = '/public/gallery';
  static const String publicNotices = '/public/notices';
  static const String publicContact = '/public/contact';
  static const String publicFaculty = '/public/faculty';
  static const String login = '/login';

  // App Routes (Post-Login)
  static const String appHome = '/app';
  static const String profile = '/app/profile';
  static const String settings = '/app/settings';
  static const String notices = '/app/notices';
  static const String messages = '/app/messages';
  static const String menu = '/app/menu';

  // Academic Routes
  static const String routine = '/app/routine';
  static const String calendar = '/app/calendar';
  static const String attendance = '/app/attendance';
  static const String syllabus = '/app/syllabus';
  static const String books = '/app/books';
  static const String results = '/app/results';

  // Financial Routes
  static const String fees = '/app/fees';

  // Gallery & Info Routes
  static const String gallery = '/app/gallery';
  static const String about = '/app/about';
  static const String contact = '/app/contact';
  static const String teachersStaff = '/app/teachers-staff';
}
