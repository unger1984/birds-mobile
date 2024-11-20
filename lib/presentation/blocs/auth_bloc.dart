import 'dart:async';

import 'package:birds/domain/datasources/settings_source.dart';
import 'package:birds/domain/entities/user_entity.dart';
import 'package:birds/domain/entities/ws_data_auth_entity.dart';
import 'package:birds/domain/entities/ws_entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
  const factory AuthEvent.clear() = _ClearAuthEvent;
  const factory AuthEvent.auth(WsDataAuthEntity data) = _UserAuthEvent;
}

final class _ClearAuthEvent extends AuthEvent {
  const _ClearAuthEvent();
}

final class _UserAuthEvent extends AuthEvent {
  final WsDataAuthEntity data;
  const _UserAuthEvent(this.data);
}

sealed class AuthState {
  const AuthState();
  const factory AuthState.off() = OffAuthState;
  const factory AuthState.on(UserEntity user) = OnAuthState;
}

final class OffAuthState extends AuthState {
  const OffAuthState();
}

final class OnAuthState extends AuthState {
  final UserEntity user;
  const OnAuthState(this.user);
}

class AuthBLoC extends Bloc<AuthEvent, AuthState> {
  final WsRepository _wsRepository;
  final SettingsSource _settingsSource;
  // В конструкторе
  // ignore: avoid-late-keyword
  late final StreamSubscription<WsCubitState> _streamSubscription;

  AuthBLoC({required WsCubit wsCubit, required WsRepository wsRepository, required SettingsSource settingsSource})
      : _wsRepository = wsRepository,
        _settingsSource = settingsSource,
        super(const AuthState.off()) {
    on<AuthEvent>(
      (event, emitter) => switch (event) {
        _ClearAuthEvent() => _clear(emitter),
        _UserAuthEvent(:WsDataAuthEntity data) => _auth(data, emitter),
      },
    );
    _streamSubscription = wsCubit.stream.listen(_wsListener);

    final token = _settingsSource.getString("token");
    if (token != null) {
      _wsRepository.send(WsEntity(cmd: WsCmd.auth, data: WsDataAuthEntity(token: token)));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();

    return super.close();
  }

  void _wsListener(WsCubitState state) {
    if (state is! MessageWsCubitState || state.message.cmd != WsCmd.auth) return;
    final data = state.message.data as WsDataAuthEntity;
    add(AuthEvent.auth(data));
  }

  void _clear(Emitter<AuthState> emitter) {
    emitter(const AuthState.off());
  }

  void _auth(WsDataAuthEntity data, Emitter<AuthState> emitter) {
    final user = data.user;
    if (user == null) {
      emitter(const AuthState.off());
    } else {
      unawaited(_settingsSource.setString('token', data.token));
      emitter(AuthState.on(user));
    }
  }
}
