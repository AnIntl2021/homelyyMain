import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lifeproductpage.dart';

class LifestylePage extends StatefulWidget {
  final String id;
  const LifestylePage({Key key, this.id}) : super(key: key);

  @override
  _LifestylePageState createState() => _LifestylePageState();
}

class _LifestylePageState extends State<LifestylePage> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        Get.to(LifeProductPage(
                  id: widget.id,
        ));
      },
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
          childAspectRatio: 0.9,
          children:[ buildContainer("T-Shirts"),
            buildContainer("Shirts"),
            buildContainer("Jeans"),
            buildContainer("Shorts"),
            buildContainer("Shoes"),
            buildContainer("Socks"),
            buildContainer("Belts"),
            buildContainer("Accessories"),

          ]
      ),
    );

  }

  Container buildContainer(String title) {
    return Container(
      decoration:
      BoxDecoration(border: Border.all(color: Colors.black)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Image(
                width: Get.width*0.25,
                image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Product%2F%20scaled_image_picker4949965731012678741.jpg?alt=media&token=9ab654fd-93ae-41a4-aab3-d66a26c1c46a"),
              ),
            ),
            Container(
              child: Center(
                  child: Text(
                    title,
                    style: GoogleFonts.arvo(
                        color: Colors.black,
                        fontSize: 14
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
