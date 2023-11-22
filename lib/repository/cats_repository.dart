import 'package:cats/model/cat.dart';
import 'package:dio/dio.dart';

class CatsRepository {
  final _dio = Dio();

  Future<Cat> loadRandomCat() async {
    final response = await _dio.get(
      "https://cataas.com/cat",
      options: Options(responseType: ResponseType.bytes),
    );
    return Cat(image: response.data);
  }
}
