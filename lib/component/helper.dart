import 'package:get/get.dart';

import 'UserController.dart';

void init(){


  Get.lazyPut(() => UserController());


}