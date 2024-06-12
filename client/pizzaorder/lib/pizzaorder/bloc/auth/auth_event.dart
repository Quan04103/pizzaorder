sealed class AuthEvent {}

class AuthLoginStarted extends AuthEvent {
  final String username;
  final String password;

  AuthLoginStarted({required this.username, required this.password});
}

class AuthRegisterStarted extends AuthEvent {
  final String username;
  final String password;
  final String nameProfile;
  final String phone;
  final String email;
  final String address;

  AuthRegisterStarted({
    required this.username,
    required this.password,
    required this.nameProfile,
    required this.phone,
    required this.email,
    required this.address,
  });
}

class AuthTimeOut extends AuthEvent {}

class AuthLoginWithGoogle extends AuthEvent {}

class AuthLoginWithFacebook extends AuthEvent {}
