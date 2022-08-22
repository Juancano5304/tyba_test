class Endpoints {
  Endpoints({
    required this.universities,
  });

  factory Endpoints.fromJson(Map<String, dynamic> json) => Endpoints(
        universities: json[_AttributeKeys.universities].toString(),
      );

  final String universities;
}

abstract class _AttributeKeys {
  static const String universities = 'universities';
}
