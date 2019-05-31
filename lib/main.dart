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
  var d;
  @override
  void initState() { 
    super.initState();
    _getData();
  }
  
  _getData() async{
    http.Response response = await http.get('http://localhost/phpWithFlutter/get.php');
    final data = json.decode(response.body);
    setState(() {
      d = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('phpMyAdmin Demo'),
      ),
      body: ListView.builder(
        itemCount: d == null ? 0 : d.toList().length,
        itemBuilder: (context, i){
          return ListTile(
            title: Text(d[i]['title']??''),
            subtitle: Text(d[i]['subtitle']??''),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
