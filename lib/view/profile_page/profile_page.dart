import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_islemleri/view/favorite_page/favorite_page.dart';
import 'package:firebase_islemleri/view/login_page/login_page.dart';
import 'package:firebase_islemleri/view/password_reset_page/reset_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_constants.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool userCheck = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        userCheck = false;
        print("users çıktı");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff232323),
        title: Text(
          "Profile".toUpperCase(),
          style: AppConstants.mainTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppConstants.mainColor,
        child: Padding(
          padding: AppConstants.profilePagePadding,
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Image.asset(
                "assets/images/profile.png",
                height: 75,
              ),
              Padding(
                padding: AppConstants.mediumVerticalPadding,
                child: userCheck
                    ? Text(
                        "${auth.currentUser?.email}",
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      )
                    : Text(""),
              ),
              createButton("Invite Friends", const Icon(Icons.person_add),
                  AppConstants.mainColor, favoriteMovies),
              createButton(
                  "Reset Password",
                  const Icon(Icons.password_outlined),
                  AppConstants.mainColor,
                  resetPassword),
              createButton("Delete Account", const Icon(Icons.delete),
                  AppConstants.mainColor, deleteAccount),
              createButton("Logout", const Icon(Icons.login_outlined),
                  AppConstants.mainColor, signOut),
            ],
          ),
        ),
      ),
    );
  }

  void favoriteMovies() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FavoriteMoviesPage()));
  }

  void resetPassword() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResetPage()));
  }

  void deleteAccount() async {
    try {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Account Deletion Successful'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'Your account has been permanently deleted You will be directed to your login page in 3 seconds',
                    textAlign: TextAlign.left,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: AppConstants.mainColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      Timer(Duration(seconds: 3), () async {
        await FirebaseAuth.instance.currentUser!.delete();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        _showMyDialog();
      }
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  createButton(var text, Icon icons, Color color, onPres) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPres,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            icons,
          ],
        ),
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(350, 60)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                color: Colors.white,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'If you want to permanently delete your account, please login again.',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Disapprove'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: signOut,
            ),
          ],
        );
      },
    );
  }
}
