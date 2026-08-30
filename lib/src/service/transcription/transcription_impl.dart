import 'package:dio/dio.dart';
import 'package:translation_api/src/model/transcription_payload.dart';
import 'package:translation_api/src/model/transcription_response.dart';
import 'package:translation_api/src/service/http_client/dio_client.dart';
import 'package:translation_api/src/service/transcription/transcription_contract.dart';

class TranscriptionService implements ITranscriptionService {
  final DioClient _dioClient = DioClient();

  ///{@macro transcription_service_docs}
  @override
  Future<TranscriptionResponse> getTranscription({
    required String sourceLanguage,
    required String audioContent,
    required int samplingRate,
  }) async {
    final res = await _dioClient.dio.post(
      _dioClient.transcriptionApiUrl,
      data: TranscriptionPayload(
        audioContent: audioContent,
        domain: "general",
        task: "asr",
        samplingRate: samplingRate,
        serviceId: _dioClient.serviceId,
        sourceLanguage: sourceLanguage,
      ).toJson(),
    );
    return TranscriptionResponse.fromJson(res.data);
  }
}
