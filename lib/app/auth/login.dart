import 'package:flutter/material.dart';
import 'package:flutter_notes_api/components/crud.dart';
import 'package:flutter_notes_api/components/customtextformfiel.dart';
import 'package:flutter_notes_api/components/valid.dart';
import 'package:flutter_notes_api/constant/Links.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_notes_api/main.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  GlobalKey<FormState> myformkey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  Crud crud = Crud();
  bool isloading = false;
  Login() async {
    isloading = true;
    Future.delayed(Duration(seconds: 8));
    if (myformkey.currentState!.validate()) {
      var response = await crud
          .postrequest(linkLogin, {"password": pass.text, "email": email.text});
      isloading = false;
      setState(() {});
      if (response['status'] == "success") {
        sharedpref.setString("id", response["data"]["id"].toString());
        sharedpref.setString(
            "username", response["data"]["username"].toString());
        sharedpref.setString(
            "password", response["data"]["password"].toString());
        sharedpref.setString("email", response["data"]["email"].toString());
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            title: "Alert",
            body: Text("Email or Password Invalid,Please Try Again"))
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: isloading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(children: [
                Form(
                  key: myformkey,
                  child: Column(
                    children: [
                      Image.asset(
                        "images/login.jpg",
                        width: 200,
                        height: 200,
                      ),
                      customTextForm(
                        hint: "Enter your email",
                        controller: email,
                        valid: (val) {
                          return validInput(val!, 25, 5);
                        },
                      ),
                      customTextForm(
                        hint: "Enter your password",
                        controller: pass,
                        valid: (val) {
                          return validInput(val!, 15, 5);
                        },
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await Login();
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                        child: Text("Login"),
                      ),
                      Container(
                        height: 10,
                      ),
                      InkWell(
                        child: Text("Sign Up"),
                        onTap: () {
                          Navigator.pushNamed(context, "/signup");
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
