class WorksheetItem {
  final String promptInHindi;
  final String promptInTargetLanguage;

  const WorksheetItem({
    required this.promptInHindi,
    required this.promptInTargetLanguage,
  });
}

class VisualFlashcard {
  final String keywordInHindi;
  final String keywordInTargetLanguage;
  final String? imageAssetKey;

  const VisualFlashcard({
    required this.keywordInHindi,
    required this.keywordInTargetLanguage,
    this.imageAssetKey,
  });
}

class BilingualWorksheet {
  final List<WorksheetItem> items;
  final List<VisualFlashcard> flashcards;

  const BilingualWorksheet({
    required this.items,
    required this.flashcards,
  });
}
