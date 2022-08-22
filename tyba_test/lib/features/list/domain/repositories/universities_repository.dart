import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/university_model.dart';
import '../entities/university.dart';

abstract class UniversitiesRepository {
  Future<Either<Failure, List<University>?>?> getUniversitiesList();

  Future<Either<Failure, bool>> updateUniversity(
      UniversityModel universityModel);
}
