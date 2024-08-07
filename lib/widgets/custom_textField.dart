import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Function(String)? onChanged;
  String? Function(String?)? validator;
  String? hintText;
  bool isPassword;
   CustomTextField(this.hintText,this.onChanged,[this.validator,this.isPassword=false]);

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      obscureText: isPassword,

       style: const TextStyle(color: Colors.white),


      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )

      ),
    );
  }
}
