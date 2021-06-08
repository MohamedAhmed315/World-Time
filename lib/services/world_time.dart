import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  late String time;
  String flag;
  String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});


  Future<void> getTime() async{

    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //  get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1, 3);

      //  create date object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 5 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      time = 'Not found';
    }

  }

}