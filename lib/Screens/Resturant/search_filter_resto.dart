// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:homelyy/Screens/Resturant/searchrestolist.dart';

class RestoSearchFilterScreen extends StatefulWidget {
  final String titlebar,category;
  const RestoSearchFilterScreen({Key key, this.titlebar, this.category}) : super(key: key);

  @override
  _RestoSearchFilterScreenState createState() => _RestoSearchFilterScreenState();
}

class _RestoSearchFilterScreenState extends State<RestoSearchFilterScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titlebar),),
        body: SearchRestoList(category: widget.category,)
    );
  }
}
