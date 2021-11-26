import 'package:flutter/material.dart';
import 'package:students_check/admin/admin_home.dart';
import 'package:students_check/admin/register.dart';
import 'package:students_check/auth/login.dart';
import 'package:students_check/auth/root_page.dart';
import 'package:students_check/pages/profile.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;


    switch (settings.name) {

      case RootPage.id:
        return MaterialPageRoute(builder: (_) => const RootPage());
        break;

      case Login.id:
        return MaterialPageRoute(builder: (_) => const Login());
        break;

      case Register.id:
        return MaterialPageRoute(builder: (_) => const Register());
        break;

      case Profile.id:
        return MaterialPageRoute(builder: (_) => Profile(currentUserId: args,));
        break;

      case AdminHome.id:
        return MaterialPageRoute(builder: (_) => const AdminHome());
        break;

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}