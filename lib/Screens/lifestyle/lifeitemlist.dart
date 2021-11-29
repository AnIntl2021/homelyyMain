import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/Screens/lifestyle/lifeprodcard.dart';
import 'package:homelyy/component/searchBoxx.dart';

class LifeItemList extends StatefulWidget {
  final String vid,uid,shopName;
  const LifeItemList({Key key, this.vid, this.uid, this.shopName}) : super(key: key);

  @override
  _LifeItemListState createState() => _LifeItemListState();
}

class _LifeItemListState extends State<LifeItemList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Column(

        children: [   AnimatedContainer(
          duration: Duration(milliseconds: 200),
          child: SearchBox(
            onChanged: (value) {

            },
            key: Key("searchBox"),
          ),
        ),


              LifeProdCard(vid:widget.vid,uid:widget.uid,shopName:widget.shopName,catId: "CAT33",),

        ],
      )
    );
  }
}
