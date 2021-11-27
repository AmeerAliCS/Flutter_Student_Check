import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:students_check/admin/admin_home.dart';
import 'package:students_check/admin/register.dart';
import 'package:students_check/auth/auth.dart';
import 'package:students_check/auth/auth_provider.dart';
import 'package:students_check/auth/root_page.dart';
import 'package:students_check/services/route_generator.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AuthProvider(
    auth: Auth(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xFF495464),
      ),
      home: const AdminHome(),
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
  ));
}

//void main() => runApp(
//  DevicePreview(
//    enabled: !kReleaseMode,
//    builder: (context) => HomePage()
//  ),
//);