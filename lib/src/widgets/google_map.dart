

import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude)async {
    Uri gooleUrl = Uri.parse("https://www.google.com/maps/search/?api=1&qurey=$latitude,$longitude");

    if(await canLaunchUrl(gooleUrl)){
      await launchUrl(gooleUrl);
    }
    else{
      throw "Could Not open the map";
    }
  }
}