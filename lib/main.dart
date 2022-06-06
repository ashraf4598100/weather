import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:weather/injection_container.dart' as di;

import 'features/app/presentation/pages/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));

  // before the runApp() call

  await di.init();

  // Than we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

