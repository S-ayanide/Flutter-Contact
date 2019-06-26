import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'add_contact.dart';
import 'view_contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  navigateToAddScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return AddContact();
    }));
  }

  navigateToViewScreen(id){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return ViewContact(id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF99AAAB),
      appBar: AppBar(
        backgroundColor: Color(0xFF30336B),
        title: Text('Your Contacts'),
      ),
      body: Container(
        child: FirebaseAnimatedList(
          query: _databaseReference,
          itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index){
            return GestureDetector(
              onTap: (){
                navigateToViewScreen(snapshot.key);
              },
              child: Card(
                color: Color(0xFFEAF0F1),
                elevation: 3.0,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: snapshot.value['photoUrl'] == "empty"
                            ? AssetImage("assets/logo.png")
                            : NetworkImage(snapshot.value['photoUrl'])
                          )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 10.0,
                                ),
                                Text('${snapshot.value['firstName']} ${snapshot.value['lastName']}', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0
                                    ),),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 10.0,
                                ),
                                Text('${snapshot.value['phone']}',),
                              ],
                            )
                          ],
                        ),
                        // child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: <Widget>[
                        //     Row(
                        //       children: <Widget>[
                        //         Icon(Icons.person),
                        //         Container(
                        //           width: 10.0,
                        //         ),
                        //         Text('${snapshot.value['firstName']} ${snapshot.value['lastName']}', style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 17.0
                        //         ),),
                        //       ],
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.all(5.0),
                        //     ),
                        //     Row(
                        //       children: <Widget>[
                        //         Icon(Icons.phone_iphone),
                        //         Container(
                        //           width: 10.0,
                        //         ),
                        //         Text('${snapshot.value['phone']}'),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: navigateToAddScreen,
      ),
    );
  }
}