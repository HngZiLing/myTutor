class User {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userAddress;
  String? userRegDate;

  User(
    { this.userId,
      this.userName,
      this.userEmail,
      this.userPhone,
      this.userAddress,
      this.userRegDate,
    }
  );

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    userAddress = json['userAddress'];
    userRegDate = json['userRegDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPhone'] = userPhone;
    data['userAddress'] = userAddress;
    data['userRegDate'] = userRegDate;
    return data;
  }
}