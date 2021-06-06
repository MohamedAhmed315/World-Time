import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  String location;
  late String time;
  String flag;
  String url;

  WorldTime(this.location, this.flag, this.url);


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

      time = now.toString();
    }
    catch(e){
      time = 'Not found';
    }

  }

}