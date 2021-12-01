import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:students_check/components/progress.dart';
import 'package:students_check/components/rounded_button.dart';
import 'package:students_check/constants.dart';

class StudentDetails extends StatefulWidget {
  static const String id = 'students_details';
  // ignore: prefer_typing_uninitialized_variables
  final profileId;
  const StudentDetails({Key? key, this.profileId}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(widget.profileId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          var userData=snapshot.data;
          return snapshot.hasData?Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: isLoading ? circularProgress()
               : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Align(
                        child: SvgPicture.asset('assets/images/reading.svg', height: 200.0,),
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    const SizedBox(height: 15.0,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Directionality(textDirection: TextDirection.rtl, child: Text('الاسم: ${userData!.get('displayName') ?? ''}', style: const TextStyle(fontSize: 19, color: kColor),)),
                          Directionality(textDirection: TextDirection.rtl, child: Text('القسم: ${userData.get('department') ?? ''}', style: const TextStyle(fontSize: 19, color: kColor))),
                          Directionality(textDirection: TextDirection.rtl, child: Text('المرحلة: ${userData.get('stage') ?? ''}', style: const TextStyle(fontSize: 19, color: kColor))),
                          Directionality(textDirection: TextDirection.rtl, child: Text('حالة الطالب: ${userData.get('vaccine') ?? ''}', style: const TextStyle(fontSize: 19, color: kColor))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0,),
                     RoundedButton(
                      title: 'تعديل حالة الطالب الى ملقح',
                      colour: gColor,
                      onPressed: () => updateStudentVaccine(userData, 'ملقح'),
                       size: 55.0,
                    ),
                    RoundedButton(
                      title: 'تعديل حالة الطالب الى غير ملقح',
                      colour: kColor,
                      onPressed: () => updateStudentVaccine(userData, 'غير ملقح'),
                      size: 55.0,
                    ),
                    RoundedButton(
                      title: 'PCR تعديل حالة الطالب الى فحص',
                      colour: bColor,
                      onPressed: () => updateStudentVaccine(userData, 'PCR فحص'),
                      size: 55.0,
                    ),
                    RoundedButton(
                      title: 'تعديل حالة الطالب الى مصاب',
                      colour: pColor,
                      onPressed: () => updateStudentVaccine(userData, 'مصاب'),
                      size: 55.0,
                    ),
                    RoundedButton(
                      title: 'حذف الطالب',
                      colour: oColor,
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        showSnackBar();
                        Navigator.of(context).pop();
                        await FirebaseFirestore.instance.collection('users').doc(widget.profileId).delete().then((_){
                          User? user = FirebaseAuth.instance.currentUser;
                          user!.delete();
                        });
                        setState(() {
                          isLoading = false;
                        });
                      },
                      size: 55.0,
                    ),
                  ],
                ),
              ),
            ) : const Center(child: Text('Waiting'));

        },
      ),
    );
  }

  updateStudentVaccine(studentData, vac) async {
    await FirebaseFirestore.instance.collection('users').doc(widget.profileId).set({
      'userId': widget.profileId,
      'displayName': studentData!.get('displayName'),
      'email': studentData!.get('email'),
      'department' : studentData.get('department'),
      'stage' : studentData.get('stage'),
      'timestamp': studentData.get('timestamp'),
      'vaccine' : vac
    });
  }

  void showSnackBar(){
    Navigator.of(context, rootNavigator: true).pop('dialog');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:Text('تمت حذف الطالب بنجاح'),
        duration: Duration(seconds: 2),
      ),
    );

  }
}