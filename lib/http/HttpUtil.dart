import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:gitclub/http/BaseResp.dart';
import 'package:http/http.dart' as http;

import 'package:gitclub/http/Api.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

//这里只封装了常见的get和post请求类型,不带Cookie
class HttpUtil<T> {
  static const String GET = "get";
  static const String POST = "post";

  static void get(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    //偷懒..
    if (!url.startsWith("http")) {
      url = Api.BaseUrl + url;
    }

    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    await _request(url, callback,
        method: GET, headers: headers, errorCallback: errorCallback);
  }

  static void post(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = Api.BaseUrl + url;
    }
    await _request(url, callback,
        method: POST,
        headers: headers,
        params: params,
        errorCallback: errorCallback);
  }

  static Future _request(String url, Function callback,
      {String method,
      Map<String, String> headers,
      Map<String, String> params,
      Function errorCallback}) async {
    String errorMsg;
    int errorCode;
    var data;
    try {
      Map<String, String> headerMap = headers == null ? new Map() : headers;
      Map<String, String> paramMap = params == null ? new Map() : params;

      http.Response res;
      if (POST == method) {
        print("POST:URL=" + url);
        print("POST:BODY=" + paramMap.toString());
        res = await http.post(url, headers: headerMap, body: paramMap);
      } else {
        print("GET:URL=" + url);
        res = await http.get(url, headers: headerMap);
      }

      if (res.statusCode != 200) {
        errorMsg = "网络请求错误,状态码:" + res.statusCode.toString();

        _handError(errorCallback, errorMsg);
        return;
      }

      //以下部分可以根据自己业务需求封装,这里是errorCode>=0则为请求成功,data里的是数据部分
      //记得Map中的泛型为dynamic
      Map<String, dynamic> responseJson = json.decode(res.body);
      GitClubResp resp = new GitClubResp.fromJson(responseJson);
      errorCode = resp.code;
      errorMsg = resp.msg;
      data = resp.data;
      // callback返回data,数据类型为dynamic
      //errorCallback中为了方便我直接返回了String类型的errorMsg
      if (callback != null) {
        if (errorCode == 0) {
          callback(data);
        } else {
          _handError(errorCallback, errorMsg);
        }
      }
    } catch (exception) {
      _handError(errorCallback, exception.toString());
    }
  }

  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    print("errorMsg :" + errorMsg);
  }

//  //上传文件
//  static void httpUploadFile(
//      final String url, final File file, Function callback,
//      {Function errorCallback}) async {
//    List<int> bytes = await file.readAsBytes();
//    var uri = Uri.parse(Api.BaseUrl + url);
//    var request = new http.MultipartRequest("POST", uri);
//    request.files.add(new http.MultipartFile.fromBytes('article_img', bytes,
//        contentType: new MediaType('application', 'x-www-form-urlencoded')));
////    http.Response response = await http.Response.fromStream(await request.send());
//    request.send().then((response) {
//      print("response++++:" + response.statusCode.toString());
//      Map<String, dynamic> responseJson = json.decode(response.toString());
////      final responseJson  = json.decode(res.body);
//      GitClubResp resp = new GitClubResp.fromJson(responseJson);
//      int errorCode = resp.code;
//      String errorMsg = resp.msg;
//      var data = resp.data;
//      // callback返回data,数据类型为dynamic
//      //errorCallback中为了方便我直接返回了String类型的errorMsg
//      if (callback != null) {
//        if (errorCode == 0) {
//          print("上传图片成功!");
//          callback(data);
//        } else {
//          print("上传图片失败!");
//          _handError(errorCallback, errorMsg);
//        }
//      }
//    });
//  }

  static void uploadFile(final String url, final File _image, Function callback,
      {Function errorCallback}) async {
    Dio dio = new Dio();
    FormData formdata = new FormData(); // just like JS
    String fileName = _image.path;
    formdata.add("article_img", new UploadFileInfo(_image, fileName));
    dio.post(Api.BaseUrl + url,
            data: formdata,
            options: Options(
              method: 'POST',
        responseType: ResponseType.JSON // or ResponseType.JSON
            ))
        .then((response) {
      if(response.data["code"] == 0){
        callback(response.data["data"]);
      }else{
        _handError(errorCallback, response.data["msg"]);
      }
    }).catchError((error) => _handError(errorCallback, error.toString()));
  }
}
