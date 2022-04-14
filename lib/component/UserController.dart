import 'dart:convert';

import 'package:get/get.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/models.dart';

class UserController extends GetxController{

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;


  bool _loading = true ;
  bool get loading => _loading;

  String _cartCount = '' ;
  String get cartCount => _cartCount;

  Future getUserList () async {
    UserModel response = await  AllApi().getLocalUsers();

    _userModel = response;
    _loading = false;
    update();

  }

  Future getUserCart () async {
    UserModel response1 = await  AllApi().getLocalUsers();

    var response = await  AllApi().getCartCount(response1.ref,);

    _cartCount = response;
    _loading = false;
    update();

  }

}