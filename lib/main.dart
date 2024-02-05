import 'package:flutter/material.dart';
import 'package:flutter_notes_api/app/auth/login.dart';
import 'package:flutter_notes_api/app/auth/signup.dart';
import 'package:flutter_notes_api/app/auth/success.dart';
import 'package:flutter_notes_api/app/home.dart';
import 'package:flutter_notes_api/app/notes/addNotes.dart';
import 'package:flutter_notes_api/app/notes/editNotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Php Rest Api",
      initialRoute: sharedpref.getString("id") == null ? "/login" : "/home",
      routes: {
        "/login": (context) => login(),
        "/signup": (context) => singup(),
        "/home": (context) => homePage(),
        "/success": (context) => success(),
        "/addnotes": (context) => addNotes(),
        "/editnotes": (context) => editNotes(),
      },
    );
  }
}
