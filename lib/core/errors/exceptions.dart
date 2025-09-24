class ServerException implements Exception {
  final String message;
  final int? code;

  const ServerException({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'ServerException: $message';
}

class NetworkException implements Exception {
  final String message;
  final int? code;

  const NetworkException({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  final String message;
  final int? code;

  const CacheException({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'CacheException: $message';
}

class ValidationException implements Exception {
  final String message;
  final int? code;

  const ValidationException({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'ValidationException: $message';
}

class UnknownException implements Exception {
  final String message;
  final int? code;

  const UnknownException({
    required this.message,
    this.code,
  });

  @override
  String toString() => 'UnknownException: $message';
}
