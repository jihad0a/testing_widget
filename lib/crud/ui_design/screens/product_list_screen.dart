import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/product.dart';
import '../widget/product_item.dart';
import 'add_new_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  List<Product> productList = [];
  bool _getProductListInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Product'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            _getProductList();
          }, icon: const Icon(Icons.refresh),),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async{
          _getProductList();
      },
        child: Visibility(
          visible: _getProductListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductItem(product: productList[index]);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewProductScreen.name);
        },
        child: const Icon(Icons.add_sharp),
      ),

    );
  }

  Future<void> _getProductList() async{
    productList.clear();
    _getProductListInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response = await get(uri);
    if(response.statusCode == 200) {
      final decodedDate = jsonDecode(response.body);
      for(Map<String, dynamic> p in decodedDate ['data']) {
        Product product = Product(
          id: p['_id'],
          productName: p['ProductName'],
          unitPrice: p['UnitPrice'],
          totalPrice: p['TotalPrice'],
          quantity: p['Qty'],
          productCode: p['ProductCode'],
          createDate: p['CreatedDate'],
          image: p['Img'],
        );
        productList.add(product);
      } setState(() {});
    } _getProductListInProgress = false;
    setState(() {});
  }

}