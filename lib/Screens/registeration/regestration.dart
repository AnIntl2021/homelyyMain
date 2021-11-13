import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/homepage/homepage.dart';
import 'package:homelyy/component/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registeration extends StatefulWidget {
  const Registeration({Key key}) : super(key: key);

  @override
  _RegisterationState createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  var _formKey = GlobalKey<FormState>();
  final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  var userEmail = "FormModel()";
  var userName = "";
  var userDOB = DateTime.now();
  var isloggedin = false ;

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedin', true).then((value) {
      prefs.setBool("token", true);
    });
  }

  _selectstartDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: userDOB, // Refer step 1
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (picked != null){
      setState(() {
        userDOB = picked;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: kdarkgreen
                            ,width: 5
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                        tag: "logo", child: Image.asset("assets/homelyy.png",width: Get.width*0.4,)
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "ENTER FEW MORE DETAILS",
                      style: GoogleFonts.arvo(
                          color: kdarkgreen, fontSize: 18),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          labelText: "Email Address",
                          // hintStyle: TextStyle(color: Colors.white30),
                          labelStyle: TextStyle(color: kgreen),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),

                          // errorText: isdiscountAvailable ? erroText : null
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userEmail = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        decoration: InputDecoration(
                          hintText: "Enter Name",
                          labelText: "Full Name",
                          // hintStyle: TextStyle(color: Colors.white30),
                          labelStyle: TextStyle(color: kgreen),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kgreen),
                          ),

                          // errorText: isdiscountAvailable ? erroText : null
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userName = value;
                        },
                      ),
                    ),
                    Text("ENTER YOUR DATE OF BIRTH"),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: (){
                        _selectstartDate(context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                                userDOB.toLocal().toString().split(' ')[0]),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(kdarkgreen)
                        ),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          // if (_formKey.currentState.validate()) {
                          //   // If the form is valid, display a snackbar. In the real world,
                          //   // you'd often call a server or save the information in a database.
                          //   _formKey.currentState.save();
                          //   Center(
                          //     child: CircularProgressIndicator(
                          //       backgroundColor: Colors.green,
                          //     ),
                          //   );
                          //
                          //   // FirebaseFirestore.instance
                          //   //     .collection("users")
                          //   //     .doc(FirebaseAuth.instance.currentUser.uid)
                          //   //     .get()
                          //   //     .then((value) {
                          //   //   if (value.exists) {
                          //   //     Map<String, String> carttotals = new Map();
                          //   //     carttotals[kcartsubTotal] = "0";
                          //   //     carttotals[kcartdiscount] = "0";
                          //   //     carttotals[kcartwallet] = "0";
                          //   //     carttotals[kcartdeliveryCharge] = "0";
                          //   //     carttotals[kcarttotal] = "0";
                          //   //     var voucherQuery = FirebaseFirestore.instance
                          //   //         .collection("users")
                          //   //         .doc(FirebaseAuth.instance.currentUser.uid)
                          //   //         .collection("cartTotal")
                          //   //         .doc("1");
                          //   //     voucherQuery.set(carttotals);
                          //   //     FirebaseFirestore.instance
                          //   //         .collection("users")
                          //   //         .doc(FirebaseAuth.instance.currentUser.uid)
                          //   //         .update({
                          //   //       kuserName: userName,
                          //   //       kuserEmail: userEmail,
                          //   //       "DOB": userDOB.toLocal().toString().split(' ')[0],
                          //   //       kwallet: "0",
                          //   //       "member": "",
                          //   //       "plan": "",
                          //   //     }).then((value) {
                          //   //       addBoolToSF();
                          //   //       Get.offAll(HomeScreen());
                          //   //     }
                          //   //     );
                          //   //   }
                          //   // });
                          //   // // ScaffoldMessenger.of(context).showSnackBar(
                          //   // //     SnackBar(content: Text('Processing Data')));
                          //
                          // }
                          Get.to(Homepage());
                        },
                        child: Text('Submit'),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
