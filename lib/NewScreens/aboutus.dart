import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homelyy/NewScreens/homellycolors.dart';

class Aboutusnew extends StatefulWidget {
  const Aboutusnew({Key key}) : super(key: key);

  @override
  _AboutusnewState createState() => _AboutusnewState();
}

class _AboutusnewState extends State<Aboutusnew> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          body: Container(


            child: SingleChildScrollView(
              child: Center(

                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Ink(
                              child: Icon(Icons.arrow_back,color: hmdarkolive,)
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text('About Us',style: TextStyle(fontSize: 35 ,fontWeight: FontWeight.bold),),
                    Padding(

                      padding: const EdgeInsets.only(left: 15,top: 10,right: 16),
                      child: Column(
                        children: [
                          Text('Homelyy, a platform where businesses meet with their customers; businesses meet with other businesses; people meet other people with the comfort of working from home. Homelyy connects people from various walks of life. It connects entrepreneurs to entrepreneurs, people, acting as the bridge between the dream and reality of conducting business from home. Homelyy is a platform for those who want to run their business from home, either in food, restaurants, or lifestyle products.'

                          ,style: TextStyle(fontSize: 17),),
                          SizedBox(height: 10),
                          Text('Business entrepreneurs sitting at home use Homelyy to kick start their business and give it a necessary boost to excel in their business areas. Food restaurants owners or lifestyle product proprietors need not worry about getting potential customers and markets. We, at Homelyy, constantly focus on providing consumers to these business owners and making them stand tall in this competitive market.',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 10),
                          Text('Homelyy, A.N. International OPC private limited. The organization enables customers and merchants across the globe to discover, meet, engage and conduct business with each other while enjoying the comfort of working from home, eradicating all social and global boundaries.',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 10),
                          Text('Homelyy offers its partners an opportunity to set up a brand image, increase visibility in the market, and attract global consumers. Business from home is made easy, quick and more efficient at Homelyy. We constantly strive to give a user-friendly experience to our users, make their work more accessible and more fun.',style: TextStyle(fontSize: 17),),
                          SizedBox(height: 10),
                          Text('Homelyy focuses on all four significant aspects of business, providing smooth functioning of business while working from home, increasing revenue, reaching out to a large customer base by accessing the large delivery fleet and increasing brand awareness and visibility. These crucial aspects of a successful business are covered here at home, giving us happy consumers and successful business operators.',style: TextStyle(fontSize: 17),),
                          SizedBox(height:10),
                          Text('Conducting business that too from home has never been this fun and easy. All fellow entrepreneurs, leave all your worries to Homelyy by simply logging in to our website and downloading our app. Be prepared for a better business experience, more customers, more cash inflow and a happy and successful business phase.',style: TextStyle(fontSize: 17),),





                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


        )
    );
  }
}
