// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final String lable;
  final bool hidePassword;

  const InputText({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.lable,
    required this.hidePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hidePassword,
      controller: controller,
      decoration: InputDecoration(
        label: Text(lable),
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
