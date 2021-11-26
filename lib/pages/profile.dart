import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:students_check/auth/auth_provider.dart';
import 'package:students_check/auth/login.dart';
import 'package:students_check/components/progress.dart';
import 'package:students_check/model/users.dart';

class Profile extends StatefulWidget {
  static const String id = 'profile';

  const Profile({Key? key, required this.currentUserId}) : super(key: key);

  final currentUserId;


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool isLoading = false;
  late Users users;
  String email = '';

  getUser() async {
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot doc = await usersRef.doc(widget.currentUserId).get();

    users = Users.fromDocument(doc);
    setState(() {
      isLoading = false;
    });
    // displayNameController.text = user.displayName;
    // phoneNumberController.text = user.phoneNumber;

    // displayName = doc['displayName'] != null ? displayName = doc['displayName'] : '';
      setState(() {
        email = doc['email'];
        isLoading = false;
      });

  }

  @override
  void initState() {
      getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
      body: isLoading ? circularProgress() : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(users.email),
            ElevatedButton(onPressed: () => _signOut(context), child: const Text('Logout')),
          ],
        ),
      ),);

    // body: StreamBuilder<DocumentSnapshot>(
    //   stream: usersRef.doc(widget.currentUserId).snapshots(),
    //   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
    //     if (snapshot.hasError){
    //       return const Text('Something went wrong');
    //     }
    //
    //     if (!snapshot.hasData){
    //       return Center(
    //         child: circularProgress(),
    //       );
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return circularProgress();
    //     }
    //
    //     users = Users.fromDocument(snapshot.data!);
    //
    //     return Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text(users.email),
    //           ElevatedButton(onPressed: () => _signOut(context), child: const Text('Logout'))
    //         ],
    //       ),
    //     );
    //   },
    // ));


  void _signOut(BuildContext context) async {
    try{
      var auth = AuthProvider.of(context)!.auth;
      await auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()),
              (Route<dynamic> route) => true);
    } catch(e){
      print('Error: $e');
    }
  }
}
