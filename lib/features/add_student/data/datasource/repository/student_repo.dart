import 'package:studentapp/features/add_student/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/add_student/data/datasource/student_remote_datasource.dart';
import 'package:studentapp/features/add_student/data/domain/repository/repo.dart';

class StudentRepositoryImpl implements StudentRepository {
  StudentRepositoryImpl({
    required this.remoteDatasource,
    required this.dbLocalDatasource,
  });

  final StudentRemoteDatasource remoteDatasource;
  final StudentDBLocalDatasource dbLocalDatasource;
}
