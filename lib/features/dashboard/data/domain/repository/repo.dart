import 'package:studentapp/core/networkhandler/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DashBoardRepository {
  Future<Either<Failure, dynamic>> getStudentProfiles();

  Future<Either<Failure, dynamic>> deleteStudentProfiles(id);

  Future<Either<Failure, dynamic>> addStudent(Map<String, Object?> newStudent);
}
