import 'package:birds/domain/entities/online.entity.dart';
import 'package:birds/domain/repositories/ws_repository.dart';
import 'package:birds/presentation/blocs/ws_cubit.dart';
import 'package:birds/presentation/sceens/video/online/online_bloc.dart';
import 'package:birds/presentation/sceens/video/online/online_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@immutable
class OnlineView extends StatelessWidget {
  const OnlineView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnlineBLoC(
        wsCubit: context.read<WsCubit>(),
        wsRepository: GetIt.I<WsRepository>(),
      ),
      child: BlocBuilder<OnlineBLoC, OnlineState>(
        builder: (context, state) => switch (state) {
          SuccessOnlineState(:List<OnlineEntity> list) => OnlineList(list: list.reversed.toList()),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}
