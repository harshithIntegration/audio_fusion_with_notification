import 'dart:convert';
import 'package:audiofusion/Employee/empdashboard.dart';
import 'package:audiofusion/admin/adminpage.dart';
import 'package:audiofusion/contactus.dart';
import 'package:audiofusion/features.dart';
import 'package:audiofusion/logout.dart';
import 'package:audiofusion/privacypolicy.dart';
import 'package:audiofusion/profilepage.dart';
import 'package:audiofusion/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:audiofusion/aboutus.dart';
import 'package:audiofusion/speakers.dart';
import 'package:audiofusion/venue.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  Map<String, dynamic>? storedResponse;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    Response();
  }

  Future<void> Response() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('response');
    if (jsonString != null) {
      setState(() {
        storedResponse = jsonDecode(jsonString);
      });
      print(storedResponse);
    } else {
      print("Stored response is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/banner.png',
                height: 600,
                width: 270,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 180,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            if (storedResponse != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfilePage(),
                                ),
                              );
                            }
                          },
                          child: const CircleAvatar(
                            radius: 31,
                            backgroundImage: AssetImage('assets/avatar.png'),
                          ),
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.cast_for_education_sharp),
                title: const Text('Features'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Features()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Privacy Policy'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy()),
                  );
                },
              ),
              if (storedResponse == null)
                ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text('Login'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                    );
                  },
                ),
              if (storedResponse != null)
                if (storedResponse?['body']['customerStatus'] == false &&
                    storedResponse?['body']['adminStatus'] == false)
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('employee'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployeeDashboard()),
                      );
                    },
                  ),
              if (storedResponse != null)
                if (storedResponse?['body']['adminStatus'] == true)
                  ListTile(
                    leading: const Icon(Icons.admin_panel_settings),
                    title: const Text('admin'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminPage()),
                      );
                    },
                  ),
              if (storedResponse != null)
                ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('logout'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Logout()),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(
              'assets/audio.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                DashboardItem(
                  icon: Icons.co_present_outlined,
                  label: 'AboutUs',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUs(),
                      ),
                    );
                  },
                ),
                DashboardItem(
                  icon: Icons.spatial_tracking_rounded,
                  label: 'Speakers',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Speakers(),
                      ),
                    );
                  },
                ),
                DashboardItem(
                  icon: Icons.add_call,
                  label: 'ContactUs',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUsPage(),
                      ),
                    );
                  },
                ),
                DashboardItem(
                  icon: Icons.location_on,
                  label: 'Venue',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Venue(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Container(
              color: Colors.blueGrey, // Set your desired background color here
              padding: EdgeInsets.all(
                  11.0), // Optional: add some padding around the text
              child: Text(
                '©Copyright 2024 All Rights Reserved by AudioVisual Fusion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  DashboardItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50.0),
            SizedBox(height: 10.0),
            Text(
              label,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
