import 'package:flutter/material.dart';

import 'package:grocery_app/screens/SignIN/viewmodel.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import 'package:grocery_app/signup/viewmodel.dart';

class MySignup extends StatefulWidget {
  const MySignup({Key key}) : super(key: key);

  @override
  _MySignupState createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
  final _formKey = GlobalKey<FormState>();
  String phone, password, name;
  SignupViewModel signinvm = SignupViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  onSaved: (value) => name = value,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Name",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  onSaved: (value) => phone = value,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Phone number",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onSaved: (value) => password = value,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: () async {
                            _formKey.currentState.save();
                            Map<String, dynamic> requestData =
                                <String, dynamic>{
                              "name": name,
                              "phone": phone,
                              "password": password,
                            };
                            await signinvm.signUp(requestData);

                            if (signinvm.success) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          WelcomeScreen()),
                                  (route) => false);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: new Text("Oops!"),
                                        content: new Text(signinvm.error),
                                        actions: <Widget>[
                                          // usual  ly buttons at the bottom of the dialog
                                          new FlatButton(
                                            child: new Text("Close"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ]);
                                  });
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Colors.orangeAccent,
                                  Colors.orangeAccent
                                ])),
                            child: Center(
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
