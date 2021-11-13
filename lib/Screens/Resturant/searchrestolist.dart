// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/Screens/homepage/Restaurant/restCard.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class SearchRestoList extends StatefulWidget {
  final String category;
  const SearchRestoList({Key key, this.category}) : super(key: key);

  @override
  _SearchRestoListState createState() => _SearchRestoListState();
}

class _SearchRestoListState extends State<SearchRestoList> {
  var listener = PaginateRefreshedChangeListener();
  var discountVisible = false;
  var tagVisible =  false;


  @override
  Widget build(BuildContext context) {
    var collection =
    FirebaseFirestore.instance.collection("Restaurant").where("cuisine",arrayContains: widget.category).snapshots();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: () async {
          listener.refreshed = true;
        }, child: PaginateFirestore(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,

          itemBuilderType: PaginateBuilderType.listView, itemBuilder: (int , context , document ) {
        var shoptitle = document.get("name");
        var cuisine = document.get("cuisine");
        var area = document.get("area");
        var discount = document.get("discount");
        var deliveryTime = document.get("deliveryTime");
        var tag = document.get("tag");
        var rating = document.get("rating");
        var shopUid = document.id;
        var openingtime = document.get("opentiming");
        var closingtime = document.get("closetiming");
        var img = document.get("img");
        var inPromo = document.get("inPromotion");
        var status = document.get("status");
        var numReview = document.get("numRating");
        return Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: RestaurentListCard(
            title: shoptitle,
            img: img,
            discount: discount,
            cuisine: cuisine,
            area: area,
            deliveryTime: deliveryTime,
            tag: tag,
            rating: rating,
            discountVisibility: discountVisible,
            tagVisibility: tagVisible,
            shopid: shopUid,
            press: () {
            }, key: Key("resto1"), closetiming: closingtime, opentiming: openingtime, badgeVisibility: inPromo, status: status, numReview: numReview,
          ),
        );

      },
          query: FirebaseFirestore.instance.collection("Restaurant").where("cuisine",arrayContains: widget.category).orderBy("name")

      ),
      ),
    );

  }
}
