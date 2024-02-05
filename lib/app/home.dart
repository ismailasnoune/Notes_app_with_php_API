import 'package:flutter/material.dart';
import 'package:flutter_notes_api/app/notes/editNotes.dart';
import 'package:flutter_notes_api/components/cardcomponent.dart';
import 'package:flutter_notes_api/components/crud.dart';
import 'package:flutter_notes_api/constant/Links.dart';
import 'package:flutter_notes_api/main.dart';
import 'package:flutter_notes_api/model/modelNote.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Crud crud = Crud();
  getNotes() async {
    var response = await crud
        .postrequest(linkviewNotes, {"id": sharedpref.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                sharedpref.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/login", (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data["status"] == "no-data") {
                      return Center(
                        child: Text(
                          'No Data Found ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data["data"].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CardWidget(
                          onDelete: () async {
                            print("delete home");
                            var response =
                                await crud.postrequest(linkdeleteNotes, {
                              "id": snapshot.data["data"][index]["note_id"]
                                  .toString(),
                              "img_name": snapshot.data["data"][index]
                                  ["note_img"]
                            });
                            print(snapshot.data["data"][index]["note_id"]);
                            if (response['status'] == "success") {
                              Navigator.of(context)
                                  .pushReplacementNamed("/home");
                            } else {}
                          },
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => editNotes(
                                      notes: snapshot.data["data"][index],
                                    )));
                          },
                          note_Model:
                              noteModel.fromJson(snapshot.data["data"][index]),
                        );
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading ... "),
                    );
                  }
                  return Center(
                    child: Text("Loading ... "),
                  );
                },
              )
            ],
          )),
    );
  }
}
