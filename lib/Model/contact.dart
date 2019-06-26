import 'package:firebase_database/firebase_database.dart';

class Contact{

  String _id;
  String _firstName;
  String _lastName;
  String _phone;
  String _photoUrl;
  String _email;
  String _address;

  Contact(this._firstName,this._lastName,this._phone,this._email,this._address,this._photoUrl);
  Contact.withId(this._id,this._firstName,this._lastName,this._phone,this._email,this._address,this._photoUrl);

  //Adding getters
  String get id => this._id;
  String get firstName => this._firstName;
  String get lastName => this._lastName;
  String get phone => this._phone;
  String get address => this._address;
  String get email => this._email;
  String get photoUrl => this._photoUrl;

  //Adding Setters
  set firstName(String firstName){
    this._firstName = firstName;
  }
  set lastName(String lastName){
    this._lastName = lastName;
  }
  set phone(String phone){
    this._phone = phone;
  }
  set address(String address){
    this._address = address;
  }
  set email(String email){
    this._email = email;
  }
  set photoUrl(String photoUrl){
    this._photoUrl = photoUrl;
  }

  Contact.fromSnapshot(DataSnapshot snapshot){
    this._id = snapshot.key;
    this._firstName = snapshot.value['firstName'];
    this._lastName = snapshot.value['lastName'];
    this._phone = snapshot.value['phone'];
    this._email = snapshot.value['email'];
    this._photoUrl = snapshot.value['photoUrl'];
    this._address = snapshot.value['address'];
  }

  Map<String,dynamic> toJson() {
    return{
      "firstName": _firstName,
      "lastName": _lastName,
      "phone": _phone,
      "address": _address,
      "email": _email,
      "photoUrl": _photoUrl,
    };
  }
}