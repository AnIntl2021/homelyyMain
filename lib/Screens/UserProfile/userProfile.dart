import 'package:contactus/contactus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/UserProfile/contactus.dart';
import 'package:homelyy/Screens/UserProfile/wallet.dart';
import 'package:homelyy/Screens/login/loginScreen.dart';
import 'package:homelyy/component/constants.dart';

class UserProfile extends StatefulWidget {
  final String id;

  const UserProfile({Key key, this.id}) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("User Name"),
                TextButton(onPressed: () {}, child: Text("EDIT"))
              ],
            ),
            buildListTile("MY ORDERS", FontAwesomeIcons.list, () {
              // Get.to(
              //     OrderPage(
              //   fromScreen: "Home",
              // )
              // );
            }
            ),
            buildListTile("WALLET", FontAwesomeIcons.wallet, () {

              Get.to(UserWallet(id: widget.id,));

            }
            ),
            buildListTile("REFER & EARN", FontAwesomeIcons.share, () {
              Fluttertoast.showToast(msg: "Available in Next Update");
            }),
            buildListTile("CONTACT US", FontAwesomeIcons.phone, () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyContactUs())
              );
            }),
            buildListTile("HELP & FAQ", FontAwesomeIcons.phone, () {
              Fluttertoast.showToast(msg: "Available in Next Update");
            }),
            Divider(),
            buildListTile("LOGOUT", FontAwesomeIcons.doorClosed, () {
              // FirebaseAuth.instance
              //     .signOut()
              //     .then((value) => Navigator.pushAndRemoveUntil<dynamic>(
              //           context,
              //           MaterialPageRoute(builder: (context) => LoginScreen()),
              //           (route) =>
              //               false, //if you want to disable back feature set to false
              //         ));
            }),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(var title, var icon, var press) => ListTile(
    trailing: Icon(FontAwesomeIcons.arrowRight),
    title: Text(title),
    leading: Icon(icon),
    onTap: press,
  );
}
