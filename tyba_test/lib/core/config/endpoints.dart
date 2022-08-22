// ignore_for_file: avoid_dynamic_calls

class Endpoints {
  Endpoints({
    required this.universities,
  });

  factory Endpoints.fromJson(dynamic json) => Endpoints(
        universities: json[_AttributeKeys.universities].toString(),
      );

  final String universities;
}

abstract class _AttributeKeys {
  static const String universities = 'universities';
}
