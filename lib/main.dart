import 'package:course_app/cart/cart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "My app",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: Cart(),

      
    )
  );
}