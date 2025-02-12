import 'package:chat_app/Auth/Login.dart';
import 'package:chat_app/Views/home_page.dart';
import 'package:chat_app/Widgets/customButton.dart';
import 'package:chat_app/Widgets/customLogo.dart';
import 'package:chat_app/Widgets/customTextFormField.dart';
import 'package:chat_app/helper/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
  static String id = 'SignUp';
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 15),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const CustomLogo(),
                  const Center(
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: 'Enter Your Email',
                    controler: email,
                    icon: const Icon(Icons.email),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: 'Enter Your Password',
                    controler: password,
                    icon: const Icon(Icons.visibility),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMaterialButton(
                    title: 'SignUp',
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 22,
                    ),
                    onpressed: () async {
                      if (formkey.currentState!.validate()) {
                        try {
                          await registerMethod();
                          Navigator.pushReplacementNamed(context, LoginPage.id,
                              arguments: email.text);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('Your password is too weak');
                            ShowSnackBar(context, 'Your password is too weak');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                            ShowSnackBar(context,
                                'The account already exists for that email.');
                          }
                        }
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(LoginPage.id);
                    },
                    child: const Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'You Have An Account?  ',
                            style: TextStyle(fontSize: 17),
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerMethod() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
  }
}
