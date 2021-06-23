import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:uni_mindelo/apis/fireBaseCalls.dart';
import 'package:uni_mindelo/utils/constants/colors.dart';
import 'package:uni_mindelo/widgets/appBar.dart';
import 'package:uni_mindelo/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Map<String, dynamic> feeds = {};
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = getFeedData();
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new Scaffold(
          appBar: CustomAppbar(
            title: translate("APP_BAR.TITLE.FEED"),
            canBack: false,
          ),
          drawer: CustomDrawer(),
          //bottomNavigationBar: CustomBottomNavigationBar(),
          body: Stack(children: <Widget>[
            Container(
              child: Card(
                elevation: 10,
                shadowColor: bottomNavigationBarTheme,
                clipBehavior: Clip.antiAlias,
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> feed =
                        document.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        new ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: PrimaryWhiteAssentColor,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          title: Text(feed["title"]),
                        ),
                        Image.network(
                          feed["img"],
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            feed["subTitle"],
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          buttonHeight: 20.0,
                          buttonMinWidth: 20.0,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                launchURL(feed["url"]);
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.facebook,
                                    size: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1.0),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Share.share(
                                  feed["url"],
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.share,
                                    size: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 1.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}

launchURL(pageUrl) async {
  if (await launch(
    pageUrl,
    enableDomStorage: true,
  )) {
    await launch(pageUrl);
  } else {
    throw 'Could not launch $pageUrl';
  }
}
