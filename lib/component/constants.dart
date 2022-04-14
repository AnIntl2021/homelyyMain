import 'dart:ui';

import 'package:flutter/material.dart';

const kgreen = Color(0xFF73BE45);
const kdarkgreen = Color(0xFF2A652D);
const kblackcolor = Color(0xFF000000);
const conurl = "https://webhooks.mongodb-realm.com/api/client/v2.0/app/application-0-aveoz/service/Homelyy/incoming_webhook/";

const shareduserdata = "userData";

const imageURL = "https://thehomelyy.com/images/";

var kpreloader = Center(child: Container(
    height:50,width: 50,child: ClipRRect(child: Image.asset('assets/loading.gif',fit: BoxFit.fill,))));


const kpending = 'Pending';
const kAccepted = 'Accepted';
const kReady = 'Ready';
const kDelivered = 'Delivered';
const kCancelled = 'Cancelled';





