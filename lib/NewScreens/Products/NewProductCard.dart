import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/component/UserController.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../Screens/Cart/cartshop.dart';
import '../../Screens/NewScreens/homellycolors.dart';
import '../../component/api.dart';
import '../../component/constants.dart';
import '../../component/counterNumber.dart';
import '../../component/models.dart';
import '../loginpage.dart';

class NewProductCard extends StatefulWidget {
  final String title,
       description,
  varient,
  type,
   symbol,
       price,
   image,
       vid,
   cutprice,
       shopName,
   uid,
  foodid;

  final function;

     final bool stock,  discountVisibility;



  const NewProductCard({Key key, this.title, this.description, this.symbol, this.price, this.image, this.vid, this.cutprice, this.shopName, this.uid, this.foodid, this.stock, this.discountVisibility, this.function, this.type, this.varient}) : super(key: key);

  @override
  _NewProductCardState createState() => _NewProductCardState();
}

class _NewProductCardState extends State<NewProductCard> {
  int _counter = 0;
  increment() async {

    setState(() {
      _counter++;
    });

    print('print conter = $_counter');

      Map<String, String> updateQuantity = new Map();
      updateQuantity['quantity'] = _counter.toString();
      var changedprice = _counter * int.parse(widget.price);
      var changedcutprice = widget.cutprice == ""
          ? ""
          : _counter * int.parse(widget.cutprice);

      var quantity = _counter.toString();
      var uuid = Uuid();
      var newUid = uuid.v1().toString().split("-");

      await AllApi().postCart(CartModel(
        img: widget.image.replaceAll("https://thehomelyy.com/images/products/", ""),
        price: changedprice.toString(),
        title: widget.title,
        recipe: widget.description,
        quantity: quantity.toString(),
        requirement: "",
        itemnumber: newUid[0] + newUid[4],
        cutprice: changedcutprice.toString(),
        ogprice: widget.price,
        ogcutprice: widget.cutprice,
        discount: '0',
        shop: widget.shopName,
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        time: DateFormat('hh-MM-yyyy').format(DateTime.now()),
        ref: widget.uid,
        vendorid:widget.vid,
        foodid: widget.foodid,
      ),"Update"
      );
     widget.function;




  }

  decrement() async {
      print('print conter = $_counter');
      if (_counter == 1 ) {
        await AllApi()
            .removeCart(widget.uid, widget.vid, widget.foodid);
        await AllApi()
            .removeShopCart(widget.uid, widget.vid);
        setState(() {
          _counter = 0;

        });
        Fluttertoast.showToast(msg: "Removed From Cart");
        Get.back()
        ;
        widget.function;

        Get.find<UserController>().update();

      } else {
        setState(() {
          _counter--;
        });
        Map<String, String> updateQuantity = new Map();
        updateQuantity['quantity'] = _counter.toString();
        var changedprice = _counter * int.parse(widget.price);
        var changedcutprice = widget.cutprice == ""
            ? ""
            : _counter * int.parse(widget.cutprice);

        var quantity = _counter.toString();
        var uuid = Uuid();
        var newUid = uuid.v1().toString().split("-");

        await AllApi().postCart(CartModel(
          img: widget.image.replaceAll("https://thehomelyy.com/images/products/", ""),
          price: changedprice.toString(),
          title: widget.title,
          recipe: widget.description,
          quantity: quantity.toString(),
          requirement: "",
          itemnumber: newUid[0] + newUid[4],
          cutprice: changedcutprice.toString(),
          ogprice: widget.price,
          ogcutprice: widget.cutprice,
          discount: '0',
          shop: widget.shopName,
          date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
          time: DateFormat('hh-MM-yyyy').format(DateTime.now()),
          ref: widget.uid,
          vendorid:widget.vid,
          foodid: widget.foodid,
        ),"Update"
        );
        setState(() {

        });
      }



  }

   createsnackbar(context) {
      final snackBar = SnackBar(
        backgroundColor: Colors.transparent,

        content: Container(
          width: Get.width,
          height: 100,
          child: Stack(
            children: [
              Container(
                  height: 100,
                  width: Get.width,
                color: hmgreen,
                  ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 200,
                  top: 30,
                ),
                child: Container(
                  child: Image.asset("assets/hero 1.png"),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 70),
                    child: Text(
                      "30% off on all purchases!",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70, top: 5),
                    child: Text(
                      "(upto 2 orders)",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 70, top: 10),
                          child: Text("Claim now",
                              style:
                              TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 17),
                          child: Image.asset(
                            "assets/arrow_homepage.png",
                            scale: .7,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        duration: Duration(minutes: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
              height: 120,
              width: 120,
              child: ClipRRect(
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context,
                        Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: kblackcolor,
                          value: loadingProgress
                              .expectedTotalBytes != null
                              ? loadingProgress
                              .cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ))),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.title}",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    // Image.asset("assets/Rectangle 66.png"),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Visibility(
                          visible: widget.discountVisibility,
                          child: Text("${widget.symbol} ${widget.cutprice}",
                            style: TextStyle(fontSize: 16,),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.symbol} ${widget.price}",
                          style: widget.discountVisibility
                              ? TextStyle(
                            fontSize: 14,

                            decoration: TextDecoration.lineThrough,
                          )
                              : TextStyle(fontSize: 16,),
                        ),
                      ],
                    ),


                    SizedBox(
                      width: 70,
                    ),
                    Visibility(
                      visible: _counter != 0 && widget.type == 'restro',
                      child: Container(
                        height: 20,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                decrement(
                                );
                                setState(() {});
                              },
                              child: Icon(
                                Icons.remove,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: hmgray2,
                                ),
                                height: 20,
                                width: 20,
                                child: Center(
                                    child: Text(
                                      "$_counter",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ))),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                increment();

                                setState(() {

                                });
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                    widget.description,
                    style: TextStyle(fontSize: 8)),
                Align(
                  alignment: Alignment.bottomRight,
                  child
                      :

                  widget.stock ?
                  InkWell(
                    onTap: () async {
                      print('typeofcard = ${widget.type}');
                    if(widget.type == 'restro')  {
                              var uuid = Uuid();
                              var newUid = uuid.v1().toString().split("-");

                              if (widget.uid == 'Guest') {
                                Get.to(LoginpageNew());
                              } else {
                                await AllApi().postCart(
                                    CartModel(
                                      img: widget.image.replaceAll(
                                          "https://thehomelyy.com/images/products/",
                                          ""),
                                      price: widget.price,
                                      title: widget.title,
                                      recipe: widget.description,
                                      quantity: '1',
                                      requirement: "",
                                      itemnumber: newUid[0] + newUid[4],
                                      cutprice: widget.cutprice,
                                      ogprice: widget.price,
                                      ogcutprice: widget.cutprice,
                                      discount: '0',
                                      shop: widget.shopName,
                                      date: DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now()),
                                      time: DateFormat('hh-MM-yyyy')
                                          .format(DateTime.now()),
                                      ref: widget.uid
                                          .toString()
                                          .replaceAll(" ", ""),
                                      vendorid: widget.vid
                                          .toString()
                                          .replaceAll(" ", ""),
                                      foodid: widget.foodid
                                          .toString()
                                          .replaceAll(" ", ""),
                                    ),
                                    "Add");

                                await AllApi().postShopCart(CartModel(
                                  shop: widget.shopName,
                                  ref:
                                      widget.uid.toString().replaceAll(" ", ""),
                                  vendorid:
                                      widget.vid.toString().replaceAll(" ", ""),
                                ));

                                setState(() {
                                  Get.isSnackbarOpen ? Get.back() : print("sd");

                                  Get.snackbar(
                                    "Go to Cart",
                                    "message",
                                    duration: Duration(minutes: 15),
                                    snackPosition: SnackPosition.BOTTOM,
                                    snackbarStatus: (value) {
                                      print("snackbar status $value");
                                    },
                                    backgroundColor: kgreen,
                                    icon: FutureBuilder(
                                        future: AllApi().getCartCount(
                                          widget.uid,
                                        ),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: kgreen,
                                              ),
                                            );
                                          }

                                          var cartCount = snapshot.requireData;

                                          print(
                                              "councart = ${widget.uid} $cartCount");

                                          return Stack(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Stack(children: [
                                                  IconButton(
                                                      icon: Icon(
                                                        FontAwesomeIcons
                                                            .opencart,
                                                        color: kdarkgreen,
                                                      ),
                                                      onPressed: () {
                                                        Get.to(CartShopPage(
                                                            ref: widget.uid));
                                                      }),
                                                  Positioned(
                                                    right: 0,
                                                    child: Badge(
                                                      badgeContent: Text(
                                                        cartCount,
                                                        style: GoogleFonts.arvo(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      // child: Icon(
                                                      //   FontAwesomeIcons.opencart,
                                                      //   color: Colors.white,
                                                      // ),
                                                    ),
                                                  )
                                                ]),
                                              ),
                                            ],
                                          );
                                        }),
                                  );

                                  // createsnackbar(context);

                                  print("addedto cart");
                                  _counter = 1;
                                });
                              }
                            }else{

                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: StatefulBuilder(
                                  builder: (context, setState) {
                                    return SingleChildScrollView(
                                      child: FutureBuilder(
                                        builder: (context, snapshot) {

                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            );
                                          }

                                          List<LifeProductModel> prod1 =
                                              snapshot.requireData;
                                          print("foodList lenght2 = ${prod1}");


                                          return Container(
                                            height: Get.height * 0.6,
                                            width: Get.width * 0.9,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: prod1.length,
                                              itemBuilder: (context, index) {
                                                print("listofproducts $prod1");
                                                var title =
                                                    prod1[index].name;
                                                var img =
                                                    prod1[index].image;
                                                var prodprice =
                                                    prod1[index].price;
                                                var prodstock =
                                                    prod1[index].status;
                                                // var catogry = product[index]["subcat"];
                                                // var collection = product[index]["collection"];
                                                var prodcutprice =
                                                    prod1[index].cutprice;
                                                var discountVisibility =
                                                prodcutprice != "0"
                                                    ? false
                                                    : true;
                                                var prodDiscount = prodcutprice ==
                                                    ""
                                                    ? ""
                                                    : (int.parse(prodprice) -
                                                    int.parse(
                                                        prodcutprice))
                                                    .toString();
                                                var defaultquantity = 0;
                                                // var totalorders = prod[index]["totalorders"];
                                                return StatefulBuilder(
                                                    builder:
                                                        (context, setState1) {
                                                      return Container(

                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(10),
                                                        ),
                                                        child: Material(
                                                          color:
                                                          Colors.transparent,
                                                          child: InkWell(
                                                            onTap: () {},
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                              child: Stack(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              margin:
                                                                              EdgeInsets.only(right: 50),
                                                                              child:
                                                                              Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Container(
                                                                                      child: Text(
                                                                                        title,
                                                                                        style: GoogleFonts.slabo27px(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blueGrey),
                                                                                        maxLines: 2,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                                height: 5),
                                                                            // Container(
                                                                            //   width:
                                                                            //   100,
                                                                            //   child:
                                                                            //   Text(
                                                                            //     produnit,
                                                                            //     maxLines: 4,
                                                                            //     style: TextStyle(color: Colors.black.withOpacity(0.5)),
                                                                            //   ),
                                                                            // ),
                                                                            SizedBox(
                                                                                height: 5),
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                              children: [
                                                                                Visibility(
                                                                                  visible: prodcutprice == "0" ? false : true,
                                                                                  child: Text(
                                                                                    "${widget.symbol}${prodcutprice}",
                                                                                    style: TextStyle(fontSize: 16, color: kdarkgreen),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  "${widget.symbol}${prodprice}",
                                                                                  style: prodcutprice != "0"
                                                                                      ? TextStyle(
                                                                                    fontSize: 14,
                                                                                    color: Colors.blueGrey,
                                                                                    decoration: TextDecoration.lineThrough,
                                                                                  )
                                                                                      : TextStyle(fontSize: 16, color: kdarkgreen),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Divider()
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Visibility(
                                                                    visible: defaultquantity <
                                                                        1 &&
                                                                        prodstock
                                                                        ? true
                                                                        : false,
                                                                    child: Positioned(
                                                                        bottom: 0,
                                                                        right: 0,
                                                                        child: ElevatedButton(
                                                                            onPressed: () async {
                                                                              if(widget.uid == 'Guest'){
                                                                                Get.to(LoginpageNew());
                                                                              }else{
                                                                                var itemInitoal =
                                                                                DateTime.now().millisecond.toString();
                                                                                setState1((){
                                                                                  _counter = 1;
                                                                                });
                                                                                var uuid = Uuid();
                                                                                var newUid = uuid.v1().toString().split("-");

                                                                                await AllApi().postCart(CartModel(
                                                                                  img: widget.image,
                                                                                  price:prodprice,
                                                                                  title: title,
                                                                                  recipe: "recipe",
                                                                                  quantity: '1',
                                                                                  requirement: "",
                                                                                  itemnumber: newUid[0] + newUid[4],
                                                                                  cutprice: prodcutprice,
                                                                                  ogprice: prodprice,
                                                                                  ogcutprice: prodcutprice,
                                                                                  discount: "10",
                                                                                  shop: widget.shopName,
                                                                                  date: DateFormat('dd-MM-yyyy')
                                                                                      .format(DateTime.now()),
                                                                                  time: DateFormat('hh-MM-yyyy')
                                                                                      .format(DateTime.now()),
                                                                                  ref: widget.uid.toString().replaceAll(" ", ""),
                                                                                  vendorid: widget.vid.toString().replaceAll(" ", ""),
                                                                                  foodid: prod1[index].productid.toString().replaceAll(" ", ""),
                                                                                ),"Add");

                                                                                await AllApi().postShopCart(CartModel(
                                                                                  shop: widget.shopName,
                                                                                  ref: widget.uid.toString().replaceAll(" ", ""),
                                                                                  vendorid: widget.vid.toString().replaceAll(" ", ""),
                                                                                ));

                                                                                setState(() {

                                                                                  Get.isSnackbarOpen ? Get.back() : print("sd");

                                                                                  Get.snackbar("Go to Cart", "message",duration: Duration(minutes: 15),snackPosition: SnackPosition.BOTTOM,snackbarStatus: (value){
                                                                                    print("snackbar status $value");

                                                                                  },backgroundColor: kgreen,icon:FutureBuilder(
                                                                                      future: AllApi().getCartCount(widget.uid,),
                                                                                      builder: (context, snapshot) {

                                                                                        if(!snapshot.hasData){

                                                                                          return Center(
                                                                                            child: CircularProgressIndicator(color: kgreen,),
                                                                                          );
                                                                                        }

                                                                                        var cartCount = snapshot.requireData;

                                                                                        print("councart = ${widget.uid} $cartCount");

                                                                                        return Stack(
                                                                                          children: [
                                                                                            Container(
                                                                                              margin: EdgeInsets.only(right: 10),
                                                                                              child: Stack(children: [
                                                                                                IconButton(
                                                                                                    icon: Icon(
                                                                                                      FontAwesomeIcons.opencart,
                                                                                                      color: kdarkgreen,
                                                                                                    ),
                                                                                                    onPressed: () {


                                                                                                      Get.to(CartShopPage(ref:widget.uid));

                                                                                                    }),
                                                                                                Positioned(
                                                                                                  right: 0,
                                                                                                  child: Badge(
                                                                                                    badgeContent: Text(
                                                                                                      cartCount,
                                                                                                      style: GoogleFonts.arvo(color: Colors.white),
                                                                                                    ),
                                                                                                    // child: Icon(
                                                                                                    //   FontAwesomeIcons.opencart,
                                                                                                    //   color: Colors.white,
                                                                                                    // ),
                                                                                                  ),
                                                                                                )
                                                                                              ]),
                                                                                            ),
                                                                                          ],
                                                                                        );
                                                                                      }
                                                                                  ), );
                                                                                  // final snackBar = SnackBar(
                                                                                  //   content:
                                                                                  //   backgroundColor: Colors.green,
                                                                                  //   duration: Duration(minutes: 15),
                                                                                  //
                                                                                  // );
                                                                                  // ScaffoldMessenger.of(context)
                                                                                  //     .showSnackBar(snackBar);
                                                                                  print("addedto cart");
                                                                                  _counter = 1;

                                                                                });
                                                                              }

                                                                            },
                                                                            child: Text("ADD"),
                                                                            style: ElevatedButton.styleFrom(primary: Colors.pink))),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                    defaultquantity <
                                                                        1
                                                                        ? false
                                                                        : true,
                                                                    child:
                                                                    Positioned(
                                                                      bottom: 0,
                                                                      right: 0,
                                                                      child:
                                                                      CounterNumberButton(
                                                                        initialValue:
                                                                        defaultquantity,
                                                                        minValue:
                                                                        0,
                                                                        maxValue:
                                                                        10,
                                                                        step: 1,
                                                                        onChanged:
                                                                            (value) async {

                                                                          setState1((){
                                                                            _counter = int.parse(value.toString());
                                                                          });
                                                                          print(value);
                                                                          if (_counter < 1) {
                                                                            await AllApi()
                                                                                .removeCart(widget.uid, widget.vid, prod1[index].foodid);
                                                                            await AllApi()
                                                                                .removeShopCart(widget.uid, widget.vid);
                                                                            setState1((){

                                                                            });
                                                                            setState(() { });

                                                                            Fluttertoast.showToast(msg: "Removed From Cart");

                                                                          } else {
                                                                            Map<String, String> updateQuantity = new Map();
                                                                            updateQuantity['quantity'] = value.toString();
                                                                            var changedprice = value * int.parse(prodprice);
                                                                            var changedcutprice = prodprice == ""
                                                                                ? ""
                                                                                : value * int.parse(prodcutprice);

                                                                            var quantity = value.toString();

                                                                            await AllApi().postCart(CartModel(
                                                                              img: img,
                                                                              price: changedprice.toString(),
                                                                              title: title,
                                                                              recipe: "",
                                                                              quantity: quantity.toString(),
                                                                              requirement: "",
                                                                              cutprice: changedcutprice.toString(),
                                                                              ogprice: prodprice,
                                                                              ogcutprice: prodcutprice,
                                                                              discount: prodDiscount,
                                                                              shop: widget.shopName,
                                                                              date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                                                              time: DateFormat('hh-MM-yyyy').format(DateTime.now()),
                                                                              ref: widget.uid,
                                                                              vendorid: widget.vid,
                                                                              foodid: prod1[index].foodid,
                                                                            ),"Update"
                                                                            );
                                                                            setState1((){

                                                                            });
                                                                            setState(() {

                                                                            });
                                                                          }
                                                                        },
                                                                        decimalPlaces:
                                                                        0,
                                                                        color:
                                                                        kdarkgreen,
                                                                        buttonSizeHeight:
                                                                        30,
                                                                        buttonSizeWidth:
                                                                        30,
                                                                        textStyle: TextStyle(
                                                                            fontSize:
                                                                            18,
                                                                            color:
                                                                            Colors.white),
                                                                        key: Key(
                                                                            ""),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                    discountVisibility,
                                                                    child:
                                                                    Positioned(
                                                                        top:
                                                                        0,
                                                                        right:
                                                                        0,
                                                                        child:
                                                                        Container(
                                                                          width:
                                                                          70,
                                                                          height:
                                                                          35,
                                                                          child: Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(2.0),
                                                                                child: Text(
                                                                                  "₹ $prodDiscount OFF",
                                                                                  style: GoogleFonts.arvo(fontSize: 12, color: Colors.white),
                                                                                ),
                                                                              )),
                                                                          decoration:
                                                                          BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                            color: Colors.green,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                  Visibility(
                                                                    visible:
                                                                    prodstock
                                                                        ? false
                                                                        : true,
                                                                    child:
                                                                    Positioned(
                                                                        bottom:
                                                                        10,
                                                                        right:
                                                                        0,
                                                                        child:
                                                                        Container(
                                                                          width:
                                                                          100,
                                                                          height:
                                                                          40,
                                                                          child: Center(
                                                                              child: Text(
                                                                                "OUT OF STOCK",
                                                                                style: GoogleFonts.arvo(fontSize: 10, color: Colors.white),
                                                                              )),
                                                                          decoration:
                                                                          BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(6)),
                                                                            color: Colors.grey,
                                                                          ),
                                                                        )),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          );
                                        },
                                        future: AllApi().getlifeprod(widget.varient,widget.vid),
                                      ),
                                    );
                                  }),
                              actions: [
                                ElevatedButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.green),
                                  ),
                                ),
                              ],
                            );
                          });

                    }
                          },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: hmolive,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ):
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Text(
                          "OUT OF STOCK",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
