class UserModel {
  final int id;
  final String name;
  final String userName;
  final String email;
  final String phone;
  final String website;

  UserModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      userName: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': userName,
      'email': email,
      'website': website,
      'phone': phone,
    };
  }
}
