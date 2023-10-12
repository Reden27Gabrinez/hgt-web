import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/widgets_common/snackbar.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController productName = TextEditingController();
  TextEditingController productDesc = TextEditingController();
  TextEditingController productQuant = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController selectedSubCategory = TextEditingController();
  TextEditingController selectedCategory = TextEditingController();
  String _imageFile = '';
  String _productCategory = '';
  final db = FirebaseFirestore.instance;
  Uint8List? selectedImageInBytes;
  Future<void> pickImage() async {
    try {
      // Pick image using file_picker package
      FilePickerResult? fileResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      // If user picks an image, save selected image to variable
      if (fileResult != null) {
        setState(() {
          _imageFile = fileResult.files.first.name;
          selectedImageInBytes = fileResult.files.first.bytes;
        });
      }
    } catch (e) {
      // If an error occured, show SnackBar with error message
      customSnackBar(e.toString());
    }
  }

  Future<String> uploadImageToFirebaseStorage() async {
    Reference ref = FirebaseStorage.instance.ref().child('Images');
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask = ref.putData(selectedImageInBytes!, metadata);

    await uploadTask.whenComplete(() => customSnackBar('Image Uploaded'));
    final imgURL = ref.getDownloadURL();
    return imgURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (_imageFile.isNotEmpty || _imageFile != '')
                            Image.memory(selectedImageInBytes!,
                                height: 200, width: 200),
                          ElevatedButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: Text('Pick Image'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: productName,
                            decoration: InputDecoration(
                                hintText: 'Product Name',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 31, 31, 176))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 31, 31, 176)))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: productDesc,
                            decoration: InputDecoration(
                                hintText: 'Product Description',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 31, 31, 176))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 31, 31, 176)))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: productQuant,
                            decoration: InputDecoration(
                                hintText: 'Quantity',
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 31, 31, 176))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 31, 31, 176)))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: productPrice,
                            decoration: InputDecoration(
                                hintText: 'Price',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 31, 176),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 31, 176),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 31, 31, 176)))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: TextField(
                                  enabled: false,
                                  controller: selectedCategory,
                                  decoration: InputDecoration(
                                      hintText:
                                          'Select Category: ${selectedCategory.text}'
                                              .toUpperCase(),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 31, 31, 176)))),
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                  enabled: false,
                                  controller: selectedSubCategory,
                                  decoration: InputDecoration(
                                      hintText:
                                          'Select Sub-Category: ${selectedSubCategory.text}'
                                              .toUpperCase(),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 31, 31, 176)))),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('category')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Text('No data available');
                              }

                              List<QueryDocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  var documentData = documents[index].data()
                                      as Map<String, dynamic>;
                                  var arrayData = documentData['categories']
                                      as List<
                                          dynamic>; // Replace 'array_field' with your array field name.

                                  // Process the array data if needed.
                                  String arrayString = arrayData.join(
                                      ', '); // Convert the array to a comma-separated string.

                                  return SizedBox(
                                    child: Card(
                                      child: ListTile(
                                          leading: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedCategory.text =
                                                    documentData['name'];
                                              });
                                            },
                                            child: const Text(
                                              'Select Category',
                                            ),
                                          ),
                                          dense: true,
                                          title: Text(
                                            '${documentData['name']}'
                                                .toUpperCase(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 20),
                                          ),
                                          subtitle: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: arrayData.length,
                                            itemBuilder: (context, arrayIndex) {
                                              var arrayElement =
                                                  arrayData[arrayIndex]
                                                      .toString();
                                              return ListTile(
                                                trailing: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      selectedSubCategory.text =
                                                          arrayElement;
                                                    });
                                                  },
                                                  child: const Text(
                                                    'Select Sub-Category',
                                                  ),
                                                ),
                                                dense: true,
                                                title: Text(
                                                    arrayElement.toUpperCase()),
                                              );
                                            },
                                          ) // Display the array as a string.
                                          ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await FirebaseFirestore.instance
                                .collection('products')
                                .doc()
                                .set({
                              'p_name': productName.text,
                              'p_price': productPrice.text,
                              'p_desc': productDesc.text,
                              'p_quantity': productQuant.text,
                              'p_category': selectedCategory.text,
                              'p_subcategory': selectedSubCategory.text,
                              'p_imgs': FieldValue.arrayUnion(
                                [
                                  await uploadImageToFirebaseStorage(),
                                ],
                              ),
                            });

                            productName.clear();
                            productPrice.clear();
                            productQuant.clear();
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        child: Text('Add'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
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
