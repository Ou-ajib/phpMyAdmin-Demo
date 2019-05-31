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
  var d;
  PersistentBottomSheetController t;

  final formKey = GlobalKey<FormState>();
  String _title;
  String _subtitle;

  _validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      _insertData();
    } 
  }

  _insertData(){
    print(_title);
    print(_subtitle);
  }


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

  _buildTextField(hint, label){
    return TextFormField(
      maxLength: 255,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5)
        ),
      ),
      validator: (value) => value.isEmpty ? "$label can't be empty!!" : null,
      onSaved: (newValue){
        if(label == 'Title') _title = newValue;
        else _subtitle = newValue;
      },
    );
  }

  _buildForm(){
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            _buildTextField('enter title...', 'Title'),
            _buildTextField('enter subtitle...', 'Subtitle'),
            RaisedButton(
              color: Colors.blue,
              child: Text('Submit', style: TextStyle(color: Colors.white),),
              onPressed: () => _validateAndSave(),
            ),
          ],
        ),
      ),
    );
  }

  _buildBottomSeet(context){
    t = showBottomSheet(
      context: context,
      builder: (ctx){
        return Container(
          height: 300,
          width: double.infinity,
          color: Colors.grey[200],
          child: _buildForm(),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('phpMyAdmin Demo'),
      ),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _getData(),
            builder: (context, snap){
              if(snap.hasError) return Text('error');
              else if(!snap.hasData) return Text('loading');
              return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (context, i){
                  return ListTile(
                    title: Text(snap.data[i]['title']),
                    subtitle: Text(snap.data[i]['subtitle']),
                  );
                },
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  return FloatingActionButton(
                    tooltip: 'Add',
                    child: Icon(Icons.add),
                    onPressed: () {
                      _buildBottomSeet(context);
                    },
                  );
                }
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: Builder(
      //   builder: (context) {
      //     return FloatingActionButton(
      //       tooltip: 'Add',
      //       child: Icon(Icons.add),
      //       onPressed: () {
      //         _buildBottomSeet(context);
      //       },
      //     );
      //   }
      // ),
    );
  }
}
