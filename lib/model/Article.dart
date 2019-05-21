

import 'package:gitclub/model/User.dart';

class Article {

  int articleId;
  String category;
  int childCategory;
  int comments;
  String date;
  String des;
  String imgUrl;
  String link;
  int rank;
  int reviewStatus;
  int stars;
  int views;
  String tag;
  String title;
  int unStars;
  User userModel;

  Article(this.articleId, this.category, this.childCategory,
      this.comments, this.date, this.des, this.imgUrl, this.link, this.rank,
      this.reviewStatus, this.stars, this.views, this.tag, this.title, this.unStars, this.userModel);


  factory Article.fromJson(Map<String, dynamic> json) {
    return new Article(
        json['articleId'],
        json['category'],
        json['childCategory'],
        json['comments'],
        json['date'],
        json['des'],
        json['imgUrl'],
        json['link'],
        json['rank'],
        json['reviewStatus'],
        json['stars'],
        json['views'],
        json['tag'],
        json['title'],
        json['unStars'],
        User.fromJson(json['user'])
    );

  }
}

