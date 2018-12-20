/*{
"data": ...,
"errorCode": 0,
"errorMsg": ""
}*/

class GitClubResp {

  int code;

  String msg;

  Object data;

  GitClubResp({this.code, this.msg, this.data});

  factory GitClubResp.fromJson(Map<String, dynamic> json) {
    return new GitClubResp(
        code: json['code'],
        msg: json['msg'],
        data: json['data']
    );
  }
}