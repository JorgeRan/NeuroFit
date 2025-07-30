import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neurofit_app/core/constants/constants.dart';
import 'package:neurofit_app/features/home/presentation/screens/home_screens.dart';
import 'package:neurofit_app/shared/presentation/screens/navigation_screen.dart';
import 'package:neurofit_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:neurofit_app/features/auth/presentation/screens/signUp_screen.dart';
import 'package:neurofit_app/features/onboarding/presentation/screens/info/welcome_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kLightGrey,
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: NavigationScreen(),
    );
  }
}
