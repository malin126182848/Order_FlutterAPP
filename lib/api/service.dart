

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../toast_utils.dart';
import 'Api.dart';

Future getRequest(url,{data}) async{
//  Map<String, dynamic> map = {
//    'Accept': 'application/json, text/javascript, */*; q=0.01',
//    'Accept-Encoding': 'gzip, deflate',
//    'Accept-Language': 'zh-CN,zh;q=0.9',
//    'Connection': 'keep-alive',
//    'Cookie': Application.token,
//    'Host': '47.105.32.20:8080',
//    'Referer': 'http://47.105.32.20:8080/Home/Home.html',
//    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36',
//    'X-Requested-With': 'XMLHttpRequest'
//  };

  try{
    print('开始请求数据');
    Response response;
    BaseOptions options = new BaseOptions(
        responseType: ResponseType.plain,

    );
    Dio dio = new Dio(options);
    if(data==null){
      response = await dio.get(url);
    }else{
      response = await dio.get(url,options: data);
    }
    print(response.statusCode);
    if(response.statusCode==200){
      print(response.data);
      return response.data;
    }else{
      throw '后台服务错误';
    }
  }catch(e){
    return print(e);
  }
}


Future postRequest(url,{data}) async{
//  Map<String, dynamic> map = {
//  'Accept': 'application/json, text/javascript, */*; q=0.01',
//  'Accept-Encoding': 'gzip, deflate',
//  'Accept-Language': 'zh-CN,zh;q=0.9',
//  'Connection': 'keep-alive',
//  'Cookie': Application.token,
//  'Host': '47.105.32.20:8080',
//  'Referer': 'http://47.105.32.20:8080/Home/Home.html',
//    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36',
//  'X-Requested-With': 'XMLHttpRequest'
//  };
  try{
    print('开始请求数据');
    Response response;
    BaseOptions options = new BaseOptions(

    );
    Dio dio = new Dio(options);
    if(data==null){
      response = await dio.post(url);
    }else{
      response = await dio.post(url,queryParameters: data);
    }
    if(response.statusCode==200){
      print(response.data);
      return response.data;
    }else{
      throw '后台服务错误';
    }
  }catch(e){
    return print(e);
  }
}

Future<String> post1(String url,{Map<String, String> params}) async {
  try{
    http.Response res = await http.post(url, body: params);
    //ProgressDialog.dismiss(Application.context1);
    print(res.statusCode);
    if(res.statusCode==200){
      return res.body;
    }else{
      print(res.statusCode);
      ToastUtils.showToast('后台服务错误');
      throw '后台服务错误';
    }
  }catch(e){
    ToastUtils.showToast('后台服务错误');
    return e.toString();
  }

}