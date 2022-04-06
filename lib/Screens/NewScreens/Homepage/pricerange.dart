import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/Screens/NewScreens/homellycolors.dart';

class Popups extends StatefulWidget {
  @override
  State<Popups> createState() => _PopupsState();
}

class _PopupsState extends State<Popups> {
 RangeValues values = RangeValues(1,100);
 RangeLabels labels = RangeLabels("1", "100");
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SliderTheme(
          data: SliderThemeData(
          trackHeight: 4,
           thumbColor: hmolive,
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
            activeTrackColor: hmolive,
            inactiveTrackColor: hmgray2,
            valueIndicatorColor: hmolive,
            showValueIndicator: ShowValueIndicator.always,
            minThumbSeparation: 100,

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RangeSlider(
                min: 0,
                max: 500,
                divisions: 10,
                labels: labels,
                onChanged: (value){setState(() {
                  values = value;
                  labels = RangeLabels('\$' + value.start.toString(),('\$' + value.end.toString()));
                });},
                values: values,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align( alignment: Alignment.centerLeft, child: Text("\$0")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 320),
                    child: Text("\$500"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}