import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Resturant/prodlistcard.dart';
import 'package:homelyy/component/api.dart';
import 'package:homelyy/component/models.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ItemList extends StatefulWidget {
  final String streamTitle, id, shopname,uid,foodid;
  final Function callback;
  final List category;

  const ItemList({
    Key key,
    this.streamTitle,
    this.callback,
    this.id,
    this.shopname,
    this.category, this.uid, this.foodid,
  }) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // var uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    PaginateRefreshedChangeListener refreshChangeListener =
        PaginateRefreshedChangeListener();
    PaginateRefreshedChangeListener refreshChangeListener2 =
        PaginateRefreshedChangeListener();
    var discountVisible = false;
    var tagVisible = false;
    // var catStream = FirebaseFirestore.instance
    //     .collection("Restaurant")
    //     .doc(widget.id)
    //     .collection("Category")
    //     .snapshots();
    // var prodStream = FirebaseFirestore.instance
    //     .collection("Restaurant")
    //     .doc(widget.id)
    //     .collection("products")
    //     .snapshots()
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RefreshIndicator(onRefresh: () async {
                refreshChangeListener.refreshed = true;
                print("Refreshed");
              }, child: ListView.builder(
                shrinkWrap: true,
                  itemCount:widget.category.length,
                  itemBuilder: (context, index) {

                return FutureBuilder(
                  future: AllApi().getcat(widget.category[index]),
                  builder: (context, snapshot) {

                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(color: Colors.white,),
                      );
                    }

                    var catList = snapshot.requireData;
                    print("catlist lenght = ${catList}");

                    return Column(
                      children: [
                        ExpansionTile(
                          onExpansionChanged: (result) {
                            if (result == true) {
                              setState(() {});
                            }
                          },
                          title: Text(catList),
                          children: [
                            FutureBuilder(
                              future: AllApi().getcatfood( widget.id, widget.category[index]),
                              builder: (context, snapshot1) {


                                if(!snapshot1.hasData){

                                  return Center(
                                    child: CircularProgressIndicator(color: Colors.white,),
                                  );

                                }

                                List<ProductModel> foodList = snapshot1.requireData;
                                print("foodList lenght = ${foodList}");



                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      RefreshIndicator(
                                          onRefresh: () async {
                                            refreshChangeListener2.refreshed = true;
                                            print("Refreshed");
                                          },
                                          child: ListView.builder(
                                            itemCount: foodList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return ProductListCard(
                                                title: foodList[index].name,
                                                totalorders: 1,
                                                price: foodList[index].price,
                                                recipe: foodList[index].description,
                                                stock: true,
                                                tagVisibility: true,
                                                img: "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/pizza_combo.webp?alt=media&token=ab1aa2b7-d1f3-4c30-8015-9c8d70161d37",
                                                key: Key("prodlistcard"),
                                                press: () {},
                                                discount: (int.parse("100") - int.parse("80"))
                                                    .toString(),
                                                discountVisibility: true,
                                                uid: widget.uid,
                                                foodid: foodList[index].foodid,
                                                shopName: widget.shopname,
                                                vid: widget.id,
                                                cutprice: "80",
                                              );
                                            }
                                          )

                                          ),
                                    ],
                                  ),
                                );
                              }
                            )
                          ],
                        ),
                        Divider()
                      ],
                    );
                  }
                );

              })

                  ),
            ],
          ),
        );

  }
}
