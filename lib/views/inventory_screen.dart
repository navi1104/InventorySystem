import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:navi_product_management/models/product_model.dart';
import 'package:navi_product_management/views/add_product_screen.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import 'package:navi_product_management/views/widgets/product_list_item.dart';

import '../controllers/inventory_controller.dart';

class InventoryScreen extends StatelessWidget {
  final InventoryController inventoryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
      ),
      body: Obx(() {
        if (inventoryController.products.isEmpty) {
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
            itemCount: inventoryController.products.length,
            itemBuilder: (context, index) {
              final product = inventoryController.products[index];
              return ProductListItem(product: product);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await scanBarcode(),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> scanBarcode() async {
    final String barcodeScanRes = await Get.to(() => SimpleBarcodeScannerPage(
          scanType: ScanType.barcode,
        ));

    if (barcodeScanRes is int) {
      // User canceled scanning
      return;
    }

    Get.snackbar('barcode', barcodeScanRes);

    await inventoryController.addProduct(barcodeScanRes);
  }
}
