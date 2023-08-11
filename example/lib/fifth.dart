import 'dart:convert';

import 'package:example/Models/userComplex.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FifthExample extends StatefulWidget {
  const FifthExample({super.key});

  @override
  State<FifthExample> createState() => _FifthExampleState();
}

class _FifthExampleState extends State<FifthExample> {
  Future<UserComplex> getProuctApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/12c00846-877d-4dc4-ab28-99be33984bab'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return UserComplex.fromJson(data);
    } else {
      return UserComplex.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Api Complex')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
              child: FutureBuilder<UserComplex>(
            future: getProuctApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(snapshot.data!.data![index].shop!.name
                                .toString()),
                            subtitle: Text(snapshot
                                .data!.data![index].shop!.shopemail
                                .toString()),
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data!.data![index].shop!.image
                                    .toString())),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width * 1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data![index].images!.length,
                                itemBuilder: (context, position) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                          snapshot.data!.data![index]
                                              .images![position].url
                                              .toString(),
                                        ))),
                                  );
                                },
                              ),
                            ),
                          ),
                          Icon(snapshot.data!.data![index].inWishlist == true
                              ? Icons.favorite
                              : Icons.favorite_outline)
                        ],
                      );
                    });
              } else {
                return Text('Loading');
              }
            },
          ))
        ]),
      ),
    );
  }
}
