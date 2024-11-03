import 'dart:async';

import 'package:birds/domain/datasources/config_source.dart';
import 'package:birds/domain/entities/ws_data_sign_in_entity.dart';
import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';

@immutable
class ChatFormView extends StatefulWidget {
  const ChatFormView({super.key});

  @override
  State<ChatFormView> createState() => _ChatFormViewState();
}

class _ChatFormViewState extends State<ChatFormView> {
  final _config = GetIt.I<ConfigSource>();
  final _wscoket = GetIt.I<WsRepository>();
  final _appAuth = const FlutterAppAuth();

  Future<void> _handleSign() async {
    try {
      final res = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          '${_config.googleAuthClientId}.apps.googleusercontent.com',
          'com.googleusercontent.apps.${_config.googleAuthClientId}:/',
          discoveryUrl: 'https://accounts.google.com/.well-known/openid-configuration',
          issuer: 'https://accounts.google.com',
          scopes: ['openid', 'email', 'profile'],
        ),
      );
      final token = res.accessToken;
      if (token != null) {
        _wscoket.send(WsEntity(cmd: WsCmd.signIn, data: WsDataSignInEntity(access_token: token)));
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }

  void _handleDonate() {
    unawaited(launchUrlString('https://www.tbank.ru/cf/5mfwO0VNFF9'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _handleDonate,
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffF08130)),
          child: Text(S.of(context).donate),
        ),
        ElevatedButton(onPressed: () => unawaited(_handleSign()), child: Text(S.of(context).sign_in)),
      ],
    );
  }
}
