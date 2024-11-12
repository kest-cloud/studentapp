import 'package:studentapp/features/dashboard/data/datasource/dashboard_remote_database.dart';
import 'package:studentapp/features/dashboard/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/setting_page/data/domain/repository/repo.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    required this.remoteDatasource,
    required this.dbLocalDatasource,
  });

  final DashboardRemoteDatasource remoteDatasource;
  final DashboardDBLocalDatasource dbLocalDatasource;
}
