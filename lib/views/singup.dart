import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reto_login_sqlite/Models/user.dart';
import 'package:reto_login_sqlite/Models/DB.dart';

class signUp extends StatefulWidget {
  signUp({Key key}) : super(key: key);

  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController controllerUser;
  TextEditingController controllerPassword;
  TextEditingController controllerGmail;

  @override
  void initState() {
    super.initState();
    controllerPassword = new TextEditingController();
    controllerUser = new TextEditingController();
    controllerGmail = new TextEditingController();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerUser.dispose();
    controllerGmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      //body
      body: Container(
        color: Colors.white,
        height: size.height * 1,
        width: size.width * 1,
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: CircleAvatar(
                    radius: 50,
                    child: IconButton(
                      iconSize: 80,
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      onPressed: () => setState(() {
                        controllerPassword.clear();
                        controllerUser.clear();
                        controllerGmail.clear();
                      }),
                    ),
                  ),
                ),
              ]),

              //User input
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50, 10, 50, 5),
                child: TextField(
                    controller: controllerUser,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        labelText: 'User',
                        icon: Icon(Icons.person))),
              ),

              //Password input
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50, 5, 50, 0),
                child: TextField(
                    controller: controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        //hintText: "ss",
                        labelText: 'Password',
                        icon: Icon(Icons.lock))),
              ),

              //Gmail
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50, 5, 50, 0),
                child: TextField(
                 
                    controller: controllerGmail,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        labelText: 'Gmail',
                        icon: Icon(Icons.person))),
              ),

              //Button Login
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(100, 10, 100, 10),
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign up",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )
                    ],
                  ),
                  onPressed: () {
                    if (controllerGmail.text.isNotEmpty &&
                        controllerPassword.text.isNotEmpty &&
                        controllerUser.text.isNotEmpty) {
                      final user = User(
                        gmail: controllerGmail.text,
                        userName: controllerUser.text,
                        password: controllerPassword.text,
                      );
                      db.instance.create(user);
                      
                      Navigator.of(context).pop();

                    } else {
                      Fluttertoast.showToast(
                          msg: "Check the text fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                ),
              ),

              Divider(
                height: 15,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
