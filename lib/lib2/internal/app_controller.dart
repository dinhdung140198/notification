import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tgs/internal/manager/global_loading_manager.dart';
import 'package:tgs/internal/router/app_router.dart';
import 'package:tgs/internal/widgets/dialog.dart';

late BuildContext _mainContext;
BuildContext get mainContext => _mainContext;

void setContext(BuildContext c) {
  _mainContext = c;
}

class AppController {
  late AppRouter? _router;
  final DialogController _dialog;
  final GlobalLoadingManager _loading;
  final Toast _toast;

  AppController()
      : _router = null,
        _dialog = DialogController(),
        _loading = GlobalLoadingManager(),
        _toast = Toast();

  void initRouter(AppRouter router){
    _router = router;
  }

  DialogController get dialog => _dialog;

  GlobalLoadingManager get loading => _loading;

  Toast get toast => _toast;

  AppRouter get router => _router!;

  void dispose(){
    loading.dispose();
  }
}


class Toast {
  void showToast({required BuildContext context, String message = '', TextStyle? textStyle}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: textStyle ?? const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void showCustomToast({required BuildContext context, required SnackBar snackBar}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(snackBar);
  }
}

final _get = GetIt.I.get;
AppController get appController => _get<AppController>();
