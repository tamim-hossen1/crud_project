import 'package:crud_project/Screen/Add_new_product.dart';
import 'package:crud_project/Screen/Update_product_Items.dart';
import 'package:crud_project/Screen/product_list.dart';
import 'package:crud_project/Widget/product_item.dart';
import 'package:crud_project/model/product.dart';
import 'package:flutter/material.dart';

class crudapp extends StatelessWidget {
  const crudapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings){
        late Widget widget;
        if(settings.name=='/'){
          widget=const ProductList();
        }
        else if(settings.name==AddNewProduct.name){
          widget=const AddNewProduct();
        }
        else if(settings.name==UpdateProductItems.name){
          final Product product=settings.arguments as Product;
          widget = UpdateProductItems(product: product);
        }
        return MaterialPageRoute(builder: (context){
          return widget;
        });
      },
      

    );
  }
}
