import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:uni_mindelo/utils/constants/colors.dart';
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
      elevation: 5,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: PrimaryWhiteAssentColor,
                image: DecorationImage(
                    image: AssetImage("assets/images/logoHeader.jpg"),
                    fit: BoxFit.fill)),
            child: Text(''),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(translate('DRAWER.TITLE.HOME')),
            onTap: () {
              pushToView(homeRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.feed),
            title: Text(translate('DRAWER.TITLE.FEED')),
            onTap: () {
              pushToView(feedRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.grade),
            title: Text(translate('DRAWER.TITLE.CLASSES')),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(translate('DRAWER.TITLE.LOGOUT')),
            onTap: () {
              deleteData(user_uid);
              Navigator.pushNamed(context, loginRoute);
            },
          ),
        ],
      ),
    );
  }

  void pushToView(view) {
    Navigator.pushNamed(context, view);
  }
}
