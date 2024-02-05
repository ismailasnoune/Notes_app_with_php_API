import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notes_api/components/crud.dart';
import 'package:flutter_notes_api/components/customtextformfiel.dart';
import 'package:flutter_notes_api/components/valid.dart';
import 'package:flutter_notes_api/constant/Links.dart';
import 'package:image_picker/image_picker.dart';

class editNotes extends StatefulWidget {
  final notes;
  const editNotes({super.key, this.notes});

  @override
  State<editNotes> createState() => _editNotesState();
}

class _editNotesState extends State<editNotes> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();
  Crud cr = Crud();
  bool isloading = false;

  File? _myfile;

  Future<void> EditNotes() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      await Future.delayed(Duration(seconds: 5));
      var response;
      if (_myfile == null) {
        response = await cr.postrequest(linkeditNotes, {
          "note_title": titlecontroller.text,
          "note_content": contentcontroller.text,
          "id": widget.notes['note_id'].toString(),
          "note_img": widget.notes['note_img'].toString()
        });
      } else {
        response = await cr.postrequestwithfile(
            linkeditNotes,
            {
              "note_title": titlecontroller.text,
              "note_content": contentcontroller.text,
              "id": widget.notes['note_id'].toString(),
              "note_img": widget.notes['note_img'].toString()
            },
            _myfile!);
      }

      setState(() {
        isloading = false;
      });
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (route) => false);
      } else {
        print("error in update note");
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    titlecontroller.text = widget.notes['note_title'];
    contentcontroller.text = widget.notes['note_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
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
                    MaterialButton(
                      onPressed: () async {
                        await EditNotes();
                      },
                      color: Colors.green,
                      child: Text("Save"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
