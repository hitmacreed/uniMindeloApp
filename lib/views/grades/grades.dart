import 'package:flutter/material.dart';
import 'package:uni_mindelo/components/colors.dart';

class Grades extends StatefulWidget {
  @override
  _GradesState createState() => _GradesState();
}

class _GradesState extends State<Grades> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: AppBarColor,
          title: Text('Notas'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: PrimaryBlackAssentColor),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Stack(
        children: <Widget>[
          Container(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.verified_user,
                      size: 35,
                    ),
                    title: Text('Informatica', style: TextStyle(fontSize: 20)),
                    subtitle: Text(
                      '18 Valores',
                      style: TextStyle(fontSize: 17),
                    ),
                    tileColor: gradesOK,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const ListTile(
                    leading: Icon(
                      Icons.gpp_bad,
                      size: 35,
                      color: PrimaryWhiteAssentColor,
                    ),
                    title: Text('Redes',
                        style: TextStyle(
                            fontSize: 20, color: PrimaryWhiteAssentColor)),
                    subtitle: Text(
                      '9 Valores',
                      style: TextStyle(
                          fontSize: 17, color: PrimaryWhiteAssentColor),
                    ),
                    tileColor: gradesNOK,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
