import 'package:flutter/material.dart';

Widget defaultFormField({

  required String hintText,
  required Widget? sufix,
  required TextInputType keyboardType,
  required TextEditingController controller,
  required Function validate,

})
=>
    TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 14.0),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 1.0,
            color:  Color.fromRGBO(0, 61, 45, 1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 1.0,
            color:  Color.fromRGBO(0, 61, 45, 1),
          ),


        ),
        suffixIcon: sufix,
      ),
      controller: controller,
      validator: (String? value)
      {
        return validate(value);
      },
      keyboardType: keyboardType,
    );