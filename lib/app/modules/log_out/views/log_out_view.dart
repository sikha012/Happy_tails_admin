import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/log_out_controller.dart';

class LogOutView extends GetView<LogOutController> {
  const LogOutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogOutView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LogOutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
