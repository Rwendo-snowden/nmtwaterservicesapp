import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Buttonupdates extends GetxController {
  var buttonStatus = 'Pay';

  updateButton() {
    buttonStatus = 'Intializing...';
    update();
  }

  backToNormal() {
    buttonStatus = 'Pay';
  }
}
