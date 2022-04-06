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
  String email,rating;
  bool status;
  var category;
  var cuisine;
  var location;


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
        this.email,this.location,this.category,this.cuisine,this.rating,this.status});

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
      location: json['location'],
        category: json['category'],
        cuisine:json['cuisine'],
      rating:json['rating'],
        status:json['status']
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
  String referid;
  String country;
  String password;
  String symbol;

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
        this.refFrom,
        this.country,
        this.referid,
        this.password,this.symbol
      });

  fromJson(Map<String, dynamic> json) {

    print("Take jsonj ${json['name']}");
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
      refFrom: json["refForm"],
        referid: json["referid"],
      country: json["country"],
        password: json["password"],
      symbol: json['symbol']

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
     data["country"]= country;
    data["password"]= password;
    print("jsonUser ${json.encode(data)}");
    return json.encode(data);
  }
}

class BannerModel {
  String bannerid;
  String name;
  String image;
  String type;

  BannerModel({ this.bannerid, this.name, this.image, this.type});

  fromJson(Map<String, dynamic> json) {
    return BannerModel(
        bannerid : json['bannerid'],
        name : json['name'],
        image : json['image'],
    type : json['type'],
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerid'] = this.bannerid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}

class CatModel {
  String name;
  String image;
  String type;
  String number;
  String catid;
  String number;

  CatModel({ this.name, this.image, this.type, this.catid,this.number});

  fromJson(Map<String, dynamic> json) {
    return CatModel(
        name : json['name'],
        image : json['image'],
        type : json['type'],
    catid : json['catid'],
      number : json['number'],
    );


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    data['catid'] = this.catid;
    return data;
  }
}

class ProductModel {

  String description;
  String vendorid;
  String foodid;
  String name;
  String image;
  String price;
  String category;
  String subcategory;
  String cutprice;
  String recommended;
  bool status;

  ProductModel(
      {
        this.description,
        this.vendorid,
        this.foodid,
        this.name,
        this.image,
        this.price,
        this.category,
        this.subcategory,this.cutprice,this.recommended,this.status});

  fromJson(Map<String, dynamic> json) {
 return ProductModel(
     description : json['description'],
     vendorid : json['vendorid'],
     foodid : json['foodid'],
 name : json['name'],
 image : json['image'],
 price : json['price'],
 category : json['category'],
 subcategory : json['subcategory'],
   cutprice : json['cutprice'],
   recommended : json['recommended'],
   status : json['status'],
 );

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['description'] = this.description;
    data['vendorid'] = this.vendorid;
    data['foodid'] = this.foodid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['cutprice'] = this.cutprice;
    data['recommended'] = this.recommended;
    data['status'] = this.status;

    return data;

  }
}

class CartModel {
  String img;
  String price;
  String title;
  String recipe;
  String quantity;
  String requirement;
  String itemnumber;
  String cutprice;
  String ogprice;
  String ogcutprice;
  String discount;
  String shop;
  String ref;
  String date;
  String time;
  String vendorid;
  String foodid;
  String productid;



  CartModel(
      {
        this.img,
        this.price,
        this.title,
        this.recipe,
        this.quantity,
        this.requirement,
        this.itemnumber,
        this.cutprice,
        this.ogprice,
        this.ogcutprice,
        this.discount,
        this.shop,
        this.date,
        this.time,
        this.ref,
        this.vendorid,
        this.foodid,
        this.productid

      });

  fromJson(Map<String, dynamic> json) {
    return CartModel(
        img : json['img'],
        price : json['price'],
        title : json['title'],
        recipe : json['recipe'],
        quantity : json['quantity'],
        requirement : json['requirement'],
        itemnumber : json['itemnumber'],
        cutprice : json['cutprice'],
        ogprice : json['ogprice'],
        ogcutprice : json['ogcutprice'],
        discount : json['discount'],
        shop : json['shop'],
        date : json['date'],
      productid : json["productid"],
      time : json['time'],
    ref : json['ref'],
    vendorid : json['vendorid'],
    foodid : json["foodid"],
    );
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['img'] = this.img;
    data['price'] = this.price;
    data['title'] = this.title;
    data['recipe'] = this.recipe;
    data['quantity'] = this.quantity;
    data['requirement'] = this.requirement;
    data['itemnumber'] = this.itemnumber;
    data['cutprice'] = this.cutprice;
    data['ogprice'] = this.ogprice;
    data['ogcutprice'] = this.ogcutprice;
    data['discount'] = this.discount;
    data['shop'] = this.shop;
    data['date'] = this.date;
    data['time'] = this.time;
    data['ref'] = this.ref;
    data['vendorid'] = this.vendorid;
    data["foodid"] = this.foodid;
    data["productid"] = this.productid;
    return data;
  }

}


class CartTotalModel {

  String discount;
  String subTotal;
  String total;
  String savings;
  String ref;

  CartTotalModel(
      {
        this.discount,
        this.subTotal,
        this.total,
        this.savings,
        this.ref,
        });

  fromJson(Map<String, dynamic> json) {
    return CartTotalModel(
      discount : json['discount'],
      subTotal : json['subTotal'],
      total : json['total'],
      savings : json['savings'],
        ref:json['ref']
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['discount'] = this.discount;
    data['subTotal'] = this.subTotal;
    data['total'] = this.total;
    data['savings'] = this.savings;
    data['ref'] = this.ref;

    return data;
  }
}


class LifeProductModel {

  String description;
  String vendorid;
  String foodid;
  String name;
  String image;
  String price;
  String category;
  String subcategory;
  String cutprice;
  bool status;
  String varient;
  String productid;

  LifeProductModel(
      {
        this.description,
        this.vendorid,
        this.foodid,
        this.name,
        this.image,
        this.price,
        this.category,
        this.subcategory,this.cutprice,this.status,this.varient,this.productid});

  fromJson(Map<String, dynamic> json) {
    return LifeProductModel(
      description : json['description'],
      vendorid : json['vendorid'],
      foodid : json['foodid'],
      name : json['name'],
      image : json['image'],
      price : json['price'],
      category : json['category'],
      subcategory : json['subcategory'],
      cutprice : json['cutprice'],
      status : json['status'],
      varient : json['varient'],
        productid:json["productid"]
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['description'] = this.description;
    data['vendorid'] = this.vendorid;
    data['foodid'] = this.foodid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['cutprice'] = this.cutprice;
    data['status'] = this.status;
    data['varient'] = this.varient;
    data["productid"] = this.productid;
    return data;
  }
}






