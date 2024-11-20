import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/components/bottom_menu/bottom_menu.dart';
import 'package:flutter/material.dart';

@immutable
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).nav_settings)),
        bottomNavigationBar: const BottomMenu(),
      ),
    );
  }
}
