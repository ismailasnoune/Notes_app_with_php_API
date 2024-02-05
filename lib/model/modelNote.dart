class noteModel {
  int? noteId;
  String? noteTitle;
  String? noteContent;
  String? noteImg;
  int? noteUsers;

  noteModel(
      {this.noteId,
      this.noteTitle,
      this.noteContent,
      this.noteImg,
      this.noteUsers});

  noteModel.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    noteTitle = json['note_title'];
    noteContent = json['note_content'];
    noteImg = json['note_img'];
    noteUsers = json['note_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note_id'] = this.noteId;
    data['note_title'] = this.noteTitle;
    data['note_content'] = this.noteContent;
    data['note_img'] = this.noteImg;
    data['note_users'] = this.noteUsers;
    return data;
  }
}
