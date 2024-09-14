import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/project_card.dart';
import '../widgets/tab_bar_widget.dart';

class PortfolioScreen extends StatefulWidget {
  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  String _searchText = "";
  late TabController _tabController;

  final List<Map<String, String>> projects = [
    {"name": "Food Ordering App", "person": "Shubham Singh"},
    {"name": "E-commerce Platform", "person": "John Doe"},
    {"name": "School Management System", "person": "Jane Doe"},
    {"name": "Instagram Clone", "person": "Shubham Singh"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 1 ? 'Portfolio' : '',
          style: TextStyle(
            fontFamily: 'CustomFont',
            fontSize: 18.sp,
          ),
        ),
        actions: _selectedIndex == 1
            ? [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {
            
            },
          ),

        ]
            : null,
        bottom: _selectedIndex == 1
            ? TabBarWidget(controller: _tabController)
            : null,
      ),
      body: Column(
        children: [
          Expanded(child: _buildBody()), 
          if (_selectedIndex == 1)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                icon: Icon(Icons.filter_list),
                label: Text('Filter Projects'),
                onPressed: () {
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, 
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            label: 'Input',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 1) {
      return Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search Projects',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchText = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  if (project["name"]!.toLowerCase().contains(_searchText)) {
                    return ProjectCard(
                      name: project["name"]!,
                      person: project["person"]!,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Container(),
      );
    }
  }
}
