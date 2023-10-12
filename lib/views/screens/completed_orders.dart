import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_app/consts/consts.dart';

class CompletedOrdersPage extends StatefulWidget {
  const CompletedOrdersPage({super.key});

  @override
  State<CompletedOrdersPage> createState() => _CompletedOrdersPageState();
}

class _CompletedOrdersPageState extends State<CompletedOrdersPage> {
  bool orderConfirmed = true;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('order_delivered', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No data available');
                }

                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var documentData =
                        documents[index].data() as Map<String, dynamic>;
                    var arrayData = documentData['orders'] as List<
                        dynamic>; // Replace 'array_field' with your array field name.

                    var totalAmount = NumberFormat.simpleCurrency(
                      locale: 'fil_PH',
                      decimalDigits: 2,
                    ).format(
                      documentData['total_amount'],
                    );

                    return SizedBox(
                      child: Card(
                        child: ListTile(
                          dense: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Order Code: ${documentData['order_code']}\n${documentData['order_by_name']}\nTotal Amount: $totalAmount',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          trailing: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Card(
                                          color: const Color.fromARGB(
                                              255, 31, 31, 176),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  'USER ID: ${documentData['order_by']}',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        252,
                                                                        255,
                                                                        58),
                                                                    letterSpacing:
                                                                        3,
                                                                  ),
                                                                ),
                                                                const Divider(),
                                                                Text(
                                                                  'USER FULLNAME: ${documentData['order_by_name']}',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        252,
                                                                        255,
                                                                        58),
                                                                    letterSpacing:
                                                                        3,
                                                                  ),
                                                                ),
                                                                const Divider(),
                                                                Text(
                                                                  'EMAIL: ${documentData['order_by_email']}',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        252,
                                                                        255,
                                                                        58),
                                                                    letterSpacing:
                                                                        3,
                                                                  ),
                                                                ),
                                                                const Divider(),
                                                                Text(
                                                                  'ADDRESS: ${documentData['order_by_address']}',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        252,
                                                                        255,
                                                                        58),
                                                                    letterSpacing:
                                                                        3,
                                                                  ),
                                                                ),
                                                                const Divider(),
                                                                Text(
                                                                  'PAYMENT METHOD: ${documentData['payment_method']}',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        252,
                                                                        255,
                                                                        58),
                                                                    letterSpacing:
                                                                        3,
                                                                  ),
                                                                ),
                                                                const Divider(),
                                                                Text(
                                                                  'DELIVERY METHOD: ${documentData['delivery_method']}',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        252,
                                                                        255,
                                                                        58),
                                                                    letterSpacing:
                                                                        3,
                                                                  ),
                                                                ),
                                                                const Divider(),
                                                                documentData[
                                                                        'order_delivered'] =
                                                                    true
                                                                        ? Text(
                                                                            'STATUS: Order Delivered',
                                                                            style:
                                                                                GoogleFonts.roboto(
                                                                              color: const Color.fromARGB(255, 252, 255, 58),
                                                                              letterSpacing: 3,
                                                                            ),
                                                                          )
                                                                        : Container(),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: const Text('Details'),
                          ),
                          subtitle: ListView.builder(
                            shrinkWrap: true,
                            itemCount: arrayData.length,
                            itemBuilder: (context, arrayIndex) {
                              var arrayElement =
                                  arrayData[arrayIndex].toString();
                              return ListTile(
                                leading: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                    arrayData[arrayIndex]['img'],
                                  ),
                                ),
                                dense: true,
                                title: Text(
                                  'Product: ${arrayData[arrayIndex]['title']}\nQuantity: ${arrayData[arrayIndex]['qty']}',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
