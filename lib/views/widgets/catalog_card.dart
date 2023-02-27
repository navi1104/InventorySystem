import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navi_product_management/models/product_model.dart';

class CatalogCard extends StatelessWidget {
  final Product product;
  const CatalogCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          CachedNetworkImage(
            imageUrl: product.imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.name),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.price.toString()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.description),
          ),
        ]),
      ),
    );
  }
}
