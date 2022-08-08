import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgs/data/network/network_util.dart';
import 'package:tgs/generated/l10n.dart';
import 'package:tgs/internal/app_config.dart';
import 'package:tgs/internal/app_controller.dart';
import 'package:tgs/internal/manager/locale_manager.dart';
import 'package:tgs/internal/router/app_router.dart';
import 'package:tgs/internal/widgets/dialog.dart';
import 'package:tgs/internal/widgets/error_page.dart';
import 'package:tgs/internal/widgets/loading.dart';

Future<void> initMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.build(Environment.dev);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NetworkingUtil networkingUtil = NetworkingUtil();
  final _messageKey = GlobalKey<ScaffoldMessengerState>();
  StreamSubscription? networkSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    appController.dispose();
    networkSubscription?.cancel();
    networkingUtil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => postBuild(context));
    return Consumer(builder: (context, ref, __) {
      final localeManager = ref.watch(localeProvider);
      final lAppRouter = ref.watch(myAppRouter);

      appController.initRouter(lAppRouter);

      return MaterialApp.router(
        locale: localeManager.locale ?? const Locale('ja'),
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: _messageKey,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        builder: (context, child) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return ErrorPage(error: errorDetails.summary.toString());
          };

          return Stack(
            children: [
              child!,
              ValueListenableBuilder<bool>(
                valueListenable: appController.loading.value,
                builder: (_, loadingSnapshot, __) {
                  return loadingSnapshot
                      ? const AppLoading()
                      : const SizedBox.shrink();
                },
              ),
            ],
          );
        },
        routerDelegate: lAppRouter.goRouter.routerDelegate,
        routeInformationParser: lAppRouter.goRouter.routeInformationParser,
        routeInformationProvider: lAppRouter.goRouter.routeInformationProvider,
      );
    });
  }

  void postBuild(BuildContext context) {
    checkNetworkResult();
  }

  void checkNetworkResult() {
    networkSubscription?.cancel();
    networkSubscription = networkingUtil.connectionChange.distinct().listen(
      (network) {
        debugPrint('network: $network');

        if (network == NetworkState.off) {
          _messageKey.currentState?.showSnackBar(_networkSnackBar());
        }
      },
    );
  }

  SnackBar _networkSnackBar(){
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: const [
          Icon(
            Icons.network_check_rounded,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'No internet connection',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
