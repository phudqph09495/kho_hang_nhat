class ModelLogin {
  String? id;
  String? email;
  String? phone;
  String? accessToken;
  String? expiredAt;
  String? avatar;

  ModelLogin(
      {this.id,
        this.email,
        this.phone,
        this.accessToken,
        this.expiredAt,
        this.avatar});

  ModelLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    accessToken = json['access_token'];
    expiredAt = json['expired_at'];
    avatar = json['avatar'];
  }


}
