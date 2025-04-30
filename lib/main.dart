import 'package:chat_app/Auth/signUp.dart';
import 'package:chat_app/Auth/Login.dart';
import 'package:chat_app/Views/chat_page.dart';
import 'package:chat_app/bloc/auth/auth_bloc.dart';
import 'package:chat_app/cubit/chat/chat_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(
    const ChatApp(),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => AuthBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            LoginPage.id: (context) => LoginPage(),
            SignUp.id: (context) => SignUp(),
            HomePage.id: (context) => HomePage(),
          },
          initialRoute: FirebaseAuth.instance.currentUser != null
              ? HomePage.id
              : LoginPage.id),
    );
  }
}
