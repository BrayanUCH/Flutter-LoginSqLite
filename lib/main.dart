import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reto_login_sqlite/Models/DB.dart';
import 'package:reto_login_sqlite/Models/user.dart';
import 'package:reto_login_sqlite/views/homePage.dart';
import 'package:reto_login_sqlite/views/singup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOGIN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage("LOGIN"),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  String titulo;

  MyHomePage(this.titulo);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerUser;
  TextEditingController controllerPassword;

  @override
  void initState() {
    super.initState();
    controllerPassword = new TextEditingController();
    controllerUser = new TextEditingController();
  }

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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

              //forgot the password
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 5),
                child: TextButton(
                  onPressed: () => print("password " +
                      controllerPassword.text +
                      "--Usuer " +
                      controllerUser.text),
                  child: const Text(
                    "Forgot the password? Click here",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              //Button Login
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(100, 10, 100, 10),
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.login_sharp,
                        size: 35,
                        color: Colors.black,
                      ),
                      Text(
                        " Login",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )
                    ],
                  ),
                  onPressed: () async {
                    if (controllerPassword.text.isNotEmpty &&
                        controllerUser.text.isNotEmpty) {
                      final user = User(
                        userName: controllerUser.text,
                        password: controllerPassword.text,
                      );
                      
                      User userr = await db.instance.read(user);
                      if (userr != null && userr.password == controllerPassword.text) {
                        
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => homePage()));
                      }else{
                        Fluttertoast.showToast(
                          msg: "Check yours credentials",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Check the text fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                ),
              ),

              Divider(
                height: 15,
              ),

              //Button Sign up
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(50, 10, 50, 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => signUp()));
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ),
              //divicion
              Divider(
                height: 20,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
