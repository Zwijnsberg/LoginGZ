import 'package:flutter/material.dart';
import 'package:testingchatapp/helper/helperfunctions.dart';
import 'package:testingchatapp/services/auth.dart';
import 'package:testingchatapp/services/database.dart';
import 'package:testingchatapp/views/chatroomscreen.dart';
import 'package:testingchatapp/widgets/widget.dart';


class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;
  AuthMethod authMethod = new AuthMethod(); // this is used to call upon any of the db functions defined in auth.dart
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  var password;
  TextEditingController usernameTEC = new TextEditingController();
  TextEditingController emailTEC = new TextEditingController();
  TextEditingController passwordTEC = new TextEditingController();

  signMeUp () {
    if (formKey.currentState.validate())
      {
        HelperFunctions.saveUserEmailSharedPreference(emailTEC.text);
        HelperFunctions.saveUserNameSharedPreference(usernameTEC.text);

        setState((){
          isLoading = true;
        }
        );//this is where the variables above that are defined below are passed to firebase
      }

    authMethod.signUpWithEmailAndPassword(emailTEC.text, passwordTEC.text).then((val){
      print("$val");
      if (isLoading)
        {
          Map<String,String> userInfoMap = {
            "name" : usernameTEC.text,
            "email": emailTEC.text,
          };

          databaseMethods.addUserInfo(userInfoMap);
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) :
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal:20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField( //TODO: refactor this shit
                    validator: (val) {
                      return val.isEmpty || val.length < 4 ? "Please provide a username with at least 4 characters." : null;
                    },
                    controller: usernameTEC,
                    style: simpleTextSTyle(),
                    decoration: textFieldInputDecoration("username"),
                  ),
                  TextFormField(
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                      null : "Please provide a valid email address.";
                    },
                    controller: emailTEC,
                    style: simpleTextSTyle(),
                    decoration: textFieldInputDecoration("email")
                  ),
                  TextFormField(
                      obscureText: true, //hides the password typed in
                      validator:  (val){
                        password = val;
                        return val.length < 6 ? "Please enter a password with at least 6 characters" : null;
                      },
                      style: simpleTextSTyle(),
                      decoration: textFieldInputDecoration("password")
                  ),
                  TextFormField(
                      obscureText: true, //hides the password typed in
                      validator: (val) {
                        return password == val? null : "Password does not match";
                      },
                      controller: passwordTEC, //write an if statement here, for if it equates the above string
                      style: simpleTextSTyle(),
                      decoration: textFieldInputDecoration("confirm password")
                  ),
                ],
              )
            ),
            SizedBox(
              height: 24.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            GestureDetector(
              onTap: (){
                signMeUp();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors:[
                          Color.fromRGBO(84, 85, 255, 120),
                          Color.fromRGBO(84, 141, 255, 60)  //const Color(0xff2A75BC),
                        ]
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('Sign Up', style: TextStyle(
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
                        Color.fromARGB(195, 68, 113, 255),
                      ]
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text('Sign Up with Google', style: TextStyle(
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
                    "Already have an account? ",
                    style: simpleTextSTyle(),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Text(
                          "Sign in now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17 ,
                            decoration: TextDecoration.underline,
                          )
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

