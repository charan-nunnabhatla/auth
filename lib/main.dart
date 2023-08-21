import 'dart:math';

import 'package:authlogin/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:authlogin/pages/sign_in_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

bool isSignedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ambwimfzohlxgfdaytvv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFtYndpbWZ6b2hseGdmZGF5dHZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTIyNDE5ODgsImV4cCI6MjAwNzgxNzk4OH0.vrpS8Mag2zH_RpD6RlC1ZnrShg-EVwxAYOl6u2Jij7o',
  );

  Supabase.instance.client.auth.onAuthStateChange.listen((event) {
    if (event == AuthChangeEvent.signedIn) {
      isSignedIn = true;
    } else {
      isSignedIn = false;
    }
  });

  runApp(const AuthPage());
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isSignedIn ? const HomePage() : const SignInHomePage(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      themeAnimationCurve: Curves.easeIn,
      themeAnimationDuration: const Duration(milliseconds: 1500),
    );
  }
}
