import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/model/response_dto.dart';
import 'package:flutter_blog/data/model/user.dart';

void main() async {
  await login_test();
}

Future<void> login_test() async {
  // given
  var requestBody = {"username": "ssar", "password": "12345"};

  // when
  // 1. http 응답 (header, body)
  Response response = await dio.post("/login", data: requestBody);

  // then
  // 2. 검증
  var responseBody = response.data;
  print(responseBody);

  // 3. 파싱
  ResponseDTO responseDTO = ResponseDTO.fromJson(responseBody);
  print(responseDTO.success);
  print(responseDTO.errorMessage);
  print(responseDTO.status);
  print(responseDTO.response);

  if (responseDTO.success) {
    User user = User.fromJson(responseDTO.response);
    responseDTO.response = user;

    // 4. header 정보
    String accessToken = response.headers["Authorization"]!.first;
    String refreshToken = response.headers["X-Refresh-Token"]!.first;

    print(accessToken);
    print(refreshToken);
  }
}
