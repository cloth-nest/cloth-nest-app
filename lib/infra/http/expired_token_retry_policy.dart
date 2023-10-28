import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/app/utils/singleton/time_expire/time_expire_singleton.dart';
import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/auto_login/auto_login_params.dart';
import 'package:ecommerce/domain/usecases/authentication/auto_login/fetch_auto_login.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/fetch_logout.dart';
import 'package:ecommerce/domain/usecases/token/fetch_token.dart';
import 'package:ecommerce/domain/usecases/token/save_token.dart';
import 'package:ecommerce/presentation/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';

enum SessionUpdateStatus { outdated, updated, deleted }

class ExpiredTokenRetryPolicy extends RetryPolicy {
  final FetchAutoLogin _fetchAutoLogin;
  final FetchToken _fetchToken;
  final SaveToken _saveToken;
  final FetchLogout _fetchLogout;

  ExpiredTokenRetryPolicy({
    required FetchAutoLogin fetchAutoLogin,
    required FetchToken fetchToken,
    required SaveToken saveToken,
    required FetchLogout fetchLogout,
  })  : _fetchAutoLogin = fetchAutoLogin,
        _fetchLogout = fetchLogout,
        _fetchToken = fetchToken,
        _saveToken = saveToken;

  @override
  int get maxRetryAttempts => 1;

  /*
  // Nếu bị lỗi 401 thì khi nào cho phép Retry?
  // 1. API đầu tiên bị 401 sẽ kiểm tra để call Auto login
  // 2. Nếu thành công thì update lại token và return true để retry
  // 3. Nếu thất bại thì return false, nếu throw exception thì bên ngoài có thấy không
   */

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401) {
      final json = jsonDecode((response as Response).body);
      final error = json['error'];
      if (error['code'] == "D0001") {
        return await lock.synchronized(() async {
          return await handleRefreshToken();
        });
      }
    } else if (response.statusCode == 200 || response.statusCode == 204) {
      return await lock.synchronized(() async {
        return await handleExpireDateApi();
      });
    }
    return false;
  }

  handleRefreshToken() async {
    try {
      final TokenEntity? tokenEntity =
          await _fetchToken.call(key: uniqueUserTokenKey);

      debugPrint('isRemember: ${tokenEntity?.isRemember}');
      if (tokenEntity?.isRemember == false) {
        await _logout();
        return false;
      }

      TokenEntity newTokenEnity = await _fetchAutoLogin.call(
        params: AutoLoginParams(
          refreshToken: tokenEntity?.refreshToken ?? '',
        ),
      );

      newTokenEnity =
          newTokenEnity.copyWith(isRemember: tokenEntity?.isRemember);

      await _saveToken.call(
        tokenEntity: newTokenEnity,
      );

      return true;
    } catch (e) {
      debugPrint('###error:${e.toString()}');
      await _logout();
      return false;
    }
  }

  _logout() async {
    await _fetchLogout.call();
    final context = MainGlobalKey.key.currentContext;

    if (context != null) {
      Beamer.of(context, root: true).beamToReplacementNamed('/login');
    }
  }

  handleExpireDateApi() {
    final timeExpire = TimeExpireSingleton().newExpireTime;
    final now = DateTime.now();
    if (timeExpire != null && timeExpire.isAfter(now)) {
      TimeExpireSingleton().updateNewTimeExpire(
          now.add(const Duration(minutes: 65)).millisecondsSinceEpoch);

      return false;
    }

    return false;
  }
}
