import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'homellycolors.dart';

class Intro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IntroState();
  }
}

class IntroState extends State<Intro> {
  List<Slide> listSlides = [];

  @override
  Widget build(BuildContext context) {

    return IntroSlider(
      slides: listSlides,

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listSlides.add(
        Slide
      (
      title: "Welcome to Homelyy",

      widgetDescription: Column(
        children: [
          Text("Order the food that you  like",style: TextStyle(color:Colors.white,fontSize: 25),),
          SizedBox(height: 10),
          Text("Order food from anywhere, anytime. Discover many mouths savoring and figure licking handmade food at just one click. ",style: TextStyle(color:Colors.white,fontSize: 16),),


        ],
      ),
      pathImage: 'assets/burger.png',
      backgroundColor: hmdarkolive,
    )

    );
    listSlides.add(Slide(
     title: " Welcome to Homelyy",

      widgetDescription: Column(
        children: [
          Text("Buy any merchandise at home!",style: TextStyle(color:Colors.white,fontSize: 25),),
          SizedBox(height: 10),
          Text('Buy fresh and trendy merchandise from the comfort of your homes. Shop from the variety of choices that you will ever get.',style: TextStyle(color:Colors.white,fontSize: 16),),
        ],
      ),
      pathImage: 'assets/lifestyleshopping.png',
      backgroundColor: hmdarkolive,
    ));
    listSlides.add(
        Slide(
      title: "Welcome to Homelly",
          widgetDescription: Column(
            children: [
              Text("Fast Delivery",style: TextStyle(color:Colors.white,fontSize: 25),),
              SizedBox(height: 5),
              Text('You will get your orders delivered quickly and efficiently while keeping an eye on safety and quality standards.',style: TextStyle(color:Colors.white,fontSize: 16),),
            ],
          ),
      pathImage: 'assets/fastdelivery.png',
      backgroundColor: hmdarkolive,
    ));
    // listSlides.add(Slide(
    //   title: "Serie A",
    //   description: "Lega Nazionale Professionisti Serie A",
    //   pathImage: "images/serie_a.jpg",
    //   backgroundColor: Colors.blueAccent,
    // ));
    // listSlides.add(Slide(
    //   title: "Ligue 1",
    //   description: "Ligue 1 Conforama",
    //   pathImage: "images/ligue_one.png",
    //   backgroundColor: Colors.amberAccent,
    // ));
  }


}
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intro(),
    );
  }
}