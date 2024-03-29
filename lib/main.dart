import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/view/login/login_view.dart';
import 'core/getStorageCacheHelper/get_storage_cache_helper.dart';
import 'firebase_options.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_cubit.dart';

import 'core/blocObserver/bloc_observer.dart';
import 'core/router/router.dart';
import 'view/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //===============================================================
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Widget? home;
  FirebaseAuth.instance.userChanges().listen((user) {
    if (user == null) {
      home = const LoginView();
    } else {
      home = const HomeView();
    }
    home ??= const LoginView();
  });
  //===============================================================
  await EasyLocalization.ensureInitialized();
  //===============================================================
  await CacheHelper.init();
  await CacheHelper.getTheme ?? await CacheHelper.cacheTheme(value: true);
  bool? isDark = await CacheHelper.getTheme;
  //===============================================================
  BlocOverrides.runZoned(
    () {
      runApp(EasyLocalization(
        path: 'assets/translation',
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp(isDark: isDark!, home: home!),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.isDark, required this.home}) : super(key: key);
  final bool? isDark;
  final Widget home;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit()..changeTheme(themeModeFromCache: isDark)),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Zoom Clone',
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              onGenerateRoute: onGenerateRoute,
              theme: lightTheme(context),
              darkTheme: darkTheme(context),
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              home: home,
            );
          },
        ));
  }
}
