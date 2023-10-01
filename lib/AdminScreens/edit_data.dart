// ignore_for_file: no_logic_in_create_state, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

// ignore: must_be_immutable
class editData extends StatefulWidget {
  String? name;
  String? category;
  int? price;
  int? quantity;
  String? image;
  String?id;
  editData({super.key, this.name, this.category, this.price, this.quantity, this.image, this.id});
  @override
  editDataState createState() {
    return editDataState(
      id:id,
        name: name,
        category: category,
        price: price,
        quantity: quantity,
        image: image);
  }
}

class editDataState extends State<editData> {
  TextEditingController? nameController;
  TextEditingController? priceController;
  TextEditingController? quantityController;
  String? id;
  String? name;
  String? category;
  int? price;
  int? quantity;
  String? image;
  List categories = ['Milk', 'Curd', 'Ghee', 'Paneer'];
  String? selectedItem;
  String? unSelecteditem;
  editDataState(
      {this.id,this.name, this.category, this.price, this.quantity, this.image});
  @override
  void initState() {
    nameController = TextEditingController();
    nameController!.text = name!;
    priceController = TextEditingController();
    priceController!.text = price.toString();
    quantityController = TextEditingController();
    quantityController!.text = quantity.toString();
    selectedItem = category;
    super.initState();
  }

  @override
  void dispose() {
    nameController!.dispose();
    priceController!.dispose();
    quantityController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 19.6),
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
              color: Colors.greenAccent,
            ),
          ),
        ),
        Expanded(
            child: Form(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 20.6, right: 20.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Product Name",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Poppins-Light"),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  buildproductname(),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text(
                    "Product Category",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Poppins-Light"),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  updateCategories(category),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text(
                    "Price",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Poppins-Light"),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  buildprice(),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Quantity",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Poppins-Light"),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  buildQuantity(),
                  const SizedBox(height: 10,),
                  buildbutton()
                ],
              ),
            ),
          ),
        ))
      ],
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
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
            ),
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

  updateCategories(String? category) {
    unSelecteditem = category;
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.black, fontFamily: "Poppins-Light"),
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green.shade700, width: 1.5),
        ),
        contentPadding: EdgeInsets.zero,
      ),
      hint: Text(
        selectedItem!,
        style: const TextStyle(fontFamily: "Poppins-Light", color: Colors.black),
      ),

      items: categories.map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () {
              setState(() {
                selectedItem = item;
              });
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
        setState(() {});
      },
      onSaved: (value) {
        selectedItem = selectedItem;
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

  buildbutton() {
    return Center(
      child: TextButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(120, 40)),
            backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ))),
        child: const Text(
          "Update",
          style: TextStyle(color: Colors.white, fontFamily: "Poppins-Medium"),
        ),
        onPressed: ()  async {

          selectedItem = selectedItem;

            Map<String, dynamic> data = {
              "productName": nameController!.text,
              "category": selectedItem,
              "price": int.parse(priceController!.text),
              "quantity": int.parse(quantityController!.text)
            };
            DocumentReference documentReference =  FirebaseFirestore.instance.collection("Admin").
            doc("Products").collection("Product_details").doc(id);
              await documentReference.update(data);
            // ignore: use_build_context_synchronously
            Navigator.of(context)
                .push(
                MaterialPageRoute(
                    builder: (BuildContext
                    context) =>
                        Adminpannel()));

        },
      ),
    );
  }
}
