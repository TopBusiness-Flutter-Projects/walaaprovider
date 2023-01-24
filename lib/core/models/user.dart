

class User {
  late int id;
  late String name = '';
  late String phone = '';
  late String email = '';
  late String location = '';
  late String image = '';
  late String userType;
  late int status;
  late int balance;
  late bool isLoggedIn = false;


  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '' as String;
    phone = json['phone'] ?? '' as String;
    email = json['email'] != null ? json['email'] as String : "";
    image = json['image'] != null ? json['image'] as String : "";
    location = json['location'] ?? '' as String;
    userType = json['user_type'] ?? '' as String;
    status = json['status'] != null ? json['status'] as int : 0;
    balance = json['balance'] != null ? json['balance'] as int : 0;
  }


  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'phone': user.phone,
      'email': user.email,
      'image': user.image,
      'location': user.location,
      'user_type': user.userType,
      "status": user.status,
      "balance": user.balance,

    };
  }
}