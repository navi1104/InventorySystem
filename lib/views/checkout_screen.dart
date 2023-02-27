import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:navi_product_management/views/widgets/app_drawer.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Check out"),
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: Center(
          child: TextButton(
        child: Text("Scan Product for check-out"),
        onPressed: (() {}),
      )),
    );
  }
}
