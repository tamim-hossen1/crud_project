import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/product.dart';

class UpdateProductItems extends StatefulWidget {
  const UpdateProductItems({super.key, required this.product});
static const String name='/Update_new_product';

final Product product;
  @override
  State<UpdateProductItems> createState() => _UpdateProductItemsState();
}



class _UpdateProductItemsState extends State<UpdateProductItems> {
  TextEditingController _titleTEcontroller=TextEditingController();
  TextEditingController _priceTEcontroller=TextEditingController();
  TextEditingController _totalpriceTEcontroller=TextEditingController();
  TextEditingController _quentityTEcontroller=TextEditingController();
  TextEditingController _imageTEcontroller=TextEditingController();
  TextEditingController _codeTEcontroller=TextEditingController();

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  bool _updateProductInProgress=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTEcontroller.text=widget.product.productName ?? '';
    _priceTEcontroller.text=widget.product.productCode ?? '';
    _totalpriceTEcontroller.text=widget.product.totalPrice ?? '';
    _quentityTEcontroller.text=widget.product.qty ?? '';
    _imageTEcontroller.text=widget.product.productName ?? '';
    _codeTEcontroller.text=widget.product.productCode ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _titleTEcontroller,
                  decoration: InputDecoration(
                      hintText: 'Name',
                      labelText: 'Product Name',
                    border: OutlineInputBorder(),
          
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter your Product Name';
                    }
                    return null;
                  }
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _priceTEcontroller,
                decoration: InputDecoration(
                  hintText: 'Price',
                  labelText: 'Product Price',
                  border: OutlineInputBorder(),
          
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your product price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _totalpriceTEcontroller,
                decoration: InputDecoration(
                  hintText: 'Total Price',
                  labelText: 'Total product price',
                  border: OutlineInputBorder(),
          
                ),
          
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your Product total Price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _quentityTEcontroller,
                decoration: InputDecoration(
                  hintText: 'Quentity',
                  labelText: 'Product Quentity',
                  border: OutlineInputBorder(),
          
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your Product Quentity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _imageTEcontroller,
                decoration: InputDecoration(
                  hintText: 'Image',
                  labelText: 'Product Image Url',
                  border: OutlineInputBorder(),
          
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your Product Image Url';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _codeTEcontroller,
                decoration: InputDecoration(
                  hintText: 'Code',
                  labelText: 'Product Code',
                  border: OutlineInputBorder(),
          
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your Product Code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.0),
              Visibility(
                visible: _updateProductInProgress==false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _updateProduct();

                      }
                    },
                    child:Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _updateProduct() async{
    _updateProductInProgress=true;
    setState(() {});
    Uri uri=Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');

    Map<String,dynamic> requestBody={
      "Img":_imageTEcontroller.text.trim(),
      "ProductName":_titleTEcontroller.text.trim(),
      "ProductCode":_codeTEcontroller.text.trim(),
      "Qty":_quentityTEcontroller.text.trim(),
      "TotalPrice":_totalpriceTEcontroller.text.trim(),
      "UnitPrice":_priceTEcontroller.text.trim(),
    };
    Response response=await post(
      uri,
      headers: {'Content-type' : 'application/json'},
      body: jsonEncode(requestBody),
    );
    _updateProductInProgress=false;
    setState(() {});
    print(response.statusCode);
    print(response.body);

    if(response.statusCode==200){
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:Text('Product has been Updated')
        )
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Product updated failed'),
          ),
      );
    }
  }

 void _clearTextFields(){
    _titleTEcontroller.clear();
    _priceTEcontroller.clear();
    _totalpriceTEcontroller.clear();
    _quentityTEcontroller.clear();
    _codeTEcontroller.clear();
    _imageTEcontroller.clear();
 }
  
  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    
    _titleTEcontroller.dispose();
    _priceTEcontroller.dispose();
    _codeTEcontroller.dispose();
    _imageTEcontroller.dispose();
    _quentityTEcontroller.dispose();
    _totalpriceTEcontroller.dispose();
    
  }
}


