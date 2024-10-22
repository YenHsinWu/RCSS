import "dart:convert";

import "package:http/http.dart" as http;

class StoreService {
  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }

  Future fetchBusinesses() async {
    final uri = Uri.parse('http://10.10.10.207:3000/api/businesses');
    final response = await http.get(uri);

    List<dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  Future getBusinessListByUuid(String uuid) async {
    final uri = Uri.parse(
        'http://10.10.10.207:3000/api/businesseListAndIsNotReadCount/${uuid}');
    final response = await http.get(uri);

    Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
