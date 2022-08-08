
import 'dart:core';

abstract class BaseResponse<T> {
  late bool error;
  late T data;
  late List<BaseError> errors;
  //Meta meta;

  BaseResponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }


  T jsonToData(Map<String, dynamic> fullJson);

  dynamic dataToJson(T data);

  parsing(Map<String, dynamic> fullJson) {
    error = fullJson["error"] ?? false;
    data = jsonToData(fullJson);
    errors = parseErrorList(fullJson);
    //meta = fullJson['meta'] != null ? Meta.fromJson(fullJson['meta']) : null;
  }

  List<BaseError> parseErrorList(Map<String, dynamic> fullJson) {
    List? errors = fullJson["errors"];
    return errors != null
        ? List<BaseError>.from(errors.map((x) => BaseError.fromJson(x)))
        : <BaseError>[];
  }

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": dataToJson(data),
    "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
  };

  static fromJson(decode) {}
}

class BaseError {
  final int code;
  final String message;

  BaseError({
    required this.code,
    required this.message,
  });

  factory BaseError.fromJson(Map<String, dynamic> json) => BaseError(
    code: json["code"] ?? json["errorCode"] ?? -792,
    message: json["message"] ?? json["errorMessage"] ?? 'Error',
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}