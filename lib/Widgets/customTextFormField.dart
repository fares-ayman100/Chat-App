import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.controler,
      required this.icon,
      this.obsecure = false});
  final String hintText;
  final TextEditingController controler;
  final Icon icon;
  final bool? obsecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      obscureText: obsecure!,
      controller: controler,
      decoration: InputDecoration(
        prefixIcon: icon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color.fromARGB(255, 118, 112, 112), fontSize: 18),
        filled: true,
        fillColor: Colors.grey[250],
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(60),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(60),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
