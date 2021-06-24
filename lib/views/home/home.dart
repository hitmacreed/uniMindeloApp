import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:uni_mindelo/apis/fireBaseCalls.dart';
import 'package:uni_mindelo/utils/constants/colors.dart';
import 'package:uni_mindelo/utils/services/router.dart';
import 'package:uni_mindelo/utils/services/storage.service.dart';
import 'package:uni_mindelo/widgets/appBar.dart';
import 'package:uni_mindelo/widgets/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isOpen = false;
  final String userId = getData(user_uid);
  Map<String, dynamic>? userData = {};
  PanelController _panelController = PanelController();
  Widget build(BuildContext context) {
    var userId = getData(user_uid);
    getUserData(userId).then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        setState(() {
          userData = {"data": documentSnapshot.data()};
        });
      }
    });
    return Scaffold(
      appBar: CustomAppbar(
        title: translate("APP_BAR.TITLE.HOME"),
        canBack: false,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.6,
            widthFactor: 4,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/home.jpeg'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.3,
            child: Container(
              color: Colors.white,
            ),
          ),
          SlidingUpPanel(
            controller: _panelController,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
            ),
            minHeight: MediaQuery.of(context).size.height * 0.35,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
            body: GestureDetector(
              onTap: () => _panelController.close(),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            panelBuilder: (ScrollController controller) =>
                _panelBody(controller, userData),
            onPanelSlide: (value) {
              if (value >= 0.2) {
                if (!_isOpen) {
                  setState(() {
                    _isOpen = true;
                  });
                }
              }
            },
            onPanelClosed: () {
              setState(() {
                _isOpen = false;
                _panelController.close();
              });
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }

  /// Panel Body
  SingleChildScrollView _panelBody(ScrollController controller, user) {
    double hPadding = 30;

    return SingleChildScrollView(
      controller: controller,
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 60,
                  ),
                  child: Column(
                    children: [
                      _titleSection(),
                      _actionSection(hPadding: hPadding),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Action Section
  Row _actionSection({required double hPadding}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Visibility(
          visible: !_isOpen,
          child: Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              // ignore: deprecated_member_use
              child: OutlineButton(
                onPressed: () => _panelController.open(),
                borderSide: BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  translate('HOME.PROFILE'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !_isOpen,
          child: SizedBox(
            width: 16,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  child: Visibility(
                    visible: !_isOpen,
                    child: SizedBox(
                      width: !_isOpen
                          ? (MediaQuery.of(context).size.width -
                                  (2 * hPadding)) /
                              1.6
                          : double.infinity,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () => Navigator.pushNamed(
                              context, gradesRoute,
                              arguments: userData!['data']!['grades']),
                          color: PrimaryColor,
                          textColor: PrimaryWhiteAssentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            translate('HOME.GRADES'),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: _isOpen,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: PrimaryColor,
                            child: ListTile(
                              leading: Icon(Icons.phone,
                                  color: PrimaryWhiteAssentColor),
                              title:
                                  Text(userData!['data']["phoneNumber"] ?? '',
                                      style: TextStyle(
                                        color: PrimaryWhiteAssentColor,
                                      )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: PrimaryColor,
                            child: ListTile(
                              leading: Icon(Icons.email,
                                  color: PrimaryWhiteAssentColor),
                              title: Text(userData!['data']["email"] ?? '',
                                  style: TextStyle(
                                    color: PrimaryWhiteAssentColor,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: PrimaryColor,
                            child: ListTile(
                              leading: Icon(Icons.cake,
                                  color: PrimaryWhiteAssentColor),
                              title: Text(
                                  ((userData!['data']["birthDay"] ??
                                          '' as Timestamp)
                                      .toDate()
                                      .toString()
                                      .split(" ")
                                      .first),
                                  style: TextStyle(
                                    color: PrimaryWhiteAssentColor,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: PrimaryColor,
                            child: ListTile(
                              leading: Icon(Icons.credit_card,
                                  color: PrimaryWhiteAssentColor),
                              title: Text(
                                  'Nº Estudante' +
                                      ' ' +
                                      userData!['data']["id_student"],
                                  style: TextStyle(
                                    color: PrimaryWhiteAssentColor,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: isPaid,
                            child: ListTile(
                              leading: Icon(Icons.credit_card,
                                  color: PrimaryWhiteAssentColor),
                              title: Text(
                                  userData!['data']["isPaid"].toString() ==
                                          'true'
                                      ? 'Propina Paga'
                                      : 'Propina por Pagar',
                                  style: TextStyle(
                                    color: PrimaryBlackAssentColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Title Section
  Column _titleSection() {
    return Column(
      children: <Widget>[
        Visibility(
          // ignore: unnecessary_null_comparison
          visible: userData != null,
          child: Column(
            children: [
              Text(
                userData!['data']!['userName'] +
                    ' ' +
                    userData!['data']['userSurname'],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                userData!['data']['course'],
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                userData!['data']['semester'] +
                    ' ' +
                    translate('HOME.SEMESTER'),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
