import 'package:family/screens/forgot_password_screen.dart';
import 'package:family/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: Color(0xFF03DAC6),
          onSecondary: Colors.black,
          error: Color(0xFFB00020),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        primaryColor: primaryColor,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.urbanist(
            color: titleTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          titleMedium: GoogleFonts.urbanist(
            color: titleTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
          titleSmall: GoogleFonts.urbanist(
            color: titleTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
          bodyMedium: GoogleFonts.urbanist(
            color: bodyTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
          ),
        ),
        useMaterial3: true,
      ),
      home: const ForgotPasswordScreen(),
    );
  }
}
