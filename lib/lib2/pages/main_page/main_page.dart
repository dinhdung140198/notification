import 'package:flutter/material.dart';
import 'package:tgs/internal/app_controller.dart';
import 'package:tgs/internal/widgets/lazy_indexed_stack.dart';
import 'package:tgs/pages/tab1_page/tab1_page.dart';
import 'package:tgs/pages/tab2_page/tab2_page.dart';
import 'package:tgs/pages/tab3_page/tab3_page.dart';
import 'package:tgs/pages/tab4_page/tab4_page.dart';

enum MainTab {
  tab1('/tab1'),
  tab2('/tab2'),
  tab3('/tab3'),
  tab4('/tab4');

  const MainTab(this.routePath);

  final String routePath;
}

class MainPage extends StatefulWidget {
  final MainTab tab;

  const MainPage({Key? key, required this.tab}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: LazyIndexedStack(
          index: widget.tab.index,
          children: [
            const Tab1Page(),
            Tab2Page(text: widget.tab.name),
            Tab3Page(text: widget.tab.name),
            Tab4Page(text: widget.tab.name),
          ],
        ),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: MainTab.tab1.name,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: MainTab.tab2.name,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: MainTab.tab3.name,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: MainTab.tab4.name,
        ),
      ],
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: widget.tab.index,
      type: BottomNavigationBarType.fixed,
      onTap: (index) =>
          appController.router.of(context).go(MainTab.values[index].routePath),
    );
  }
}
