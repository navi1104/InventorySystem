import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../controllers/inventory_controller.dart';
import '../models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  final String barcode;

  const AddProductScreen({Key? key, required this.barcode}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final InventoryController inventoryController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  late File _imageFile = File(null.toString());
  bool _uploadingImage = false;
  late final pickedFile;
  Future<void> _getImage() async {
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  bool clickAdd = false;
  Future<void> _uploadImage() async {
    setState(() {
      _uploadingImage = true;
    });

    final ref = firebase_storage.FirebaseStorage.instance
        .ref('product_images/${widget.barcode}.jpg');

    final task = ref.putFile(File(pickedFile.path));

    final snapshot = await task.whenComplete(() {});

    if (snapshot.state == firebase_storage.TaskState.success) {
      final downloadURL = await snapshot.ref.getDownloadURL();
      _addProduct(downloadURL);
    } else {
      setState(() {
        _uploadingImage = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to upload image'),
        ),
      );
    }
  }

  void _addProduct(String imageUrl) async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      try {
        await inventoryController.addNewProduct(Product(
            barcode: widget.barcode,
            name: _nameController.text,
            price: double.parse(_priceController.text),
            count: 1,
            description: _descriptionController.text,
            imageUrl: imageUrl));
        Navigator.of(context).pop();
      } catch (err) {
        Get.snackbar("Error", err.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: _uploadingImage
                      ? const CircularProgressIndicator()
                      : _imageFile.path != "null"
                          ? Theme.of(context).platform == TargetPlatform.android
                              ? Image.file(_imageFile)
                              : Image.network(_imageFile.path)
                          : Icon(
                              Icons.image,
                              size: 30,
                            ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _getImage,
                      child: const Text('Select Image'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    // onPressed: _uploadingImage ? null : () => _uploadImage(),
                    onPressed: (() async {
                      if (_imageFile.path == "null" ||
                          _descriptionController.text == "" ||
                          _nameController.text == "") {
                        Get.snackbar("Error", "Please enter all details",
                            backgroundColor: Colors.red,
                            colorText: Colors.white);
                      } else {
                        setState(() {
                          clickAdd = true;
                        });
                        await _uploadImage();
                      }
                    }),
                    child: clickAdd
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : Text('Add Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
