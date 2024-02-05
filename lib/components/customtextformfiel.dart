import 'package:flutter/material.dart';

class customTextForm extends StatelessWidget {
  final hint, controller;
  final String? Function(String?)? valid;
  const customTextForm(
      {super.key,
      required this.hint,
      required this.controller,
      required this.valid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
