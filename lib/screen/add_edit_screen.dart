import 'dart:io';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/requests/productRequests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class add_edit_screen extends StatefulWidget {
  static const routeName = '/add_edit_screen';
  @override
  _add_edit_screenState createState() => _add_edit_screenState();
}

class _add_edit_screenState extends State<add_edit_screen> {
  File _pickedImage;
  final _nameController=TextEditingController();
  final _priceController=TextEditingController();
  final _form = GlobalKey<FormState>();
  File _image;
  final picker = ImagePicker();

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveForm() async{
    final isValid = _form.currentState.validate();
    if (!isValid || _pickedImage == null) {
      return;
    }else{
      try{
        Product newProduct = Product(name: _nameController.text,
            price:_priceController.text
            ,productImage: _image);
        var product=await ProductRequests().addNewProduct(newProduct);
        if(product !=null){
          print('product added successfully ${product}');
          Navigator.of(context).pop();
        }
      }catch(ex){
        print('error in posting new product');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Photo Library'),
                        onTap: () {
                          getImageCamera();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text('Camera'),
                      onTap: () {
                        getImageGallery();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          }
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(87, 87, 243, 1),
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'name'),
                textInputAction: TextInputAction.next,
                controller: _nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: _priceController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
              ),
        SizedBox(
          height: 32,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: _image != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.file(
                  _image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              )
                  : Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                width: 100,
                height: 100,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
