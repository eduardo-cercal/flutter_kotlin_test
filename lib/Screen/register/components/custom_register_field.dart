import 'package:flutter/material.dart';

class CustomRegisterField extends StatefulWidget {
  final String title;
  final String value;

  const CustomRegisterField({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  State<CustomRegisterField> createState() => _CustomRegisterFieldState();
}

class _CustomRegisterFieldState extends State<CustomRegisterField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            initialValue: widget.value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
