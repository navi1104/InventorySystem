import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:navi_product_management/views/widgets/app_drawer.dart';

class DevTeamScreen extends StatelessWidget {
  const DevTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("DevScreen")),drawer: AppDrawer(),);
  }
}