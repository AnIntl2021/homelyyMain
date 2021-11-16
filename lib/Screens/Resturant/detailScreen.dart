
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/Screens/Resturant/body.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/homeAppbar.dart';


class DetailsScreen extends StatefulWidget {
  final type;
  final String rating;
  final String shoptitle;
  final List<dynamic> cuisine;
  final String shopUid,opentiming,closetiming;
  final int numReview;
  final List category;

  const DetailsScreen({
     Key key,
     this.rating,
     this.shoptitle,
     this.cuisine,
     this.shopUid,  this.opentiming,  this.closetiming,  this.numReview, this.type, this.category,
  }) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // var uid = FirebaseAuth.instance.currentUser.uid.toString();
  @override
  Widget build(BuildContext context) {
    // var stream = FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(uid)
    //     .collection("cart")
    //     .snapshots();
    return Body(
        category:widget.category,
        type: widget.type,
        title: widget.shoptitle,
        rating: widget.rating,
        numReviews: widget.numReview,
        cuisine: widget.cuisine, key: Key("shopBody"),id: widget.shopUid, opentiming: widget.opentiming, closetiming: widget.closetiming, shopname: widget.shoptitle ,
      );
  }
}