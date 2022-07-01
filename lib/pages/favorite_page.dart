import 'package:flutter/material.dart';

import '../constants/constants.dart';

class FavoriteMoviesPage extends StatelessWidget {
  const FavoriteMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        elevation: 12,
        title: Text(
          "Favorite Movies List".toUpperCase(),
          style: Constants.mainTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Constants.mainColor,
        child: Text("asdgasdgas"),
      ),
    );
  }
}
