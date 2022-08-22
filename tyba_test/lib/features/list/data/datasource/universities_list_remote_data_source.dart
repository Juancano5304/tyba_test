import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../models/university_model.dart';

abstract class UniversitiesListRemoteDataSource {
  Future<List<UniversityModel>> getUniversitiesList();
}

class UniversitiesListRemoteDataSourceImpl
    implements UniversitiesListRemoteDataSource {
  UniversitiesListRemoteDataSourceImpl({
    required this.dio,
    required this.endpoint,
  });

  final Dio dio;
  final String endpoint;

  @override
  Future<List<UniversityModel>> getUniversitiesList() async {
    final Response<dynamic> response = await dio.get(endpoint);
    if (response.statusCode == HttpStatus.ok) {
      return Future<List<UniversityModel>>.value(
          UniversityModel.fromList(response.data));
    } else {
      throw ServerException();
    }
  }
}
