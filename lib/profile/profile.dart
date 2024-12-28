import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:projectmppl/login/Login.dart';
import 'package:projectmppl/login/daftarakun.dart';

import 'package:projectmppl/profile/ubahprofile.dart';
import '../home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  String getProfileImage() {
    if (_currentUser != null) {
      if (_currentUser!.photoURL != null && _currentUser!.photoURL != "") {
        return _currentUser!.photoURL!;
      }
      return "https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg";
    }
    return "null";
  }

  String getDisplayName() {
    if (_currentUser != null) {
      if (_currentUser!.displayName != null &&
          _currentUser!.displayName != "") {
        return _currentUser!.displayName!;
      }
    }
    return "unset";
  }

  String getEmail() {
    if (_currentUser != null) {
      if (_currentUser!.email != null && _currentUser!.email != "") {
        return _currentUser!.email!;
      }
    }
    return "unset";
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF4500), Color(0xFFFFA500)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.arrow_downward,
                color: Colors.black,
                size: 30.0,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const home()),
              );
            },
          ),
          actions: [
            MaterialButton(
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const UbahProfile()),
                );
              },
              child: const Text(
                "Ubah Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: CachedNetworkImage(
                        imageUrl: getProfileImage(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    getDisplayName(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 1000,
                  height: 5,
                  color: Colors.purple[200],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    getEmail(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 1000,
                  height: 5,
                  color: Colors.purple[200],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepOrange), // Change to desired color
                      ),
                      onPressed: _logout,
                      child: const Text('Logout'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.deepOrangeAccent), // Change to desired color
                      ),
                      onPressed: () {
                        // _logout;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Daftarakun()));
                      },
                      child: const Text('Daftar Akun baru'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
