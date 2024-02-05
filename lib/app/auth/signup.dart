import 'package:flutter/material.dart';
import 'package:flutter_notes_api/components/crud.dart';
import 'package:flutter_notes_api/components/customtextformfiel.dart';
import 'package:flutter_notes_api/components/valid.dart';
import 'package:flutter_notes_api/constant/Links.dart';

class singup extends StatefulWidget {
  const singup({super.key});

  @override
  State<singup> createState() => _singupState();
}

class _singupState extends State<singup> {
  Crud _crud = Crud();
  GlobalKey<FormState> myformkey = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isloading = false;

  Singup() async {
    if (myformkey.currentState!.validate()) {
      isloading = true;
      print(linkSignup);
      var response = await _crud.postrequest(linkSignup, {
        "username": username.text,
        "password": pass.text,
        "email": email.text
      });
      isloading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/success", (route) => false);
      } else {
        print("Signup Fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(children: [
                Form(
                  key: myformkey,
                  child: Column(
                    children: [
                      Image.asset(
                        "images/signup.jpg",
                        width: 200,
                        height: 200,
                      ),
                      customTextForm(
                        hint: "Enter your username",
                        controller: username,
                        valid: (val) {
                          return validInput(val!, 15, 5);
                        },
                      ),
                      customTextForm(
                        hint: "Enter your email",
                        controller: email,
                        valid: (val) {
                          return validInput(val!, 25, 10);
                        },
                      ),
                      customTextForm(
                        hint: "Enter your password",
                        controller: pass,
                        valid: (val) {
                          return validInput(val!, 20, 6);
                        },
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await Singup();
                          print("signup pressed");
                        },
                        color: Colors.green,
                        textColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                        child: Text("Sign Up"),
                      ),
                      Container(
                        height: 10,
                      ),
                      InkWell(
                        child: Text("Login"),
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                      )
                    ],
                  ),
                ),
              ]),
            ),
    );
  }
}
