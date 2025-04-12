import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zyptopulse/layout_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   bool isDarkMode = false;

  final String _themeKey = 'isDarkMode';

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  // Load saved theme preference from SharedPreferences.
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool(_themeKey) ?? false;
    });
  }

  // Toggle theme and save preference.
  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = !isDarkMode;
      prefs.setBool(_themeKey, isDarkMode);
    });
  }

  // Configure routes using GoRouter.
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
      GoRoute(path: '/home', builder: (context, state) => const LayoutScreen()),

    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(

      title: 'ZyptoPulse',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:zyptopulse/screens/home_screen.dart';
// import 'package:zyptopulse/screens/splashscreen.dart';
// import 'package:zyptopulse/theme/app_theme.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   bool isDarkMode = false;
//   final String _themeKey = 'isDarkMode';
//
//   @override
//   void initState() {
//     super.initState();
//     _loadThemePreference();
//   }
//
//   // Load saved theme preference from SharedPreferences.
//   Future<void> _loadThemePreference() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isDarkMode = prefs.getBool(_themeKey) ?? false;
//     });
//   }
//
//   // Toggle theme and save preference.
//   Future<void> _toggleTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isDarkMode = !isDarkMode;
//       prefs.setBool(_themeKey, isDarkMode);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Theme Toggle with SharedPreferences',
//       debugShowCheckedModeBanner: false,
//       theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
//       home: SplashScreen(isDarkMode: isDarkMode,toggleTheme: _toggleTheme,)
//     );
//   }
// }

