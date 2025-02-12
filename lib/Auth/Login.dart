import 'package:chat_app/Auth/signUp.dart';
import 'package:chat_app/Views/home_page.dart';
import 'package:chat_app/Widgets/customButton.dart';
import 'package:chat_app/Widgets/customLogo.dart';
import 'package:chat_app/Widgets/customTextFormField.dart';
import 'package:chat_app/helper/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      'Login',
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
                    obsecure: true,
                    icon: const Icon(Icons.lock),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: MaterialButton(
                      onPressed: () {},
                      child: const Text(
                        'Forget Password?',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  CustomMaterialButton(
                    title: 'Login',
                    icon: const Icon(
                      Icons.login,
                      color: Colors.white,
                      size: 22,
                    ),
                    onpressed: () async {
                      if (formkey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                          Navigator.pushReplacementNamed(context, HomePage.id,arguments: email.text);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                            ShowSnackBar(context, 'This Email is not exist');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                            ShowSnackBar(context, 'The Password Is Wrong');
                          }
                        }
                      } else {}
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'OR Login with',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          color: Colors.white,
                          onPressed: () {},
                          child: Image.asset(
                            'assets/facebook.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          color: Colors.white,
                          onPressed: () {},
                          child: Image.asset(
                            'assets/google.jpeg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          color: Colors.white,
                          onPressed: () {},
                          child: Image.asset(
                            'assets/apple.png',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(SignUp.id);
                    },
                    child: const Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: 'Dont\'t have an account?  ',
                            style: TextStyle(fontSize: 20),
                          ),
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                                fontSize: 22,
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
}
