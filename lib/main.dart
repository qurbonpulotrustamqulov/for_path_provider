import 'package:flutter/material.dart';
import 'package:for_path_provider/page/home_page.dart';
import 'package:for_path_provider/servise/init_storage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(storage: IntStorage()),
    ),
  );
}
