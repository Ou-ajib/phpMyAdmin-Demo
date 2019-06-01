import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddDataPage extends StatefulWidget {
  final String id;
  AddDataPage({this.id});
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final formKey = GlobalKey<FormState>();

  String _title;

  String _subtitle;

  _validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      if(widget.id == null)_insertData();
      else _updateData();
      form.reset();
    } 
  }

  _updateData(){
    String url = 'http://localhost/phpWithFlutter/update.php';
    http.post(url,body: {
      'id': widget.id,
      'title': _title,
      'subtitle': _subtitle,
    });
  }
  _insertData(){
    String url = 'http://localhost/phpWithFlutter/add.php';
    http.post(url,body: {
      'title': _title,
      'subtitle': _subtitle,
    });
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

  Widget _buildForm(){
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
              child: Text(widget.id == null ? 'Add' : 'Edit', style: TextStyle(color: Colors.white),),
              onPressed: () => _validateAndSave(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? 'Add Data' : 'Update Data'),
      ),
      body: _buildForm(),
    );
  }
}