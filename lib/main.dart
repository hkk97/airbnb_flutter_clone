import 'package:flutter/material.dart';
import 'package:airbandb/home_page.dart';

void main() {
  runApp(const AirBnB());
}

class AirBnB extends StatelessWidget {
  const AirBnB({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Airbnb Flutter Clone Project'),
    );
  }
}
