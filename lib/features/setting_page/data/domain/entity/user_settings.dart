class UserSettings {
  final int? id;
  final String theme;
  final bool notificationsEnabled;
  final String language;
  final String fontSize;

  UserSettings({
    this.id,
    required this.theme,
    required this.notificationsEnabled,
    required this.language,
    required this.fontSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'theme': theme,
      'notifications_enabled': notificationsEnabled ? 1 : 0,
      'language': language,
      'font_size': fontSize,
    };
  }

  static UserSettings fromMap(Map<String, dynamic> map) {
    return UserSettings(
      id: map['id'],
      theme: map['theme'],
      notificationsEnabled: map['notifications_enabled'] == 1,
      language: map['language'],
      fontSize: map['font_size'],
    );
  }
}
