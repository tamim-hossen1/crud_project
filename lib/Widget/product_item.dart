import 'package:crud_project/Screen/Update_product_Items.dart';
import 'package:crud_project/model/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Image.network(product.img ?? ''),
      title: Text(product.productName ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.productCode ?? ''),
          Text(product.qty ?? ''),
          Text(product.unitPrice ?? ''),
          Text(product.totalPrice ?? ''),


        ],

      ),
      trailing: Wrap(
        children: [
          IconButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Are you sure to Delete?'),
                        actions: [
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                          ),
                          TextButton(
                              onPressed: (){
                                _delete();
                                Navigator.pop(context);
                              },
                              child: Text('Yes')
                          )
                        ],
                      );
                    });

              },
              icon: Icon(Icons.delete)
          ),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, UpdateProductItems.name,
              arguments: product,
              );
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
    );
  }

  Future<void> _delete() async{

    final Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/${product.id}");

    Response response=  await get(uri);
    print(response.body);
    print(response.statusCode);

  }
}
