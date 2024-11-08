// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Settings
            // ListTile(
            //   leading: Icon(Icons.person),
            //   title: Text('Edit Profile'),
            //   onTap: () {
            //     // Navigate to profile edit page (if you have one)
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.camera_alt),
            //   title: Text('Change Profile Picture'),
            //   onTap: () {
            //     // Function to change profile picture
            //   },
            // ),

            // Theme Settings
            SwitchListTile(
              title: Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),

            // Language Settings
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              subtitle: Text(selectedLanguage),
              onTap: () {
                // Show language selection options
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Select Language'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('English'),
                              onTap: () {
                                setState(() {
                                  selectedLanguage = 'English';
                                });
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: Text('Spanish'),
                              onTap: () {
                                setState(() {
                                  selectedLanguage = 'Spanish';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // Notification Settings
            SwitchListTile(
              title: Text('Enable Notifications'),
              value: true,
              onChanged: (bool value) {
                setState(() {});
              },
            ),

            // App Info
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('App Version'),
              subtitle: Text('1.0.0'),
              onTap: () {},
            ),

            // Logout
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                // Handle logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
