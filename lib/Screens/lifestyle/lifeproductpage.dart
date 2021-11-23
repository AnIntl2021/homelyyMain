import 'package:flutter/material.dart';
import 'package:homelyy/Screens/lifestyle/lifeitemlist.dart';
import 'package:homelyy/component/homeAppbar.dart';

class LifeProductPage extends StatefulWidget {
  final String id;
  const LifeProductPage({Key key, this.id}) : super(key: key);

  @override
  _LifeProductPageState createState() => _LifeProductPageState();
}

class _LifeProductPageState extends State<LifeProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: homeAppBar(context,"stream", widget.id),
        body: SingleChildScrollView(
            child: LifeItemList(
              key: Key("grocelist"),
            ))
    );
  }
}
