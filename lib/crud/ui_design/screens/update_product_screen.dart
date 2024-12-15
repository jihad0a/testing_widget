import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  final Product product;
  static const String name = '/update-product';

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _codeEditingController = TextEditingController();
  final TextEditingController _uniteEditingController = TextEditingController();
  final TextEditingController _totalEditingController = TextEditingController();
  final TextEditingController _quantityEditingController = TextEditingController();
  final TextEditingController _imageEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameEditingController.text = widget.product.productName ?? '';
    _uniteEditingController.text = widget.product.unitPrice ?? '';
    _totalEditingController.text = widget.product.totalPrice ?? '';
    _quantityEditingController.text = widget.product.quantity ?? '';
    _imageEditingController.text = widget.product.image ?? '';
    _codeEditingController.text = widget.product.productCode ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: 'Product Name',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Inter Product Name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: _codeEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Code',
              labelText: 'Product Code',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Inter valid Code';
              }
              return null;
            },
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: _uniteEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Price',
              labelText: 'Product Price',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Inter valid Price';
              }
              return null;
            },
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: _totalEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Total Price',
              labelText: 'Product Total',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Inter valid Price';
              }
              return null;
            },
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: _quantityEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Quantity',
              labelText: 'Product Quantity',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Inter Product Quantity';
              }
              return null;
            },
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: _imageEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            decoration: InputDecoration(
              hintText: 'image',
              labelText: 'Product Image',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Inter valid url';
              }
              return null;
            },
          ),
          const SizedBox(height: 14,),
          Visibility(
            visible: _updateProductInProgress == false,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateProduct();
                }
              },
              child: const Text('Add Product'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _updateProduct() async{
    _updateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');

    Map<String, dynamic> requestBody = {
      "Img": _imageEditingController.text.trim(),
      "ProductCode": _codeEditingController.text.trim(),
      "ProductName": _nameEditingController.text.trim(),
      "Qty": _quantityEditingController.text.trim(),
      "TotalPrice": _totalEditingController.text.trim(),
      "UnitPrice": _uniteEditingController.text.trim(),
    };

    Response response = await post(
      uri,
      headers: {'Content-type' : 'application/json'},
      body: jsonEncode(requestBody),
    );
    _updateProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product has been updated!')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product updated failed. Try later.')));
      Navigator.pop(context);
    }

  }


  @override
  void dispose() {
    _nameEditingController.dispose();
    _codeEditingController.dispose();
    _uniteEditingController.dispose();
    _totalEditingController.dispose();
    _imageEditingController.dispose();
    _quantityEditingController.dispose();
    super.dispose();
  }
}