import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navi_product_management/controllers/inventory_controller.dart';

class BarcodeEntryDialog extends StatefulWidget {
  @override
  _BarcodeEntryDialogState createState() => _BarcodeEntryDialogState();
}

class _BarcodeEntryDialogState extends State<BarcodeEntryDialog> {
  final _formKey = GlobalKey<FormState>();
  final InventoryController _inventoryController = Get.find();
  TextEditingController barcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Barcode'),
      content: Form(
        child: TextFormField(
          controller: barcodeController,
          key: _formKey,
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _inventoryController.addProduct(barcodeController.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
