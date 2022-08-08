
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgs/data/repository/auth_repository/auth_repository_impl.dart';
import 'package:tgs/pages/tab1_page/tab1_viewmodel.dart';

final tab1ViewModel = StateNotifierProvider<Tab1ViewModel, Tab1State>((ref) => Tab1ViewModel(ref.read(authRepositoryImpl)));