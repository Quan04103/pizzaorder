class UserModel {
  final String? token;
  final int? status;
  final String? id;
  final String? username;
  final String? password;
  final String? nameProfile;
  final String? email;
  final String? phone;
  final String? address;

  const UserModel({
    this.token,
    this.status,
    this.id,
    this.username,
    this.password,
    this.nameProfile,
    this.email,
    this.phone,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      status: map['status'] as int?,
      token: map['token'] as String?,
      id: map['id'] as String?,
      username: map['username'] as String?,
      password: map['password'] as String?,
      nameProfile: map['nameProfile'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      address: map['address'] as String?,
    );
  }
}