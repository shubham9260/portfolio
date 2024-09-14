import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;

  TabBarWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,  // Provide explicit TabController
      indicatorColor: Colors.orange,
      labelColor: Colors.orange,
      unselectedLabelColor: Colors.grey,
      tabs: [
        Tab(text: 'Project'),
        Tab(text: 'Saved'),
        Tab(text: 'Shared'),
        Tab(text: 'Achievement'),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);  // Create TabController
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
        title: Text('TabBar Example'),
        bottom: TabBarWidget(controller: _tabController),  // Pass TabController to TabBarWidget
      ),
      body: TabBarView(
        controller: _tabController,  // Link TabController to TabBarView
        children: [
          Center(child: Text('Project')),  // Content for the Project tab
          Container(),  // Empty Container for Saved tab (shows nothing)
          Container(),  // Empty Container for Shared tab (shows nothing)
          Container(),  // Empty Container for Achievement tab (shows nothing)
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: MyHomePage()));
