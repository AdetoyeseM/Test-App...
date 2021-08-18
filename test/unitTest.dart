import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:intelligent_inno_task/core/services/api.dart';
import 'package:intelligent_inno_task/core/services/endpoints.dart';
import 'package:intelligent_inno_task/models/userListModels.dart';

import 'package:mockito/mockito.dart';

late UserList _userList;

String url = Api.BASE_URL + Endpoints.user;
Future getUsersList(http.Client http) async {
  final response = await http.get(Uri.parse(url), headers: Headers());

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    _userList = UserList.fromJson(data);

    return _userList;
  } else if (response.statusCode != 200) {
    throw Exception('Error geting List');
  }
}

// ignore: non_constant_identifier_names
Headers() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'app-id': '611bd0227d07216650c255b7'
    };

class MockClient extends Mock implements http.Client {}

void main() {
  test('returns a list of if the http call completes successfully', () async {
    final httpClient = MockClient();
    when(httpClient.get(Uri.parse(url), headers: Headers())).thenAnswer(
        (_) async => http.Response('{"id": "673536683adsete6u8823"}', 200));

    expect(await getUsersList(httpClient), isA<UserList>());
  });
}
