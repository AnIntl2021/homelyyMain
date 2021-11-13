import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:homelyy/Screens/UserProfile/UserInfo.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/component/models.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class AllApi {


  Future getRestaurant() async {

    var userGetURL = Uri.parse("${conurl}restroget");

    var response = await http.get(userGetURL);

    var list = json.decode(response.body);
    //
    print("list ${
    response.body
    }");

    // Map json = jsonDecode(jsonString);
    //
    // String user = jsonEncode(UserModel().fromJson(json));


    return response.body;
  }

  Future postUser(UserModel usermodel) async {

    var userGetURL = Uri.parse("${conurl}userpost?lat=1234&lon=5647");

    var response = await http.post(userGetURL,body: {
      "name" : usermodel.name,
      "address" : usermodel.address,
      "ref" : usermodel.ref,
      "dob" : usermodel.dob,
      // "location" : json.encode({"j":"k"}),
      "member" : usermodel.member,
      "phone" : usermodel.phone,
      "token" : usermodel.token,
      "wallet" : usermodel.wallet,
    "email" : usermodel.email,
    });

    // var list = json.decode(response.body);
    //
    print(

        "response for userpost ${response.body}");



    // Map json = jsonDecode(jsonString);
    //
    // String user = jsonEncode(UserModel().fromJson(json));


    return response.body;
  }

  Future getUser(String ref) async {

    var userGetURL = Uri.parse("${conurl}userge?ref=$ref");

    var response = await http.get(userGetURL);

    // var list = json.decode(response.body);
    //
    print(

        "response for userpost ${response.body}");



    // Map json = jsonDecode(jsonString);
    //
    // String user = jsonEncode(UserModel().fromJson(json));


    return response.body;
  }


}