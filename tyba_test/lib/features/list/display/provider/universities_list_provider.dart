import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/config/endpoints.dart';
import '../../../../core/connection/network_info.dart';
import '../../../../core/error/failure.dart';
import '../../data/datasource/universities_list_local_data_source.dart';
import '../../data/datasource/universities_list_remote_data_source.dart';
import '../../data/models/university_model.dart';
import '../../data/repositories/universities_repository_impl.dart';

class UniversitiesListProvider extends ChangeNotifier {
  UniversitiesListProvider({
    this.failure,
    this.universitiesList,
  });
  static const String endpointsAssetsPath = 'assets/config/endpoints.json';

  List<UniversityModel>? universitiesList;
  Failure? failure;

  Future<void> eitherFailureOrUniversitiesList() async {
    final String universityEndpoint = Endpoints.fromJson(
      json.decode(
        await rootBundle.loadString(
          endpointsAssetsPath,
        ),
      ),
    ).universities;
    final UniversitiesRepositoryImpl repositoryImpl =
        UniversitiesRepositoryImpl(
      remoteDataSource: UniversitiesListRemoteDataSourceImpl(
        dio: Dio(),
        endpoint: universityEndpoint,
      ),
      localDataSource: UniversitiesListLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final Either<Failure, List<UniversityModel>?>? failureOrUniversitiesList =
        await repositoryImpl.getUniversitiesList();

    if (failureOrUniversitiesList == null) {
      failure = const ServerFailure(errorMessage: 'Empty Universities List');
      return;
    }

    failureOrUniversitiesList.fold(
      (Failure newFailure) {
        universitiesList = null;
        failure = newFailure;
        notifyListeners();
      },
      (List<UniversityModel>? newUniversitiesList) {
        universitiesList = newUniversitiesList;
        failure = null;
        notifyListeners();
      },
    );
  }
}
