class ResponseEntity<T> {
  int code;
  String msg;
  T data;

  ResponseEntity({this.code, this.msg, this.data});

  factory ResponseEntity.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseEntity(
      code: parsedJson['code'],
      msg: parsedJson['msg'],
      data: parsedJson['data'],
    );
  }
}