import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomCepField extends StatefulWidget {
  final String title;
  final String value;

  const CustomCepField({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  State<CustomCepField> createState() => _CustomCepFieldState();
}

class _CustomCepFieldState extends State<CustomCepField> {
  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SizedBox(
                width: mediaData.width * 0.3,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter()
                  ],
                  initialValue: widget.value,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: mediaData.width * 0.05,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.resolveWith(
                    (states) =>
                        Size(mediaData.width * 0.13, mediaData.height * 0.07),
                  ),
                  shape: MaterialStateProperty.resolveWith(
                    (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Icon(Icons.search),
              )
            ],
          )
        ],
      ),
    );
  }
}
