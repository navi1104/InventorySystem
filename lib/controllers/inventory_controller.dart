import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navi_product_management/views/add_product_screen.dart';

import '../models/product_model.dart';

class InventoryController extends GetxController {
  final CollectionReference inventoryRef =
      FirebaseFirestore.instance.collection('inventory products');

  final RxList<Product> products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load initial inventory from Firestore
    loadInventory();
  }

  Future<void> loadInventory() async {
    final snapshot = await inventoryRef.get();
    products.value = snapshot.docs
        .map((doc) => Product(
              name: doc['name'],
              barcode: doc['barcode'],
              price: doc['price'].toDouble(),
              count: doc['count'],
              imageUrl: doc['imageUrl'],
              description: doc['description'],
            ))
        .toList();
  }

  Future<void> addProduct(String barcode) async {
    print("Add product function called");
    print(barcode + " from controller");
    final existingProductIndex =
        products.indexWhere((p) => p.barcode == barcode);
    if (existingProductIndex != -1) {
      final existingProduct = products[existingProductIndex];
      final updatedProduct =
          existingProduct.copyWith(count: existingProduct.count + 1);
      await updateProduct(updatedProduct);
    } else {
      Get.to(() => AddProductScreen(barcode: barcode));
    }
  }

  Future<void> removeProductByBarcodeAndQuantity(String barcode) async {
    Rx<int> quantity = 0.obs;
    Get.dialog(
      AlertDialog(
        title: Text("Enter a number"),
        content: TextField(
          onChanged: (value) {
            quantity.value = int.tryParse(value) ?? 0;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Quantity",
            hintText: "Enter Quantity to checkout",
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final existingProductIndex =
                  products.indexWhere((p) => p.barcode == barcode);
              if (existingProductIndex != -1) {
                final existingProduct = products[existingProductIndex];
                if (existingProduct.count <= quantity.value) {
                  await removeProduct(existingProduct);
                } else {
                  final updatedProduct = existingProduct.copyWith(
                      count: existingProduct.count - quantity.toInt());
                  await updateProduct(updatedProduct);
                }
              } else {
                Get.snackbar("Error", "Product not found");
              }
              Get.back();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  Future<void> addNewProduct(Product product) async {
    try {
      await inventoryRef.doc(product.barcode).set(product.toJson());
      products.add(product);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } catch (err) {
      Get.snackbar("Error", err.toString());
    }
  }

  Future<void> updateProduct(Product product) async {
    print("updating product");
    await inventoryRef.doc(product.barcode).update({
      'name': product.name,
      'barcode': product.barcode,
      'price': product.price,
      'count': product.count,
      'imageUrl': product.imageUrl,
      'description': product.description,
    });
    products[products.indexWhere((p) => p.barcode == product.barcode)] =
        product;
  }

  Future<void> removeProduct(Product product) async {
    await inventoryRef.doc(product.barcode).delete();
    products.remove(product);
  }
}
