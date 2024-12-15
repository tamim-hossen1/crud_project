import 'dart:convert';

import 'package:crud_project/Screen/Add_new_product.dart';
import 'package:crud_project/Widget/product_item.dart';
import 'package:crud_project/model/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});


  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> ProductList=[];
  bool _getproductListInProgress=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
              onPressed: (){
                _getProductList();
              },
              icon: Icon(Icons.refresh),
          )
        ],
      ),

      body: RefreshIndicator(
        onRefresh: ()async{
          _getProductList();
        },
        child: Visibility(
          visible: _getproductListInProgress==false,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: ProductList.length,
              itemBuilder: (context,index){
                return ProductItem(
                    product: ProductList[index]
                );
              }
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, AddNewProduct.name);
          },
          child: Icon(Icons.add),
      ),

    );
  }
  Future<void> _getProductList() async{
    _getproductListInProgress=true;
    ProductList.clear();

    setState(() {});
    Uri uri=Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response= await get(uri);
    print(response.statusCode);
    print(response.body);
    if(response.statusCode==200){
      final decodeData=jsonDecode(response.body);
      print(decodeData["status"]);

      for(Map<String,dynamic> p in decodeData["data"]){
        Product product=Product(
          id:p['_id'],
          productName: p['ProductName'],
          productCode: p['ProductCode'],
          img: p['Img'],
          unitPrice: p['UnitPrice'],
          qty: p['Qty'],
          totalPrice: p['TotalPrice'],
          createdDate: p['CreatedDate']

        );
        ProductList.add(product);
    }
      setState(() {});
    }
    _getproductListInProgress=false;
    setState(() {

    });
  }
}
