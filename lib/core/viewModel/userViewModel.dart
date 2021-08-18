import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intelligent_inno_task/core/services/api.dart';
import 'package:intelligent_inno_task/core/services/endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:intelligent_inno_task/core/services/hiveServices.dart';
import 'package:intelligent_inno_task/models/userDetailsModel.dart';
import 'package:intelligent_inno_task/models/userHiveModel.dart';
import 'package:intelligent_inno_task/screens/userLocalPage.dart';
import 'package:intelligent_inno_task/utils/navigationUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class UsersViewModel extends ChangeNotifier {
  final HiveService hiveService = HiveService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  List<UserHiveList> userHiveList = [];
  List<UserHiveList> get _userHiveList => userHiveList;
  // List<UserList> userList = [];
  late UserDetails dummyUserDetails;

  Future<void> getUsersName(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    String url = Api.BASE_URL + Endpoints.user;

    try {
      userHiveList = [];
      final responses = await http.get(Uri.parse(url), headers: Headers());
      var decodedJson = json.decode(responses.body);

      if (responses.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        List<dynamic> dummyUsers = decodedJson['data'];
        dummyUsers.forEach((element) {
          UserHiveList userHive = UserHiveList(
              id: 'id',
              title: 'title',
              firstName: 'firstName',
              lastName: 'lastName',
              picture: 'picture');

          userHive.firstName = element['firstName'];

          userHive.id = element['id'];

          userHive.lastName = element['lastName'];

          userHive.picture = element['picture'];

          userHive.title = element['title'];

          userHiveList.add(userHive);
        });

        await hiveService.addBoxes(_userHiveList, "UserList");
        _isLoading = false;
      }
    } catch (e) {
      if (e is SocketException) {
        _isLoading = false;
        notifyListeners();
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: new Text("No Internet Connection"),
                  content: new Text("Check Offline"),
                  actions: <Widget>[
                    CupertinoDialogAction(
                        child: Text("OK"),
                        onPressed: () => navigateReplace(context, LocalUser()))
                  ],
                ));
      } else {}
    }
  }

  List<UserHiveList> get dummyList {
    return [...userHiveList];
  }

  List<UserHiveList> searchForUser(String userName) {
    // ignore: unnecessary_null_comparison
    if (userName == null || userName.isEmpty) {
      return userHiveList;
    } else {
      return userHiveList
          .where((value) =>
              (value.firstName!
                  .toLowerCase()
                  .contains(userName.toLowerCase())) ||
              value.lastName!.toLowerCase().contains(userName.toLowerCase()))
          .toList();
    }
  }

  Future<UserDetails> getUserDetails(
      String userID, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    String url = Api.BASE_URL + Endpoints.user + userID;

    try {
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        var details = json.decode(response.body);
        dummyUserDetails = UserDetails.fromJson(details);
        return dummyUserDetails;
      }
    } catch (e) {
      if (e is SocketException) {
        _isLoading = false;
        notifyListeners();
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: new Text("No Internet Connection"),
                  content: new Text("Check Offline"),
                  actions: <Widget>[
                    CupertinoDialogAction(
                        child: Text("OK"),
                        onPressed: () => navigateReplace(context, LocalUser()))
                  ],
                ));
      } else {}
    }
    return dummyUserDetails;
  }

  // ignore: non_constant_identifier_names
  Headers() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'app-id': '611bd0227d07216650c255b7'
      };
}
