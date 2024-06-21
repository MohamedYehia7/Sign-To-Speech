import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;

  static init(){
    dio = Dio(
        BaseOptions(
          baseUrl: 'http://ELKhamry.somee.com/api/Account/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Length':'<calculated when request is sent>',
            'Host':'<calculated when request is sent>',
            'User-Agent':'PostmanRuntime/7.39.0',
            'Accept':'*/*',
            'Accept-Encoding':'gzip, deflate, br',
            'Connection':'keep-alive',
          }
        ),
    );

    return dio;
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,

    String? token
  })async{
    dio.options.headers= {
      'Authorization':'Bearer $token'??'',
      // 'Postman-Token':'<calculated when request is sent>',
    };

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required var request_data,
    String? token
  })async{
    dio.options.headers= {
      'token':token??'',
      'Content-Type':'application/json',
    };
    return dio.post(url, queryParameters: query,data: request_data);

  }


  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? request_data,

    String? token
  })async{
    dio.options.headers= {

      'Authorization':token??''
    };
    return dio.put(url, queryParameters: query,data: request_data);

  }
}