

import 'package:gitclub/model/User.dart';

class Article {

  int article_id;
  String category;
  int child_category;
  int comments;
  String date;
  String des;
  String img_url;
  String link;
  int rank;
  int review_status;
  int stars;
  int views;
  String tag;
  String title;
  int un_stars;
  User userModel;

  Article(this.article_id, this.category, this.child_category,
      this.comments, this.date, this.des, this.img_url, this.link, this.rank,
      this.review_status, this.stars, this.views, this.tag, this.title, this.un_stars, this.userModel);


  factory Article.fromJson(Map<String, dynamic> json) {
    return new Article(
        json['article_id'],
        json['category'],
        json['child_category'],
        json['comments'],
        json['date'],
        json['des'],
        json['img_url'],
        json['link'],
        json['rank'],
        json['review_status'],
        json['stars'],
        json['views'],
        json['tag'],
        json['title'],
        json['un_stars'],
        User.fromJson(json['user'])
    );

  }
}

