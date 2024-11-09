import 'package:studentapp/features/setting_page/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/setting_page/data/domain/repository/repo.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/core/di-manual/di_manual.dart';

class SettingsNotifier extends ChangeNotifier {
  SettingsDBLocalDatasource settingsDBLocalDatasource =
      getIt<SettingsDBLocalDatasource>();

  final SettingsRepository _repository;
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  SettingsNotifier(
    this._repository,
  );

//
}
