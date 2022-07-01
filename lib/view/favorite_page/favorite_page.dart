import 'package:firebase_islemleri/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class FavoriteMoviesPage extends StatelessWidget {
  const FavoriteMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.mainColor,
        elevation: 12,
        title: Text(
          "Favorite Movies List".toUpperCase(),
          style: AppConstants.mainTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppConstants.mainColor,
        child: Text("asdgasdgas"),
      ),
    );
  }
}
