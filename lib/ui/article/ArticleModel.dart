import 'package:scoped_model/scoped_model.dart';

class ArticleModel extends Model {
  String _title;
  String _url;

  get title => _title;
  get url => _url;

  void set(String title, String url) {
    _title = title;
    _url = url;
  }

  ArticleModel of(context) => ScopedModel.of<ArticleModel>(context);

}