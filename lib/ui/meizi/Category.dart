
class Category<T> {

  bool error;
  T results;


  Category(this.error, this.results);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['error'],
      json['results']
    );
  }

}

class Meizi {
   String _id;
   String createdAt;
   String desc;
   String publishedAt;
   String source;
   String type;
   String url;
   bool used;
   String who;


   Meizi(this._id, this.createdAt, this.desc, this.publishedAt, this.source,
       this.type, this.url, this.used, this.who);

   factory Meizi.fromJson(Map<String, dynamic> json) {
     return new Meizi(
         json['_id'],
         json['createdAt'],
         json['desc'],
         json['publishedAt'],
         json['source'],
         json['type'],
         json['url'],
         json['used'],
         json['who']);
   }
}