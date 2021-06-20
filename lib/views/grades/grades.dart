import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:uni_mindelo/utils/colors.dart';
import 'package:uni_mindelo/widgets/appBar.dart';
import 'package:uni_mindelo/widgets/bottomNavigationBar.dart';

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
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: getUserGrades.length,
              itemBuilder: (context, int index) {
                final GlobalKey<ExpansionTileCardState> cards = new GlobalKey();
                final userGrade = List.from(getUserGrades[index].toList());
                final gradeColor = double.parse(userGrade[index]["grade"]) <= 9
                    ? gradesNOK
                    : gradesOK;
                return Container(
                  child: ExpansionTileCard(
                    key: cards,
                    leading: CircleAvatar(
                        backgroundColor: gradeColor,
                        foregroundColor: PrimaryWhiteAssentColor,
                        child: Text(userGrade[index]["grade"])),
                    title: Text(userGrade[index]["title"]),
                    // subtitle: Text(userGrade[index]["semester"]),
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
                            "teste",
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
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.arrow_downward),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Open'),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.arrow_upward),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Close'),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.swap_vert),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Toggle'),
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
  return List.filled(userGrades.length, userGrades, growable: false);
}
