import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo15/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class creaDataAdmin extends StatefulWidget {
  const creaDataAdmin({super.key});

  @override
  State<creaDataAdmin> createState() => _creaDataAdminState();
}

class _creaDataAdminState extends State<creaDataAdmin> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productInfoController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void ProductAddInfo() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final String uid = Uuid().v1();

    Map<String, dynamic> data = {
      'productName': productNameController.text.trim(),
      'productPrice': productPriceController.text.trim(),
      'productInfo': productInfoController.text.trim(),
      'productDescription': productDescriptionController.text.trim(),
      'id': uid,
    };

    try {
      await FirebaseFirestore.instance.collection('ClothingData').doc(uid).set(data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data Submitted Successfully", style: TextStyle(color: Colors.white)),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }



  Widget customTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String errorText,
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) => (value == null || value.isEmpty) ? errorText : null,
      ),
    );
  }



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Enter Product Details",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),

                    customTextField(
                      label: 'Product Name',
                      icon: Icons.label,
                      controller: productNameController,
                      errorText: 'Please enter Product Name',
                    ),
                    customTextField(
                      label: 'Product Price',
                      icon: Icons.attach_money,
                      controller: productPriceController,
                      errorText: 'Please enter Product Price',
                      inputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    customTextField(
                      label: 'Product Info',
                      icon: Icons.info_outline,
                      controller: productInfoController,
                      errorText: 'Please enter Product Info',
                    ),
                    customTextField(
                      label: 'Product Description',
                      icon: Icons.description,
                      controller: productDescriptionController,
                      errorText: 'Please enter Product Description',
                    ),

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ElevatedButton(
                        onPressed: ProductAddInfo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Submit Data',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
