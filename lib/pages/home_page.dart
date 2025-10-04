import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Current user er UID
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text("Home Page"),),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection("users").doc(uid).get(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasError){
              return const Center(child: Text("Something went wrong"),);
            }
            if(!snapshot.hasData || !snapshot.data!.exists){
              return const Center(child: Text("User data not found"));
            }

            // Data read From Firestore
            var userData = snapshot.data!.data() as Map<String,dynamic>;

            // Convert Date Time
            Timestamp ts = userData['createdAt'];
            DateTime dateTime = ts.toDate();



            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("WelCome, ${userData["name"] ?? ''}",style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("Email: ${userData['email'] ?? ''}", style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text("Phone: ${userData['phone'] ?? ''}", style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text("Create Date: $dateTime", style: const TextStyle(fontSize: 18)),
                ],
              ),
            );

          },
      )
    );
  }
}
