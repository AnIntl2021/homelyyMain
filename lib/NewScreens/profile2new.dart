import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homellycolors.dart';

class Profilenewone extends StatefulWidget {
  final String id;
  const Profilenewone({Key  key, this.id}) : super(key: key);

  @override
  _ProfilenewoneState createState() => _ProfilenewoneState();
}

class _ProfilenewoneState extends State<Profilenewone> {
  bool showBottomSheet = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: hmgreen,

            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          InkWell(
                            child: Icon(Icons.arrow_back,color: hmdarkolive),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {


                              }
                              );
                            },
                            child: Text('Edit',style: TextStyle(fontSize: 17,color: hmdarkolive),
                            ),
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Icon(Icons.person_outline_rounded,color: hmdarkolive,size: 70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Tiara Sharma',style: TextStyle(fontSize: 30,color: hmblack),),
                        SizedBox(width: 10),
                        Icon(Icons.edit,color:hmdarkolive ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Text('Phone Number',style: TextStyle(fontSize: 15,color: hmdarkolive)),
                          InkWell(child: SizedBox(width: 15)),
                          Icon(Icons.edit,color: hmdarkolive),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: TextFormField(
                        decoration: InputDecoration(

                            filled: true,
                            fillColor: Colors.lightGreen[100],

                            contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            )

                        ),
                      ),
                    ),

                    SizedBox(height:15 ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Text('Email',style: TextStyle(fontSize: 15,color: hmdarkolive)),
                          InkWell(child: SizedBox(width: 15)),
                          Icon(Icons.edit,color: hmdarkolive),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: TextFormField(
                        decoration: InputDecoration(

                            filled: true,
                            fillColor: Colors.lightGreen[100],

                            contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            )

                        ),
                      ),
                    ),
                    SizedBox(height:15 ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Row(
                        children: [
                          Text('Password',style: TextStyle(fontSize: 15,color: hmdarkolive)),
                          InkWell(child: SizedBox(width: 15)),
                          Icon(Icons.edit,color: hmdarkolive),
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: TextFormField(
                        decoration: InputDecoration(

                            filled: true,
                            fillColor: Colors.lightGreen[100],

                            contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            )

                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: InkWell(
                            onTap: (){

                              showModalBottomSheet(


                                builder: (context) {


                                  return Container(
                                    height: 200,
                                    width: double.infinity,

                                    alignment: Alignment.center,

                                    decoration: (BoxDecoration(color: hmgreen, borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                                    )
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                          onTap:(){
                                    Get.back();
                                    },

                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 40,right: 30),
                                                    child: Column(
                                                      children: [
                                                        Icon(Icons.cancel),
                                                      ],
                                                    ),
                                                  )
                                              ),

                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 50),
                                            child: Row(
                                              children: [
                                                Text('Enter Current Password',style: TextStyle(fontSize: 15,color: hmdarkolive)),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20,right: 20),
                                            child: TextFormField(
                                              decoration: InputDecoration(

                                                  filled: true,
                                                  fillColor: Colors.lightGreen[100],

                                                  contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  ),
                                                  enabledBorder:OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  )

                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 50),
                                            child: Row(
                                              children: [
                                                Text('Enter New Password',style: TextStyle(fontSize: 15,color: hmdarkolive)),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20,right: 20),
                                            child: TextFormField(
                                              decoration: InputDecoration(

                                                  filled: true,
                                                  fillColor: Colors.lightGreen[100],

                                                  contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  ),
                                                  enabledBorder:OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  )

                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 50),
                                            child: Row(
                                              children: [
                                                Text('Confirm New Password',style: TextStyle(fontSize: 15,color: hmdarkolive)),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20,right: 20),
                                            child: TextFormField(
                                              decoration: InputDecoration(

                                                  filled: true,
                                                  fillColor: Colors.lightGreen[100],

                                                  contentPadding: EdgeInsets.only(left: 100,right: 0,top: 0,bottom: 0),

                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  ),
                                                  enabledBorder:OutlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  )

                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          InkWell(
                                            child: Container(
                                              child: Center(child: Text('Confirm',style: TextStyle(color: Colors.white),)
                                              ),
                                              height: 30,width: 135,
                                              decoration: BoxDecoration(color: hmdarkolive,
                                                borderRadius:   BorderRadius.circular(30),
                                              ),


),
                                          ),
                                          SizedBox(height: 50),

                                        ],
                                      ),
                                    ),


                                  );


                                }, context: context,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              );


                            },
                              child: Text('Change Current Password',style: TextStyle(color: hmdarkolive),)




                          ),

                        ),
                      ],
                    ),


                  ],


                ),

              ),

            )
        )
    );
  }


}

