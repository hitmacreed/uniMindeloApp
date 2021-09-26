import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:octo_image/octo_image.dart';
import 'package:uni_mindelo/apis/fireBaseCalls.dart';
import 'package:uni_mindelo/utils/constants/colors.dart';
import 'package:uni_mindelo/utils/services/launchUrlService.dart';
import 'package:uni_mindelo/widgets/appBar.dart';
import 'package:uni_mindelo/widgets/drawer.dart';
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
          return Center(
            child: CircularProgressIndicator(),
          );
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
                        OctoImage(
                          image: NetworkImage(feed["img"]),
                          progressIndicatorBuilder: (context, progress) {
                            double? value;
                            var expectedBytes = progress?.expectedTotalBytes;
                            if (progress != null && expectedBytes != null) {
                              value = progress.cumulativeBytesLoaded /
                                  expectedBytes;
                            }
                            return CircularProgressIndicator(value: value);
                          },
                          errorBuilder: (context, error, stacktrace) =>
                              Icon(Icons.error),
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
                        new Divider(
                          height: 5,
                          color: PrimaryGreyColor,
                          thickness: 5.0,
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
