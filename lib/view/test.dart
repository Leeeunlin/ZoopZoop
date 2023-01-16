import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoopzoop/controller/mainController.dart';

class Test extends GetView<MainController> {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: double.infinity, height: 300, color: Colors.red),
        Container(width: double.infinity, height: 300, color: Colors.blue),
        Container(width: double.infinity, height: 300, color: Colors.red),
      ],
    );
  }
}
