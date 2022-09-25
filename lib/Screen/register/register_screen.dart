import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teste_flutter_kotlin/Screen/home/home_screen.dart';
import 'package:teste_flutter_kotlin/Screen/register/components/custom_register_field.dart';
import 'package:teste_flutter_kotlin/helpers/constants.dart';
import 'package:http/http.dart' as http;
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
  bool loading = false;

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
                  function: () async =>
                      await _existsRegister(cpf.text, context),
                  stringFunction: (String value) async =>
                      await _existsRegister(value, context),
                  loading: loading,
                ),
                CustomRegisterField(
                  title: "Nome*",
                  controller: name,
                  loading: loading,
                ),
                CustomCepField(
                  title: "CEP*",
                  controller: cep,
                  function: _getCep,
                  stringFunction: (String value) async => _getCep(),
                  loading: loading,
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
                    onPressed: _isValid()
                        ? () async {
                            await _insertRegister();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          }
                        : null,
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

  Future _existsRegister(String text, BuildContext context) async {
    setState(() => loading = true);

    final exists =
        await kotlinResources.invokeMethod("existRegister", {"cpf": text});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: exists["id"] == 0 ? Colors.blue : Colors.red,
        duration: const Duration(seconds: 2),
        content: Text(
            exists["id"] == 0
                ? "Sem registro para esse cpf"
                : "Cpf no registro de ${exists["name"]}",
            textAlign: TextAlign.center),
      ),
    );
    setState(() {
      if (exists["id"] != 0) {
        cpf.clear();
      }
      loading = false;
    });
  }

  Future<void> _getCep() async {
    setState(() => loading = true);
    final clearCep = cep.text.replaceAll(RegExp('[.-]'), "");

    final response =
        await http.get(Uri.parse("http://viacep.com.br/ws/$clearCep/json/"));
    final result = jsonDecode(response.body);

    if(result["erro"]!=null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          content: Text(
              "CEP não existe",
              textAlign: TextAlign.center),
        ),
      );
    }

    setState(() {
      if (result["erro"] == null) {
        district.text = result["bairro"];
        address.text = result["logradouro"];
      }
      loading = false;
    });
  }

  Future<void> _insertRegister() async {
    final Map<String, dynamic> map = {
      "name": name.text,
      "cpf": cpf.text,
      "cep": cep.text,
      "district": district.text,
      "address": address.text
    };

    await kotlinResources.invokeMethod("insertRegister", map);
  }

  bool _isValid() {
    return name.text.isNotEmpty &&
        cpf.text.isNotEmpty &&
        cep.text.isNotEmpty &&
        district.text.isNotEmpty &&
        address.text.isNotEmpty;
  }
}
