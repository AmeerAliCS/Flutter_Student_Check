import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:students_check/auth/auth_provider.dart';
import 'package:students_check/auth/login.dart';
import 'package:students_check/components/progress.dart';
import 'package:students_check/model/users.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:students_check/constants.dart';

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


  @override
  Widget build(BuildContext context) => Scaffold(

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          var userData=snapshot.data;
          return snapshot.hasData?Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _showImage(),
                    const SizedBox(height: 30.0,),
                    _showText(userData),
                    const SizedBox(height: 30.0,),
                    _showVacImg(userData),
                  ],
                ),
              ),
            ),
          ):Center(
            child: circularProgress(),
          );

        },
      ));

  Widget _showImage() {
    return GestureDetector(
      onLongPress: () =>_signOut(context),
      child: Align(
          alignment: Alignment.topCenter,
          child: Image.asset('assets/images/dijlah.png',
              height: 150.0)),
    );
  }

  Widget _showText(userData) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Directionality(textDirection: TextDirection.rtl,
              child: Text(userData!.get("displayName") ?? '', style: const TextStyle(fontSize: 22, color: kColor, fontWeight: FontWeight.bold),)),
          const Text(" :الاسم", style: TextStyle(fontSize: 22, color: kColor, fontWeight: FontWeight.bold)),
        ],),

      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Directionality(textDirection: TextDirection.rtl,
              child: Text(userData.get("department") ?? '', style: const TextStyle(fontSize: 22, color: kColor, fontWeight: FontWeight.bold),)),
          const Text(" :القسم", style: TextStyle(fontSize: 22, color: kColor, fontWeight: FontWeight.bold)),
        ],),

      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Directionality(textDirection: TextDirection.rtl,
              child: Text(userData.get("stage") ?? '', style: const TextStyle(fontSize: 22, color: kColor, fontWeight: FontWeight.bold),)),
          const Text(" :المرحلة", style: TextStyle(fontSize: 22, color: kColor, fontWeight: FontWeight.bold)),
        ],),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Directionality(textDirection: TextDirection.rtl,
                child: Text(userData.get("vaccine") ?? '', style: const TextStyle(fontSize: 22, color: kColor, fontWeight: FontWeight.bold),)),
            const Text(" :حالةالطالب", style: TextStyle(fontSize: 22, color: kColor, fontWeight: FontWeight.bold)),
          ],),
      ),
    ],);
  }

  Widget _showVacImg(userData) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('حالةاللقاح', style: TextStyle(fontSize: 34,color: kColor, fontWeight: FontWeight.bold)),
        ),
        userData.get("vaccine") == 'ملقح' ? SvgPicture.asset('assets/images/vac1.svg', height: 120.0)
            : userData.get("vaccine") == 'غير ملقح' ? SvgPicture.asset('assets/images/vac2.svg', height: 120.0) :
        userData.get("vaccine") == 'PCR' ? SvgPicture.asset('assets/images/vac3.svg', height: 120.0)
            : userData.get("vaccine") == 'مصاب' ? SvgPicture.asset('assets/images/vac4.svg', height: 120.0)
            : const Center(child: Text('No Data'),),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(userData.get("vaccine"), style: const TextStyle(fontSize: 22, color: kColor, fontWeight: FontWeight.bold),),
        ),

      ],),
    );
  }

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