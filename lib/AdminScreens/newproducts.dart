import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../repositories/authentication.dart';
import 'homeScreen.dart';

class Newproducts extends StatefulWidget {
  const Newproducts({super.key});


  @override
  NewProductsState createState() => NewProductsState();
}

class NewProductsState extends State<Newproducts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController productImage = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  Authentication authentication = Authentication();
  final newProductKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  var image;
  List categories = ['Milk', 'Curd', 'Ghee', 'Paneer'];
  String? selectedItem = "";
  File? imageFile;
  var url;
  String? imageUrl;
 var documentId;

  @override
   void initState()  {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top:19.6),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 20,
              ),
            ),
          ),
          Expanded(
            child: Form(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: const EdgeInsets.only(left: 20.3, right: 20.3),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Product Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins-Light"),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        buildproductname(),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Product Category",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins-Light"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildcategory(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 12.3),
                          child: const Text(
                            "Price",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins-Light"),
                          ),
                        ),
                        buildprice(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 12.3),
                          child: const Text(
                            "Quantity",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins-Light"),
                          ),
                        ),
                        //SizedBox(height: 8,),
                        buildQuantity(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 12.3),
                          child: const Text(
                            "Upload Image",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins-Light"),
                          ),
                        ),
                        buildImage(),
                        const SizedBox(
                          height: 5,
                        ),
                        saveButton(),
                        const SizedBox(
                          height: 10,
                        )
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildproductname() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: (name) {
          if (name!.isEmpty) {
            return 'Please enter product name';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "Enter Product Name",
            labelText: "Name",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
         controller: nameController,
      ),
    );
  }

  buildcategory() {
    return DropdownButtonFormField2(
      decoration: const InputDecoration(
        hintText: "Select Category",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
        ),
      ),
      items: categories.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            onTap: () {
              selectedItem = item;
            },
          )).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select category.';
        }
        return null;
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
      },
      onSaved: (value) {
        selectedItem = value.toString();
        value = selectedItem;
      },
    );
  }

  buildprice() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: (price) {
          if (price!.isEmpty) {
            return 'Please enter price';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "Enter Price",
            labelText: "Price",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: priceController,
      ),
    );
  }

  buildQuantity() {
    return SizedBox(
      height: 70,
      child: TextFormField(
        validator: (quantity) {
          if (quantity!.isEmpty) {
            return 'Please enter Quantity';
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: "How much Quantity",
            labelText: "Quantity",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: quantityController,
      ),
    );
  }

  uploadImage() {
    return Container(
      alignment: Alignment.topRight,
      child: TextButton(
          style: TextButton.styleFrom(
              minimumSize: const Size(20, 20),
              foregroundColor: Colors.greenAccent,
              backgroundColor: const Color(0xffc29b51)),
          onPressed: () {
            setState(() {
              _getFromGallery();
            });

          },
          child: const Text(
            "Upload ",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null){
      setState(()  {
        imageFile = File(pickedFile.path);
         image =  authentication.moveToStorage(imageFile, selectedItem, nameController.text);
      });
    }
  }

  buildImage() {
    return Column(
      children: [
        imageFile != null
            ? Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(
                      left: 12.3,
                      right: 12.3,
                      top: 5.6,
                    ),
                    child: Center(
                      child: Image.file(
                        imageFile!,
                        width: 200,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        imageFile = null;
                      });
                    },
                    child: const Text(
                      "Remove",
                      textAlign: TextAlign.center,
                    ))
              ],
            )
            : Container(
              decoration: BoxDecoration(
                  border: Border.all(
                color: const Color(0xcc9fce4c),
              )),
              child: Container(
                  margin: const EdgeInsets.only(right: 12.3),
                  child: uploadImage()),
            )
      ],
    );
  }

  saveButton() {
    return Center(
      child: TextButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(140, 30)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
              side: const BorderSide(color: Colors.green),
            ))),
        onPressed: () async {
          image = await image;
          documentId = authentication.product_values();
          var value = await documentId;
          if(value==null){
             value = 1000;
          }
          else{
            value = int.parse(value);
            value = value+1;
          }

          Map<String, dynamic> data = {
              "productName": nameController.text,
              "price": int.parse(priceController.text),
              "quantity": int.parse(quantityController.text),
              "category": selectedItem,
              "image": image,
               "id":value
          };
          await FirebaseFirestore.instance
              .collection('Admin')
              .doc("Products")
              .collection("Product_details")
              .doc(value.toString()).set(data);
          // ignore: use_build_context_synchronously
          Navigator.of(context)
              .push(
              MaterialPageRoute(
                  builder: (BuildContext
                  context) =>
                      Adminpannel()));
        },
        child: const Text(
          "Save",
          style: TextStyle(fontSize: 15, fontFamily: "Poppins-Medium"),
        ),
      ),
    );
  }


}
