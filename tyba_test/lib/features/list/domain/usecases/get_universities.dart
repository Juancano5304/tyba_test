import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usercases/usecases.dart';
import '../entities/university.dart';
import '../repositories/universities_repository.dart';

class GetUniversities {
  GetUniversities({required UniversitiesRepository repository})
      : _repository = repository;

  final UniversitiesRepository _repository;

  Future<Either<Failure, List<University>?>?> call(
    NoParams params,
  ) async {
    return _repository.getUniversitiesList();
  }
}
