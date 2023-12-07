import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: "http://192.168.0.95:8080",
    contentType: "application/json; charset=utf-8",
    validateStatus: (status) => true,
  ),
);

final secureStorage = FlutterSecureStorage();
