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
import '../../../list/data/datasource/universities_list_local_data_source.dart';
import '../../../list/data/datasource/universities_list_remote_data_source.dart';
import '../../../list/data/models/university_model.dart';
import '../../../list/data/repositories/universities_repository_impl.dart';

enum DetailsPageViewState {
  completed,
  error,
  initial,
  loading,
}

class UniversitiesDetailsProvider extends ChangeNotifier {
  static const String endpointsAssetsPath = 'assets/config/endpoints.json';

  List<UniversityModel>? universitiesList;
  Failure? failure;
  DetailsPageViewState listPageViewState = DetailsPageViewState.initial;

  Future<void> updateUniversity(UniversityModel universityModel) async {
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

    final Either<Failure, bool> failureOrSuccessUpdate =
        await repositoryImpl.updateUniversity(universityModel);

    failureOrSuccessUpdate.fold(
      (Failure newFailure) {
        universitiesList = null;
        failure = newFailure;
        notifyListeners();
      },
      (bool isUniversityUpdated) {
        failure = null;
        notifyListeners();
      },
    );
  }
}
