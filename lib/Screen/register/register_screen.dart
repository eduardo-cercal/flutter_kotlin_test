import 'package:flutter/material.dart';
import 'package:teste_flutter_kotlin/Screen/register/components/custom_register_field.dart';

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
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.all(mediaData.longestSide * 0.03),
            child: Column(
              children: [
                const CustomRegisterField(title: "CPF*", value: ""),
                const CustomRegisterField(title: "Nome*", value: ""),
                const CustomRegisterField(title: "CEP*", value: ""),
                const CustomRegisterField(title: "Bairro*", value: ""),
                const CustomRegisterField(title: "Endereço*", value: ""),
                SizedBox(height: mediaData.height*0.01),
                ElevatedButton(onPressed: (){}, child: Text("Registrar"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
