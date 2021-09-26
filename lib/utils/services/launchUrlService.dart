import 'package:url_launcher/url_launcher.dart';

launchURL(pageUrl) async {
  if (await launch(
    pageUrl,
    enableDomStorage: true,
  )) {
  } else {
    throw 'Could not launch $pageUrl';
  }
}
