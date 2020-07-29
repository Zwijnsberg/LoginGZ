import 'package:flutter/material.dart';
import 'package:testingchatapp/helper/helperfunctions.dart';
import 'package:testingchatapp/services/auth.dart';
import 'package:testingchatapp/services/database.dart';
import 'package:testingchatapp/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chatroomscreen.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethod authMethod = new AuthMethod();
  DatabaseMethods dbMethods = new DatabaseMethods();

  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapUserInfo;

  signIn(){
    if (formKey.currentState.validate()) //once signing in after validation:
    {
      HelperFunctions.saveUserEmailSharedPreference(emailTEC.text); //we add this user's email to the sharedpreference (global variable)

      // TODO: function to get user details
      setState((){
        isLoading = true; //loading is started and signified to the rest of the program
      });

      dbMethods.getUserByEmail(emailTEC.text).then((val){ //extract the user profile ("name") from the email given in the form of a query
        snapUserInfo = val;
        HelperFunctions.saveUserEmailSharedPreference(snapUserInfo.documents[0].data["name"]);
      });

      authMethod.signInWithEmailAndPassword(emailTEC.text, passwordTEC.text).then((val){ //then we actually try signing in,
        if(val!=null){ //and if signed in succesfully we go on to the Chatroom() screen

          HelperFunctions.saveUserLoggedInSharedPreference(true);

          if (isLoading){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => ChatRoom()
            ));
          }
        }
      });
    }
    else
      {
        print('chickenbutt');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                      null : "Please provide a valid email address.";
                    },
                    controller: emailTEC,
                    style: simpleTextSTyle(),
                    decoration: textFieldInputDecoration("email"),
                    ),
                  TextFormField(
                      obscureText: true, //hides the password typed in
                      validator:  (val){
                        return val.length < 6 ? "Password may not be valid." : null;
                      },
                      controller: passwordTEC,
                      style: simpleTextSTyle(),
                      decoration: textFieldInputDecoration("password")
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {
                    print('waddup homez');
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('Forgot password?',
                        style: simpleTextSTyle())
                  ),
                )
            ),
            SizedBox(
              height: 8.0,
            ),
            GestureDetector(
              onTap: (){
                signIn();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                  colors:[
                    Color.fromRGBO(84, 85, 255, 120),
                    Color.fromRGBO(84, 141, 255, 60)
                    ]
                   ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text('Sign In', style: TextStyle(
                    color: Colors.white,
                    fontSize: 17 ,
                  )),
                )
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors:[
                        const Color(0xff),
                        Color.fromRGBO(84, 141, 255, 80)
                      ]
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text('Sign In with Google', style: TextStyle(
                    color: Colors.white,
                    fontSize: 17 ,
                  )),
                )
            ),
            SizedBox(
              height: 18.0,
            ),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have account? ",
                    style: simpleTextSTyle(),
                  ),
                  GestureDetector(
                      onTap:(){
                        widget.toggle();
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Register now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17 ,
                              decoration: TextDecoration.underline,
                            ),
                          )
                      )
                  )
                ],
              ),
            ),
            SizedBox(
              height: 250,
            )
          ],
        ),
      )
    );
  }
}


