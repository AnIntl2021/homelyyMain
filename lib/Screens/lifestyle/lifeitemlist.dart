import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/Screens/lifestyle/lifeprodcard.dart';
import 'package:homelyy/component/searchBoxx.dart';

class LifeItemList extends StatefulWidget {
  const LifeItemList({Key key}) : super(key: key);

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

          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: [

              LifeProdCard(),

            ],
          ),
        ],
      )
    );
  }
}
