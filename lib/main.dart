import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJSON();
  print(_data[1]["title"]);
  for (int i = 0; i < _data.length; i++) {
    print("Title: ${_data[i]["title"]}");
  }

  runApp(MaterialApp(
      home: Scaffold(
    appBar: AppBar(
      title: Text("JSON parsing"),
      backgroundColor: Colors.orange,
    ),
    body: ListView.builder(
        itemCount: _data.length,
        padding: const EdgeInsets.all(4.4),
        itemBuilder: (BuildContext context, int position) {
          return Column(
            children: <Widget>[
              Divider(
                height: 3.4,
              ),
              ListTile(
                title: Text(" ${_data[position]["title"]}"),
                subtitle: Text(" ${_data[position]["body"]}"),
                leading: CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: Text(_data[position]["title"][0]),
                ),
                onTap: ()=> showTapMessage(context, _data[position]["title"]),
              )
            ],
          );
        }),
  )));
}

void showTapMessage(BuildContext context, String message) {
  var alertDialog = AlertDialog(
    title: Text(message),
    actions: <Widget>[
      FlatButton(
        onPressed: ()=>Navigator.of(context).pop(),
        child: Text("Ok"),
      )
    ],
  );
  showDialog(context: context, builder:(context){
    return alertDialog;
  });
}

Future<List> getJSON() async {
  String apiURL = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(apiURL);
  return json.decode(response.body);
}
