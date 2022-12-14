import 'package:equatable/equatable.dart';

class University extends Equatable {
  const University({
    required this.alphaTwoCode,
    required this.country,
    required this.domains,
    required this.name,
    this.stateProvince,
    required this.webPages,
  });

  factory University.fromJson(Map<String, dynamic> json) => University(
        alphaTwoCode: json[_AttributeKeys.alphaTwoCode].toString(),
        country: json[_AttributeKeys.country].toString(),
        domains: (json[_AttributeKeys.domains] as List<String>)
            .map((String item) => item)
            .toList(),
        name: json[_AttributeKeys.name].toString(),
        stateProvince: json[_AttributeKeys.stateProvince]?.toString(),
        webPages: (json[_AttributeKeys.webPages] as List<String>)
            .map((String item) => item)
            .toList(),
      );

  final List<String> domains;
  final List<String> webPages;
  final String alphaTwoCode;
  final String country;
  final String name;
  final String? stateProvince;

  Map<String, dynamic> toJson() => <String, dynamic>{
        _AttributeKeys.alphaTwoCode: alphaTwoCode,
        _AttributeKeys.country: country,
        _AttributeKeys.domains: domains,
        _AttributeKeys.name: name,
        _AttributeKeys.stateProvince: stateProvince,
        _AttributeKeys.webPages: webPages,
      };

  @override
  List<Object?> get props => <Object?>[
        alphaTwoCode,
        country,
        domains,
        name,
        stateProvince,
        webPages,
      ];
}

abstract class _AttributeKeys {
  static const String alphaTwoCode = 'alpha_two_code';
  static const String country = 'country';
  static const String domains = 'domains';
  static const String name = 'name';
  static const String stateProvince = 'state-province';
  static const String webPages = 'web_pages';
}
