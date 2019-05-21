class User {

  int userId;
  int adminStatus;
  String avatar;
  String city;
  String date;
  String gender;
  String userName;
  String openId;
  int score;
  String sessionKey;

  User(this.userId, this.adminStatus, this.avatar, this.city, this.date,
      this.gender, this.userName, this.openId, this.score, this.sessionKey);


  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
        json['userId'],
        json['adminStatus'],
        json['avatar'],
        json['city'],
        json['date'],
        json['gender'],
        json['userName'],
        json['openId'],
        json['score'],
        json['sessionKey']
    );
  }
}