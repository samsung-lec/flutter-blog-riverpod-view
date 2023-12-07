import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/data/model/user.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// 1. 창고 관리자
final sessionProvider = Provider<SessionStore>((ref) {
  return SessionStore();
});

// 2. 창고
class SessionStore extends SessionUser {
  final mContext = navigatorKey.currentContext;

  Future<void> login(String username, String password) async {
    Logger().d("SessionStore : login()");

    var (responseDTO, accessToken, refreshToken) =
        await UserRepository().fetchLogin(username, password);

    if (responseDTO.success) {
      // 1. 디바이스에 토큰 저장
      await secureStorage.write(key: "accessToken", value: accessToken);
      await secureStorage.write(key: "refreshToken", value: refreshToken);

      // 2. 로그인 세션 저장
      user = responseDTO.response;
      this.accessToken = accessToken;
      this.refreshToken = refreshToken;

      // 3. 페이지 이동
      Navigator.pushNamed(mContext!, Move.postListPage);
    } else {
      ScaffoldMessenger.of(mContext!)
          .showSnackBar(SnackBar(content: Text("${responseDTO.errorMessage}")));
    }
  }

  Future<void> logout() async {
    user = null;
    this.accessToken = null;
    this.refreshToken = null;
    await secureStorage.delete(key: "accessToken");
    await secureStorage.delete(key: "refreshToken");
  }
}

// 3. 창고 데이터
class SessionUser {
  User? user;
  String? accessToken;
  String? refreshToken;
  bool isLogin;

  SessionUser(
      {this.user, this.accessToken, this.refreshToken, this.isLogin = false});
}
