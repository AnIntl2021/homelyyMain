import 'package:flutter/cupertino.dart';

import 'iteminfo.dart';

class Body extends StatefulWidget {
  final String type;
  final String rating;
  final String title;
  final id,opentiming,closetiming,shopname;
  final List<dynamic> cuisine;
  final int numReviews;
  final List category;
  const Body({ Key key,  this.title,  this.rating,  this.cuisine,  this.id,  this.opentiming,  this.closetiming,  this.shopname,  this.numReviews, this.type, this.category})
      : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return ItemInfo(
      category: widget.category,
      type: widget.type,
      title: widget.title,
      rating: widget.rating,
      numReview: widget.numReviews,
      cuisine: widget.cuisine, key: Key("itemInfo"),id: widget.id, closetiming: widget.closetiming, opentiming: widget.opentiming, shopname: widget.shopname,
    );
  }
}