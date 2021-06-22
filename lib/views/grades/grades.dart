import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:uni_mindelo/utils/colors.dart';
import 'package:uni_mindelo/widgets/appBar.dart';
import 'package:uni_mindelo/widgets/bottomNavigationBar.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Grades extends StatefulWidget {
  var userGrades;
  Grades({this.userGrades});

  @override
  _GradesState createState() => _GradesState();
}

class _GradesState extends State<Grades> {
  Widget build(BuildContext context) {
    List getUserGrades = getGrades(widget.userGrades);
    return Scaffold(
      appBar: CustomAppbar(
        title: translate("APP_BAR.TITLE.GRADES"),
        canBack: true,
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: getUserGrades.length,
              itemBuilder: (context, int index) {
                final GlobalKey<ExpansionTileCardState> cards = new GlobalKey();
                final userGrade = List.from(getUserGrades[index]);
                final gradeColor = double.parse(userGrade[index]["grade"]) <= 9
                    ? gradesNOK
                    : gradesOK;
                final userAprovedNotAprovedf =
                    double.parse(userGrade[index]["grade"]) <= 9
                        ? translate('GRADES.GRADE_NOK')
                        : translate('GRADES.GRADE_OK') +
                            userGrade[index]["grade"] +
                            translate('GRADES.VALUE');
                return Container(
                  child: ExpansionTileCard(
                    key: cards,
                    leading: CircleAvatar(
                        backgroundColor: gradeColor,
                        foregroundColor: PrimaryWhiteAssentColor,
                        child: Text(userGrade[index]["grade"])),
                    title: Text(userGrade[index]["title"]),
                    children: <Widget>[
                      Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            translate('GRADES.PROFESSOR_GRADE') +
                                '\n' +
                                userGrade[index]["teacher"] +
                                '\n' +
                                userAprovedNotAprovedf,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              send(userGrade[index]["teacherEmail"],
                                  userGrade[index]["grade"]);
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.email),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text(translate('GRADES.BT_MAIL')),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              launchURL();
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.file_download),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text(translate('GRADES.BT_DOWNLOAD')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

List getGrades(userGrades) {
  return new List.filled(userGrades.length, userGrades, growable: true);
}

launchURL() async {
  //DEBUG SAMPLE PDF
  const url = 'http://www.pdf995.com/samples/pdf.pdf';
  if (await launch(
    url,
    enableDomStorage: true,
  )) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> send(recipientEmail, grade) async {
  final Email email = Email(
    body: translate('GRADES.EMAIL_BODY') + grade + translate('GRADES.VALUES'),
    subject: translate('GRADES.EMAIL_SUBJECT'),
    recipients: [recipientEmail],
    isHTML: true,
  );

  try {
    await FlutterEmailSender.send(email);
    print("Email Enviado");
  } catch (error) {
    print(error);
  }
}
