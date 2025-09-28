import 'package:emailauthwithfirebase/pages/authentication/registration_from.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: AppBarThemeData(backgroundColor: Colors.blue,centerTitle: true, iconTheme: IconThemeData(color: Colors.white,),foregroundColor: Colors.white)
      ),
      home: RegistrationForm()
    );
  }
}
