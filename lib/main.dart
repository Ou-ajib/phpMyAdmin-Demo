import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:php_myadmin_demo/add_update_page.dart';

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
  var d;
  PersistentBottomSheetController t;


  @override
  void initState() { 
    super.initState();
    _getData();
  }
  
  _getData() async{
    http.Response response = await http.get('http://localhost/phpWithFlutter/get.php');
    // http.Response response = await http.get('http://phpmyadminwithflutter.000webhostapp.com/get.php');
    final data = json.decode(response.body);
    return data;
  }

  _deleteData(id){
    String url = 'http://localhost/phpWithFlutter/delete.php';
    http.post(url,body: {
      'id': id,
    }).then((_){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('phpMyAdmin Demo'),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snap){
          if(snap.hasError) return Text('error');
          else if(!snap.hasData) return Text('loading');
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (context, i){
              return ListTile(
                title: Text(snap.data[i]['title']),
                subtitle: Row(
                  children: <Widget>[
                    Text(snap.data[i]['subtitle']),
                    Expanded(child: Container(),),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue,),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=> AddDataPage(id: snap.data[i]['id']))
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => _deleteData(snap.data[i]['id']),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> AddDataPage())
        ),
      ),
    );
  }
}
