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
    _current = BlocProvider.of<MainRouterBLoC>(context).state is VideoMainRouterState ? 0 : 1;
  }

  void _handleChange(int index) {
    switch (index) {
      case 2:
        unawaited(launchUrlString(GetIt.I<ConfigSource>().donateUrl));
        break;
      case 1:
        BlocProvider.of<MainRouterBLoC>(context).add(const MainRouterEvent.about());
        setState(() {
          _current = index;
        });
        break;
      case 0:
      default:
        BlocProvider.of<MainRouterBLoC>(context).add(const MainRouterEvent.video());
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
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/png/translation.png',
            semanticLabel: 'Translation',
            width: 32,
            height: 32,
            color: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
          ),
          label: S.of(context).nav_video,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/png/about.png',
            semanticLabel: 'About',
            width: 32,
            height: 32,
            color: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
          ),
          label: S.of(context).nav_about,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/png/donate.png',
            semanticLabel: 'Donate',
            width: 32,
            height: 32,
            // color: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? Colors.white : Colors.black,
          ),
          label: S.of(context).nav_donate,
        ),
      ],
    );
  }
}
