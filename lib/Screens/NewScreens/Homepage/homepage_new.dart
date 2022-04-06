import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Components_new/discountcar_new.dart';
import '../homellycolors.dart';



class HomePageNew1 extends StatefulWidget {
  @override
  State<HomePageNew1> createState() => _HomePageNew1State();
}

class _HomePageNew1State extends State<HomePageNew1> {
  var selectedCard = 'Food Store';
  var selectedFood = 'Chinese food';
  var selectedDish = "Raman's Food Corner";

  Future createsnackbar(context){

   return  Future.delayed(Duration(seconds: 1),
        (){
          final snackBar = SnackBar(
            backgroundColor: Colors.transparent,
            content:  Container(
                width: 300,
                height: 100,
                child: Stack(children: [
                  Container(
                    height: 100,
                    child: ClipRRect(
                        child: Image.asset("assets/Rectangle 31.png"))
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(child: Image.asset("assets/Vector.png"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:200,top: 30,),
                    child: Container(child: Image.asset("assets/hero 1.png"),),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50,left:70),
                        child: Text("30% off on all purchases!",style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),Padding(
                        padding: const EdgeInsets.only(left:70,top: 5),
                        child: Text("(upto 2 orders)",style: TextStyle(color: Colors.white),),
                      ),Container(child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 70,top:10),
                            child: Text("Claim now",style: TextStyle(fontSize: 20,color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top:17),
                            child: Image.asset("assets/arrow_homepage.png",scale: .7,color: Colors.white,),
                          )
                        ],),)
                    ],)
                ],),
              ),

            duration: Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
    );


  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      bottomNavigationBar: Container(
        color: hmgreen,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
  Image.asset("assets/Vector_house.png"),Image.asset("assets/Vector_pin.png"),Image.asset("assets/Vector_heart.png"),Image.asset("assets/Vector_people.png")
],
          ),
        ),
      ),

      backgroundColor: Colors.white,
      body:

      CustomScrollView(

        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            title: Stack(
              children: [
                Center(
                    child: ClipRRect(
                        child: Image.asset(
                  "assets/homelyy.png",
                  height: 100,
                ))),
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
                  child: CircleAvatar(
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 10),
                    ),
                    radius: 10,
                  ),
                )
              ],
            ),
            toolbarHeight: 100,
            floating: true,
          ),
          buildImages(context),
        ],

      ),
    );
  }

  Widget buildImages(context) => SliverToBoxAdapter(
          child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/Vector.jpg"),
              SizedBox(width: 7),
              Text(
                "2883,Haibowal kalan,Ludhiana,India",
                style: TextStyle(fontSize: 15),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Search",
              filled: true,
              fillColor: hmgreen,
              prefixIcon: Image.asset("assets/Search.png"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide()),
              //fillColor: Colors.green
            ),
          ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildCard("Food Store","15 stores available","assets/food-store.png"),

          buildCard("Lifestyle Store","20 Stores availabe","assets/clothing-store.png"),
        ]


      )
        ,Container(
            height: 170,
            child: DiscountCardNew(
              key: Key("catRow"),
              title: 'Slider',
              snapshot: [
"assets/jay-wennington-N_Y88TWmGwA-unsplash 1.png","assets/homelyy.png"
              ]
              // selectedType == 0 ? [
              //   "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/images%2Ffood_banner.webp?alt=media&token=b54e6725-4af0-4783-84d8-e2bcf21e20d3",
              //   "https://firebasestorage.googleapis.com/v0/b/food-app-b497c.appspot.com/o/images%2F5fe3266f03a46_json_image_1608722031.webp?alt=media&token=5791a1c2-e50a-44b9-a593-eb2f342f78de"
              // ] : [
              //       "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Slider%2FSP_Offers_Block02DEC06.jpg?alt=media&token=17873f3c-2001-4443-ab09-02665092e3fb",
              //   "https://firebasestorage.googleapis.com/v0/b/factory-club-cc524.appspot.com/o/Slider%2Funnamed.jpg?alt=media&token=10ee0306-c5c7-4ac3-a99a-ca9cbb2ffc34"
              //
              //   ]
              ,
            ),
          ),

         Text("Browse food categories",style: TextStyle(fontSize: 20),),
          GridView.count(crossAxisCount: 2,
            childAspectRatio: 1.3,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true
            ,children: [
            buildCuicrelCard("assets/ramen.png","Chinese food","15\nProviders"), buildCuicrelCard("assets/pasta.png","Italian food","8\nProviders"), buildCuicrelCard("assets/masala-dosa.png","South-Indian","10\nProviders"), buildCuicrelCard("assets/fried-rice.png","Other Options","6\nProviders"),
          ],)
,SizedBox(height: 10,),Text("Popular service near me",style: TextStyle(fontSize: 20),),SizedBox(height: 10,),
          Column(
            children: [
              buildRowcards("assets/homepagecookimage.png","Raman's Food Corner","South-Indian"),
              SizedBox(height: 10,)
              ,buildRowcards("assets/homepagecookimage.png","Raman's Food Corner","South-Indian"),
              SizedBox(height: 10,),
              buildRowcards("assets/homepagecookimage.png","Raman's Food Corner","South-Indian")
            ],
          )

        ],
      ));

  Row buildRowcards(String image,String title,String subtitle) {
    return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
    Stack(children: [
    Container(child: Image.asset("assets/homepagecookimage.png"),),
    Padding(
    padding: const EdgeInsets.only(left: 16,right: 4,top: 4,bottom: 4),
    child: Container(child: Text("2 Orders",style: TextStyle(color: Colors.white),),),
    )
    ],),
            Container(
              color: hmgreen,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Raman's Food Corner"),
                    ),Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("South-Indian"),
                    ),SizedBox(height: 15,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("\$2.99 delivery fee",style: TextStyle(fontSize: 10),),
                        ),SizedBox(width: 10,),Icon(Icons.access_time_outlined,size: 12,),
                        Text("15-20 min",style: TextStyle(fontSize: 10))
                      ],

                    ),SizedBox(height: 10,),Container(

                      color: hmgreen,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,

                            children: [Stack(

                        children: [
                        Container(child: Image.asset("assets/star_homepage.png",scale: .8,)),
              Container(child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text("4.7",style: TextStyle(fontSize: 6,color: Colors.white),),
              ),)
              ],
            ),SizedBox(width: 95,),ClipRect(child: Image.asset("assets/arrow_homepage.png",scale: .7,))]),
                      ),
                    ),SizedBox(height: 10,)

                  ],
                ),
              ),
            )
          ],
        );
  }

  Padding buildCuicrelCard(String image,String title,String subtitle) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child:

          Container(

decoration: BoxDecoration(
  color: hmgreen,
  borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(

                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Image.asset(image,
                            scale:
                            .9,),SizedBox(width: 12,),Text(subtitle),

                        ],


                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(title,style: TextStyle(fontSize: 20),),
                      )
                    ],
                  ),
                Image.asset("assets/Rectangle 15.png")],
              )
            ),
          ),
        );
  }

  Stack buildcatcard(String title,String subtitle,String image) {
    return Stack(
      alignment: Alignment.topRight,
      children: [

        Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: hmgreen,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),

            child:
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset("image",scale:
                    .7),
                    SizedBox(width: 10)
                    ,Column(
                      children: [
                        Text("subtitle",style: TextStyle(
                            fontSize: 15
                        ),),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text("title",style: TextStyle(fontSize: 20),),

              ],

            )

        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(child: Image.asset("image")),
        )
      ],
    );
  }

  buildCard(String title,String subtitle,String image) {
    return InkWell(
      onTap: (){
        setState(() {
          selectedCard = title;
        });
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [

          Container(

            child:
            Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        title,style: TextStyle(
                        fontSize: 20,

                      ),
                      ),
                      Text(
                          subtitle
                      )
                    ],
                  ),
                ),

                SizedBox(height: 25)
                ,ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.asset(image)
                )],


            ),

            decoration:  BoxDecoration(color: hmgreen,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(child: selectedCard == title ? Image.asset("assets/Rectangle 15.png") : Image.asset("assets/Rectangle 17.png") ),
          ),
        ],
      ),
    );
  }
}

