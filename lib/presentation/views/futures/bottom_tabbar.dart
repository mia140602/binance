import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({super.key});

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My TabBar'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Option 1'),
            Tab(text: 'Option 2'),
            Tab(text: 'Option 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text('Content for Option 1')),
          Center(child: Text('Content for Option 2')),
          Center(child: Text('Content for Option 3')),
        ],
      ),
    );
  }
}
