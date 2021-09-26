import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:uni_mindelo/apis/fireBaseCalls.dart';
import 'package:uni_mindelo/utils/constants/colors.dart';
import 'package:uni_mindelo/utils/constants/paymentTitle.dart';
import 'package:uni_mindelo/utils/services/launchUrlService.dart';
import 'package:uni_mindelo/utils/services/router.dart';
import 'package:uni_mindelo/widgets/appBar.dart';
import 'package:uni_mindelo/widgets/drawer.dart';

class Bribes extends StatefulWidget {
  @override
  _BridesState createState() => _BridesState();
}

class _BridesState extends State<Bribes> {
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _userBribes = getUserBribes();
    List<dynamic> bribes = [];
    return StreamBuilder<QuerySnapshot>(
      stream: _userBribes,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        bribes = snapshot.data!.docs.map((DocumentSnapshot document) {
          return document.data() as Map<String, dynamic>;
        }).toList();

        return new Scaffold(
            appBar: CustomAppbar(
              title: translate("APP_BAR.TITLE.BRIBES"),
              canBack: false,
            ),
            drawer: CustomDrawer(),
            body: Stack(children: [cardsList(context, bribes)]));
      },
    );
  }
}

Column cardsList(context, userbribes) {
  return new Column(
    children: <Widget>[
      for (int i = 0; i < userbribes.length; i++)
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.payment,
                  size: 50,
                  color: userbribes[i]["isPaid"] == true
                      ? PrimaryColor
                      : isNotPaid,
                ),
                title: Text(
                  '${translate("PAYMENT.PAYMENT_REFERENCE")} ${convertTimeStamp(userbribes[i]["duePayment"])}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${translate("PAYMENT.AMOUNT_TO_PAY")} ${userbribes[i]["amount"]} CVE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      userbribes[i]["isPaid"] == false
                          ? translate("PAYMENT.PAYMENT_DUE")
                          : translate("PAYMENT.PAYMENT_DUE_PAID"),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ))),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  userbribes[i]["isPaid"] == false
                      // ignore: deprecated_member_use
                      ? FlatButton(
                          textColor: PrimaryColor,
                          onPressed: () {
                            Navigator.pushNamed(context, payment,
                                arguments: payBribe);
                          },
                          child: Text(
                            translate("PAYMENT.BT_PAY"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isNotPaid,
                              fontSize: 15,
                            ),
                          ),
                        )
                      // ignore: deprecated_member_use
                      : FlatButton(
                          textColor: PrimaryColor,
                          onPressed: () {
                            launchURL('http://www.pdf995.com/samples/pdf.pdf');
                          },
                          child: Text(
                            translate("PAYMENT.BT_PAY_INVOICE"),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: PrimaryColor),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
    ],
  );
}

convertTimeStamp(timestamp) {
  final date = DateTime.parse(timestamp.toDate().toString());
  return '${date.day}/${date.month}/${date.year}';
}
