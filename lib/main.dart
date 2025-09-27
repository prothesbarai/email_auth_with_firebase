import 'package:emailauthwithfirebase/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: AppBarThemeData(backgroundColor: Colors.blue,centerTitle: true, iconTheme: IconThemeData(color: Colors.blue,),foregroundColor: Colors.white)
      ),
      home: HomePage()
    );
  }
}
