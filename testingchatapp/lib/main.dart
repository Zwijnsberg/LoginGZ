import 'package:flutter/material.dart';
import 'package:testingchatapp/helper/authenticate.dart';
import 'package:testingchatapp/views/chatroomscreen.dart';
import 'package:testingchatapp/views/signup.dart';
import 'helper/helperfunctions.dart';
import 'views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() { //the app starts, this function is called to check whether we need to log in or are already logged in
    // TODO: implement initState
    super.initState();
  }

  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((val){
      setState(() {
        userIsLoggedIn = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo',
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        home: userIsLoggedIn!= null ? userIsLoggedIn ? ChatRoom() : Authenticate() : Authenticate(),
    );
  }
}





