import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:uni_mindelo/utils/services/router.dart';
import 'package:uni_mindelo/utils/services/storage.service.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          header(),
          item(
              icon: Icons.contacts,
              text: translate('DRAWER.TITLE.HOME'),
              onTap: () => pushToView(homeRoute)),
          item(
              icon: Icons.feed,
              text: translate('DRAWER.TITLE.FEED'),
              onTap: () => pushToView(feedRoute)),
          item(
              icon: Icons.event,
              text: translate('DRAWER.TITLE.CLASSES'),
              onTap: () => pushToView(classes)),
          item(
              icon: Icons.payment,
              text: translate('DRAWER.TITLE.PAYMENT'),
              onTap: () => pushToView(payment)),
          item(
              icon: Icons.logout,
              text: translate('DRAWER.TITLE.LOGOUT'),
              onTap: () => {deleteData(user_uid), pushToView(loginRoute)}),
          Divider(),
          ListTile(
            title: Text('v1.0.0'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget header() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/logoHeader.jpg'))),
        child: Stack(children: <Widget>[
          Positioned(bottom: 12.0, left: 16.0, child: Text('')),
        ]));
  }

  Widget item(
      {IconData? icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void pushToView(view) {
    Navigator.pushNamed(context, view);
  }
}
