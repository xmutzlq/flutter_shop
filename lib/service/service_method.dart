import "package:dio/dio.dart";
import 'package:flutter_shop/config/global_config.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future request(url, {formData, CancelToken cancelToken}) async{
  try{
    Response response;

    Dio dio = new Dio();
    dio.options.contentType = ContentType.json;
    dio.options.connectTimeout = 5000; 
    dio.options.receiveTimeout = 5000;
    dio.interceptors.add(LogInterceptor(responseBody: GlobalConfig.isDebug));

    if(formData == null) {
      response = await dio.post(servicePath[url], cancelToken: cancelToken);
    } else {
      response = await dio.post(servicePath[url], data:formData, cancelToken: cancelToken);
    }
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>$e');
  }

}