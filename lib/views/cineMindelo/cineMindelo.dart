import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:octo_image/octo_image.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:ticketview/ticketview.dart';
import 'package:uni_mindelo/apis/fireBaseCalls.dart';
import 'package:uni_mindelo/utils/constants/colors.dart';
import 'package:uni_mindelo/utils/constants/paymentTitle.dart';
import 'package:uni_mindelo/utils/services/launchUrlService.dart';
import 'package:uni_mindelo/utils/services/router.dart';
import 'package:uni_mindelo/widgets/appBar.dart';
import 'package:uni_mindelo/widgets/drawer.dart';
// ignore: unused_import
import 'package:transparent_image/transparent_image.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:worm_indicator/shape.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:worm_indicator/worm_indicator.dart';

class CineMindelo extends StatefulWidget {
  @override
  _CineMindeloState createState() => _CineMindeloState();
}

class _CineMindeloState extends State<CineMindelo> {
  Widget build(BuildContext context) {
    PageController _controller = PageController(
      initialPage: 0,
    );
    final Stream<QuerySnapshot> _cineMindelo = cineMindeloMovies();
    return StreamBuilder<QuerySnapshot>(
      stream: _cineMindelo,
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
            title: translate("APP_BAR.TITLE.CINE_MINDELO"),
            canBack: false,
          ),
          drawer: CustomDrawer(),
          bottomNavigationBar: SizedBox(
              height: 18,
              child: WormIndicator(
                length: 2,
                controller: _controller,
                shape: Shape(
                    size: 16,
                    spacing: 8,
                    shape: DotShape.Circle // Similar for Square
                    ),
              )),
          body: PageView(
            controller: _controller,
            children: <Widget>[
              Container(
                height: 200,
                child: Card(
                  margin: EdgeInsets.all(10),
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  shadowColor: bottomNavigationBarTheme,
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> movies =
                          document.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/cineMindelo.jpg'),
                            ),
                            title: Text(
                                '${movies["title"]} e ${movies["subTitle"]}'),
                            subtitle: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyText1,
                                children: [
                                  TextSpan(
                                      text:
                                          '${translate('TICKETS.PRICE')} ${movies["price"]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      child: Icon(
                                        Icons.attach_money,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          OctoImage(
                            image: NetworkImage(movies["img"]),
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
                              movies["description"],
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.end,
                            buttonHeight: 10.0,
                            buttonMinWidth: 10.0,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, payment,
                                      arguments: buyTicket);
                                },
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.add_shopping_cart,
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
                                  launchURL(
                                    movies["ytUrl"],
                                  );
                                },
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.smart_display,
                                      size: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1.0),
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
              TicketView(
                backgroundPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                backgroundColor: PrimaryColor,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 24, horizontal: 0),
                drawArc: true,
                triangleAxis: Axis.vertical,
                borderRadius: 6,
                drawDivider: true,
                trianglePos: .5,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                      '${translate('TICKETS.MOVIE')} Jumani Next Level - 2 horas',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              SizedBox(height: 14),
                              Text(
                                  '${translate('TICKETS.PLACE')} Auditório Onésimo Silveira - UniMindelo',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 14),
                              Text('${translate('TICKETS.PRICE')} 200 \$',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 14),
                              Text(
                                  '${translate('TICKETS.DATE')} 29/01/2022 - 19H00',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 14),
                              Text('${translate('TICKETS.PEOPLE')}: 1',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 14),
                              Text(translate('TICKETS.INFO'),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 30),
                          child:
                              Image.asset('assets/images/qr_placeholder.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
