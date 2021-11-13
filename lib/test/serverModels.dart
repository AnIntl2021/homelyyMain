import 'dart:convert';

import 'package:homelyy/test/api.dart';
import 'package:http/http.dart' as http;

class UserAgentClient {
  var code = "arsalan";
  var conurl = "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-aqwyr/service/test/incoming_webhook/";

  registerUser() async {

    var url = Uri.parse(conurl + "rest?secret=$code");

    var response = await http.get(url,
       );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("LOGIN RESPONSE ${response.body}");

      if (response.body != [] || response.body == "USER EXISTS") {
        print("USERLIST ${response.body}");
        List list = json.decode(response.body);

    print("USERLIST ${list.length}");


  }
  }
  }
}