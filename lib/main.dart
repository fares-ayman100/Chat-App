import 'package:chat_app/Auth/signUp.dart';
import 'package:chat_app/Auth/Login.dart';
import 'package:chat_app/Views/home_page.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ChatApp(),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => const LoginPage(),
          SignUp.id: (context) => const SignUp(),
          HomePage.id: (context) => HomePage(),
        },
        initialRoute: FirebaseAuth.instance.currentUser != null
            ? HomePage.id
            : LoginPage.id);
  }
}
