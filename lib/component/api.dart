import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:homelyy/Screens/UserProfile/UserInfo.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/component/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AllApi {

  Future<UserModel> updateLocalUsers(String jsonString) async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    // Map json = jsonDecode(jsonString);
    //
    // String user = jsonEncode(UserModel().fromJson(json));

    await pref.setString('userData', jsonString);
    await pref.setBool('loggedin', true);


    return getLocalUsers();

  }

  Future<UserModel> getLocalUsers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var a = pref.getString("userData");
      print("Get Lcocal User ${a}");

    var jsonid = await jsonDecode(a);
    Map json = jsonDecode(jsonid);
    print("converted ${json["name"]}");



    // print("allusersJson  ${json}");

    List<UserModel> newList = [];

    UserModel userid = await UserModel().fromJson(json);


    //

    return userid;
  }


  Future getRestaurant() async {

    var userGetURL = Uri.parse("${conurl}restrogetnearme?lat=19.219305858205278&lng=72.980145824379");

    var response = await http.get(userGetURL);

    var list = json.decode(response.body);

    //
    // print("list ${
    // response.body
    // }");
    // print("listconvertedd ${
    //     list
    // }");
    // Map json = jsonDecode(jsonString);
    //
    // String user = jsonEncode(UserModel().fromJson(json));



    return list;

  }

  Future postUser(UserModel usermodel) async {

    var userGetURL = Uri.parse("${conurl}userpost?ref=${usermodel.phone}");

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

    // print(
    //
    //     "response for userpost ${response.body}");



    // Map json = jsonDecode(jsonString);
    //
    // String user = jsonEncode(UserModel().fromJson(json));


    return response.body;
  }

  Future getUser(String ref) async {
    print("prionting ref = $ref");

    var userGetURL = Uri.parse("${conurl}userget?ref=$ref");


    var response = await http.get(userGetURL);
    print("prionting ref users = ${response.body}");
    print(

        "response for userpost ${response.body}");



    return response.body;
  }

  Future getcat(String catid ) async {
    var userGetURL = Uri.parse("${conurl}categorynameget?catid=$catid");
    var response = await http.get(userGetURL);



    print(response.body);


     // List list = json.decode(response.body);
     print("listofcat ${jsonDecode(response.body)}");
    //
    // Iterable<VenueModel> newList = list.map((e) {
    //   return VenueModel().fromJson(e);
    // });
    //
    // return newList.toList();
    return jsonDecode(response.body);
  }

  Future getcatfood(String vendorid , String catid) async {
    var userGetURL = Uri.parse("${conurl}getcatfood?vendorid=$vendorid&catid=$catid");
    var response = await http.get(userGetURL);

    // List list = json.decode(response.body);

    // print(response.body);
    //
    // Iterable<VenueModel> newList = list.map((e) {
    //   return VenueModel().fromJson(e);
    // });
    //
    // return newList.toList();

  }





}