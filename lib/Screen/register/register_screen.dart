import 'package:flutter/material.dart';
import 'package:teste_flutter_kotlin/Screen/register/components/custom_register_field.dart';
import 'package:teste_flutter_kotlin/constants.dart';

import 'components/custom_cep_field.dart';
import 'components/custom_cpf_field.dart';
import 'components/custom_view_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController cpf = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController cep = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaData = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de pessoa"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => _customAlertDialog(),
              );
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.all(mediaData.longestSide * 0.03),
            child: Column(
              children: [
                CustomCpfField(
                  title: "CPF*",
                  controller: cpf,
                  function: () async => await _existsRegister(cpf.text),
                  stringFunction: (String value) async =>
                      await _existsRegister(value),
                ),
                CustomRegisterField(
                  title: "Nome*",
                  controller: name,
                ),
                CustomCepField(
                  title: "CEP*",
                  controller: cep,
                  function: () {},
                ),
                CustomViewField(
                  title: "Bairro",
                  controller: district,
                ),
                CustomViewField(
                  title: "Endereço",
                  controller: address,
                ),
                SizedBox(height: mediaData.height * 0.01),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.resolveWith(
                        (states) =>
                            Size(mediaData.width, mediaData.height * 0.07),
                      ),
                    ),
                    onPressed: () async {
                      kotlinResources.invokeMethod("insertRegister");
                      Navigator.of(context).pop();
                    },
                    child: const Text("Registrar"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customAlertDialog() => AlertDialog(
        title: const Text("Descartar Registro?"),
        content: const Text(
            "Essa ação irá descartar o registro atual, deseja confirmar ?"),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop, child: const Text("Não")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                "Sim",
                style: TextStyle(color: Colors.red),
              )),
        ],
      );

  Future _existsRegister(String text) async {
    final exits = await kotlinResources.invokeMethod("existRegister");

    print(exits);
  }
}
