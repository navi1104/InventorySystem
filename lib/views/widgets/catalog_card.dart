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
          Expanded(
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\u{20B9}${product.price.toString()}',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.description,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.w200),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
