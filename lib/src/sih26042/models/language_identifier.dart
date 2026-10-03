class LanguageIdentifier {
  final String code;
  final String displayName;

  const LanguageIdentifier({
    required this.code,
    required this.displayName,
  });

  static const hindi = LanguageIdentifier(code: 'hi', displayName: 'Hindi');
  static const ho = LanguageIdentifier(code: 'hoc', displayName: 'Ho');
  static const mundari =
      LanguageIdentifier(code: 'unr', displayName: 'Mundari');
  static const santhali =
      LanguageIdentifier(code: 'sat', displayName: 'Santhali');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is LanguageIdentifier &&
        other.code == code &&
        other.displayName == displayName;
  }

  @override
  int get hashCode => Object.hash(code, displayName);
}
