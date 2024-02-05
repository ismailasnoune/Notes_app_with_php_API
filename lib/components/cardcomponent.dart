import 'package:flutter/material.dart';
import 'package:flutter_notes_api/constant/Links.dart';
import 'package:flutter_notes_api/model/modelNote.dart';

class CardWidget extends StatelessWidget {
  final void Function() ontap;
  final void Function()? onDelete;
  final noteModel note_Model;
  // final String content;
  // final String title;
  const CardWidget(
      {super.key,
      required this.ontap,
      required this.note_Model,
      // required this.content,
      // required this.title,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  "${linkImageroot}${note_Model.noteImg}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Text("${note_Model.noteTitle}"),
                    subtitle: Text("${note_Model.noteContent}"),
                    trailing: IconButton(
                        onPressed: onDelete, icon: Icon(Icons.delete)),
                  ))
            ],
          ),
        ));
  }
}
