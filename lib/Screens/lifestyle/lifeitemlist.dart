import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:homelyy/Screens/lifestyle/lifeprodcard.dart';
import 'package:homelyy/component/searchBoxx.dart';

import '../../component/constants.dart';

class LifeItemList extends StatefulWidget {
  final String vid,uid,shopName,catid;
  const LifeItemList({Key key, this.vid, this.uid, this.shopName, this.catid}) : super(key: key);

  @override
  _LifeItemListState createState() => _LifeItemListState();
}

class _LifeItemListState extends State<LifeItemList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:  Column(

        children: [   


              LifeProdCard(vid:widget.vid,uid:widget.uid,shopName:widget.shopName,catId: widget.catid,),

        ],
      )
    );
  }
}
