import 'package:flutter/material.dart';

class ImagePath {
  static String localImagePath = "assets/images/";
  static String netWorkImagePath = 'https://image.tmdb.org/t/p/original/';
  static String imgNotFoundPath = localImagePath + 'img_not_found.jpg';
  static getImageUrl(String backdrop) {
    return netWorkImagePath + backdrop;
  }
}
