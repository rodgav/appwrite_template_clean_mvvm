class LoginRequest {
  String email, password, name;

  LoginRequest(this.email, this.password, {String? name}) : name = name ?? '';
}
