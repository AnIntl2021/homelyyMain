import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:homelyy/Screens/UserProfile/UserInfo.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/component/models.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AllApi {

  Future<UserModel> updateLocalUsers(String jsonString,String phone) async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    // Map json = jsonDecode(jsonString);
    //
    // String user = jsonEncode(UserModel().fromJson(json));

    await pref.setString('userData', jsonString);
    await pref.setString('phone', phone);
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


  Future getRestaurant(String lat,String lon) async {
    print("recieving api");
    var userGetURL = Uri.parse("${conurl}restrogetnearme?lat=$lat&lng=$lon");
    print("recieving api $userGetURL");
    var response = await http.get(userGetURL);
    print("got restaurant ${response.body}");




    var list = json.decode(response.body);
    print("got restaurant1 ${list.length}");
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

    var newList = list.length == 0 ? [] : list.map((e) {
      return restaurantModel().fromJson(e);
    });



    return newList == [] ? [] : newList.toList();

  }

  Future getLifestyle(String lat,String lon) async {

    var userGetURL = Uri.parse("${conurl}lifestylegetnearme?lat=$lat&lng=$lon");

    var response = await http.get(userGetURL);




    var list = json.decode(response.body);


    var newList = list.length == 0 ? null : list.map((e) {
      return restaurantModel().fromJson(e);
    });



    return newList == null ? [] : newList.toList();

  }

  Future getRestaurantbyCat(String catid,String lat,String lon) async {

    var userGetURL = Uri.parse("${conurl}restobycat?lat=$lat&lng=$lon&catid=$catid");

    var response = await http.get(userGetURL);




    var list = json.decode(response.body);


    var newList = list.length == 0 ? null : list.map((e) {
      return restaurantModel().fromJson(e);
    });



    return newList == null ? [] : newList.toList();

  }

  Future getLifestylebyCat(String catid,String lat,String lon) async {

    var userGetURL = Uri.parse("${conurl}lifestylebycat?lat=$lat&lng=$lon&catid=$catid");


    var response = await http.get(userGetURL);




    var list = json.decode(response.body);


    var newList = list.length == 0 ? null : list.map((e) {
      return restaurantModel().fromJson(e);
    });



    return newList == null ? [] : newList.toList();

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
      "country":usermodel.country,
      "password": usermodel.password,'symbol':usermodel.symbol
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
    print("prionting ref = $ref");

    var userGetURL = Uri.parse("${conurl}userget?ref=$ref");


    var response = await http.get(userGetURL,headers: {'Content-Type': 'application/json'});

    print("prionting ref users = ${utf8.decode(response.bodyBytes)} $ref");

    // print("response for userpost ${response.body}");



    return utf8.decode(response.bodyBytes);

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

  Future<List<CatModel>> getCategory({ String vendorId,}) async {
    var getCategoryUrl = Uri.parse(
        "https://webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-aveoz/service/Homelyy/incoming_webhook/getCategoryVendor?vendorId=$vendorId");
    var response = await http.get(getCategoryUrl);
    if (response.body != "null") {
      List categoryList = json.decode(response.body);
      Iterable<CatModel> category = categoryList.map((e) {
        return CatModel().fromJson(e);
      });
      return category.toList();
    } else {
      return null;
    }
  }



  Future getcatfood(String vendorid , String catid) async {
    var userGetURL = Uri.parse("${conurl}getcatfood?vendorid=$vendorid&catid=$catid");
    print(userGetURL);
    var response = await http.get(userGetURL);

    List list = json.decode(response.body);

    print(response.body);

    Iterable<ProductModel> newList = list.map((e) {
      return ProductModel().fromJson(e);
    });

    return newList.toList();

  }

  Future getrecproduct(String vendorid ) async {
    var userGetURL = Uri.parse("${conurl}getRecProdcut?vendorid=$vendorid");
    var response = await http.get(userGetURL);

    List list = json.decode(response.body);

    print(response.body);

    Iterable<LifeProductModel> newList = list.map((e) {
      return LifeProductModel().fromJson(e);
    });

    return newList.toList();

  }



  Future<List<ProductModel>> getrestrecfood(String vendorid ) async {

    var userGetURL = Uri.parse("${conurl}getrecFoods?vendorid=$vendorid");
    var response = await http.get(userGetURL);
    print("vendorid $vendorid");

    List list = json.decode(response.body);

    print(response.body);

    Iterable<ProductModel> newList = list.map((e) {
      return ProductModel().fromJson(e);
    });

    return newList.toList();

  }


  Future<List<BannerModel>> getBanner(String type) async {
    var userGetURL = Uri.parse("${conurl}bannergetapp?type=$type");
    var response = await http.get(userGetURL);

    List list = json.decode(response.body);

     print(response.body);
    //

    Iterable<BannerModel> newList = list.map((e) {
      return BannerModel().fromJson(e);
    });

    print("bannerList = ${newList.toList()[0].image}");
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

  Future postCart(CartModel cartModel,String type) async {

    var userGetURL = Uri.parse("${conurl}addCart?ref=${cartModel.ref}&vendorid=${cartModel.vendorid}&foodid=${cartModel.foodid}");

    print("cartFoofid=");
    var response = type == "Add" ?await http.put(userGetURL,body: {

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

    })  : await http.put(userGetURL,body: {

      "price" : cartModel.price,
      // "location" : json.encode({"j":"k"}),

      "quantity" : cartModel.quantity,


      "cutprice" : cartModel.cutprice,
      "discount" : cartModel.discount,

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

    var userGetURL = Uri.parse("${conurl}addShopCart?ref=${cartModel.ref}&vendorid=${cartModel.vendorid}");

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

    var userGetURL = Uri.parse("${conurl}removeShopCart?ref=$ref&vendorid=$vendorid");

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


  Future  getCountShopCart(String ref,String vid) async {

    var userGetURL = Uri.parse("${conurl}getCountShopCart?ref=$ref&vendorid=$vid");

    var response = await http.get(userGetURL);
    print("response of gotShopcCountcart ${response.body}");
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


  Future postCartTotal(CartTotalModel cartModel) async {

    var userGetURL = Uri.parse("${conurl}addCartTotal?ref=${cartModel.ref}");

    var response = await http.put(userGetURL,body: {

      "total" : cartModel.total,
      "subTotal" : cartModel.subTotal,
      "ref" : cartModel.ref,
      "savings" : cartModel.savings,
      // "location" : json.encode({"j":"k"}),
      "discount" : cartModel.discount ,


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


  Future getCartTotal(String ref) async {

    var userGetURL = Uri.parse("${conurl}getCartTotal?ref=$ref");
    print("uri $userGetURL");
    var response = await http.get(userGetURL);
    print("response of gotccart ${response.body} $ref");

    var list = json.decode(response.body);

    print(response.body);

      return CartTotalModel().fromJson(list);
  }


  Future postOrders(CartModel cartModel,String rNum) async {

    var userGetURL = Uri.parse("${conurl}addOrders");




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
      "foodid" : cartModel.foodid,
      "vendorid" : cartModel.vendorid,
      "order_id" :rNum

    });

    print("response of ccart ${response.body}");



    return response.body;
  }


  Future addOrderTotal(UserModel users,CartTotalModel cartTotal,String shopName,String uaddress,String rNum) async {
    var date =DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

    var userGetURL = Uri.parse("${conurl}addOrderTotal");
    print("orderToital $rNum");
    var response = await http.post(userGetURL,body: {

      'address':uaddress,
      'date': date ,
      'name':users.name,
      'phone':users.phone,
      'ref':users.ref,
      'status':"Pending",
      'vid':shopName,
      'total':cartTotal.total,
      'discount':cartTotal.discount,
      'subtotal':cartTotal.subTotal,
      'savings':cartTotal.savings,
      'order_id': rNum



    });

    print("response of ccart ${response.body}");



    return response.body;
  }

  Future removeAllCart(String ref,String vendorid) async {

    var userGetURL = Uri.parse("${conurl}removeAllCart?ref=$ref&vid=$vendorid");

    var response = await http.get(userGetURL);
    print("response of deleteAllCart ${response.body}");

    return response.body;
  }

  Future getOrderTotal(String ref) async {

    var userGetURL = Uri.parse("${conurl}getOrderTotal?ref=$ref");
    print("uri $userGetURL");
    var response = await http.get(userGetURL);
    print("response of gotorder ${response.body} $ref");

    var list = json.decode(response.body);

    print(list);

    return list ;
  }


  Future getOrders(String ref,String vendorid,String order_id) async {

    var userGetURL = Uri.parse("${conurl}getOrderDetail?ref=$ref&vendorid=$vendorid&order_id=$order_id");
    print("uri $userGetURL");
    var response = await http.get(userGetURL);
    print("response of gotOrders ${response.body} $ref $vendorid");

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

  Future getlifeProdAll(String vendorid , String catid) async {
    var userGetURL = Uri.parse("${conurl}getLifeProducts?vendorid=$vendorid&category=$catid");
    // print("vendorUrl = $userGetURL");
    var response = await http.get(userGetURL);

    List list = json.decode(response.body);
    //
    print("vendorUrl Product${response.body} $vendorid $catid");

    Iterable<LifeProductModel> newList = list.map((e) {
      return LifeProductModel().fromJson(e);
    });

    return newList.toList();

  }

  Future getlifeprod(String varient,String vid) async {
    var userGetURL = Uri.parse("${conurl}getlifeprod?varient=$varient&vid=$vid");
    var response = await http.get(userGetURL);

    List list = json.decode(response.body);

    print("vendorUrl Product${userGetURL}");

    Iterable<LifeProductModel> newList = list.map((e) {
      return LifeProductModel().fromJson(e);
    });

    return newList.toList();

  }

  Future getVendorbyid(String vid) async {

    var userGetURL = Uri.parse("${conurl}vendorgetid?vendorid=$vid");
    var response = await http.get(userGetURL);

    var list = json.decode(response.body);

    print("vebndordetaukl1 ${userGetURL}");
    print("venodr nmaem ${list}");
   // var checkMap = LifeProductModel().fromJson(list);
    print("checkmap ${list["name"]}");
    return list["name"];


  }

  Future getVendorbyid1(String vid) async {

    var userGetURL = Uri.parse("${conurl}vendorgetid?vendorid=$vid");
    var response = await http.get(userGetURL);

    var list = json.decode(response.body);

    print("vebndordetaukl1 ${userGetURL}");
    print("venodr nmaem ${list}");
    // var checkMap = LifeProductModel().fromJson(list);
    print("checkmap ${list["name"]}");
    return list["status"];


  }

  Future getCatImage(String catid) async {


    var userGetURL = Uri.parse("${conurl}getCategoryImage?catid=$catid");
    var response = await http.get(userGetURL);

    var list = json.decode(response.body);

    print("catIMage ${list}");

    return list;

  }

  Future updateWallet(String ref,String wallet) async {

    var userGetURL = Uri.parse("${conurl}updateUserWallet?ref=$ref");

    var response = await http.put(userGetURL,body: {

      "wallet" : wallet,

    });

    print("response of wallet ${response.body}");
     SharedPreferences pref = await SharedPreferences.getInstance();



    return response.body;
  }

  Future updateToken(String ref,String token) async {

    var userGetURL = Uri.parse("${conurl}updateUserWallet?ref=$ref");

    var response = await http.put(userGetURL,body: {

      "token" : token,

    });

    print("response of wallet ${response.body}");
    SharedPreferences pref = await SharedPreferences.getInstance();



    return response.body;
  }

  Future<double> getAllRatings(String vid,int userRating) async {


    var userGetURL = Uri.parse("${conurl}ratingall?vendorid=$vid");

    var response = await http.get(userGetURL);

    List allRating = json.decode(response.body);

    var allRatingCount = allRating.length + 1;

    var ct = 0.0;

    Future.forEach(allRating,(element){

        ct += double.parse(element["rating"]);

    });

    var totalRating = ct + userRating;




    double avgRating = totalRating / allRatingCount;




    return avgRating;

  }

  Future addRating(String ref,String vendorid,String rating , String comment) async {

    var date =DateFormat('yyyy/MM/dd').format(DateTime.now());
    var time =DateFormat('hh:mm aa ').format(DateTime.now());

    var userGetURL = Uri.parse("${conurl}ratingadd");

    var response = await http.post(userGetURL,body: {

      "rating" : rating,
      "comment":comment,
      "user":ref,
      "vendorid":vendorid,
      "date":date,
      "time":time,



    });

    print("response of wallet ${response.body}");
    SharedPreferences pref = await SharedPreferences.getInstance();



    return response.body;
  }

  Future updateRating(String vid,double userRating) async {


    var userGetURL = Uri.parse("${conurl}rateVendor?vendorid=$vid&rating=$userRating");

    var response = await http.get(userGetURL);







    return response;

  }




}