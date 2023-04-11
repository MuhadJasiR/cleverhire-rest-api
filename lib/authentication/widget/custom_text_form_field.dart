import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 119, 253, 124),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextFormField(
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ),
    ));
  }
}
