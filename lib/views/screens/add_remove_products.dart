import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/views/screens/add_product.dart';

class AddorRemoveProductsPage extends StatefulWidget {
  const AddorRemoveProductsPage({super.key});

  @override
  State<AddorRemoveProductsPage> createState() =>
      _AddorRemoveProductsPageState();
}

class _AddorRemoveProductsPageState extends State<AddorRemoveProductsPage> {
  final ref = FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductPage(),
            ),
          );
        },
        label: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: ref,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SpinKitCircle(
                      color: Colors.red,
                    );
                  }
                  final documents = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      final data = document.data();

                      return ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('products')
                                .doc(document.reference.id)
                                .delete();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        title: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 3,
                            minHeight: 100,
                          ),
                          child: Card(
                            elevation: 20,
                            color: const Color.fromARGB(255, 31, 31, 176),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 31, 31, 176),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Card(
                                    child: Image.network(
                                      '${data['p_imgs'][0]}',
                                      scale: 2,
                                    ),
                                  ),
                                  Text(
                                    'Product Name: ${data['p_name']},',
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                          255, 252, 255, 58),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                    color: Color.fromARGB(255, 252, 255, 58),
                                  ),
                                  Text(
                                    'Description: ${data['p_desc']}',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 252, 255, 58),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Category: ${data['p_category']}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              255, 252, 255, 58),
                                        ),
                                      ),
                                      Text(
                                        'Sub-Category: ${data['p_subcategory']}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              255, 252, 255, 58),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Price: ${data['p_price']}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              255, 252, 255, 58),
                                        ),
                                      ),
                                      Text(
                                        'Quantity: ${data['p_quantity']}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                              255, 252, 255, 58),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
