
import 'package:flutter/material.dart';
import 'package:widget/crud/ui_design/screens/add_new_product_screen.dart';
import 'package:widget/crud/ui_design/screens/product_list_screen.dart';
import 'package:widget/crud/ui_design/screens/update_product_screen.dart';

import 'models/product.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if(settings.name == '/') {
          widget = const  ProductListScreen();
        } else if(settings.name == AddNewProductScreen.name) {
          widget = const AddNewProductScreen();
        } else if(settings.name == UpdateProductScreen.name) {
          final Product product =settings.arguments as Product;
          widget = UpdateProductScreen(product: product);
        }
        return MaterialPageRoute(builder: (context) => widget);
      },
    );
  }
}
