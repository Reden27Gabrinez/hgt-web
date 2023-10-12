import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewUserPage extends StatefulWidget {
  const ViewUserPage({super.key});

  @override
  State<ViewUserPage> createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {
  List<DataRow> _createRows(QuerySnapshot snapshot) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      final data = documentSnapshot.data()! as Map<String, dynamic>;

      return DataRow(cells: [
        DataCell(
          Text(
            '${data['id']}',
          ),
        ),
        DataCell(
          Text(
            '${data['name']}'.toUpperCase(),
          ),
        ),
        DataCell(
          Text(
            '${data['email']}',
          ),
        ),
        DataCell(
          Text(
            '${data['role']}'.toUpperCase(),
          ),
        ),
      ]);
    }).toList();

    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (BuildContext context, AsyncSnapshot userSnapshot) {
                  if (userSnapshot.hasData) {
                    return DataTable(
                      headingTextStyle: GoogleFonts.roboto(
                        fontSize: 17,
                        color: const Color.fromARGB(255, 31, 31, 176),
                      ),
                      border: TableBorder.all(
                        width: 1,
                        color: const Color.fromARGB(
                          255,
                          31,
                          31,
                          176,
                        ),
                      ),
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(
                            'ID',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'NAME',
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'EMAIL',
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ROLE',
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: _createRows(userSnapshot.data),
                    );
                  } else {
                    return const SpinKitCircle(
                      color: const Color.fromARGB(255, 31, 31, 176),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
