
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:homelyy/Screens/homepage/Restaurant/restCard.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class PopularRestaurantList extends StatefulWidget {
  final String? type,uid;
  final List? category;
  final GeoPoint? userGeoPoint;
  final bool? status;
  final List? listofRestaurant;
  const PopularRestaurantList({Key? key, this.category, this.userGeoPoint, this.status, this.type, this.listofRestaurant, this.uid}) : super(key: key);

  @override
  _PopularRestaurantListState createState() => _PopularRestaurantListState();
}

class _PopularRestaurantListState extends State<PopularRestaurantList> {
  var listener = PaginateRefreshedChangeListener();


  @override
  Widget build(BuildContext context) {
    print("restaurant gettin ${widget.listofRestaurant}");
  // var uid = FirebaseAuth.instance.currentUser.uid;
  //   final geo = Geoflutterfire();
  //   var firestore =
  //       FirebaseFirestore.instance;
  //   var  future = firestore.collection("users").doc(uid).get();


    return  ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
      itemCount: widget.listofRestaurant!.length,
      itemBuilder: (context,index) {

      return  Padding(

            padding:  EdgeInsets.all(8.0),

            child: RestaurentListCard(

              category:widget.listofRestaurant![index].category,
              title: widget.listofRestaurant![index].name,

              type: widget.listofRestaurant![index].type,

              img:widget.listofRestaurant![index].image,

              discount: "15",

              cuisine: widget.listofRestaurant![index].cuisine,

              area: widget.listofRestaurant![index].address,

              deliveryTime: "15-20",

              tag: "",

              rating: widget.listofRestaurant![index].rating,

              discountVisibility: true,

              tagVisibility: false,

              shopid: widget.listofRestaurant![index].vendorid,

              press: () {},

              key: Key("resto1"),

              closetiming: "10",

              opentiming: "10",

              badgeVisibility: widget.listofRestaurant![index].inPromotion == "1" ? true : false,

              status: !widget.status!,

              numReview: 12,

              uid: widget.uid!.replaceAll("+", "").removeAllWhitespace,

              // category:widget.listofRestaurant[index]["category"],
              // title: widget.listofRestaurant[index]["name"],
              //
              // type: widget.listofRestaurant[index]["type"],
              //
              // img:widget.listofRestaurant[index]["image"],
              //
              // discount: "15",
              //
              // cuisine: widget.listofRestaurant[index]["cuisine"],
              //
              // area: widget.listofRestaurant[index]["address"],
              //
              // deliveryTime: "15-20",
              //
              // tag: "",
              //
              // rating: widget.listofRestaurant[index]["rating"],
              //
              // discountVisibility: true,
              //
              // tagVisibility: false,
              //
              // shopid: widget.listofRestaurant[index]["vendorid"],
              //
              // press: () {},
              //
              // key: Key("resto1"),
              //
              // closetiming: "10",
              //
              // opentiming: "10",
              //
              // badgeVisibility: widget.listofRestaurant[index]["inPromotion"] == "1" ? true : false,
              //
              // status: true,
              //
              // numReview: 12,
              //
              // uid: widget.uid.replaceAll("+", "").removeAllWhitespace,

            )
        );
      }
    );

  }
}
