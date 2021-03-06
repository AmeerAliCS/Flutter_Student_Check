import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:students_check/admin/register.dart';
import 'package:students_check/admin/students_data.dart';
import 'package:students_check/auth/auth_provider.dart';
import 'package:students_check/auth/login.dart';
import 'package:students_check/components/rounded_button.dart';
import 'package:students_check/constants.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _showImage(),
                const SizedBox(height: 70.0,),
                _showDataButton(),
                _showAddButton(),
                _showLogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showImage() {
    return GestureDetector(
        onLongPress: () => _signOut(context),
        child: Align(child: SvgPicture.asset('assets/images/admin_img.svg', height: 260.0), alignment: Alignment.topCenter,)
    );
  }

  Widget _showDataButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: RoundedButton(
          title: 'بيانات الطلاب',
          colour: kColor,
          onPressed: (){
            Navigator.of(context).pushNamed(StudentsData.id);
          },
          size: 0,
        ),
      ),
    );
  }

  Widget _showAddButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: RoundedButton(
          title: 'اضافة طالب',
          colour: bColor,
          onPressed: (){
            Navigator.of(context).pushNamed(Register.id);
          },
          size: 0,
        ),
      ),
    );
  }

  Widget _showLogoutButton() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: RoundedButton(
          title: 'تسجيل خروج',
          colour: oColor,
          size: 0,
          onPressed: () =>_signOut(context),
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    try{
      var auth = AuthProvider.of(context)!.auth;
      await auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()),
              (Route<dynamic> route) => false);
    } catch(e){
      print('Error: $e');
    }
  }

}
