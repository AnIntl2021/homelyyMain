import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homelyy/Screens/UserProfile/UserInfo.dart';
import 'package:homelyy/component/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/homepage/homepage.dart';
import 'Screens/login/loginScreen.dart';
import 'component/constants.dart';
import 'component/splashscreenMY.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification'),
    enableLights: true
);


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> firebaseMessgaingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
  print("a message bg : ${message.messageId}");

}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseMessgaingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var currentUser = FirebaseAuth.instance.currentUser;
  var isloggedin = false;
  var phone ;

  Future<List> getBoolValuesSF() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool('loggedin') ?? false;
    var userphone = prefs.getString("phone");
    print("Get Lcocal User ${userphone}");
    print("boolvalue $boolValue");
    return [boolValue,userphone];

  }

  @override
  void initState() {

    getBoolValuesSF().then((value) {

      setState(() {
        isloggedin = value[0];
        phone = value[1];
      });
    });

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SplashScreenMy(
            duration: 6000,
            imageSize: 180,
            imageSrc: "assets/homelyy.png",
            text: "HOMELYY -EVERYTHING FROM HOME",
            colors: [Colors.amber],
            textType: TextType1.ScaleAnimatedText,
            textStyle: GoogleFonts.cabin(
                fontSize: 30,
                color: kgreen,
                fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,
            speed: 1, navigateRoute: isloggedin ? Homepage(userRef: phone,) : LoginScreen()
        )
      ),
    );
  }
}

