import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});
  static const String name='/Add_new_product';

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}


bool _addNewProductInProgress=false;

class _AddNewProductState extends State<AddNewProduct> {
  TextEditingController _titleTEcontroller=TextEditingController();
  TextEditingController _priceTEcontroller=TextEditingController();
  TextEditingController _totalpriceTEcontroller=TextEditingController();
  TextEditingController _quentityTEcontroller=TextEditingController();
  TextEditingController _imageTEcontroller=TextEditingController();
  TextEditingController _codeTEcontroller=TextEditingController();

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                visible: _addNewProductInProgress==false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        addNewProduct();


                      }



                    },
                    child: Text('Save'),

                ),
              )
            ],
          ),
        ),
      ),
    );

  }
  Future<void> addNewProduct() async{
    _addNewProductInProgress=true;
    setState(() {});
    Uri uri=Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');

    Map<String,dynamic> requestBody={
      "Img":_imageTEcontroller.text.trim(),
      "ProductCode":_codeTEcontroller.text.trim(),
      "ProductName":_titleTEcontroller.text.trim(),
      "Qty":_quentityTEcontroller.text.trim(),
      "TotalPrice":_totalpriceTEcontroller.text.trim(),
      "UnitPrice":_priceTEcontroller.text.trim()
    };
    Response response=  await post(
        uri,
      headers: {
          "content-type" : "Application/json"
      },
      body: jsonEncode(requestBody),
    );
    print(response.statusCode);
    print(response.body);
    _addNewProductInProgress=false;
    setState(() {});
    if(response.statusCode==200){
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text('New product added'),
        )
      );

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('New product added failed!.Try again')
        ),
      );
    }

  }


  void _clearTextFields(){
    _titleTEcontroller.clear();
    _priceTEcontroller.clear();
    _codeTEcontroller.clear();
    _totalpriceTEcontroller.clear();
    _quentityTEcontroller.clear();
    _imageTEcontroller.clear();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEcontroller.dispose();
    _priceTEcontroller.dispose();
    _codeTEcontroller.dispose();
    _totalpriceTEcontroller.dispose();
    _quentityTEcontroller.dispose();
    _imageTEcontroller.dispose();
  }
}
