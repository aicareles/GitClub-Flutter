import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:gitclub/http/BaseResp.dart';
import 'package:http/http.dart' as http;

import 'package:gitclub/http/Api.dart';
import 'package:http_parser/http_parser.dart';

/*数据接口类型errorCode>0是接口请求成功
{
"data": ...,
"errorCode": 0,
"errorMsg": ""
}
*/

//class Api {
//  static const String BaseUrl = "http://www.wanandroid.com/";
//}

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
        method: GET,
        headers: headers,
        errorCallback: errorCallback);
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
        headers: headers, params: params, errorCallback: errorCallback);
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
        print("POST:URL="+url);
        print("POST:BODY="+paramMap.toString());
        res = await http.post(url, headers: headerMap, body: paramMap);
      } else {
        print("GET:URL="+url);
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
//      final responseJson  = json.decode(res.body);
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

  static void _handError(Function errorCallback,String errorMsg){
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    print("errorMsg :"+errorMsg);
  }


//  //上传文件
//  static void httpUploadFile(
//      final String url,
//      final File file) async {
//    List<int> bytes = await file.readAsBytes();
//    var request = new http.MultipartRequest("POST", Uri);
////    request.fields['article_img'] = 'article_img';
//    request.files.add(new http.MultipartFile.fromBytes('article_img', bytes, contentType: new MediaType('application', 'x-www-form-urlencoded')));
//
//    request.send().then((response) {
//      if (response.statusCode == 200) print("Uploaded!");
//    });
//  }

  
}
