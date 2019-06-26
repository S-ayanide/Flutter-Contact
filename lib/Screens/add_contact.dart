import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import '../Model/contact.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String _firstName = '';
  String _lastName = '';
  String _photoUrl = 'empty';
  String _email = '';
  String _address = '';
  String _phone = '';

  saveContact(BuildContext context) async {
    if(
      _firstName.isNotEmpty && _lastName.isNotEmpty && _phone.isNotEmpty && _email.isNotEmpty && 
      _address.isNotEmpty
    ){
      Contact contact = Contact(this._firstName,this._lastName,this._phone,this._email,this._address,this._photoUrl);

      await _databaseReference.push().set(contact.toJson());
      navigateToLastScreen(context);
    } else {
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Empty Fields"),
            content: Text("Please fill all the fields"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        } 
      );
    }
  }

  navigateToLastScreen(context){
    Navigator.of(context).pop();
  }

  Future pickImage() async{
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200.0,
      maxWidth: 200.0
    );
    String fileName = basename(file.path);
    uploadImage(file, fileName);
  }

  void uploadImage(File file,String fileName) async{
    StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
    storageReference.putFile(file).onComplete.then((firebaseFile) async{
      var downloadUrl = await firebaseFile.ref.getDownloadURL();

      setState(() {
        _photoUrl = downloadUrl;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF0F1),
      appBar: AppBar(
        backgroundColor: Color(0xFF30336B),
        title: Text("Add Contact"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: GestureDetector(
                  onTap: (){
                    this.pickImage();
                  },
                  child: Center(
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _photoUrl == "empty"
                          ? AssetImage("assets/logo.png")
                          : NetworkImage(_photoUrl),
                        )
                      ),
                    ),
                  ),
                )
              ),
              Container(
                margin: EdgeInsets.only(top:10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    setState(() {
                      _firstName = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    setState(() {
                      _lastName = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    setState(() {
                      _phone = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    setState(() {
                      _email = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Your Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    setState(() {
                      _address = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Your Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                  color: Colors.black,
                  child: Text('Save', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),),
                  onPressed: (){
                    saveContact(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}