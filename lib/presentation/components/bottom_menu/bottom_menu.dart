import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/blocs/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    if (index == 0) {
      BlocProvider.of<MainRouterBLoC>(context).add(const MainRouterEvent.video());
    } else {
      BlocProvider.of<MainRouterBLoC>(context).add(const MainRouterEvent.about());
    }
    setState(() {
      _current = index;
    });
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
      ],
    );
  }
}
