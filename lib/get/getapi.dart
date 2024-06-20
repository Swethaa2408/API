import 'dart:convert';
import 'package:api/get/modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class getapi extends StatefulWidget {
  const getapi({super.key});

  @override
  State<getapi> createState() => _getapiState();
}

class _getapiState extends State<getapi> {

  Future<Agify> fetch() async {
    var result = await http.get(Uri.parse("https://api.agify.io?name=meelad"));
    return Agify.fromJson(jsonDecode(result.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(), 
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.count.toString()),
                      Text(snapshot.data!.name.toString()),
                      Text(snapshot.data!.age.toString()),

                    ],
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}






