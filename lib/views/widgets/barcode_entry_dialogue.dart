import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navi_product_management/controllers/inventory_controller.dart';
import 'package:navi_product_management/views/add_product_screen.dart';

class BarcodeEntryDialog extends StatefulWidget {
  @override
  _BarcodeEntryDialogState createState() => _BarcodeEntryDialogState();
}

class _BarcodeEntryDialogState extends State<BarcodeEntryDialog> {
  final InventoryController _inventoryController = Get.find();
  TextEditingController barcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Barcode'),
      content: Form(
        child: TextFormField(
          controller: barcodeController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a barcode';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Barcode',
          ),
        ),
      ),
      actions: [
        MaterialButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          child: Text('OK'),
          onPressed: () async {
            if (barcodeController.text != "") {
              print(barcodeController.text);
              Navigator.of(context).pop();
              await _inventoryController.addProduct(barcodeController.text);
            } else {
              Get.snackbar("Error", "please enter barcode",
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
          },
        ),
      ],
    );
  }
}
