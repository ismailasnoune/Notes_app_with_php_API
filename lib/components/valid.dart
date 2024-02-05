import 'package:flutter_notes_api/constant/messages.dart';

validInput(String val, int max, int min) {
  if (val.isEmpty) {
    return "${msgempty}";
  }
  if (val.length < min) {
    return "${msgmin}:${min} Characters";
  }
  if (val.length > max) {
    return "${msgmax}:${max} Characters";
  }
}
