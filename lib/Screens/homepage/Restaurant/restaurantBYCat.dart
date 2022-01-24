import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homelyy/Screens/homepage/Restaurant/restCard.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:homelyy/component/models.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';

class RestaurantByCat extends StatefulWidget {
  final int type;
  final String catid;
  final String uid;
  final List restomodel;
  const RestaurantByCat({Key key, this.type, this.catid, this.uid, this.restomodel}) : super(key: key);

  @override
  _RestaurantByCatState createState() => _RestaurantByCatState();
}

class _RestaurantByCatState extends State<RestaurantByCat> {
  var listener = PaginateRefreshedChangeListener();


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: homeAppBar(context,"Shops near you", widget.uid
          .replaceAll("+", "")
          .removeAllWhitespace,"Product"),
      body: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.restomodel.length,
              itemBuilder: (context,index) {
                print('resto ${widget.restomodel}');
                return  Padding(

                    padding:  EdgeInsets.all(8.0),

                    child: widget.restomodel.isEmpty ? Center(child: Text('No Restaurant Available'),) :RestaurentListCard(
                      category:widget.restomodel[index].category,
                      title: widget.restomodel[index].name,

                      type:widget.restomodel[index].type,

                      img:
                      widget.restomodel[index].image,
                      discount: "15",

                      cuisine: widget.restomodel[index].cuisine,

                      area: widget.restomodel[index].address,

                      deliveryTime: "15-20",

                      tag: "",

                      rating: widget.restomodel[index].rating,

                      discountVisibility: true,

                      tagVisibility: false,

                      shopid: widget.restomodel[index].vendorid,

                      press: () {},

                      key: Key("resto1"),

                      closetiming: "10",

                      opentiming: "10",

                      badgeVisibility:widget.restomodel[index].inPromotion == "1" ? true : false,

                      status: true,

                      numReview: 12,
                      uid: widget.uid.replaceAll("+", "").removeAllWhitespace,

                    )
                );
              }
          )
    );

  }
}
