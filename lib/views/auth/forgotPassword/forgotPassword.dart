import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:uni_mindelo/apis/fireBaseCalls.dart';
import 'package:uni_mindelo/components/background.dart';
import 'package:uni_mindelo/components/colors.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  static String email = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppBarColor,
        leading: IconButton(icon:Icon(Icons.arrow_back,color: PrimaryBlackAssentColor),
          onPressed:() => Navigator.pop(context, false),
        )
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset("assets/images/logo.png",
                  width: size.width * 0.35),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: translate('FORGOT_PASSWORD.USERNAME'),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              // ignore: deprecated_member_use
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                        forgotPassword(email, context);
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                textColor: PrimaryBlackAssentColor,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: PrimaryColor,
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    translate('FORGOT_PASSWORD.BT_TITLE'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
