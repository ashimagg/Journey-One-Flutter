import 'package:http/http.dart' as http;

class HttpLoader {
  Future<String> httpGET(String server, String path, String userId) async {
    var url = Uri.https(server, path, {'q': '{http)', 'user_id': userId});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Could not load";
    }
  }

  Future<String> getPositions(String userId) {
    Future<String> pos = httpGET(
        'pqold6av9a.execute-api.us-east-1.amazonaws.com',
        '/prod/entries',
        userId);
    return pos;
  }
}
