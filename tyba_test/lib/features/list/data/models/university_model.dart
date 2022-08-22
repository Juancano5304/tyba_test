// ignore_for_file: must_be_immutable, overridden_fields, avoid_dynamic_calls, annotate_overrides

import '../../domain/entities/university.dart';

class UniversityModel extends University {
  UniversityModel({
    required this.alphaTwoCode,
    required this.domains,
    required this.country,
    this.image,
    this.stateProvince,
    this.studentsCount,
    required this.webPages,
    required this.name,
  }) : super(
          alphaTwoCode: alphaTwoCode,
          domains: domains,
          country: country,
          webPages: webPages,
          name: name,
        );

  factory UniversityModel.fromJson(dynamic json) => UniversityModel(
        alphaTwoCode: json[_AttributeKeys.alphaTwoCode].toString(),
        domains: (json[_AttributeKeys.domains] as List<dynamic>)
            .map((dynamic domain) => domain as String)
            .toList(),
        country: json[_AttributeKeys.country].toString(),
        image: json[_AttributeKeys.image]?.toString(),
        stateProvince: json[_AttributeKeys.stateProvince]?.toString(),
        studentsCount:
            int.tryParse(json[_AttributeKeys.studentsCount].toString()),
        webPages: (json[_AttributeKeys.webPages] as List<dynamic>)
            .map((dynamic webPage) => webPage as String)
            .toList(),
        name: json[_AttributeKeys.name].toString(),
      );

  static List<UniversityModel> fromList(dynamic list) {
    List<UniversityModel> result = <UniversityModel>[];
    if (list != null) {
      result = <UniversityModel>[];
      for (final dynamic json in list as List<dynamic>) {
        final UniversityModel postModel = UniversityModel.fromJson(json);
        result.add(postModel);
      }
    }
    return result;
  }

  final String alphaTwoCode;
  final List<String> domains;
  final String country;
  String? image;
  final String? stateProvince;
  int? studentsCount;
  final List<String> webPages;
  final String name;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        _AttributeKeys.alphaTwoCode: alphaTwoCode,
        _AttributeKeys.country: country,
        _AttributeKeys.domains: domains,
        _AttributeKeys.image: image,
        _AttributeKeys.name: name,
        _AttributeKeys.stateProvince: stateProvince,
        _AttributeKeys.studentsCount: studentsCount,
        _AttributeKeys.webPages: webPages,
      };
}

abstract class _AttributeKeys {
  static const String alphaTwoCode = 'alpha_two_code';
  static const String country = 'country';
  static const String domains = 'domains';
  static const String image = 'image';
  static const String name = 'name';
  static const String stateProvince = 'state-province';
  static const String studentsCount = 'students_count';
  static const String webPages = 'web_pages';
}
