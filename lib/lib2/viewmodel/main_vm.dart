
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgs/data/repository/auth_repository/auth_repository_impl.dart';
import 'package:tgs/pages/main_page/main_viewmodel.dart';

final mainViewModel = ChangeNotifierProvider<MainViewModel>((ref) => MainViewModel(ref.read(authRepositoryImpl)));