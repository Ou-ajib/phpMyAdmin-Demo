import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'phpMyAdmin Demo',
  home: MyHomePage(),
));


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title;

  @override
  void initState() { 
    super.initState();
    _getData();
  }
  
  _getData() async{
    http.Response response = await http.get('http://phpmyadminwithflutter.000webhostapp.com/get.php');
    final data = json.decode(response.body);
    // print(data);
    setState(() => title = data['title']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('phpMyAdmin Demo'),
      ),
      body: Center(
        child: Text(title??'Loading...'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
