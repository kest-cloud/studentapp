import 'package:dartz/dartz.dart';
import 'package:studentapp/core/networkhandler/failure.dart';
import 'package:studentapp/core/utils/dims.dart';
import 'package:studentapp/features/dashboard/data/datasource/dashboard_remote_database.dart';
import 'package:studentapp/features/dashboard/data/datasource/localdatasource/local.dart';
import 'package:studentapp/features/dashboard/data/domain/entity/student_from_api.dart';
import 'package:studentapp/features/dashboard/data/domain/repository/repo.dart';

class DashBoardRepositoryImpl implements DashBoardRepository {
  DashBoardRepositoryImpl({
    required this.remoteDatasource,
    required this.dbLocalDatasource,
  });

  final DashboardRemoteDatasource remoteDatasource;
  final DashboardDBLocalDatasource dbLocalDatasource;

  @override
  Future<Either<Failure, dynamic>> getStudentProfiles() async {
    try {
      var response = await remoteDatasource.getStudentProfiles();
      Logger(response);

      return Right(response);
    } catch (e) {
      print(e);
      return Left(
        Failure(
          message: ExceptionHandler.handleError(e).toString(),
          data: ExceptionHandler.handleError(e).toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteStudentProfiles(id) async {
    try {
      var response = await remoteDatasource.deleteStudentProfiles(id);
      Logger(response);

      return Right(response);
    } catch (e) {
      print(e);
      return Left(
        Failure(
          message: ExceptionHandler.handleError(e).toString(),
          data: ExceptionHandler.handleError(e).toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, dynamic>> addStudent(
      Map<String, Object?> newStudent) async {
    try {
      var response = await remoteDatasource.addStudent(newStudent);
      Logger(response);

      return Right(response);
    } catch (e) {
      print(e);
      return Left(
        Failure(
          message: ExceptionHandler.handleError(e).toString(),
          data: ExceptionHandler.handleError(e).toString(),
        ),
      );
    }
  }

  // @override
  // Future<Either<Failure, BaseResponseModel>> createPassword(
  //     {required CreatePasswordRequest params}) async {
  //   try {
  //     var response = await remoteDatasource.createPassword(params: params);
  //     return Right(BaseResponseModel.fromJson(response.data!));
  //   } catch (e) {
  //     return Left(
  //       Failure(
  //         message: ExceptionHandler.handleError(e),
  //         data: ExceptionHandler.errorResponseData(e),
  //       ),
  //     );
  //   }
  // }
}
