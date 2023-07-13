import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Row(
        children: [
          // SidebarNavigation(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome to the Dashboard',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Main Content Area',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Add your widgets, charts, and data here',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      color: Colors.grey[200],
      child: ListView(
        children: [
          ListTile(
            title: Text('Home'),
            onTap: () {
              // Handle Home navigation
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Handle Profile navigation
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Handle Settings navigation
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Handle Logout navigation
            },
          ),
        ],
      ),
    );
  }
}
