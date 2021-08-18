import 'package:hive/hive.dart';

part 'userHiveModel.g.dart';

@HiveType(typeId: 0)
class UserHiveList extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? firstName;
  @HiveField(3)
  String? lastName;
  @HiveField(4)
  String? picture;

  UserHiveList(
      {required this.id,
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.picture});

  UserHiveList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['picture'] = this.picture;
    return data;
  }
}
