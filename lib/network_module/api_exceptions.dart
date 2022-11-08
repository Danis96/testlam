class AppException implements Exception {
  AppException([this._message, this._prefix]);

  final dynamic _message;
  final dynamic _prefix;

  @override
  String toString() {
    return '$_prefix\n$_message';
  }
}

class BadRequestValidationException implements Exception {
  BadRequestValidationException.fromJson(dynamic json, {int? code}) {
    print(json);
    if (code != null) {
      statusCode = code;
    }
    if (json['error_description'] != null) {
      detail = json['error_description'] as String;
    }
    if (json['Message'] != null) {
      detail = json['Message'] as String;
    }
    // ignore: always_specify_types
    errors = {};

    if (json['error_description'] != null && json['error_description'] is Map<String, dynamic>) {
      final Map<String, List<String>> parsedErrors = <String, List<String>>{};

      final Map<String, dynamic> jsonError = json['error_description'] as Map<String, dynamic>;

      if (jsonError is List<dynamic>) {
        jsonError.forEach((String key, dynamic value) {
          // ignore: always_specify_types
          final List<String> lErrors = (value as List).cast<String>();
          parsedErrors[key] = lErrors;
        });
        errors = parsedErrors;
      } else if (jsonError is Map<String, dynamic>) {
        mapError = jsonError;
      }
    } else if (json['Message'] != null && json['Message'] is Map<String, dynamic>) {
      final Map<String, List<String>> parsedErrors = <String, List<String>>{};

      final Map<String, dynamic> jsonError = json['Message'] as Map<String, dynamic>;

      if (jsonError is List<dynamic>) {
        jsonError.forEach((String key, dynamic value) {
          // ignore: always_specify_types
          final List<String> lErrors = (value as List).cast<String>();
          parsedErrors[key] = lErrors;
        });
        errors = parsedErrors;
      } else if (jsonError is Map<String, dynamic>) {
        mapError = jsonError;
      }
    } else if (json != null) {
      final Map<String, List<String>> parsedErrors = <String, List<String>>{};
      final Map<String, dynamic> jsonError = json as Map<String, dynamic>;

      if (jsonError is List<dynamic>) {
        jsonError.forEach((String key, dynamic value) {
          // ignore: always_specify_types
          final List<String> lErrors = (value as List).cast<String>();
          parsedErrors[key] = lErrors;
        });
        errors = parsedErrors;
      } else if (jsonError is Map<String, dynamic>) {
        mapError = jsonError;
      }
    }
    print(detail);
  }

  String? detail;
  int? statusCode;
  Map<String, List<String>>? errors;
  Map<String, dynamic>? mapError;

  @override
  String toString() {
    return detail!;
  }
}

class InternetException extends AppException {
  InternetException([String? message]) : super(message, 'Error During Communication');

  @override
  String toString() {
    return '$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException([dynamic message]) : super(message, 'Invalid Request Exception');
}

class UnauthorisedException extends AppException {
  UnauthorisedException([dynamic message]) : super(message, 'Unauthorized!');
}

class InvalidInputException extends AppException {
  InvalidInputException([dynamic message]) : super(message, 'Invalid Input Exception');
}

class AuthenticationException extends AppException {
  AuthenticationException([dynamic message]) : super(message, 'Authentication Exception');
}
