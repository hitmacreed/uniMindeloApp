import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_mindelo/views/auth/forgotPassword/forgotPassword.dart';
import 'package:uni_mindelo/views/auth/login/login.dart';
import 'package:uni_mindelo/views/grades/grades.dart';
import 'package:uni_mindelo/views/home/home.dart';

const String loginRoute = '/';
const String forgorPassword = '/forgorPassword';
const String homeRoute = '/home';
const String gradesRoute = '/grades';

/* use with no arguments => Navigator.pushNamed(context, home);*/
/* use with arguments => Navigator.pushNamed(context, grades, arguments: 'Data from home'); */
/* get arguments => var data = settings.arguments; */

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
      case '/forgorPassword':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/grades':
        var data = settings.arguments;
        return MaterialPageRoute(builder: (_) => Grades(userGrades: data));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
