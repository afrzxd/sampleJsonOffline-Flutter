import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data["items"];
      print("jumlah item : ${_items.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Json Offline'),
        ),
        body: Column(
          children: [
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            key: ValueKey(_items[index]["id"].toString()),
                            margin: const EdgeInsets.all(10),
                            color: Colors.amber.shade100,
                            child: ListTile(
                              leading: Text(_items[index]["id"].toString()),
                              title: Text(_items[index]["nama"]),
                              subtitle: Text(_items[index]["deskripsi"]),
                            ),
                          );
                        }))

                    /* Test Data pakai button*/
                    )
                : ElevatedButton(
                    onPressed: () {
                      readJson();
                    },
                    child: const Center(
                      child: Text('Load Data'),
                    ),
                  ),
          ],
        ));
  }
}
