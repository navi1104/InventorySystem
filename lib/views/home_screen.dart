import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:navi_product_management/views/widgets/app_drawer.dart';
import 'package:navi_product_management/views/widgets/catalog_card.dart';
import 'package:navi_product_management/views/widgets/product_list_item.dart';

import '../controllers/auth_controller.dart';
import '../controllers/inventory_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final InventoryController _inventoryController =
      Get.find<InventoryController>();

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
      body: Obx(() {
        if (_inventoryController.products.isEmpty) {
          return Center(
            child: Column(
              children: [
                Center(
                  child: Text(
                      "Please wait.. if it loads for too long it means there are no products"),
                ),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: _inventoryController.products.length,
            itemBuilder: (context, index) {
              final product = _inventoryController.products[index];
              return CatalogCard(product: product);
            },
          );
        }
      }),
    );
  }
}
