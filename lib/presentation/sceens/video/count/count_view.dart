import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/sceens/video/count/count_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CountView extends StatelessWidget {
  const CountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountBLoC, CountState>(
      buildWhen: (prev, next) =>
          prev is TotalCountState && next is TotalCountState ? prev.total != next.total : prev != next,
      builder: (context, state) => switch (state) {
        TotalCountState(:int total) => Text(S.of(context).online(total)),
        _ => const SizedBox(height: 20),
      },
    );
  }
}
