import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  final String hint;
  final bool? enable;
  final bool? passCheck;

  final void Function(String?)? onSave;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  CustomTextFormField({
    this.controller,
    required this.text,
    required this.hint,
    required this.onSave,
    required this.validator,
    this.enable,
    this.passCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: text,
            fontsize: 20,
            color: Colors.black,
          ),
          TextFormField(
            obscureText: passCheck == true ? true : false,
            enabled: enable,
            controller: controller,
            onSaved: onSave,
            validator: validator,
            decoration: InputDecoration(
              errorStyle:
                  const TextStyle(fontFamily: 'Comfortaa-bold', fontSize: 14),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              fillColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
