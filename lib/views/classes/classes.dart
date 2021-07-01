import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:uni_mindelo/apis/fireBaseCalls.dart';
import 'package:uni_mindelo/utils/constants/colors.dart';
import 'package:uni_mindelo/widgets/appBar.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Classes extends StatefulWidget {
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersClasses = getUserClasses();
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    List<FlutterWeekViewEvent> classes = [];
    return StreamBuilder<QuerySnapshot>(
      stream: _usersClasses,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        var getClasses = snapshot.data!.docs.map((DocumentSnapshot document) {
          return document.data() as Map<String, dynamic>;
        }).toList();

        getClasses.forEach((el) => {
              classes.add(
                FlutterWeekViewEvent(
                  title: el["title"],
                  description: el["description"],
                  start:
                      date.add(Duration(hours: convertTimeStamp(el["start"]))),
                  end: date.add(Duration(hours: convertTimeStamp(el["end"]))),
                ),
              )
            });

        return new Scaffold(
          appBar: CustomAppbar(
            title: translate("APP_BAR.TITLE.CLASSES"),
            canBack: true,
          ),
          body: Stack(children: <Widget>[
            Container(
                child: WeekView(
                    userZoomable: true,
                    dates: [
                      date.subtract(Duration(days: 1)),
                      date,
                      date.add(Duration(days: 1))
                    ],
                    events: classes,
                    style: WeekViewStyle(
                        dayViewSeparatorWidth: 5,
                        dayViewSeparatorColor: currentTimeCircleColor)))
          ]),
        );
      },
    );
  }
}

convertTimeStamp(Timestamp timestamp) {
  String convertedDate;
  convertedDate = DateFormat.j().format(timestamp.toDate());
  return int.parse(convertedDate.split(" ")[0]);
}
