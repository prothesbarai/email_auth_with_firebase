import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      body: Center(
        child: Text("Welcome",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
