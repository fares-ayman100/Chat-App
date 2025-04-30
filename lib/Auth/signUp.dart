import 'package:chat_app/Auth/Login.dart';
import 'package:chat_app/Widgets/customButton.dart';
import 'package:chat_app/Widgets/customLogo.dart';
import 'package:chat_app/Widgets/customTextFormField.dart';
import 'package:chat_app/bloc/auth/auth_bloc.dart';
import 'package:chat_app/helper/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  static String id = 'SignUp';

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is SignupLoading) {
          Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SignupSuccess) {
          Navigator.pushNamed(context, LoginPage.id);
        }
        if (state is SignupFailuer) {
          ShowSnackBar(context, state.errMessage);
        }
      }, builder: (context, state) {
        return Container(
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                          BlocProvider.of<AuthBloc>(context).add(SignUpEvent(
                              email: email.text, password: password.text));
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginPage.id);
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
        );
      }),
    );
  }
}
