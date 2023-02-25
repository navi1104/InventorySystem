import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/inventory_controller.dart';
import '../models/product_model.dart';

class EditProductScreen extends StatelessWidget {
  final Product product;

  const EditProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final inventoryController = Get.find<InventoryController>();
    final TextEditingController nameController =
        TextEditingController(text: product.name);
    final TextEditingController barcodeController =
        TextEditingController(text: product.barcode);
    final TextEditingController priceController =
        TextEditingController(text: product.price.toString());
    final TextEditingController countController =
        TextEditingController(text: product.count.toString());
    final TextEditingController imageUrlController =
        TextEditingController(text: product.imageUrl);
    final TextEditingController descriptionController =
        TextEditingController(text: product.description);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Enter product name',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Barcode:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: barcodeController,
                decoration: InputDecoration(
                  hintText: 'Enter barcode',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Price:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter product price',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Count:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: countController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter count',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Image URL:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(
                  hintText: 'Enter product image URL',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter product description',
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text;
                  final price = double.tryParse(priceController.text) ?? 0.0;
                  final count = int.tryParse(countController.text) ?? 0;
                  final imageUrl = imageUrlController.text;
                  final description = descriptionController.text;
                  final updatedProduct = Product(
                    name: name,
                    barcode: barcodeController.text,
                    price: price,
                    count: count,
                    imageUrl: imageUrl,
                    description: description,
                  );
                  await inventoryController.updateProduct(updatedProduct);
                  Get.back();
                },
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
