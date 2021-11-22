// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/Screens/homepage/Restaurant/restCard.dart';
import 'package:homelyy/component/models.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class PopularRestaurantList extends StatefulWidget {
  final String type;
  final List category;
  final GeoPoint userGeoPoint;
  final bool status;
  final List listofRestaurant;
  const PopularRestaurantList({Key key, this.category, this.userGeoPoint, this.status, this.type, this.listofRestaurant}) : super(key: key);

  @override
  _PopularRestaurantListState createState() => _PopularRestaurantListState();
}

class _PopularRestaurantListState extends State<PopularRestaurantList> {
  var listener = PaginateRefreshedChangeListener();


  @override
  Widget build(BuildContext context) {

  //
  // var uid = FirebaseAuth.instance.currentUser.uid;
  //   final geo = Geoflutterfire();
  //   var firestore =
  //       FirebaseFirestore.instance;
  //   var  future = firestore.collection("users").doc(uid).get();


    return  ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
      itemCount: widget.listofRestaurant.length,
      itemBuilder: (context,index) {

      return  Padding(

            padding:  EdgeInsets.all(8.0),

            child: RestaurentListCard(
              category:widget.category,
              title: widget.listofRestaurant[index]["name"],

              type:widget.listofRestaurant[index]["type"],

              img:
              widget.type == "0" ?"https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/Restaurant-logo-design-webp.webp?alt=media&token=847033e4-0e4b-4987-ac99-253736f10487"
                  : "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Slider%2Fpuma.jpg?alt=media&token=7790fda5-ee3c-4898-801c-f8a46ef93baa",

              discount: "15",

              cuisine: widget.category == "0" ? ["Italian", "Mughlai", "Chinese"] : ["Half Tshirts","Full Tshirts,""Jeans"],

              area: widget.listofRestaurant[index]["address"],

              deliveryTime: "15-20",

              tag: "",

              rating: widget.listofRestaurant[index]["rating"],

              discountVisibility: true,

              tagVisibility: false,

              shopid: widget.listofRestaurant[index]["vendorid"],

              press: () {},

              key: Key("resto1"),

              closetiming: "10",

              opentiming: "10",

              badgeVisibility: widget.listofRestaurant[index]["inPromotion"] == "1" ? true : false,

              status: true,

              numReview: 12,

            )
        );
      }
    );

    //   PaginateFirestore(
    //       physics: NeverScrollableScrollPhysics(),
    //       shrinkWrap: true,
    //       itemBuilderType: PaginateBuilderType.listView,
    //       itemBuilder: (int, context, document) {
    //         // var shoptitle = future.data[int]["name"];
    //         // List<dynamic> cuisine = future.data[int]["cuisine"];
    //         // var area = future.data[int]["area"];
    //         // var discount = future.data[int]["discount"];
    //         // var deliveryTime = future.data[int]["deliveryTime"];
    //         // var tag = future.data[int]["tag"];
    //         // var rating = future.data[int]["rating"];
    //         // var shopUid = future.data[int].id;
    //         // var openingtime = future.data[int]["opentiming"];
    //         // var closingtime = future.data[int]["closetiming"];
    //         // var img = future.data[int]["img"];
    //         // var inPromo = future.data[int]["inPromotion"];
    //         // var status = future.data[int]["status"];
    //         // var numReview = future.data[int]["numRating"];
    //         // GeoPoint shopLocation =
    //         // future.data[int]["location.geopoint"];
    //
    //         // var distancehave = geopoint.haversineDistance(
    //         //     lat: shopLocation.latitude,
    //         //     lng: shopLocation.longitude);
    //         // var distance = geopoint.distance(
    //         //     lat: shopLocation.latitude,
    //         //     lng: shopLocation.longitude);
    //
    //         // print(
    //         //     "getting Restaurant $shopUid $distancehave $distance");
    //
    //         return Container(
    //           margin: EdgeInsets.only(top: 10, bottom: 10),
    //           child: RestaurentListCard(
    //
    //
    //             title: "Burger Adda",
    //             img: "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/Restaurant-logo-design-webp.webp?alt=media&token=847033e4-0e4b-4987-ac99-253736f10487",
    //             discount: "15",
    //             cuisine: ["Italian","Mughlai","Chinese"],
    //             area: "Farwania",
    //             deliveryTime: "15-20m",
    //             tag: "",
    //             rating: "",
    //             discountVisibility: true,
    //             tagVisibility:  false,
    //             shopid: "shopUid",
    //             press: () {},
    //             key: Key("resto1"),
    //             closetiming: "10",
    //             opentiming: "10",
    //             badgeVisibility: true,
    //             status: true,
    //             numReview: 12,
    //
    //
    //           ),
    //         );
    //       },
    //       query: FirebaseFirestore.instance
    //           .collection("Restaurant").
    //       where(
    //           "type", isEqualTo: "Restaurant")
    //           .where("inPromotion", isEqualTo: true)
    //           .orderBy("name")),
    // );

    //   FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    //   future: future,
    //   builder: (context,future){
    //     if (!future.hasData) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     GeoPoint userGeoPoint = future.requireData.get("location.geopoint");
    //
    //     GeoFirePoint geopoint = GeoFirePoint(userGeoPoint.latitude, userGeoPoint.longitude );
    //     var ref  = geo.collection(collectionRef: firestore.collection("Restaurant").
    //         where(
    //         "type", isEqualTo: "Restaurant")
    //         .where("inPromotion",isEqualTo: true))
    //         .within(center: geopoint, radius: 20, field: "location");
    //     ref.listen((event) {
    //     }).asFuture();
    //  return StreamBuilder(
    //       stream: ref,
    //       builder: (context, future) {
    //         if (!future.hasData) {
    //           return Center(child: CircularProgressIndicator());
    //         }
    //         return Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: PaginateFirestore(
    //               physics: NeverScrollableScrollPhysics(),
    //               shrinkWrap: true,
    //               itemBuilderType: PaginateBuilderType.listView,
    //               itemBuilder: (int, context, document) {
    //                 var shoptitle = future.data[int]["name"];
    //                 List<dynamic> cuisine = future.data[int]["cuisine"];
    //                 var area = future.data[int]["area"];
    //                 var discount = future.data[int]["discount"];
    //                 var deliveryTime = future.data[int]["deliveryTime"];
    //                 var tag = future.data[int]["tag"];
    //                 var rating = future.data[int]["rating"];
    //                 var shopUid = future.data[int].id;
    //                 var openingtime = future.data[int]["opentiming"];
    //                 var closingtime = future.data[int]["closetiming"];
    //                 var img = future.data[int]["img"];
    //                 var inPromo = future.data[int]["inPromotion"];
    //                 var status = future.data[int]["status"];
    //                 var numReview = future.data[int]["numRating"];
    //                 GeoPoint shopLocation =
    //                     future.data[int]["location.geopoint"];
    //
    //                 var distancehave = geopoint.haversineDistance(
    //                     lat: shopLocation.latitude,
    //                     lng: shopLocation.longitude);
    //                 var distance = geopoint.distance(
    //                     lat: shopLocation.latitude,
    //                     lng: shopLocation.longitude);
    //
    //                 print(
    //                     "getting Restaurant $shopUid $distancehave $distance");
    //
    //                 return Container(
    //                   margin: EdgeInsets.only(top: 10, bottom: 10),
    //                   child: RestaurentListCard(
    //                     title: shoptitle,
    //                     img: img,
    //                     discount: discount,
    //                     cuisine: cuisine,
    //                     area: area,
    //                     deliveryTime: deliveryTime,
    //                     tag: tag,
    //                     rating: rating,
    //                     discountVisibility: discount == "" ? false : true,
    //                     tagVisibility: tag == "new" ? true : false,
    //                     shopid: shopUid,
    //                     press: () {},
    //                     key: Key("resto1"),
    //                     closetiming: closingtime,
    //                     opentiming: openingtime,
    //                     badgeVisibility: inPromo,
    //                     status: status,
    //                     numReview: numReview,
    //                   ),
    //                 );
    //               },
    //               query: FirebaseFirestore.instance
    //                   .collection("Restaurant").
    //               where(
    //               "type", isEqualTo: "Restaurant")
    //                   .where("inPromotion", isEqualTo: true)
    //                   .orderBy("name")),
    //         );
    //       });
    // });
  }
}
