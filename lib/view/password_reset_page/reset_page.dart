import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_islemleri/pages/user/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main_page.dart';

class ResetPage extends StatefulWidget {
  ResetPage({Key? key}) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final TextEditingController _email = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xff232323),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Image.asset(
                    "assets/images/icon.png",
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Text(
                    "Resset Password",
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                      ],
                      style: GoogleFonts.openSans(
                          fontSize: 14, color: Colors.white),
                      controller: _email,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.greenAccent),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          filled: true,
                          fillColor: const Color(0xff232323),
                          hintText: "E-mail",
                          label: const Text("E-mail"),
                          labelStyle: GoogleFonts.openSans(
                              fontSize: 14, color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: Colors.grey,
                          ),
                          prefixText: ' ',
                          hintStyle: GoogleFonts.openSans(
                              fontSize: 14, color: Colors.grey[400])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextButton(
                        child: Text("Reset Password",
                            style: GoogleFonts.openSans(
                              fontSize: 20,
                            )),
                        onPressed: () {
                          auth.sendPasswordResetEmail(
                              email: _email.text.toString());

                          Navigator.pop(context);
                        },
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
  }
}
