import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/inventory_controller.dart';
import '/models/product_model.dart';
import '/views/edit_product_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  const ProductListItem({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final InventoryController inventoryController = Get.find();

    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ALERT'),
              content: Text(
                  'Are you sure you want to delete ${product.name} from inventory?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    await inventoryController.removeProduct(product);
                    Navigator.of(context).pop();
                  },
                  child: Text('YES'),
                ),
                TextButton(
                  onPressed: () {
                    // Do something when the user taps the button
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: product.imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: 75, // set the width and height to the same value
            height: 100,
            fit: BoxFit.cover,
          ),
          title: Text(
            product.name,
            style: TextStyle(
              color: product.count == 0 ? Colors.red : null,
            ),
          ),
          subtitle: Text('${product.count} in stock'),
          trailing: IconButton(
            onPressed: () {
              Get.to(() => EditProductScreen(product: product));
            },
            icon: Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
