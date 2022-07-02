import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const mainColor = Color(0xff232323);

  static final mainTitleStyle = GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const movieTitleTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  static final pageTitleStyle = GoogleFonts.openSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(0, 5),
        blurRadius: 2,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ],
  );
  static final profilePagePadding =
      EdgeInsets.symmetric(vertical: 16, horizontal: 64);
  static final mediumVerticalPadding = EdgeInsets.symmetric(vertical: 16);
}
