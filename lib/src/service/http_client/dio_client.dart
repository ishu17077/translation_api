import 'package:dio/dio.dart';

class DioClient {
  late final Dio dio;
  static DioClient? _insance;
  String translationApiUrl =
      "https://admin.models.ai4bharat.org/inference/translate";
  String transcriptionApiUrl =
      "https://admin.models.ai4bharat.org/inference/transcribe";
  String suggestionApiUrl = "https://xlit-api1.ai4bharat.org/tl";
  String serviceId = "ai4bharat/indictrans--gpu-t4";
  DioClient._createInstance();

  factory DioClient() {
    if (_insance == null) {
      _insance = DioClient._createInstance();
      _insance!.dio = Dio();
    }
    return _insance!;
  }
}
