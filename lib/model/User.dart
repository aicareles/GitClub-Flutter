class User {

  int user_id;
  int admin_status;
  String avatar;
  String city;
  String date;
  String gender;
  String nick_name;
  String open_id;
  int score;
  String session_key;

  User(this.user_id, this.admin_status, this.avatar, this.city, this.date,
      this.gender, this.nick_name, this.open_id, this.score, this.session_key);


  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
        json['user_id'],
        json['admin_status'],
        json['avatar'],
        json['city'],
        json['date'],
        json['gender'],
        json['nick_name'],
        json['open_id'],
        json['score'],
        json['session_key']
    );
  }
}