import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({required this.url});

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    String data = response.body;
    response.body == 200 ? response.body : response.statusCode;

    return jsonDecode(data);
  }
}
