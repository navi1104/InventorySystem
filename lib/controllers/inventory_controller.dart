import 'package:cloud_firestore/cloud_firestore.dart';
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
              price: doc['price'],
              count: doc['count'],
              imageUrl: doc['imageUrl'],
              description: doc['description'],
            ))
        .toList();
  }

  Future<void> addProduct(String barcode) async {
    print("Add product function called");
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

  Future<void> addNewProduct(Product product) async {
    try {
      await inventoryRef.doc(product.barcode).set(product.toJson());
      products.add(product);
    } catch (e) {
      Get.snackbar("Error", e.toString());
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
