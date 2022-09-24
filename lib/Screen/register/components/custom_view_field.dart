import 'package:flutter/material.dart';

class CustomViewField extends StatefulWidget {
  final String title;
  final String value;

  const CustomViewField({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  State<CustomViewField> createState() => _CustomViewFieldState();
}

class _CustomViewFieldState extends State<CustomViewField> {
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
            enabled: false,
            initialValue: widget.value,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
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
