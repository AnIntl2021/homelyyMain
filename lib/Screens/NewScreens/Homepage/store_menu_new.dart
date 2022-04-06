import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homelyy/Screens/NewScreens/homellycolors.dart';

class StoreMenuNew extends StatefulWidget {

  @override
  State<StoreMenuNew> createState() => _StoreMenuNewState();
}

class _StoreMenuNewState extends State<StoreMenuNew> {
  int _counter = 0;
  increment(){
    setState(() {
      _counter++;
    });
  }

  decrement(){
    setState(() {
      _counter--;
    });
  }
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:CustomScrollView(

        slivers: [
          SliverAppBar(
            backgroundColor: hmgreen,flexibleSpace: FlexibleSpaceBar(background: Container(
              child: ClipRRect(
                child: Image.asset(
                    "assets/imagefood2.png",
                  fit: BoxFit.fill,
                )),
            ),),
            pinned: true,
            expandedHeight: 175,

            leading: Image.asset("assets/arrow left2.png"),
            actions: [Row(
              children: [Padding(
                padding: const EdgeInsets.only(top: 3,right: 10),
                child: Image.asset("assets/heart3.png"),
              )
                ,Padding(
                  padding: const EdgeInsets.only(top: 10,right: 10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/Group 11.png",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: CircleAvatar(
                            backgroundColor: hmblue,
                            child: Text(
                              "0",
                              style: TextStyle(fontSize: 10,color: Colors.white),
                            ),
                            radius: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )],
            floating: true,
          ),
          buildImages2(context),
        ],

      ),
    );
  }
  Widget buildImages2(context) => SliverToBoxAdapter(
    child: Column(children: [
    Container(
      color: hmgreen,
      child: Column(children: [
        SizedBox(height: 10,),Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            child: Row(children: [
              ClipRRect(child: Image.asset("assets/smallstar.png")),SizedBox(width: 10,),Text("4.6",style: TextStyle(fontSize: 15)),
              SizedBox(width: 20,),Text("(500 + ratings)",style: TextStyle(fontSize: 15),)
            ],),
          ),
        ),SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(

            child: Row(children: [
              ClipRRect(child: Image.asset("assets/locationmark.png")),SizedBox(width: 10,),Text("2435, Kings street, Ontario (K27G3V)",style: TextStyle(fontSize: 15)),
            ],),
          ),
        ),SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(

            child: Row(children: [
              ClipRRect(child: Image.asset("assets/clock.png")),SizedBox(width: 10,),Text("Open Hours - 8:00Am to 12:00AM",style: TextStyle(fontSize: 15)),

            ],),
          ),
        ),SizedBox(height: 10,)
      ],),
    ),
      Column(children: [
        SizedBox(height: 15,),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Search",
            filled: true,
            fillColor: hmgreen,
            prefixIcon: ClipRRect(child: Image.asset("assets/Search.png")),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide()),
            //fillColor: Colors.green
          ),
        )
      ],),SizedBox(height: 10,),
      SizedBox(height: 8,),Container(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: hmolive,
                    borderRadius: BorderRadius.circular(20)),
                width: 60,
                child: Image.asset("assets/menuicon.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: hmolive,
                    borderRadius: BorderRadius.circular(20)),
                width: 100,
                child: const Center(
                    child: Text(
                      'Popular',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: hmolive,
                    borderRadius: BorderRadius.circular(20)),
                width: 100,
                child: const Center(
                    child: Text(
                      'Combos',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: hmolive,
                    borderRadius: BorderRadius.circular(20)),
                width: 80,
                child: const Center(
                    child: Text(
                      'Dosa',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: hmolive,
                    borderRadius: BorderRadius.circular(20)),
                width: 100,
                child: const Center(
                    child: Text(
                      'Utappam',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 15,),
      Container(
        color: hmgreen,
        child: Padding(
          padding: const EdgeInsets.only(top: 15,bottom: 15),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text("Popular",style: TextStyle(fontSize: 20),),
          ),Icon(Icons.arrow_drop_down)
      ],),
        ),),SizedBox(height: 10,)
      ,
      Container(
        height: Get.height,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,

          itemCount: 6,
          controller: _scrollController,
          itemBuilder: (context,index){
            return Column(
              children: [SizedBox(height: 10,),
                buildProductCard("  Chilli Idli"),SizedBox(height: 10,)
                ,Divider(color: Colors.black,)
              ],
            );
          },


        ),
      )
    ],),
  );

  Container buildProductCard(String title) {
    return Container(
      color: Colors.white,
      height: 120,
      child: Row(
        children: [Container
          (height: 120,width: 120
            ,child: ClipRRect(child: Image.asset("assets/shreyak-singh-gFB1IPmH6RE-unsplash 1.png",fit: BoxFit.fill))),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Image.asset("assets/Rectangle 66.png"),Text(title,style: TextStyle(fontSize: 15),),SizedBox(width:70,),
                  Container(
                    height: 20,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            decrement();
                            setState((){});
                          },
                          child: Icon(Icons.remove,color: Colors.black,size: 15,),
                        ), SizedBox(width: 10),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), color: hmgray2,
                            )
                            ,height: 20,width: 20,
                            child: Center(child: Text("$_counter",style: TextStyle(fontSize: 17,color: Colors.black),))),
                        SizedBox(width: 10),InkWell(
                          onTap: (){
                            increment();
                            setState((){});
                          },

                          child: Icon(Icons.add,color: Colors.black,size: 15,),
                        ),
                      ],

                    ),
                  ),
                ],),SizedBox(height: 7,),
                Text("\$21.99",style: TextStyle(fontSize: 15)),
                Row(children: [
                  Text("Enjoy the spiciness over sour yogurt and \nplain sooji in every bite you take of this \nchilli idli. This haryani aromatic chilli will \nlighten up your senses. ",style: TextStyle(fontSize: 8)),
Padding(
padding: const EdgeInsets.only(top: 40,),
child:   Container(

  decoration: BoxDecoration(color: hmolive,borderRadius: BorderRadius.circular(15)),

  child:

  Padding(

            padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),

            child: Text("Customize",style: TextStyle(fontSize:10,color: Colors.white),),

  )

  ,),
)
                ],)
              ],
            ),
          ),
        Divider(
        )],
      ),

    );
  }
}
