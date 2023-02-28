import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:navi_product_management/models/product_model.dart';
import 'package:navi_product_management/views/add_product_screen.dart';
import 'package:navi_product_management/views/widgets/app_drawer.dart';
import 'package:navi_product_management/views/widgets/barcode_entry_dialogue.dart';
import 'package:simple_barcode_scanner/enum.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import 'package:navi_product_management/views/widgets/product_list_item.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../controllers/inventory_controller.dart';

class InventoryScreen extends StatelessWidget {
  final InventoryController inventoryController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
        elevation: 0,
      ),
      drawer: AppDrawer(),
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
        onPressed: () async => {
          if (Theme.of(context).platform == TargetPlatform.android)
            {await scanBarcode()}
          else
            {
              await showDialog<String>(
                  context: context,
                  builder: (context) {
                    return BarcodeEntryDialog();
                  })
            }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> scanBarcode() async {
    final String barcodeScanRes =
        await Get.to(() => SimpleBarcodeScannerPage());

    if (barcodeScanRes == "-1") {
      return;
    }

    Get.snackbar('barcode', barcodeScanRes);

    await inventoryController.addProduct(barcodeScanRes);
  }
}
