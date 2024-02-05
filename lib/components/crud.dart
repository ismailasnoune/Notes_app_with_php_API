import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('ismail:ismail1414'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  getrequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url), headers: myheaders);
      if (response.statusCode == 200) {
        var responsebody = json.decode(response.body);
        return responsebody;
      } else {
        print("error${response.statusCode}");
      }
    } catch (e) {
      print("errorcatch${e}");
    }
  }

  postrequest(String url, Map data) async {
    Future.delayed(Duration(seconds: 2));

    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        print("okReq");
        var responsebody = json.decode(response.body);
        return responsebody;
      } else {
        print("errorReq${response.statusCode}");
      }
    } catch (e) {
      print("errorcatch${e}");
    }
  }

  postrequestwithfile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());

    var multirequestfile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.headers.addAll(myheaders);
    request.files.add(multirequestfile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("error${myrequest.statusCode}");
    }
  }
}
