import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

import '../devteam_screen.dart';
import '../home_screen.dart';
import '../inventory_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Product Management',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Get.to(() => HomeScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Inventory/Check-in'),
            onTap: () {
              Get.to(() => InventoryScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Meet the Dev Team'),
            onTap: () {
              Get.to(() => DevTeamScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: () {
              Get.find<AuthController>().signOut();
            },
          ),
        ],
      ),
    );
  }
}
