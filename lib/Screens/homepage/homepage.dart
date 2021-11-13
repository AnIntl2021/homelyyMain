import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homelyy/Screens/UserProfile/userProfile.dart';
import 'package:homelyy/Screens/homepage/homeBody.dart';
import 'package:homelyy/Screens/orders/orderpage.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:homelyy/component/models.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // AllApi().postUser(UserModel(
    //     name:"Arsalan",
    //     address:"Arsalan",
    //     ref:"Arsalan",
    //     email:"Arsalan",
    //     dob:"Arsalan",
    //     location:[{
    //       "type":"Point",
    //       "point":[1,1]
    //     }],
    //     member:"Arsalan",
    //     phone:"Arsalan",
    //     token:"Arsalan",
    //     wallet:"Arsalan"
    // ));

    final List<Widget> viewContainer = [
      Body(
        key: Key("Bodyhome"),
        fromMap:  false,
      ),
      OrderPage(),
      UserProfile(),
      Container(),

    ];


    return SafeArea(
      child: Scaffold(
        body:   Scaffold(
                appBar: homeAppBar(context,"GROPOD",""),
                bottomNavigationBar: buildBNB(),
                body: IndexedStack(
                  index: currentIndex,
                  children: viewContainer,
                ),
              )

      ),
    );
  }

  Widget buildBNB() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 75,
      width: double.infinity,
      // double.infinity means it cove the available width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -7),
            blurRadius: 33,
            color: kgreen.withOpacity(0.11),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.home,
                  size: currentIndex == 0 ? 30 : 24,
                  color: currentIndex == 0 ?  kgreen : kblackcolor.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
              ),
              Text("Home")
            ],
          ),
          Stack(children: [
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.opencart,
                    size: currentIndex == 1 ? 30 : 24,
                    color: currentIndex == 1 ?  kgreen : kblackcolor.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
                Text("Your Orders")
              ],
            ),
          ]),
          Column(
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.user,
                  size: currentIndex == 2 ? 30 : 24,
                  color: currentIndex == 2 ?  kgreen : kblackcolor.withOpacity(0.5),
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
              ),
              Text("Profile")
            ],
          ),
          Column(
            children: [
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.heart,
                    size: currentIndex == 3 ? 30 : 24,
                    color: currentIndex == 3 ?  kgreen : kblackcolor.withOpacity(0.5),
                  ),
                  onPressed: (){
                    currentIndex = 3;
                  }),
              Text("Rate Us")
            ],
          ),
        ],
      ),
    );
  }
}
