import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:desiroo/core/app_config.dart';
import 'package:desiroo/core/errors/failure.dart';
import 'package:dio/dio.dart';

class HttpClient {
  final Dio _dio = Dio();

  HttpClient() {
    _dio
      ..options.baseUrl = AppConfig.shared.baseUrl
      ..options.connectTimeout = const Duration(seconds: 5)
      ..options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<Either<Failure, dynamic>> get(String url) async {
    try {
      Response response = await _dio.get<String>(url);
      return getResult(response);
    } catch (error) {
      Failure failure = await handleDioError(error);
      return Left(failure);
    }
  }

  Future<Either<Failure, dynamic>> getWithQuery(
      String url,
      Map<String, dynamic> query,
      ) async {
    try {
      Response response = await _dio.get<String>(
        url,
        queryParameters: query,
      );
      return getResult(response);
    } catch (error) {
      Failure failure = await handleDioError(error);
      return Left(failure);
    }
  }

  Future<Either<Failure, dynamic>> post(
      String url,
      Map<String, dynamic> query,
      ) async {
    try {
      Response response = await _dio.post<String>(url);
      return getResult(response);
    } catch (error) {
      Failure failure = await handleDioError(error);
      return Left(failure);
    }
  }

  Future<Either<Failure, dynamic>> postWithBody(
    String url,
    dynamic body,
  ) async {
    try {
      Response response = await _dio.post<String>(url, data: body);
      return getResult(response);
    } catch (error) {
      Failure failure = await handleDioError(error);
      return Left(failure);
    }
  }

  Future<Either<Failure, dynamic>> getResult<String>(
    Response<dynamic> response,
  ) async {
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      if (response.data != null && response.data != '') {
        return Right(json.decode(response.data));
      }
      return const Right('');
    } else if (response.statusCode! >= 400 && response.statusCode! <= 499) {
      return Left(ClientFailure());
    } else if (response.statusCode! >= 500 && response.statusCode! <= 599) {
      return Left(ServerFailure(data: response.data));
    }
    return Left(UnexpectedFailure());
  }

  Future<Failure> handleDioError(error) async {
    if (error.error is SocketException ||
        error.type == DioExceptionType.connectionTimeout) {
      return InternetConnectionFailure();
    }
    return UnexpectedFailure();
  }
}
