import 'dart:convert';

class restaurantModel {
  String name;
  String address;
  String image;
  String user;
  String password;
  String type;
  String vendorid;
  String inPromotion;
  String description;
  String email;

  restaurantModel(
      {
        this.name,
        this.address,
        this.image,
        this.user,
        this.password,
        this.type,
        this.vendorid,
        this.inPromotion,
        this.description,
        this.email});

  fromJson(Map<String, dynamic> json) {

   
    email = json['email'];

    return restaurantModel(


        name : json['name'],

        address : json['address'],

        image : json['image'],

        user : json['user'],

        password : json['password'],

        type : json['type'],

        vendorid : json['vendorid'],

        inPromotion : json['inPromotion'],

        description : json['description'],

    );


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['image'] = this.image;
    data['user'] = this.user;
    data['password'] = this.password;
    data['type'] = this.type;
    data['vendorid'] = this.vendorid;
    data['inPromotion'] = this.inPromotion;
    data['description'] = this.description;
    data['email'] = this.email;
    return data;
  }
}

class  UserModel {
  String name;
  String address;
  String ref;
  String email;
  String dob;
  dynamic location;
  String member;
  String phone;
  String token;
  String wallet;
  String refFrom;

  UserModel(
      {
        this.name,
        this.address,
        this.ref,
        this.email,
        this.dob,
        this.location,
        this.member,
        this.phone,
        this.token,
        this.wallet,
        this.refFrom
      });

  fromJson(Map<String, dynamic> json) {


    email = json['email'];

    return UserModel(


      name : json['name'],

      address : json['address'],

      ref : json['ref'],

      email : json['email'],

      dob : json['dob'],

      // location : json['location'],

      member : json['member'],

      phone : json['phone'],

      token : json['token'],

      wallet : json['wallet'],
      refFrom: json["refForm"]

    );


  }

  String toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['ref'] = this.ref;
    data['dob'] = this.dob;
    data['location'] = this.location;
    data['member'] = this.member;
    data['phone'] = this.phone;
    data['token'] = this.token;
    data['wallet'] = this.wallet;
    data['email'] = this.email;
     data["refForm"] =refFrom;
    print("jsonUser ${json.encode(data)}");
    return json.encode(data);
  }
}

