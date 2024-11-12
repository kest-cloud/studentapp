import 'package:sqflite/sqflite.dart';
import 'package:studentapp/features/setting_page/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/setting_page/data/domain/entity/user_settings.dart';
import 'package:studentapp/features/setting_page/data/domain/repository/repo.dart';
import 'package:flutter/material.dart';

class SettingsNotifier extends ChangeNotifier {
  final SettingsRepository _repository;

  SettingsNotifier(
    this._repository,
  );

//
  Future<int> saveSettings(UserSettings settings) async {
    final db = await DatabaseHelper.instance.database;

    // If there is an existing entry, update it; otherwise, insert a new row
    final result = await db.insert(
      'user_settings',
      settings.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  Future<UserSettings?> getSettings() async {
    final db = await DatabaseHelper.instance.database;

    // Query the settings table for the first row
    final maps = await db.query('user_settings', limit: 1);

    if (maps.isNotEmpty) {
      return UserSettings.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateSettings(UserSettings settings) async {
    final db = await DatabaseHelper.instance.database;

    return await db.update(
      'user_settings',
      settings.toMap(),
      where: 'id = ?',
      whereArgs: [settings.id],
    );
  }
}
