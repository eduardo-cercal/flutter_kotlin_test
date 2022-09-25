import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_flutter_kotlin/Screen/home/components/custom_list_tile.dart';

import '../../helpers/constants.dart';
import '../register/register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de registros"),
        centerTitle: true,
      ),
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.blue,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RegisterScreen()));
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          iconSize: 40,
        ),
      ),
      body: FutureBuilder<List>(
          future: _getData(),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return Card(
                      child: ExpansionTile(
                        title: Text(
                          item["name"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children: [
                          CustomListTile(
                              text: item["cpf"], icon: Icons.book_outlined),
                          CustomListTile(
                              text: item["cep"],
                              icon: Icons.location_on_outlined),
                          CustomListTile(
                              text: item["address"],
                              icon: Icons.maps_home_work_outlined),
                          CustomListTile(
                              text: item["district"], icon: Icons.map_outlined),
                        ],
                        onExpansionChanged: (expanded) => setState(() {

                        }),
                      ),
                    );
                  })
              : const Center(child: CircularProgressIndicator())),
    );
  }

  Future<List> _getData() async {
    try {
      final List list = await kotlinResources.invokeMethod("getList");

      return list;
    } catch (e) {
      return [];
    }
  }
}
