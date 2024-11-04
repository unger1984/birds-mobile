import 'dart:async';

import 'package:birds/generated/l10n.dart';
import 'package:birds/presentation/components/bottom_menu/bottom_menu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

@immutable
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  void _handleDonate() {
    unawaited(launchUrlString('https://www.tbank.ru/cf/5mfwO0VNFF9'));
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      S.of(context).about_p1,
      S.of(context).about_p2,
      S.of(context).about_p3,
      S.of(context).about_p4,
      S.of(context).about_p5,
      S.of(context).about_p6,
      S.of(context).about_p7,
      S.of(context).about_p8,
      S.of(context).about_p9,
      S.of(context).about_p10,
      S.of(context).about_p11,
    ];

    final pairs = List.generate(
      list.length ~/ 2 + (list.length % 2 > 0 ? 1 : 0),
      (index) => list.getRange(index * 2, index * 2 + 2 > list.length ? list.length : index * 2 + 2).toList(),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).nav_about)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: OrientationBuilder(
            builder: (context, orientation) => switch (orientation) {
              Orientation.portrait => ListView(
                  children: [
                    ...list.map((element) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(element, textAlign: TextAlign.justify),
                        )),
                    ElevatedButton(
                      onPressed: _handleDonate,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffF08130)),
                      child: Text(S.of(context).donate),
                    ),
                  ],
                ),
              Orientation.landscape => ListView(
                  children: [
                    ...pairs.map((element) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  element.first,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  element.last,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ],
                          ),
                        )),
                    ElevatedButton(
                      onPressed: _handleDonate,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffF08130)),
                      child: Text(S.of(context).donate),
                    ),
                  ],
                ),
            },
          ),
        ),
        bottomNavigationBar: const BottomMenu(),
      ),
    );
  }
}
