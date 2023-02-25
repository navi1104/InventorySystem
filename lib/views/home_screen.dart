import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:navi_product_management/views/widgets/app_drawer.dart';

import '../controllers/auth_controller.dart';
import 'devteam_screen.dart';
import 'inventory_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Catalog'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authController.signOut();
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Product Catalog'),
      ),
    );
  }
}
