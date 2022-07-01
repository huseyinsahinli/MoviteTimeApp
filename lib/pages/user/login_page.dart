import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_islemleri/pages/user/register_page.dart';
import 'package:firebase_islemleri/pages/user/reset_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  bool _isHidden = true;

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    auth.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MainPage(
                    title: '',
                  )),
        );
      }
    });
  }

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
                    "Sign In",
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
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                      ],
                      obscureText: _isHidden,
                      style: GoogleFonts.openSans(
                          fontSize: 14, color: Colors.white),
                      controller: _password,
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
                          hintText: "Password",
                          label: const Text("Password"),
                          labelStyle: GoogleFonts.openSans(
                              fontSize: 14, color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          suffix: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(
                              _isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                          prefixText: ' ',
                          hintStyle: GoogleFonts.openSans(
                              fontSize: 14, color: Colors.grey[400])),
                    ),
                    TextButton(
                      child: Row(
                        children: [
                          Text("Forgot Password",
                              style: GoogleFonts.openSans(
                                fontSize: 12,
                                color: Colors.white70,
                              )),
                          const Icon(
                            Icons.lock_outline,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPage()));
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff232323)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff232323)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          await auth.signInWithEmailAndPassword(
                              email: _email.text.toString(),
                              password: _password.text.toString());
                        } on FirebaseAuthException catch (e) {}
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xff232323)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    onPressed: signInWithGoogle,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/images/google.png",
                            height: 32,
                          ),
                          Text("Sign in with Google",
                              style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
