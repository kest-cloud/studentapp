import 'package:flutter/material.dart';
import 'package:studentapp/core/di-manual/di_manual.dart';
import 'package:studentapp/features/setting_page/data/domain/entity/user_settings.dart';
import 'package:studentapp/features/setting_page/presentation/notifier/settings_notifier.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Default settings values
  String theme = 'Light';
  bool notificationsEnabled = true;
  String language = 'English';
  String fontSize = 'Medium';

  @override
  void initState() {
    super.initState();
    _loadUserSettings();
  }

  // Load user settings from the database
  void _loadUserSettings() async {
    final caller = getIt<SettingsNotifier>();
    final savedSettings = await caller.getSettings();
    if (savedSettings != null) {
      setState(() {
        theme = savedSettings.theme;
        notificationsEnabled = savedSettings.notificationsEnabled;
        language = savedSettings.language;
        fontSize = savedSettings.fontSize;
      });
    }
  }

  // Save user settings to the database
  void _saveUserSettings() async {
    final caller = getIt<SettingsNotifier>();
    final settings = UserSettings(
      theme: theme,
      notificationsEnabled: notificationsEnabled,
      language: language,
      fontSize: fontSize,
    );
    await caller.saveSettings(settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme selection
          ListTile(
            title: const Text('Theme'),
            trailing: DropdownButton<String>(
              value: theme,
              items: ['Light', 'Dark']
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  theme = newValue!;
                  _saveUserSettings();
                });
              },
            ),
          ),

          // Notifications toggle
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
                _saveUserSettings();
              });
            },
          ),

          // Language selection
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: language,
              items: ['English', 'Spanish', 'French']
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  language = newValue!;
                  _saveUserSettings();
                });
              },
            ),
          ),

          // Font Size selection
          ListTile(
            title: Text('Font Size'),
            trailing: DropdownButton<String>(
              value: fontSize,
              items: ['Small', 'Medium', 'Large']
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  fontSize = newValue!;
                  _saveUserSettings();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
