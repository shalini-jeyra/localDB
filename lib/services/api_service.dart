
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ApiService{


   Future getService(
  
  ) async {
  
    final response = await http.get(
      Uri.parse(
          'https://itunes.apple.com/in/rss/topalbums/limit=25/json'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
       
      },
    );
  
 if (response.statusCode == 200) {
 
 var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
          
          return jsonResponse['feed']['entry'];
 }else{
print('Failed to load top albums');
 }
  }
}