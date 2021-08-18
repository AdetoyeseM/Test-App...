 

class UserList {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  UserList(
      {  required this.id,
        this.title,
      required this.firstName,
      required this.lastName,
      required this.picture});

  UserList.fromJson(Map<String, dynamic> json) {
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
