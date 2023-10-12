import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController addSubCat = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color.fromARGB(255, 31, 31, 176),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 10,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        const Color.fromARGB(255, 31, 31, 176),
                                  ),
                                  child: Text(
                                    'PERSONAL CARE',
                                    style: GoogleFonts.roboto(
                                      color: const Color.fromARGB(
                                          255, 252, 255, 58),
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('category')
                                        .doc('personal_care')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: SpinKitCircle(
                                            color: Color.fromARGB(
                                                255, 31, 31, 176),
                                          ),
                                        );
                                      }

                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          itemExtent: 50,
                                          shrinkWrap: true,
                                          children: data['categories']
                                              .map<Widget>((e) {
                                            return Column(
                                              children: [
                                                ListTile(
                                                  dense: true,
                                                  shape:
                                                      const BeveledRectangleBorder(
                                                    side: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 31, 31, 176),
                                                    ),
                                                  ),
                                                  title: Center(
                                                    child: Text(e
                                                        .toString()
                                                        .toUpperCase()),
                                                  ),
                                                  trailing: IconButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'category')
                                                          .doc('personal_care')
                                                          .update(
                                                        {
                                                          'categories':
                                                              FieldValue
                                                                  .arrayRemove(
                                                                      [e]),
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                )
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 31, 31, 176),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            insetPadding:
                                                const EdgeInsets.all(280),
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextField(
                                                  controller: addSubCat,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('personal_care')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayUnion([
                                                          addSubCat.text
                                                              .toString(),
                                                        ]),
                                                      },
                                                    );
                                                    addSubCat.clear();
                                                  },
                                                  child: const Text('Add'),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Add Sub-Category',
                                    style: GoogleFonts.roboto(
                                      color: const Color.fromARGB(
                                          255, 252, 255, 58),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color.fromARGB(255, 31, 31, 176),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 10,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        const Color.fromARGB(255, 31, 31, 176),
                                  ),
                                  child: Text(
                                    'FROZEN GOODS',
                                    style: GoogleFonts.roboto(
                                      color: const Color.fromARGB(
                                          255, 252, 255, 58),
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('category')
                                        .doc('frozen_goods')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: SpinKitCircle(
                                            color: Color.fromARGB(
                                                255, 31, 31, 176),
                                          ),
                                        );
                                      }

                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          itemExtent: 50,
                                          shrinkWrap: true,
                                          children: data['categories']
                                              .map<Widget>((e) {
                                            return Column(
                                              children: [
                                                ListTile(
                                                  dense: true,
                                                  shape:
                                                      const BeveledRectangleBorder(
                                                    side: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 31, 31, 176),
                                                    ),
                                                  ),
                                                  title: Center(
                                                    child: Text(e
                                                        .toString()
                                                        .toUpperCase()),
                                                  ),
                                                  trailing: IconButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'category')
                                                          .doc('frozen_goods')
                                                          .update(
                                                        {
                                                          'categories':
                                                              FieldValue
                                                                  .arrayRemove(
                                                                      [e]),
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                )
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 31, 31, 176),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            insetPadding:
                                                const EdgeInsets.all(280),
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextField(
                                                  controller: addSubCat,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('frozen_goods')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayUnion([
                                                          addSubCat.text
                                                              .toString(),
                                                        ]),
                                                      },
                                                    );
                                                    addSubCat.clear();
                                                  },
                                                  child: const Text('Add'),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Add Sub-Category',
                                    style: GoogleFonts.roboto(
                                      color: const Color.fromARGB(
                                          255, 252, 255, 58),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color.fromARGB(255, 31, 31, 176),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 10,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        const Color.fromARGB(255, 31, 31, 176),
                                  ),
                                  child: Text(
                                    'SNACKS',
                                    style: GoogleFonts.roboto(
                                      color: const Color.fromARGB(
                                          255, 252, 255, 58),
                                      letterSpacing: 3,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('category')
                                        .doc('snacks')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('${snapshot.error}');
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: SpinKitCircle(
                                            color: Color.fromARGB(
                                                255, 31, 31, 176),
                                          ),
                                        );
                                      }

                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          itemExtent: 50,
                                          shrinkWrap: true,
                                          children: data['categories']
                                              .map<Widget>((e) {
                                            return Column(
                                              children: [
                                                ListTile(
                                                  dense: true,
                                                  shape:
                                                      const BeveledRectangleBorder(
                                                    side: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 31, 31, 176),
                                                    ),
                                                  ),
                                                  title: Center(
                                                    child: Text(e
                                                        .toString()
                                                        .toUpperCase()),
                                                  ),
                                                  trailing: IconButton(
                                                    onPressed: () {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'category')
                                                          .doc('snacks')
                                                          .update(
                                                        {
                                                          'categories':
                                                              FieldValue
                                                                  .arrayRemove(
                                                                      [e]),
                                                        },
                                                      );
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                )
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 31, 31, 176),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            insetPadding:
                                                const EdgeInsets.all(280),
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextField(
                                                  controller: addSubCat,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('snacks')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayUnion([
                                                          addSubCat.text
                                                              .toString(),
                                                        ]),
                                                      },
                                                    );
                                                    addSubCat.clear();
                                                  },
                                                  child: const Text('Add'),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Text(
                                    'Add Sub-Category',
                                    style: GoogleFonts.roboto(
                                      color: const Color.fromARGB(
                                          255, 252, 255, 58),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 4,
                  height: 4,
                  color: Color.fromARGB(255, 31, 31, 176),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 31, 31, 176),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 31, 31, 176),
                                ),
                                child: Text(
                                  'BEVERAGES',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                              Center(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('category')
                                      .doc('beverages')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: SpinKitCircle(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      );
                                    }

                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        itemExtent: 50,
                                        shrinkWrap: true,
                                        children:
                                            data['categories'].map<Widget>((e) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                dense: true,
                                                shape:
                                                    const BeveledRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 31, 31, 176),
                                                  ),
                                                ),
                                                title: Center(
                                                  child: Text(e
                                                      .toString()
                                                      .toUpperCase()),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('beverages')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayRemove([e]),
                                                      },
                                                    );
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 31, 31, 176),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.all(280),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: addSubCat,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('category')
                                                      .doc('fresh_produce')
                                                      .update(
                                                    {
                                                      'categories': FieldValue
                                                          .arrayUnion([
                                                        addSubCat.text
                                                            .toString(),
                                                      ]),
                                                    },
                                                  );
                                                  addSubCat.clear();
                                                },
                                                child: const Text('Add'),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  'Add Sub-Category',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 31, 31, 176),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 31, 31, 176),
                                ),
                                child: Text(
                                  'FRESH PRODUCE',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                              Center(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('category')
                                      .doc('fresh_produce')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: SpinKitCircle(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      );
                                    }

                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        itemExtent: 50,
                                        shrinkWrap: true,
                                        children:
                                            data['categories'].map<Widget>((e) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                dense: true,
                                                shape:
                                                    const BeveledRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 31, 31, 176),
                                                  ),
                                                ),
                                                title: Center(
                                                  child: Text(e
                                                      .toString()
                                                      .toUpperCase()),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('fresh_produce')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayRemove([e]),
                                                      },
                                                    );
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 31, 31, 176),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.all(280),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: addSubCat,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('category')
                                                      .doc('fresh_produce')
                                                      .update(
                                                    {
                                                      'categories': FieldValue
                                                          .arrayUnion([
                                                        addSubCat.text
                                                            .toString(),
                                                      ]),
                                                    },
                                                  );
                                                  addSubCat.clear();
                                                },
                                                child: const Text('Add'),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  'Add Sub-Category',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 31, 31, 176),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 31, 31, 176),
                                ),
                                child: Text(
                                  'BABY/KIDS',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                              Center(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('category')
                                      .doc('baby_kids')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: SpinKitCircle(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      );
                                    }

                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        itemExtent: 50,
                                        shrinkWrap: true,
                                        children:
                                            data['categories'].map<Widget>((e) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                dense: true,
                                                shape:
                                                    const BeveledRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 31, 31, 176),
                                                  ),
                                                ),
                                                title: Center(
                                                  child: Text(e
                                                      .toString()
                                                      .toUpperCase()),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('baby_kids')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayRemove([e]),
                                                      },
                                                    );
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 31, 31, 176),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.all(280),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: addSubCat,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('category')
                                                      .doc('baby_kids')
                                                      .update(
                                                    {
                                                      'categories': FieldValue
                                                          .arrayUnion([
                                                        addSubCat.text
                                                            .toString(),
                                                      ]),
                                                    },
                                                  );
                                                  addSubCat.clear();
                                                },
                                                child: const Text('Add'),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  'Add Sub-Category',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 4,
                  height: 4,
                  color: Color.fromARGB(255, 31, 31, 176),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 31, 31, 176),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 31, 31, 176),
                                ),
                                child: Text(
                                  'BAKING GOODS',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                              Center(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('category')
                                      .doc('baking_goods')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: SpinKitCircle(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      );
                                    }

                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        itemExtent: 50,
                                        shrinkWrap: true,
                                        children:
                                            data['categories'].map<Widget>((e) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                dense: true,
                                                shape:
                                                    const BeveledRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 31, 31, 176),
                                                  ),
                                                ),
                                                title: Center(
                                                  child: Text(e
                                                      .toString()
                                                      .toUpperCase()),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('baking_goods')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayRemove([e]),
                                                      },
                                                    );
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 31, 31, 176),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.all(280),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: addSubCat,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('category')
                                                      .doc('baking_goods')
                                                      .update(
                                                    {
                                                      'categories': FieldValue
                                                          .arrayUnion([
                                                        addSubCat.text
                                                            .toString(),
                                                      ]),
                                                    },
                                                  );
                                                  addSubCat.clear();
                                                },
                                                child: const Text('Add'),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  'Add Sub-Category',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 31, 31, 176),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 31, 31, 176),
                                ),
                                child: Text(
                                  'DAIRY',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                              Center(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('category')
                                      .doc('dairy')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: SpinKitCircle(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      );
                                    }

                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        itemExtent: 50,
                                        shrinkWrap: true,
                                        children:
                                            data['categories'].map<Widget>((e) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                dense: true,
                                                shape:
                                                    const BeveledRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 31, 31, 176),
                                                  ),
                                                ),
                                                title: Center(
                                                  child: Text(e
                                                      .toString()
                                                      .toUpperCase()),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('dairy')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayRemove([e]),
                                                      },
                                                    );
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 31, 31, 176),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.all(280),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: addSubCat,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('category')
                                                      .doc('dairy')
                                                      .update(
                                                    {
                                                      'categories': FieldValue
                                                          .arrayUnion([
                                                        addSubCat.text
                                                            .toString(),
                                                      ]),
                                                    },
                                                  );
                                                  addSubCat.clear();
                                                },
                                                child: const Text('Add'),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  'Add Sub-Category',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 31, 31, 176),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 31, 31, 176),
                                ),
                                child: Text(
                                  'CLEANERS',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                              Center(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('category')
                                      .doc('cleaners')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: SpinKitCircle(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      );
                                    }

                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        itemExtent: 50,
                                        shrinkWrap: true,
                                        children:
                                            data['categories'].map<Widget>((e) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                dense: true,
                                                shape:
                                                    const BeveledRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 31, 31, 176),
                                                  ),
                                                ),
                                                title: Center(
                                                  child: Text(e
                                                      .toString()
                                                      .toUpperCase()),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('cleaners')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayRemove([e]),
                                                      },
                                                    );
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 31, 31, 176),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.all(280),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: addSubCat,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('category')
                                                      .doc('cleaners')
                                                      .update(
                                                    {
                                                      'categories': FieldValue
                                                          .arrayUnion([
                                                        addSubCat.text
                                                            .toString(),
                                                      ]),
                                                    },
                                                  );
                                                  addSubCat.clear();
                                                },
                                                child: const Text('Add'),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  'Add Sub-Category',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  thickness: 4,
                  height: 4,
                  color: Color.fromARGB(255, 31, 31, 176),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Color.fromARGB(255, 31, 31, 176),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 200,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 31, 31, 176),
                                ),
                                child: Text(
                                  'OTHERS',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                              Center(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('category')
                                      .doc('others')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: SpinKitCircle(
                                          color:
                                              Color.fromARGB(255, 31, 31, 176),
                                        ),
                                      );
                                    }

                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        itemExtent: 50,
                                        shrinkWrap: true,
                                        children:
                                            data['categories'].map<Widget>((e) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                dense: true,
                                                shape:
                                                    const BeveledRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 31, 31, 176),
                                                  ),
                                                ),
                                                title: Center(
                                                  child: Text(e
                                                      .toString()
                                                      .toUpperCase()),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('category')
                                                        .doc('others')
                                                        .update(
                                                      {
                                                        'categories': FieldValue
                                                            .arrayRemove([e]),
                                                      },
                                                    );
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 31, 31, 176),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.all(280),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextField(
                                                controller: addSubCat,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                    Color.fromARGB(
                                                        255, 31, 31, 176),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('category')
                                                      .doc('others')
                                                      .update(
                                                    {
                                                      'categories': FieldValue
                                                          .arrayUnion([
                                                        addSubCat.text
                                                            .toString(),
                                                      ]),
                                                    },
                                                  );
                                                  addSubCat.clear();
                                                },
                                                child: Text(
                                                  'Add',
                                                  style: GoogleFonts.roboto(
                                                    color: Color.fromARGB(
                                                        255, 252, 255, 58),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Text(
                                  'Add Sub-Category',
                                  style: GoogleFonts.roboto(
                                    color:
                                        const Color.fromARGB(255, 252, 255, 58),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
