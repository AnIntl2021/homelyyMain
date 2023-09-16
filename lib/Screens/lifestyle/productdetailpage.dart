
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/Cart/cartPage.dart';
import 'package:homelyy/component/constants.dart';
import 'package:homelyy/component/counterNumber.dart';
import 'package:homelyy/component/homeAppbar.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
 final String? title,itemnumber;
 final String? price;
 final String? note;
 final String? image,cutprice,discount;
 final bool? tagVisibility;
 final bool? stock;
 final bool? discountVisibility;
 final int? totalorders;
 final String? type;


  ProductDetailPage({ Key? key,  this.title,  this.price,  this.note,  this.image, this.cutprice, this.discount, this.tagVisibility, this.stock, this.discountVisibility, this.totalorders, this.type, this.itemnumber})
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
   String? selectedValue;
   String? selectedValueSize;
   String? selectedAvailable;
   String? selectedTotalOrders;
  var defaultValue = 1;
  // var listitem = ListItem;
  var list = [];
  var snapshot1;
  var list1 = [];
  var snapshot2;
  double width = 100.0;

  double height = 150.0;

  double customFontSize = 16;
  var currentTime = "";
  String defaultFontFamily = 'Roboto-Light.ttf';
  List imageof = [];
   late AnimationController controller;
   Animation<double>? animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;
  Widget _appBar(String uid) {
    var stream = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("cart")
        .snapshots();
    return AppBar(
      actions: [
        Container(
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {

          },
          child: Stack(children: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.opencart,
              ),
              onPressed: () {
                print("clicked");
                Get.to(CartPage());
              },
            ),
            StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  var count = snapshot.data!.size;
                  return Positioned(
                    right: 0,
                    child: BadgePositioned(
                      child: Text(
                        count.toString(),
                        style: GoogleFonts.arvo(color: Colors.white),
                      ),
                      // child: Icon(
                      //   FontAwesomeIcons.opencart,
                      //   color: Colors.white,
                      // ),
                    ),
                  );
                }),
          ]),
        ),
      ),]
    );
  }

  Widget _icon(IconData icon,
      {Color color = Colors.black,
        double size = 20,
        double padding = 10,
        bool isOutLine = false}) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    );
  }

  Widget _detailWidget() {
   var astream = FirebaseFirestore.instance.collection("products").doc(widget.itemnumber)
        .collection("size").snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: astream,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var firstSize = snapshot.requireData.docs[0].get("name");
        return DraggableScrollableSheet(
          maxChildSize: .8,
          initialChildSize: .43,
          minChildSize: .43,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                    SizedBox(height: 10),
                    Visibility(
                      visible: widget.discountVisibility!,
                      child: Container(
                        width: 60,
                        height: 25,
                        child: Center(child: Text("₹ ${widget.discount} OFF",style: GoogleFonts.arvo(fontSize: 12,color: Colors.white),)),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: Colors.green,),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text( widget.title!,style:  TextStyle(fontSize: 25),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                    visible: widget.cutprice == "" ? false : true,
                                    child: Text(
                                      widget.cutprice == "" ? "" : "Rs.${widget.cutprice}",
                                      style: TextStyle(fontSize: 16, color: kgreen),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Rs.${ widget.price}",
                                    style: widget.discountVisibility!
                                        ? TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                      decoration: TextDecoration.lineThrough,
                                    )
                                        : TextStyle(fontSize: 16, color: kgreen),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _availableSize(firstSize),
                    SizedBox(
                      height: 20,
                    ),
                    _availableColor(firstSize),
                    SizedBox(
                      height: 20,
                    ),
                    cartCounter(),
                    SizedBox(
                      height: 20,
                    ),
                    _description(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }

  Widget _availableSize(String? firstSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
           "Available Size",
        ),
        SizedBox(height: 20),
        _sizeWidget(
          "size",
          widget.itemnumber,
          firstSize
        )
      ],
    );
  }

  Widget _availableColor(String? firstSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
Text(
        "Available Color",

        ),
        SizedBox(height: 20),
        _colorWidget(
          'colors',
          widget.itemnumber,
          firstSize
        )
      ],
    );
  }


  Widget _colorWidget(String text, String? streamType,String? firstSize) {
    print(text);
    var stream = FirebaseFirestore.instance.collection("products");
    return StreamBuilder<QuerySnapshot>(
        stream: stream.doc(streamType).collection(text).where("size",isEqualTo: selectedValueSize ?? firstSize).snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          }
          var colorQuery = snapshot.data!.docs;
          // var colors = snapshot.data.doc;
          // List<Widget> widget = [];
          // colors.forEach((element) {
          //   var color1 = element.data()["name"];
          //   print(color1);
          // });

          return Container(
            height: 90,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ListView.builder(
                    itemCount: colorQuery.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      var color = Colors.black;
                      // var orderData = snapshot1;
                      // print(orderData.documentID);
                      // var a = "";
                      // orderData.forEach((key, value) {
                      //   a = value;
                      //   list.add(ListItem<String>(value));
                      // });
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            selectedValue = colorQuery[index]["name"];
                            setState(() {
                              selectedAvailable = colorQuery[index]["available"];
                              selectedTotalOrders = colorQuery[index]["totalorders"];
                              // selectedValue = list[index].data;
                            });
                          },
                          child: Column(
                            children: [
                              Text("Only ${colorQuery[index]["available"]} Available",
                                style: GoogleFonts.arvo(color: Colors.green,

                                ),),

                              Container(

                                margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:Colors.black, width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: selectedValue == colorQuery[index]["name"]
                                      ? Colors.deepOrange
                                      : Colors.white,
                                ),
                                child:Text(
                                   colorQuery[index]["name"],
                               style:  TextStyle (fontSize: 16,
                                  color: selectedValue == colorQuery[index]["name"]
                                      ? Colors.white
                                      : color,)
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          );
        });
  }

  Widget _sizeWidget(String text, String? streamType,String? firstSize) {
    print(text);
    var stream = FirebaseFirestore.instance.collection("products");
    return StreamBuilder<QuerySnapshot>(
        stream: stream.doc(streamType).collection(text).snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            );
          }
          var size = snapshot.data!.docs;
          // var colors = snapshot.data.doc;
          // List<Widget> widget = [];
          // colors.forEach((element) {
          //   var color1 = element.data()["name"];
          //   print(color1);
          // });

          return Container(
            height: 50,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ListView.builder(
                    itemCount: size.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      var color = Colors.black;
                      // var orderData = snapshot1;
                      // print(orderData.documentID);
                      // var a = "";
                      // orderData.forEach((key, value) {
                      //   a = value;
                      //   list.add(ListItem<String>(value));
                      // });
                      return GestureDetector(
                        onTap: () {

                          selectedValueSize = size[index]["name"];
                          setState(() {
                            selectedValue = null;
                            // selectedValue = list[index].data;
                          });
                        },
                        child: Container(

                          margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: selectedValueSize == size[index]["name"]
                                ? Colors.deepOrange
                                : Colors.white,
                          ),
                          child: Text(
                            size[index]["name"],
                           style:TextStyle (fontSize: 16,
                            color: selectedValueSize == size[index]["name"]
                                ? Colors.white
                                : color,)
                          ),
                        ),
                      );
                    }),
              ),
            ),
          );
        });
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
        "Description",

        ),
        SizedBox(height: 20),
        Text(widget.note!),
      ],
    );
  }

  FloatingActionButton _flotingButton(String uid) {
    return
      FloatingActionButton(
      onPressed: () {
      if(widget.stock!)  {
          var currentAddingDate =
              DateTime.now().toLocal().toString().split(' ')[0];
          var currentAddingTime =
              DateFormat('kk:mm:ss').format(DateTime.now()).toString();
          var deliveryTime = "";
          if (selectedValueSize == null) {
            final snackBar = SnackBar(
              content: Text('Please Select a Size'),
              backgroundColor: Colors.red,
              duration: Duration(milliseconds: 500),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (selectedValue == null) {
            final snackBar = SnackBar(
              content: Text('Please Select a Color'),
              backgroundColor: Colors.red,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            Map<String, dynamic> items = new Map();
            items['color'] = selectedValue;
            items['img'] = widget.image;
            items['title'] = widget.title;
            items['price'] =
                (defaultValue * int.parse(widget.price!)).toString();
            items['quantity'] = defaultValue.toString();
            items['size'] = selectedValueSize;
            items['uid'] = uid;
            items['addedDate'] = currentAddingDate;
            items['addedTime'] = currentAddingTime;

            items['cutprice'] = widget.cutprice == ""
                ? ""
                : (defaultValue * int.parse(widget.cutprice!)).toString();
            items['ogprice'] = widget.price;
            items['ogcutprice'] = widget.cutprice;
            items['discount'] = widget.discount;
            items['totalorders'] = widget.discount;
            items['stock'] = widget.stock;
            items['type'] = widget.type;
            items['totalorders'] =selectedTotalOrders;
            items['available'] = selectedAvailable;
            items['itemnumber'] = widget.itemnumber;



            FirebaseFirestore.instance
                .collection("users")
                .doc(uid)
                .collection("cart")
                .doc("${widget.title} $selectedValue $selectedValueSize").get().then((value) {
                  if(value.exists){
                    Get.snackbar(
                        "Product Already in Cart", "Select any other Varient of Product",
                        snackPosition: SnackPosition.BOTTOM
                    );
                  }else{
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .collection("cart")
                        .doc("${widget.title} $selectedValue $selectedValueSize")
                        .set(items)
                        .then((value) {
                      setState(() {
                        defaultValue = 1;
                      });
                      final snackBar = SnackBar(
                        content: Text('Product Added To Cart'),
                        backgroundColor: Colors.green,
                        duration: Duration(milliseconds: 1000),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }
            });

          }
        }else{
        Get.snackbar("ITEM OUT OF STOCK", "We will update you when it wil come back",snackPosition: SnackPosition.BOTTOM);
      }
      },
      backgroundColor: Colors.orange,
      child: Icon(Icons.shopping_basket,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  Widget cartCounter() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Quantity",

          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30),
                child: CounterNumberButton(
                  initialValue: defaultValue,
                  minValue: 1,
                  maxValue: 10,
                  step: 1,
                  onChanged: (value) {
                    // get the st value from here

                    setState(() {
                      defaultValue = value.toInt();
                    });
                  },
                  decimalPlaces: 0,
                  color: kgreen,
                  buttonSizeHeight: 30,
                  buttonSizeWidth: 30,
                  textStyle: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(width: 10,),

            ],
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    print("stock ${widget.stock}");
    var currentUser = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(backgroundColor: kgreen,),
      floatingActionButton: _flotingButton(currentUser),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  width : MediaQuery.of(context).size.width,
                  height: 300,
                  child: Image.asset("assets/jeans.png")
                ),
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }
}