import 'package:dio/dio.dart';

abstract class HttpMethods {
  static String get = "GET";
  static String post = "POST";
  static String patch = "PATCH";
  static String put = "PUT";
  static String delete = "DELETE";
}

class HttpManager {
  Future<Map> restRequest({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    Dio dio = Dio();

    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
        {
          'content-type': 'application/json',
          'accept': 'application/json',
          'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
          'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
        },
      );

    try {
      Response response = await dio.request(
        url,
        data: body,
        options: Options(
          method: method,
          headers: defaultHeaders,
        ),
      );
      return response.data;
    } on DioException catch (error) {
      return error.response?.data ?? {};
    } catch (error) {
      return {};
    }
  }
}
