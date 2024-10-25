import 'dart:async';
import 'dart:io';

import 'package:birds/domain/app_bloc_observer.dart';
import 'package:birds/presentation/app.dart';
import 'package:birds/utils/logging.dart';
import 'package:birds/utils/service_locator.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:media_kit/media_kit.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

abstract final class Main {
  static final log = Logger('Main');

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting();

    MediaKit.ensureInitialized();

    WakelockPlus.enable();
    if (Platform.isAndroid) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }

    Logging.setup();
    await ServiceLocator.setup();

    Bloc.observer = AppBlocObserver.instance();
    Bloc.transformer = bloc_concurrency.sequential<Object?>();

    runApp(const App());
  }
}

void main() {
  runZonedGuarded<void>(
    () => unawaited(Main.init()),
    (err, stackTrace) => Main.log.shout('Unhandled exception', err, stackTrace),
  );
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   // Create a [Player] to control playback.
//   final _player = Player(configuration: PlayerConfiguration(muted: true));
//   // Create a [VideoController] to handle video output from [Player].
//   late final _controller = VideoController(_player);
//
//   final _media = Media(kIsWeb
//       ? 'https://birds.unger1984.pro:8888/mystream/index.m3u8'
//       : 'rtsps://birds.unger1984.pro:8322/mystream');
//
//   bool _preloader = true;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     unawaited(_init());
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _player.dispose();
//     super.dispose();
//   }
//
//   Future<void> _init() async {
//     // if (!kIsWeb) {
//     //   if (Platform.isAndroid) {
//     //     if (await Permission.videos.isDenied ||
//     //         await Permission.videos.isPermanentlyDenied) {
//     //       final state = await Permission.videos.request();
//     //       if (!state.isGranted) {
//     //         await SystemNavigator.pop();
//     //       }
//     //     }
//     //   }
//     // }
//     // await player
//     //     .open(Media('https://birds.unger1984.pro:8888/mystream/index.m3u8'));
//     // await player.open(Media('rtsp://birds.unger1984.pro:8554/mystream'));
//
//     _player.stream.buffering.listen((buff) {
//       print('BUFF $buff');
//       setState(() {
//         _preloader = buff;
//         if (buff) {
//           // ограничим
//           _timer?.cancel();
//           _timer = Timer(Duration(seconds: 10), _reload);
//         } else {
//           _timer?.cancel();
//         }
//       });
//     });
//
//     // player.stream.track.listen((track) {
//     //   print('TRACK $track');
//     // });
//     //
//     // player.stream.error.listen((String error) {
//     //   print('ERROR $error');
//     //   setState(() {
//     //     _error = true;
//     //   });
//     //   Future.delayed(Duration(seconds: 2), () => player.open(media));
//     // });
//     //
//     // player.stream.completed.listen((completed) {
//     //   print('COMPLETED $completed');
//     // });
//     //
//     _player.stream.playing.listen(
//           (playing) {
//         print('PLAY $playing');
//         if (!playing) {
//           _player.play();
//         }
//         // if (!playing) {
//         //   player.play();
//         // }
//       },
//     );
//
//     // _controller.player.setPlaylistMode(PlaylistMode.loop);
//
//     await _player.open(_media);
//     _player.setVolume(0);
//     // Future.delayed(const Duration(seconds: 1), player.play);
//
//     // player.stream.
//
//     if (kIsWeb) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         // mutes the video
//         _player.setVolume(0);
//         // Plays the video once the widget is build and loaded.
//         _player.play();
//       });
//     }
//   }
//
//   Future<void> _reload() async {
//     print('RELOAD');
//     await _player.open(_media);
//     await _player.setVolume(0);
//     if (!_player.state.playing) await _player.play();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.width * 9.0 / 16.0,
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Video(
//               controller: _controller,
//               controls: null,
//             ),
//             if (_preloader)
//               Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.pink,
//                   )),
//           ],
//         ),
//       ),
//     );
//   }
// }
