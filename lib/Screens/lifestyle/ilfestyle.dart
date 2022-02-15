import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/models.dart';
import 'lifeproductpage.dart';

class LifestylePage extends StatefulWidget {
  final String id,vid,shopName,uid;
  final List category;
  const LifestylePage({Key key, this.id, this.vid, this.shopName, this.uid, this.category}) : super(key: key);

  @override
  _LifestylePageState createState() => _LifestylePageState();
}

class _LifestylePageState extends State<LifestylePage> {

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {

      },
      child: FutureBuilder<List<CatModel>>(
        future: AllApi().getCategory(vendorId:widget.id),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          var catList = snapshot.requireData;
          print("catlist lenght = ${catList}");

          return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                childAspectRatio: 0.9,),
              itemCount: catList.length,
              itemBuilder: (context,index){
                return InkWell(onTap:(){

                  Get.to(
                      LifeProductPage(
                    id: widget.id,
                    vid:widget.vid,
                    uid:widget.uid,
                    shopName:widget.shopName,
                    catid: catList[index].name,
                  )
                  );

                },child: buildContainer(catList[index].name,catList[index].image));
              },

          );
        }
      ),
    );

  }

  Widget buildContainer(String catname,String catimage) {
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
                    image: NetworkImage("${imageURL}category/$catimage"),
                  ),
                ),
                Container(
                  child: Center(
                      child: Text(
                        catname ,
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
