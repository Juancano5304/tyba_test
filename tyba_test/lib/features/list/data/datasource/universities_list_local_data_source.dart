import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/university_model.dart';

const String cachedUniversitiesList = 'CACHED_UNIVERSITIES_LIST';

abstract class UniversitiesListLocalDataSource {
  Future<void> cacheUniversitiesList(List<UniversityModel>? modelToCache);
  Future<List<UniversityModel>?> getCachedUniversitiesList();
  Future<bool> updateUniversity(UniversityModel universityModel);
}

class UniversitiesListLocalDataSourceImpl
    implements UniversitiesListLocalDataSource {
  UniversitiesListLocalDataSourceImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> cacheUniversitiesList(List<UniversityModel>? modelToCache) {
    if (modelToCache != null) {
      return _sharedPreferences.setString(
        cachedUniversitiesList,
        json.encode(modelToCache.toList()),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<UniversityModel>?> getCachedUniversitiesList() {
    final String? jsonString =
        _sharedPreferences.getString(cachedUniversitiesList);
    if (jsonString != null) {
      return Future<List<UniversityModel>?>.value(UniversityModel.fromList(
          json.decode(jsonString) as Map<String, dynamic>));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<bool> updateUniversity(UniversityModel universityModel) {
    final String? jsonString =
        _sharedPreferences.getString(cachedUniversitiesList);
    if (jsonString != null) {
      final List<UniversityModel> universityList =
          UniversityModel.fromList(json.decode(jsonString));
      universityList
          .singleWhere((UniversityModel element) => element == universityModel)
        ..image = universityModel.image
        ..studentsCount = universityModel.studentsCount;

      return Future<bool>.value(true);
    } else {
      throw CacheException();
    }
  }
}
