import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as Http;
import 'package:dio/dio.dart' as dio;
import 'package:getx_mvvm_boilerplate/commons/data/mock_data_loader.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../../application/env.dart';
import '../../../di/container.dart';
import '../../preferences/user_preference.dart';
import '../../services/base_service/base_service_failure.dart';
import 'package:getx_mvvm_boilerplate/commons/utils/list_utils.dart';

class BaseService {
  String? baseUrl;
  final String serverType;
  final bool usingMockData;
  final UserPreference userPreference = inject<UserPreference>();
  final Http.Dio _dio = inject<Http.Dio>();
  final MockDataLoader _mockDataLoader = MockDataLoader();
  final Options defaultOptions = Options(
    sendTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
  );

  BaseService(EnvironmentConfig env)
      : serverType = env.getServerType(),
        baseUrl = env.getServiceApiBaseUrl(),
        usingMockData = env.isUsingMockApiData {
    initSetting();
  }

  Future<String?> getToken() async {
    var token = await userPreference.getToken();
    return token;
  }

  void initSetting() {
    _dio.interceptors
        .add(Http.InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await userPreference.getToken();
      if (token != null && !(options.path ?? '').endsWith('/auth')) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (Http.DioError e, handler) {
      return handler.next(e);
    }));
  }

  String basePath(String path) => '$baseUrl$path';

  // REST API Method
  Future<Http.Response<String?>> _getString(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<String>(
        includeBasePath ? basePath(path) : path,
        queryParameters: queryParameters ?? {},
        options: options ?? defaultOptions,
      );
    } on Http.DioError catch (e) {
      return _getDioErrorResponse<String?>(e);
    }
  }

  Future<Http.Response<Map<String, dynamic>?>> _get(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<Map<String, dynamic>>(
        includeBasePath ? basePath(path) : path,
        queryParameters: queryParameters ?? {},
        options: options ?? defaultOptions,
      );
    } on Http.DioError catch (e) {
      return _getDioErrorResponse<Map<String, dynamic>?>(e);
    }
  }

  Future<Http.Response<List<dynamic>?>> _getArray(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<List<dynamic>>(
        includeBasePath ? basePath(path) : path,
        queryParameters: queryParameters ?? {},
        options: options ?? defaultOptions,
      );
    } on Http.DioError catch (e) {
      return _getDioErrorResponse<List<dynamic>?>(e);
    }
  }

  Future<Http.Response<Map<String, dynamic>?>> _post(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        includeBasePath ? basePath(path) : path,
        queryParameters: queryParameters ?? {},
        data: data,
        options: options ?? defaultOptions,
      );
    } on Http.DioError catch (e) {
      return _getDioErrorResponse<Map<String, dynamic>?>(e);
    }
  }

  Future<Http.Response<Map<String, dynamic>?>> _put(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        includeBasePath ? basePath(path) : path,
        queryParameters: queryParameters ?? {},
        data: data,
        options: options ?? defaultOptions,
      );
    } on Http.DioError catch (e) {
      return _getDioErrorResponse<Map<String, dynamic>?>(e);
    }
  }

  Future<Http.Response<Map<String, dynamic>?>> _patch(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      return await _dio.patch(
        includeBasePath ? basePath(path) : path,
        queryParameters: queryParameters ?? {},
        data: data,
        options: options ?? defaultOptions,
      );
    } on Http.DioError catch (e) {
      return _getDioErrorResponse<Map<String, dynamic>?>(e);
    }
  }

  Future<Http.Response<List<dynamic>?>> _patchArray(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      return await _dio.patch(
        includeBasePath ? basePath(path) : path,
        queryParameters: queryParameters ?? {},
        data: data,
        options: options ?? defaultOptions,
      );
    } on Http.DioError catch (e) {
      return _getDioErrorResponse<List<dynamic>?>(e);
    }
  }

  Future<Http.Response<Map<String, dynamic>?>> _delete(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        includeBasePath ? basePath(path) : path,
        queryParameters: queryParameters,
        options: options ?? defaultOptions,
      );
    } on Http.DioError catch (e) {
      return _getDioErrorResponse<Map<String, dynamic>?>(e);
    }
  }

  Future<Http.Response<String?>?> _deleteString(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        includeBasePath ? basePath(path) : path,
        queryParameters: queryParameters,
        options: options ?? defaultOptions,
      );
    } on Http.DioError catch (e) {
      return _getDioErrorResponse<String?>(e);
    }
  }

  Http.Response<T?> _getDioErrorResponse<T>(Http.DioError e) {
    if (e.type == Http.DioErrorType.badResponse ||
        e.type == Http.DioErrorType.unknown) throw e;
    return e.response!.mapData((dynamic data) => data as T?);
  }

  // |=====================================================================
  // | Shorthand
  // |=====================================================================

  Future<Http.Response<String?>?> getString(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _getString(
      path,
      includeBasePath: includeBasePath,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Http.Response<Map<String, dynamic>?>?> get(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Http.Response<Map<String, dynamic>>? mockResponse,
    Options? options,
  }) async {
    if (usingMockData) {
      mockResponse
          ?.throwToFailureResponseExceptionWhen((res) => res.statusCode != 200);
      return mockResponse;
    }
    return await _get(
      path,
      includeBasePath: includeBasePath,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Http.Response<List<dynamic>?>?> getArray(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Http.Response<List<dynamic>>? mockResponse,
    Options? options,
  }) async {
    if (usingMockData) {
      mockResponse
          ?.throwToFailureResponseExceptionWhen((res) => res.statusCode != 200);
      return mockResponse;
    }
    return await _getArray(
      path,
      includeBasePath: includeBasePath,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Http.Response<Map<String, dynamic>?>?> post(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Http.Response? mockResponse,
    Options? options,
  }) async {
    if (usingMockData) {
      mockResponse
          ?.throwToFailureResponseExceptionWhen((res) => res.statusCode != 200);
      return mockResponse as FutureOr<Http.Response<Map<String, dynamic>?>?>;
    }
    return await _post(
      path,
      includeBasePath: includeBasePath,
      queryParameters: queryParameters,
      data: data,
      options: options,
    );
  }

  Future<Http.Response<Map<String, dynamic>?>?> put(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Http.Response? mockResponse,
    Options? options,
  }) async {
    if (usingMockData) {
      mockResponse
          ?.throwToFailureResponseExceptionWhen((res) => res.statusCode != 200);
      return mockResponse as FutureOr<Http.Response<Map<String, dynamic>?>?>;
    }
    return await _put(
      path,
      includeBasePath: includeBasePath,
      queryParameters: queryParameters,
      data: data,
      options: options,
    );
  }

  Future<Http.Response<Map<String, dynamic>?>?> patch(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Http.Response? mockResponse,
    Options? options,
  }) async {
    if (usingMockData) {
      mockResponse
          ?.throwToFailureResponseExceptionWhen((res) => res.statusCode != 200);
      return mockResponse as FutureOr<Http.Response<Map<String, dynamic>?>?>;
    }
    return await _patch(
      path,
      includeBasePath: includeBasePath,
      queryParameters: queryParameters,
      data: data,
      options: options,
    );
  }

  Future<Http.Response<List<dynamic>?>> patchArray(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Http.Response? mockResponse,
    Options? options,
  }) async {
    if (usingMockData) {
      mockResponse
          ?.throwToFailureResponseExceptionWhen((res) => res.statusCode != 200);
      return mockResponse as FutureOr<Http.Response<List<dynamic>?>>;
    }
    return await _patchArray(
      path,
      includeBasePath: includeBasePath,
      queryParameters: queryParameters,
      data: data,
      options: options,
    );
  }

  Future<Http.Response<Map<String, dynamic>?>?> delete(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Http.Response? mockResponse,
    Options? options,
  }) async {
    if (usingMockData) {
      mockResponse
          ?.throwToFailureResponseExceptionWhen((res) => res.statusCode != 200);
      return mockResponse as FutureOr<Http.Response<Map<String, dynamic>?>?>;
    }
    return await _delete(
      path,
      includeBasePath: includeBasePath,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Http.Response<String?>?> deleteString(
    String path, {
    bool includeBasePath = true,
    Map<String, dynamic>? queryParameters,
    Http.Response? mockResponse,
    Options? options,
  }) async {
    if (usingMockData) {
      mockResponse
          ?.throwToFailureResponseExceptionWhen((res) => res.statusCode != 200);
      return mockResponse as FutureOr<Http.Response<String?>?>;
    }
    return await _deleteString(
      path,
      includeBasePath: includeBasePath,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<dio.Response<Map<String, dynamic>>> multipartHttpRequest(
    String method,
    String path, {
    http.MultipartFile? multipartFile,
    List<http.MultipartFile>? multipartFileList,
    Map<String, String>? data,
    bool includeBasePath = true,
  }) async {
    try {
      http.MultipartRequest multipartRequest = await _getMultipartRequest(
        method,
        path,
        multipartFile: multipartFile,
        multipartFileList: multipartFileList,
        data: data,
        includeBasePath: includeBasePath,
      );
      var response = await multipartRequest.send();
      final respStr = await response.stream.bytesToString();
      return dio.Response<Map<String, dynamic>>(
        data: jsonDecode(respStr),
        statusCode: response.statusCode,
        requestOptions: RequestOptions(path: ''),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response<List<dynamic>>> multipartHttpRequestArray(
    String method,
    String path, {
    http.MultipartFile? multipartFile,
    List<http.MultipartFile>? multipartFileList,
    Map<String, String>? data,
    bool includeBasePath = true,
  }) async {
    try {
      http.MultipartRequest multipartRequest = await _getMultipartRequest(
        method,
        path,
        multipartFile: multipartFile,
        multipartFileList: multipartFileList,
        data: data,
        includeBasePath: includeBasePath,
      );
      var response = await multipartRequest.send();
      final respStr = await response.stream.bytesToString();
      return dio.Response<List<dynamic>>(
        data: jsonDecode(respStr),
        statusCode: response.statusCode,
        requestOptions: RequestOptions(path: ''),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<http.MultipartRequest> _getMultipartRequest(
    String method,
    String path, {
    http.MultipartFile? multipartFile,
    List<http.MultipartFile>? multipartFileList,
    Map<String, String>? data,
    bool includeBasePath = true,
  }) async {
    final token = await userPreference.getToken();
    Map<String, String> headers = <String, String>{
      'Authorization': 'Bearer $token'
    };
    var uri = Uri.parse(includeBasePath ? basePath(path) : path);
    var request = http.MultipartRequest(method, uri)..headers.addAll(headers);
    if (multipartFile != null) {
      request.files.add(multipartFile);
    } else if (multipartFileList.isNotBlank) {
      request.files.addAll(multipartFileList!);
    }
    if (data != null) {
      request.fields.addAll(data);
    }
    return request;
  }
}

extension MockBaseService on BaseService {
  Future<Http.Response<Map<String, dynamic>>> mockResponseFromJsonFile(
    String mockDataFilename, [
    Http.Response? baseResponse,
  ]) async {
    if (usingMockData && mockDataFilename.isEmpty) {
      throw Exception(
          'base_service usingMockData but no mock data filename sent');
    }
    var res = baseResponse ??
        Http.Response<Map<String, dynamic>>(
            statusCode: 200, requestOptions: Http.RequestOptions(path: ''));
    res.data = await _mockDataLoader.load(mockDataFilename);
    return res as FutureOr<Http.Response<Map<String, dynamic>>>;
  }

  Future<Http.Response<List<dynamic>>> mockResponseArrayFromJsonFile(
    String mockDataFilename, [
    Http.Response? baseResponse,
  ]) async {
    if (usingMockData && mockDataFilename.isEmpty) {
      throw Exception(
          'base_service usingMockData but no mock data filename sent');
    }
    var res = baseResponse ??
        Http.Response<List<dynamic>>(
            statusCode: 200, requestOptions: Http.RequestOptions(path: ''));
    res.data = await _mockDataLoader.loadArray(mockDataFilename);
    return res as FutureOr<Http.Response<List<dynamic>>>;
  }
}

extension ExtendResponse<I> on Http.Response<I?> {
  Http.Response<O> mapData<O>(O Function(I? data) mapper) {
    return Http.Response<O>(
      data: mapper(data),
      headers: headers,
      requestOptions: requestOptions,
      isRedirect: isRedirect,
      statusCode: statusCode,
      statusMessage: statusMessage,
      redirects: redirects,
      extra: extra,
    );
  }
}
