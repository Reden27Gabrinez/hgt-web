import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final adminEmail = TextEditingController();
  final adminPass = TextEditingController();

  bool isObscured = true;

  void viewPass() {
    setState(() {
      if (isObscured == true) {
        isObscured = false;
      } else {
        isObscured = true;
      }
    });
  }

  void signIn() {
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: adminEmail.text, password: adminPass.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("$e"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 31, 31, 176),
        centerTitle: true,
        title: Text(
          'COMPRA SA HGT - ADMIN',
          style: GoogleFonts.delaGothicOne(
            color: const Color.fromARGB(255, 252, 255, 58),
            letterSpacing: 5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 130,
            ),
            Center(
                child: Card(
              elevation: 10,
              color: const Color.fromARGB(255, 214, 214, 214),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2.8,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/hgt_logo.png',
                        scale: 2,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: adminEmail,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 31, 176))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 31, 31, 176)))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        obscureText: isObscured,
                        controller: adminPass,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: viewPass,
                            child: Icon(isObscured
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 31, 31, 176)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 31, 31, 176)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          signIn();
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 31, 31, 176),
                          ),
                          child: Text(
                            'LOGIN',
                            style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 252, 255, 58),
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
