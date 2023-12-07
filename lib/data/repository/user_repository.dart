import 'package:dio/dio.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/data/model/response_dto.dart';
import 'package:flutter_blog/data/model/user.dart';

class UserRepository {
  Future<(ResponseDTO, String, String)> fetchLogin(
      String username, String password) async {
    // 1. map 변환
    var requestBody = {"username": username, "password": password};

    // 2. 통신
    Response response = await dio.post("/login", data: requestBody);

    // 3. 파싱
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    if (!responseDTO.success) {
      return (responseDTO, "", "");
    }

    User user = User.fromJson(responseDTO.response);
    responseDTO.response = user;

    String accessToken = response.headers["Authorization"]!.first;
    String refreshToken = response.headers["X-Refresh-Token"]!.first;

    // 4. 리턴 (responseDTO)
    return (responseDTO, accessToken, refreshToken);
  }
}
