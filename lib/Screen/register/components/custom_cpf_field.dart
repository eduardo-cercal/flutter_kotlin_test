import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_flutter_kotlin/helpers/constants.dart';

class CustomCpfField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final void Function(String value) stringFunction;
  final VoidCallback function;
  final bool loading;

  const CustomCpfField(
      {Key? key,
      required this.title,
      required this.controller,
      required this.function,
      required this.stringFunction,
      required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SizedBox(
                width: mediaData.width * 0.62,
                child: TextField(
                  enabled: !loading,
                  onSubmitted:  stringFunction,
                  controller: controller,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter()
                  ],
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
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
                onPressed: !loading ? function : null,
                child: !loading
                    ? const Icon(Icons.search)
                    : const CircularProgressIndicator(),
              )
            ],
          )
        ],
      ),
    );
  }
}
