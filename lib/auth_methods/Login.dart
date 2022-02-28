import 'dart:convert';
import 'package:ecommerce/model/user.dart';
import 'package:http/http.dart' as http;

Future<Map<String,dynamic>> loginUser (User user) async {
  final http.Response response = await http.post(
    'http://10.0.2.2:90/auth/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': user.email,
      'password':user.password
    }),
  );
  var result = jsonDecode(response.body);
  print(result);
  return result;
}