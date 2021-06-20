import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:uni_mindelo/utils/services/router.dart';
import '../colors.dart';

// ignore: must_be_immutable
class DialogService extends StatelessWidget {
  final String subTitle;
  final String title;
  bool dismissOnPopLogin;
  DialogService(
      {required this.subTitle,
      required this.title,
      required this.dismissOnPopLogin});

  dialogContent(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return NetworkGiffyDialog(
      image: Image.asset(
        "assets/images/loginBaseDialog.gif",
        fit: BoxFit.cover,
      ),
      entryAnimation: EntryAnimation.LEFT,
      title: Text(
        translate(title),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
      ),
      description: Text(
        translate(subTitle),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.0),
      ),
      onlyCancelButton: true,
      buttonCancelText: Text(translate('DIALOG.DIALOG_BT.OK')),
      buttonCancelColor: PrimaryColor,
      onCancelButtonPressed: () {
        if (dismissOnPopLogin == true) {
          Navigator.pushNamed(context, loginRoute);
        } else {
          Navigator.pop(context, true);
        }
      },
      // onOkButtonPressed: () {},
    );
  }
}
