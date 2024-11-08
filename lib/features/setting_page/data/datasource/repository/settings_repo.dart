import 'package:studentapp/features/setting_page/data/datasource/sett_remote_datasource.dart';
import 'package:studentapp/features/setting_page/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/setting_page/data/domain/repository/repo.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required this.remoteDatasource,
    required this.dbLocalDatasource,
  });

  final SettingsRemoteDatasource remoteDatasource;
  final SettingsDBLocalDatasource dbLocalDatasource;
}
