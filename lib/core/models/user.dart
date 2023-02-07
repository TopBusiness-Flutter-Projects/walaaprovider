

class User {
  late int id;
  late String name = '';
  late String phone = '';
  late String phone_code = '';
  late String email = '';
  late String location = '';
  late String image = '';
  late int userType;
  late int status;
  late int balance;
  late bool isLoggedIn = false;


  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    phone = json['phone'] ?? '';
    phone_code = json['phone_code'] ?? '';
    email = json['email'] != null ? json['email'] as String : "";
    image = json['image'] != null ? json['image'] as String : "";
    location = json['location'] ?? '';
    userType = json['user_type'] ?? 0;
    status = json['status'] != null ? json['status'] as int : 0;
    balance = json['balance'] != null ? json['balance'] as int : 0;
  }


  static Map<String, dynamic> toJson(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'phone': user.phone,
      'phone_code': user.phone_code,
      'email': user.email,
      'image': user.image,
      'location': user.location,
      'user_type': user.userType,
      "status": user.status,
      "balance": user.balance,

    };
  }
}