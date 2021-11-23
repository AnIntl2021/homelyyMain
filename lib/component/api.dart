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

  Future getLifestyle() async {

    var userGetURL = Uri.parse("${conurl}lifestylegetnearme?lat=19.219305858205278&lng=72.980145824379");

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

    List list = json.decode(response.body);

    print(response.body);

    Iterable<ProductModel> newList = list.map((e) {
      return ProductModel().fromJson(e);
    });

    return newList.toList();

  }

  Future getBanner(String type) async {
    var userGetURL = Uri.parse("${conurl}bannergetapp?type=$type");
    var response = await http.get(userGetURL);

    List list = json.decode(response.body);

     print(response.body);
    //

    Iterable<BannerModel> newList = list.map((e) {
      return BannerModel().fromJson(e);
    });

    print("bannerList = $newList");
    //
     return newList.toList();

  }

  Future getRestoCat() async {
    var userGetURL = Uri.parse("${conurl}categoryrestro");
    var response = await http.get(userGetURL);

    List list = json.decode(response.body);

    print(response.body);
    //

    Iterable<CatModel> newList = list.map((e) {
      return CatModel().fromJson(e);
    });

    print("bannerList = $newList");
    //
    return newList.toList();

  }

  Future getLifeCat() async {
    var userGetURL = Uri.parse("${conurl}categorylifestyle");
    var response = await http.get(userGetURL);

    List list = json.decode(response.body);

    print(response.body);
    //

    Iterable<CatModel> newList = list.map((e) {
      return CatModel().fromJson(e);
    });

    print("bannerList = $newList");
    //
    return newList.toList();

  }

  Future postCart(CartModel cartModel) async {

    var userGetURL = Uri.parse("${conurl}addCart?ref=${cartModel.ref}&vendorid=${cartModel.vendorid}&foodid=${cartModel.foodid}");

    var response = await http.post(userGetURL,body: {

      "img" : cartModel.img,
      "price" : cartModel.price,
      "ref" : cartModel.ref,
      "title" : cartModel.title,
      // "location" : json.encode({"j":"k"}),
      "recipe" : cartModel.recipe ,
      "quantity" : cartModel.quantity,
      "requirement" : cartModel.requirement,
      "itemnumber" : cartModel.itemnumber,
      "cutprice" : cartModel.cutprice,
      "ogprice" : cartModel.ogprice,
      "ogcutprice" : cartModel.ogcutprice,
      "discount" : cartModel.discount,
      "shop" : cartModel.shop,

    });
    print("response of ccart ${response.body}");
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

  Future postShopCart(CartModel cartModel) async {

    var userGetURL = Uri.parse("${conurl}addShopCart?ref=${cartModel.ref}&vendorid=${cartModel.vendorid}}");

    var response = await http.post(userGetURL,body: {
      "shop" : cartModel.shop,
    });

    print("response of Shopccart ${response.body}");

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

  Future removeCart(String ref,String vendorid,String foodid) async {

    var userGetURL = Uri.parse("${conurl}removecart?ref=$ref&vendorid=$vendorid&foodid=$foodid");

    var response = await http.get(userGetURL);
    print("response of deleteccart ${response.body}");
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

  Future getCart(String ref,String vendorid) async {

    var userGetURL = Uri.parse("${conurl}getCart?ref=$ref&vendorid=$vendorid");
      print("uri $userGetURL");
    var response = await http.get(userGetURL);
    print("response of gotccart ${response.body} $ref $vendorid");

    List list = json.decode(response.body);

    print(response.body);
    //

    Iterable<CartModel> newList = list.map((e) {
      return CartModel().fromJson(e);
    });

    print("CartList = $newList");
    //
    return newList.toList();


    return response.body;
  }

  Future removeShopCart(String ref,String vendorid) async {

    var userGetURL = Uri.parse("${conurl}removecart?ref=$ref&vendorid=$vendorid");

    var response = await http.get(userGetURL);
    print("response of delteShopccart ${response.body}");
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

  Future getShopCart(String ref) async {

    var userGetURL = Uri.parse("${conurl}getShopCart?ref=$ref");

    var response = await http.get(userGetURL);
    print("response of gotShopccart ${response.body}");

    List list = json.decode(response.body);

    print(response.body);
    //

    print("CartList = $list");
    //
    return list.toList();

    return response.body;
  }


  Future  getCartCount(String ref) async {

    var userGetURL = Uri.parse("${conurl}getCartCount?ref=$ref");

    var response = await http.get(userGetURL);
    print("response of gotShopccart ${response.body}");
    // var list = json.decode(response.body);
    //

    // print(
    //
    //     "response for userpost ${response.body}");



    // Map json = jsonDecode(jsonString);
    //
    // String user = jsonEncode(UserModel().fromJson(json));


    return jsonDecode(response.body);
  }

}