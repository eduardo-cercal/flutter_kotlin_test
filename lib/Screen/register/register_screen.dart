import 'package:flutter/material.dart';
import 'package:teste_flutter_kotlin/Screen/register/components/custom_register_field.dart';

import 'components/custom_cep_field.dart';
import 'components/custom_cpf_field.dart';
import 'components/custom_view_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                const CustomCpfField(title: "CPF*"),
                const CustomRegisterField(title: "Nome*"),
                const CustomCepField(
                  title: "CEP*",
                  value: '',
                ),
                const CustomViewField(
                  title: "Bairro",
                  value: '',
                ),
                const CustomViewField(
                  title: "Endereço",
                  value: '',
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
                    onPressed: () async{
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
}
