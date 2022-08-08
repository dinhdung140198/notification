import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tgs/internal/router/route_utils.dart';
import 'package:tgs/internal/widgets/error_page.dart';
import 'package:tgs/pages/authen/login/login_page.dart';
import 'package:tgs/pages/detail_page/detail_page.dart';
import 'package:tgs/pages/landing_page/landing_page.dart';
import 'package:tgs/pages/main_page/main_page.dart';

final myAppRouter = Provider<AppRouter>((ref) {
  final router = RouterNotifier(ref);
  return AppRouter(router);
});

class AppRouter {
  final RouterNotifier _router;
  final GoRouter _goRouter;
  static const _transitionPageKey = ValueKey<String>('Page key');

  GoRouter get goRouter => _goRouter;

  AppRouter(this._router)
      : _goRouter = GoRouter(
          debugLogDiagnostics: true,
          refreshListenable: _router,
          urlPathStrategy: UrlPathStrategy.path,
          initialLocation: AppPage.root.path,
          errorBuilder: (_, state) => ErrorPage(error: state.error.toString()),
          redirect: _router.redirectLogic,
          navigatorBuilder: (_, state, child) =>
              _router.loading ? const LandingPage() : child,
          routes: <GoRoute>[
            GoRoute(
              path: AppPage.root.path,
              name: AppPage.root.name,
              redirect: (state) => AppPage.tab1.path,
            ),

            GoRoute(
              path: AppPage.login.path,
              name: AppPage.login.name,
              builder: (context, state) => const LoginPage(),
            ),

            // tab1
            GoRoute(
              path: AppPage.tab1.path,
              name: AppPage.tab1.name,
              pageBuilder: (_, state) => FadeTransitionPage(
                key: _transitionPageKey,
                child: const MainPage(
                  tab: MainTab.tab1,
                ),
              ),
              routes: [
                GoRoute(
                  path: AppPage.detail1.path,
                  name: AppPage.detail1.name,
                  builder: (context, state) {
                    final id = state.params[AppPage.detail1.params];

                    return DetailPage(id: id);
                  },
                ),
              ],
            ),

            //tab2
            GoRoute(
              path: AppPage.tab2.path,
              name: AppPage.tab2.name,
              pageBuilder: (_, state) => FadeTransitionPage(
                key: _transitionPageKey,
                child: const MainPage(
                  tab: MainTab.tab2,
                ),
              ),
            ),

            //tab3
            GoRoute(
              path: AppPage.tab3.path,
              name: AppPage.tab3.name,
              pageBuilder: (_, state) => FadeTransitionPage(
                key: _transitionPageKey,
                child: const MainPage(
                  tab: MainTab.tab3,
                ),
              ),
            ),

            //tab4
            GoRoute(
              path: AppPage.tab4.path,
              name: AppPage.tab4.name,
              pageBuilder: (_, state) => FadeTransitionPage(
                key: _transitionPageKey,
                child: const MainPage(
                  tab: MainTab.tab4,
                ),
              ),
            ),
          ],
        );

  GoRouter of(BuildContext context) => GoRouter.of(context);

  void pop() =>
      _goRouter.location != AppPage.root.path ? _goRouter.pop() : null;
}

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  bool _loading = true;

  RouterNotifier(this._ref) {
    _ref.listen<bool>(stateProvider, (_, __) => notifyListeners());
    checkLoginStatus();
  }

  bool get loading => _loading;

  String? redirectLogic(GoRouterState state) {
    final auth = _ref.read(stateProvider);
    final areWeLoggingIn = state.location == AppPage.login.path;

    if (!auth) return areWeLoggingIn ? null : AppPage.login.path;
    if (areWeLoggingIn && auth) return AppPage.root.path;

    return null;
  }

  Future<void> checkLoginStatus() async {
    //final _result = await CheckLoginCommand().run();
    await Future.delayed(const Duration(seconds: 2));
    _loading = false;
    //_isLoggedIn = _result;
    notifyListeners();
  }
}

final stateProvider = StateNotifierProvider<LoggedInState, bool>(
  (ref) => LoggedInState(),
);

class LoggedInState extends StateNotifier<bool> {
  LoggedInState() : super(false);

  void login() => state = true;

  void logout() => state = false;
}

/// TransitionPage
class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          transitionsBuilder: (c, animation, a2, child) => FadeTransition(
            opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
            child: child,
          ),
          child: child,
        );
}
