import 'dart:async';

import 'package:birds/domain/datasources/config_source.dart';
import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/blocs/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';

@immutable
class BottomMenu extends StatefulWidget {
  const BottomMenu({super.key});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _current = 0;

  @override
  void initState() {
    super.initState();
    switch (context.read<MainRouterBLoC>().state) {
      case VideoMainRouterState():
        _current = 0;
        break;
      case SettingsMainRouterState():
        _current = 1;
        break;
      case AboutMainRouterState():
        _current = 2;
        break;
    }
    // _current = BlocProvider.of<MainRouterBLoC>(context).state is VideoMainRouterState ? 0 : 1;
  }

  void _handleChange(int index) {
    switch (index) {
      case 3:
        unawaited(launchUrlString(GetIt.I<ConfigSource>().donateUrl));
        break;
      case 2:
        context.read<MainRouterBLoC>().add(const MainRouterEvent.about());
        setState(() {
          _current = index;
        });
        break;
      case 1:
        context.read<MainRouterBLoC>().add(const MainRouterEvent.settings());
        setState(() {
          _current = index;
        });
        break;
      case 0:
      default:
        context.read<MainRouterBLoC>().add(const MainRouterEvent.video());
        setState(() {
          _current = index;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _handleChange,
      currentIndex: _current,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
      unselectedItemColor: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
      selectedFontSize: 12,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/png/translation.png',
            semanticLabel: 'Translation',
            width: 24,
            height: 24,
            color: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
          ),
          label: S.of(context).nav_video,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/png/settings.png',
            semanticLabel: 'Settings',
            width: 24,
            height: 24,
            color: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
          ),
          label: S.of(context).nav_settings,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/png/about.png',
            semanticLabel: 'About',
            width: 24,
            height: 24,
            color: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
          ),
          label: S.of(context).nav_about,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/png/donate.png',
            semanticLabel: 'Donate',
            width: 24,
            height: 24,
            // color: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
          ),
          label: S.of(context).nav_donate,
        ),
      ],
    );
  }
}
