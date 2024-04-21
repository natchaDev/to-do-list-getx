import 'package:dio/dio.dart' as Http;

extension ExtendResponse on Http.Response {
  void throwToFailureResponseExceptionWhen(bool Function(Http.Response response) checker) {
    if (!checker(this)) return;
    this.throwToFailureResponseException();
  }

  void throwToFailureResponseException() {
    if (this == null) {
      throw Exception('base_service usingMockData but no mock data sent');
    }
    switch (this.statusCode ?? -1) {
      case 400:
        throw FailureResponse400(this);
      case 401:
        throw FailureResponse401(this);
      case 404:
        throw FailureResponse404(this);
      default:
        throw FailureResponse(this);
    }
  }

  Http.Response<T> orThrowWhen<T>(bool Function(Http.Response<T> response) checker) {
    if (checker(this as Http.Response<T>)) {
      this.throwToFailureResponseException();
    }
    return this as Http.Response<T>;
  }

  Http.Response<T> orThrowIfNot200<T>() {
    return this.orThrowWhen((Http.Response<T> response) => response.statusCode != 200);
  }

  Http.Response<T> orThrowIfNot200or201<T>() {
    return this.orThrowWhen((Http.Response<T> response) => !(response.statusCode == 200 || response.statusCode == 201));
  }
  Http.Response<T> orThrowIfNot204<T>() {
    return this.orThrowWhen((Http.Response<T> response) => !(response.statusCode == 204));
  }
}

Http.Response<T> Function(Http.Response<T>?) checkStatus200<T>() => (Http.Response<T>? res) => res!.orThrowIfNot200<T>();

Http.Response<T> Function(Http.Response<T>?) checkSuccessPost<T>() => (Http.Response<T>? res) => res!.orThrowIfNot200or201<T>();

Http.Response<T> Function(Http.Response<T>?) checkSuccessDelete<T>() => (Http.Response<T>? res) => res!.orThrowIfNot204<T>();

Http.Response Function(Http.Response) get check200 => (Http.Response res) => res.orThrowIfNot200();

Http.Response Function(Http.Response) mapResponseData(Map Function(Map?) mapper) {
  return (Http.Response res) {
    res.data = mapper(res.data);
    return res;
  };
}

class FailureResponse<T> implements Exception {
  final Http.Response response;

  FailureResponse(this.response);

  @override
  String toString() {
    return '${this.runtimeType} {response: $response}';
  }
}

class FailureResponse400<T> extends FailureResponse<T> {
  FailureResponse400(Http.Response response) : super(response);
}

class FailureResponse401<T> extends FailureResponse<T> {
  FailureResponse401(Http.Response response) : super(response);
}

class FailureResponse404<T> extends FailureResponse<T> {
  FailureResponse404(Http.Response response) : super(response);
}
