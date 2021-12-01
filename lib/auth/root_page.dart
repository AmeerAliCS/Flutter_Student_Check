import 'package:flutter/material.dart';
import 'package:students_check/admin/admin_home.dart';
import 'package:students_check/auth/auth.dart';
import 'package:students_check/auth/auth_provider.dart';
import 'package:students_check/auth/login.dart';
import 'package:students_check/constants.dart';
import 'package:students_check/pages/profile.dart';


class RootPage extends StatefulWidget {
  static const String id = 'root_page';

  const RootPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  login,
  notLogin,
  notKnow
}

class _RootPageState extends State<RootPage> {

  bool isAuth = false;
  late bool isAdmin;
  final String admin = 'VS3vEyP5R0MSNOi35xN7ATV0egS2';
  AuthStatus checkLogged = AuthStatus.notKnow;
  final DateTime timestamp = DateTime.now();

  AuthStatus authStatus = AuthStatus.notKnow;

  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context)!.auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          if(!snapshot.hasData){
            return const Login();
          }
          final bool isLoggedIn = snapshot.hasData;
          if(snapshot.data == admin){
              isAdmin = true;
          }
          else{
              isAdmin = false;
          }
          if(isLoggedIn){
            if(isAdmin){
              return const AdminHome();
            } else{
              return Profile(currentUserId: snapshot.data);
            }
          } else{
            return const Login();
          }
        }
        else if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none){

          print('Error in network');
        }
        return _buildWaitingScreen();
      },
    );
  }

  Widget _buildWaitingScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(kColor),),
      ),
    );
  }


}