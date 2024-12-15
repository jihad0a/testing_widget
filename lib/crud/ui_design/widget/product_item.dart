import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/product.dart';
import '../screens/update_product_screen.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  List<Product> productList = [];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.product.image ?? 'Unknown', width: 50,),
      title: Text(widget.product.productName ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product Code: ${widget.product.productCode ?? 'Unknown'}'),
          Text('Quantity: ${widget.product.quantity ?? 'Unknown'}'),
          Text('Price: ${widget.product.unitPrice ?? 'Unknown'}'),
          Text('Total Price: ${widget.product.totalPrice ?? 'Unknown'}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(onPressed: () {
            _deleteProduct(widget.product.id.toString());
          }, icon: const Icon(Icons.delete_sharp),),
          IconButton(onPressed: () {
            Navigator.pushNamed(
              context, UpdateProductScreen.name,
              arguments: widget.product);
          }, icon: const Icon(Icons.edit_outlined),),
        ],
      ),
    );
  }
  Future<void> _deleteProduct(String id) async {
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/${id}');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(content: Text('ProductDelete Successful!')),);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Delete failed!')),
      );
      setState(() {});
    }
  }
}
