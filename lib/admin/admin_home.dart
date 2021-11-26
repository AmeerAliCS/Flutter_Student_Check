import 'package:flutter/material.dart';
import 'package:students_check/admin/register.dart';

class AdminHome extends StatefulWidget {
  static const String id = 'admin_home';
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Admin'),
          ),
          ElevatedButton(
            child: const Text('اضافة طالب'),
            onPressed: (){
              Navigator.of(context).pushNamed(Register.id);
            },
          )
        ],
      ),
    );
  }
}
