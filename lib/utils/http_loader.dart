import 'package:http/http.dart' as http;

class HttpLoader {
  Future<String> getPositions(String userId, String token) async {
    String serverUrl = 'pqold6av9a.execute-api.us-east-1.amazonaws.com';
    String path = '/prod/entries';
    Map<String, dynamic> queryParams = {'user_id': userId};
    Uri url = Uri.https(serverUrl, path, queryParams);
    return httpGet(url, {'Authorization': token});
  }

  Future<String> httpGet(Uri url, Map<String, String> headers) async {
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Could not load";
    }
  }
}
