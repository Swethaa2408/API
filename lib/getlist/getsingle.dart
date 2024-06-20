import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal.dart';
class getSingle extends StatefulWidget {
  final int id;
  const getSingle({super.key, required this.id});

  @override
  State<getSingle> createState() => _getSingleState();
}

class _getSingleState extends State<getSingle> {

  Future<Products> fetchdata() async {
    final int id1= widget.id;
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products/$id1"));
    return Products.fromJson(jsonDecode(res.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetchdata(),
              builder: (BuildContext context,snapshot){
                if(snapshot.hasData){
                  return  ListTile(
                    leading:  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(snapshot.data!.image!),fit: BoxFit.fill
                          )
                      ),
                    ),
                    title: Column(
                      children: [
                        Text(snapshot.data!.id!.toString()),
                        Text(snapshot.data!.title!.toString()),
                        Text(snapshot.data!.category!.toString()),
                        Text(snapshot.data!.description!.toString()),
                        Text(snapshot.data!.price!.toString()),
                        Text(snapshot.data!.rating!.rate.toString()),
                        Text(snapshot.data!.rating!.count.toString()),
                      ],
                    ),
                  );
                } else if(snapshot.hasError){
                  return Text("error");
                } return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
