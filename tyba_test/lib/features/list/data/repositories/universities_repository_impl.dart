import 'package:dartz/dartz.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/universities_repository.dart';
import '../datasource/universities_list_local_data_source.dart';
import '../datasource/universities_list_remote_data_source.dart';
import '../models/university_model.dart';

class UniversitiesRepositoryImpl implements UniversitiesRepository {
  UniversitiesRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final UniversitiesListLocalDataSource localDataSource;
  final UniversitiesListRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<UniversityModel>?>?> getUniversitiesList() async {
    if (await networkInfo.isConnected!) {
      try {
        final List<UniversityModel> universities =
            await remoteDataSource.getUniversitiesList();

        return Right<Failure, List<UniversityModel>?>(universities);
      } on ServerException {
        return const Left<Failure, List<UniversityModel>?>(
            ServerFailure(errorMessage: 'Exception from Server'));
      }
    } else {
      return const Right<Failure, List<UniversityModel>?>(null);
    }
  }

  @override
  Future<Either<Failure, bool>> updateUniversity(
      UniversityModel universityModel) async {
    try {
      final bool response =
          await localDataSource.updateUniversity(universityModel);
      return Right<Failure, bool>(response);
    } on CacheException {
      return const Left<Failure, bool>(
          CacheFailure(errorMessage: 'Exception from Cache'));
    }
  }
}
