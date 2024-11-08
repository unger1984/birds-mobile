// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `BirdsFeeder`
  String get title {
    return Intl.message(
      'BirdsFeeder',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Трансляция`
  String get nav_video {
    return Intl.message(
      'Трансляция',
      name: 'nav_video',
      desc: '',
      args: [],
    );
  }

  /// `О проекте`
  String get nav_about {
    return Intl.message(
      'О проекте',
      name: 'nav_about',
      desc: '',
      args: [],
    );
  }

  /// `Сейчас смотрят {total}`
  String online(Object total) {
    return Intl.message(
      'Сейчас смотрят $total',
      name: 'online',
      desc: '',
      args: [total],
    );
  }

  /// `Войти с Google`
  String get sign_in {
    return Intl.message(
      'Войти с Google',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `На семечки`
  String get donate {
    return Intl.message(
      'На семечки',
      name: 'donate',
      desc: '',
      args: [],
    );
  }

  /// `Уже пару лет, как подкармливаю птичек на даче. Работаю я из дома, и рабочий стол стоит прямо перед окном, за которым висит кормушка. Каждое утро насыпаю новую порцию семечек, а потом наблюдаю за разными птицами, слетающимися на пир.`
  String get about_p1 {
    return Intl.message(
      'Уже пару лет, как подкармливаю птичек на даче. Работаю я из дома, и рабочий стол стоит прямо перед окном, за которым висит кормушка. Каждое утро насыпаю новую порцию семечек, а потом наблюдаю за разными птицами, слетающимися на пир.',
      name: 'about_p1',
      desc: '',
      args: [],
    );
  }

  /// `Оказывается, пернатый мир средней полосы России довольно богат. Очень часто приходилось пользоваться помощью Google чтобы определить, что за птичка пожаловала на обед.`
  String get about_p2 {
    return Intl.message(
      'Оказывается, пернатый мир средней полосы России довольно богат. Очень часто приходилось пользоваться помощью Google чтобы определить, что за птичка пожаловала на обед.',
      name: 'about_p2',
      desc: '',
      args: [],
    );
  }

  /// `Чаще всего, конечно, прилетают обычные синички. Эта птичка очень осторожная. Сначала сядет на ветку растущей рядом яблони и осмотрит округу. Потом быстро подлетит, схватит семечку, и обратно на ветку, там уже ее шелушит.`
  String get about_p3 {
    return Intl.message(
      'Чаще всего, конечно, прилетают обычные синички. Эта птичка очень осторожная. Сначала сядет на ветку растущей рядом яблони и осмотрит округу. Потом быстро подлетит, схватит семечку, и обратно на ветку, там уже ее шелушит.',
      name: 'about_p3',
      desc: '',
      args: [],
    );
  }

  /// `Еще частые гости – воробьи. Эти на порядок наглее. Прилетают всегда стайкой, едят сидя прямо в кормушке. Те, что посильнее и понаглее еще и отгоняют своих товарищей. Забавно смотреть на их противоборство.`
  String get about_p4 {
    return Intl.message(
      'Еще частые гости – воробьи. Эти на порядок наглее. Прилетают всегда стайкой, едят сидя прямо в кормушке. Те, что посильнее и понаглее еще и отгоняют своих товарищей. Забавно смотреть на их противоборство.',
      name: 'about_p4',
      desc: '',
      args: [],
    );
  }

  /// `Зимой часто кормушку навещают снегири. Оказывается, у самки снегиря брюшко совсем даже не красное, а просто серое. Я по первости долго не мог понять, что за странная птица, вроде похожа на снегиря, но не красная!`
  String get about_p5 {
    return Intl.message(
      'Зимой часто кормушку навещают снегири. Оказывается, у самки снегиря брюшко совсем даже не красное, а просто серое. Я по первости долго не мог понять, что за странная птица, вроде похожа на снегиря, но не красная!',
      name: 'about_p5',
      desc: '',
      args: [],
    );
  }

  /// `Более редкие гости, которых видел – малиновки, лесные канарейки, дрозды, соловьи. Пару раз видел дубоноса. Прошлой зимой часто прилетали две куропатки, они на кормушку не садились, «паслись» в снегу под ней.`
  String get about_p6 {
    return Intl.message(
      'Более редкие гости, которых видел – малиновки, лесные канарейки, дрозды, соловьи. Пару раз видел дубоноса. Прошлой зимой часто прилетали две куропатки, они на кормушку не садились, «паслись» в снегу под ней.',
      name: 'about_p6',
      desc: '',
      args: [],
    );
  }

  /// `Особенной пикантности ситуации добавляет моя домашняя кошка. Очень уж любит она охотиться на всякую живность. Когда она дома, сядет рядом перед окном и с азартом наблюдает за птичками. Даже «щебетать» пытается. Потом просится на улицу, и тогда птицам приходится быть в двойне осторожнее. Несмотря на совсем демаскирующий цвет и колокольчик, кошка иногда умудряется поймать какого-нибудь зазевавшегося пернатого.`
  String get about_p7 {
    return Intl.message(
      'Особенной пикантности ситуации добавляет моя домашняя кошка. Очень уж любит она охотиться на всякую живность. Когда она дома, сядет рядом перед окном и с азартом наблюдает за птичками. Даже «щебетать» пытается. Потом просится на улицу, и тогда птицам приходится быть в двойне осторожнее. Несмотря на совсем демаскирующий цвет и колокольчик, кошка иногда умудряется поймать какого-нибудь зазевавшегося пернатого.',
      name: 'about_p7',
      desc: '',
      args: [],
    );
  }

  /// `Во общем, под окном у меня разворачивается интересное и порой завораживающее кино, с природными актерами. Вот я и подумал, а чего это я только один на все это смотрю, надо поделиться с миром прекрасным зрелищем. Век высоких технологий на дворе как никак. Решил поставить камеру и организовать эту трансляцию.`
  String get about_p8 {
    return Intl.message(
      'Во общем, под окном у меня разворачивается интересное и порой завораживающее кино, с природными актерами. Вот я и подумал, а чего это я только один на все это смотрю, надо поделиться с миром прекрасным зрелищем. Век высоких технологий на дворе как никак. Решил поставить камеру и организовать эту трансляцию.',
      name: 'about_p8',
      desc: '',
      args: [],
    );
  }

  /// `Тут можно понаблюдать за пернатыми вместе со мной, обсудить увиденное в чате и подкинуть малую копеечку на корм птичкам. Проект полностью некоммерческий, платных услуг не предоставляет. Но я не откажусь от пожертвований, которые пойдут на корм пернатым и развитее проекта. Есть мысли поставить еще несколько камер, или даже организовать кормушку в более недоступном месте. `
  String get about_p9 {
    return Intl.message(
      'Тут можно понаблюдать за пернатыми вместе со мной, обсудить увиденное в чате и подкинуть малую копеечку на корм птичкам. Проект полностью некоммерческий, платных услуг не предоставляет. Но я не откажусь от пожертвований, которые пойдут на корм пернатым и развитее проекта. Есть мысли поставить еще несколько камер, или даже организовать кормушку в более недоступном месте. ',
      name: 'about_p9',
      desc: '',
      args: [],
    );
  }

  /// `Корм птицам я насыпаю обычно утром. Ближе к концу осени, зимой и в начале весны стараюсь каждый день. Летом пореже – птицам хватает естественного корма, они становятся редкими гостями на кормушке и не успевают съедать все. Зимой же корм съедают довольно быстро – уже после обеда кормушка почти пустая.`
  String get about_p10 {
    return Intl.message(
      'Корм птицам я насыпаю обычно утром. Ближе к концу осени, зимой и в начале весны стараюсь каждый день. Летом пореже – птицам хватает естественного корма, они становятся редкими гостями на кормушке и не успевают съедать все. Зимой же корм съедают довольно быстро – уже после обеда кормушка почти пустая.',
      name: 'about_p10',
      desc: '',
      args: [],
    );
  }

  /// `Буду рад любым вашим предложениям и замечаниям. Оставляйте комментарии в чате трансляции, я их обязательно прочитаю!`
  String get about_p11 {
    return Intl.message(
      'Буду рад любым вашим предложениям и замечаниям. Оставляйте комментарии в чате трансляции, я их обязательно прочитаю!',
      name: 'about_p11',
      desc: '',
      args: [],
    );
  }

  /// `У данного проекта есть сайт, https://birds.unger1984.pro/ , Подробнее обо мне и остальных проектах можно узнать на GitHub https://github.com/unger1984/`
  String get about_p12 {
    return Intl.message(
      'У данного проекта есть сайт, https://birds.unger1984.pro/ , Подробнее обо мне и остальных проектах можно узнать на GitHub https://github.com/unger1984/',
      name: 'about_p12',
      desc: '',
      args: [],
    );
  }

  /// `Не удалось создать изображение`
  String get screenshot_error {
    return Intl.message(
      'Не удалось создать изображение',
      name: 'screenshot_error',
      desc: '',
      args: [],
    );
  }

  /// `Изображение сохранено в галерее`
  String get screenshot_success {
    return Intl.message(
      'Изображение сохранено в галерее',
      name: 'screenshot_success',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
