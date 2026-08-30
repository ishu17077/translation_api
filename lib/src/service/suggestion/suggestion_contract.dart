import 'package:translation_api/src/model/suggestion_response.dart';

abstract class SuggestionContract {
  Future<SuggestionResponse> getSuggestion(String text);
}
