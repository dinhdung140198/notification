import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stacked/stacked.dart';
import 'package:tgs/data/repository/auth_repository/auth_repository_impl.dart';

abstract class Tab1State{}

class Tab1Loading extends Tab1State{}
class Tab1Error extends Tab1State{}
class Tab1Data extends Tab1State{
  final List<String>? items;

  Tab1Data({this.items});

  Tab1Data copyWith({List<String>? item}){
    return Tab1Data(items: item ?? items);
  }
}


class Tab1ViewModel extends StateNotifier<Tab1State>{
  final AuthRepositoryImpl authRepositoryImpl;

  Tab1ViewModel(this.authRepositoryImpl) : super(Tab1Loading()){
    init();
  }

  List<String> items = [];
  Tab1Data? dataState;

  Future<void> init() async {
    await getItems();
  }

  Future<void> getItems() async {
    await Future.delayed(const Duration(seconds: 1));
    items.addAll(['1', '2', '3', '4']);
    dataState = Tab1Data(items: items);
    state = dataState!;
  }

  void removeItem(int index){
    items.removeAt(index);
    state = dataState!.copyWith(item: items);
  }

}