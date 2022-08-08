import 'package:get_it/get_it.dart';
import 'package:tgs/internal/app_controller.dart';
import 'package:tgs/my_app.dart';

Future<void> main() async {
  registerSingletons();
  await initMyApp();
}

void registerSingletons({bool testMode = false}) {
  GetIt.I.registerLazySingleton(() => AppController());

  if (testMode) {
    GetIt.I.pushNewScope();
  }
}