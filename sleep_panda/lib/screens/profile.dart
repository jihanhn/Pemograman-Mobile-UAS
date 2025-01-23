import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/screens/edit_profile.dart';
import 'package:sleep_panda/screens/feedback.dart';
import 'package:sleep_panda/screens/login.dart';
import 'package:sleep_panda/screens/terms_and_condition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Box box;

  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() async {
    box = await Hive.openBox('data');
    setState(() {
      profileImagePath = box.get('profileImagePath', defaultValue: null);
    });
  }

  void _logout() async {
    // Fetch the stored email and password from Hive
    String? email = box.get('email');
    String? password = box.get('password');

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: $email'),
              Text('Password: $password'),
              SizedBox(height: 10),
              Text('Are you sure you want to logout?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Destroy Hive data (clear the box)
                box.clear();
                Navigator.pop(context); // Close the dialog
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (route) => false,
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                // Circular profile image
                ClipOval(
                  child: profileImagePath != null
                      ? Image.file(
                          File(profileImagePath!),
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/default.png',
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff272E49),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        'Untuk hasil analisa yang lebih baik, akurat, dan bermanfaat. Profil tidur hanya bisa diakses setelah kamu melakukan pelacakan tidur paling tidak 30 hari.',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        softWrap: true, // Ensures text wraps correctly
                        overflow: TextOverflow
                            .visible, // Ensures text is fully displayed
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff009090)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ));
                            },
                            child: Text(
                              'Lihat Profile Tidur',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff272E49),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      // Item pertama
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical:
                                8.0), // Memberikan padding untuk jarak antar elemen
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10), // Jarak antar icon dan teks
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Detil profil',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    color: Color(
                                        0xff9797974D), // Divider untuk pemisah
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditProfilePage(),
                                ));
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Item kedua
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Image.asset('assets/docs.png'),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Terms & Conditions',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Divider(
                                    color: Color(0xff9797974D),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TermsAndConditionsPage(),
                                ));
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Feedback',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FeedbackPage(),
                                ));
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Color(0xff009090)),
                      onPressed: () {
                        _logout();
                      },
                      child: Text('Logout')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
