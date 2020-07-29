import 'package:flutter/material.dart';
import 'package:testingchatapp/helper/authenticate.dart';
import 'package:testingchatapp/services/auth.dart';
import 'package:testingchatapp/views/signin.dart';
import 'package:testingchatapp/views/signup.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 140),
          Container(
            child: Center(
              child: Text(
                  'The app starts here.',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(84, 141, 255, 10),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  )
              ),
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: Container(
                width: 150,
                height: 60,
                child: GestureDetector(
                  onTap: () {
                    AuthMethod().signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => Authenticate()  //TODO: make this SignIn() when you figure out how to add the toggle function as argument
                    ));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors:[
                              Color.fromRGBO(254, 255, 223, 20),
                              Color.fromRGBO(168, 188, 255, 20),
                            ]
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text('Sign Out', style: TextStyle(
                          color: Colors.black,
                          fontSize: 17 ,
                          decoration: TextDecoration.none,
                        )),
                      )
                  ),
                ),
            ),
          )
        ]
    ),);
  }
}


