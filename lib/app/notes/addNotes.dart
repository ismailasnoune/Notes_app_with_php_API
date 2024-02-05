import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_api/components/crud.dart';
import 'package:flutter_notes_api/components/customtextformfiel.dart';
import 'package:flutter_notes_api/components/valid.dart';
import 'package:flutter_notes_api/constant/Links.dart';
import 'package:flutter_notes_api/main.dart';
import 'package:image_picker/image_picker.dart';

class addNotes extends StatefulWidget {
  const addNotes({super.key});

  @override
  State<addNotes> createState() => _addNotesState();
}

class _addNotesState extends State<addNotes> {
  File? _myfile;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();
  Crud cr = Crud();
  bool isloading = false;

  AddNotes() async {
    print(_myfile);
    if (_myfile == null) {
      return AwesomeDialog(
          context: context, title: "alert", body: Text("Please Add a Image"))
        ..show();
    } else {
      print(_myfile);
    }

    if (_formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      await Future.delayed(Duration(seconds: 3));

      var response = await cr.postrequestwithfile(
          linkaddNotes,
          {
            "note_title": titlecontroller.text,
            "note_content": contentcontroller.text,
            "note_user": sharedpref.getString("id")
          },
          _myfile!);

      setState(() {
        isloading = false;
      });
      if (response['status'] == "success") {
        Navigator.of(context).pushReplacementNamed("/home");
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formkey,
                child: ListView(
                  children: [
                    customTextForm(
                        hint: "Enter Title of Note",
                        controller: titlecontroller,
                        valid: (val) {
                          return validInput(val!, 25, 3);
                        }),
                    customTextForm(
                        hint: "Enter Content of Note",
                        controller: contentcontroller,
                        valid: (val) {
                          return validInput(val!, 225, 5);
                        }),
                    MaterialButton(
                      onPressed: () async {
                        await AddNotes();
                      },
                      color: Colors.blue,
                      child: Text("Add"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        "Please Chosse Image ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          _myfile = File(xfile!.path);
                                          Navigator.of(context).pop();

                                          setState(() {});
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text(" From Gallery",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ))),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          _myfile = File(xfile!.path);
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(10),
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text("From Camera",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ))),
                                      )
                                    ],
                                  ),
                                ));
                      },
                      color: _myfile == null ? Colors.blue : Colors.green,
                      child: Text("Choose Image"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
