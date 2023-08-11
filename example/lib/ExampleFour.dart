import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  var data;
  Future<void> getUserApi() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api fetching withouth using plugin")),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUserApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              } else {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(children: [
                          ReUsableRow(
                              title: 'name',
                              value: data[index]['name'].toString()),
                          ReUsableRow(
                              title: 'userName',
                              value: data[index]['username'].toString()),
                          ReUsableRow(
                              title: 'adress',
                              value:
                                  data[index]['address']['street'].toString()),
                          ReUsableRow(
                              title: 'geo',
                              value: data[index]['address']['geo']['lng']
                                  .toString())
                        ]),
                      );
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  ReUsableRow({super.key, required this.title, required this.value});
  String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}
