import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/Login.dart';
import '../login/Daftarakun.dart';
import '../login/lupapass.dart';
import 'homepenyewa.dart';

class loginpenyewa extends StatefulWidget {
  const loginpenyewa({Key? key}) : super(key: key);

  @override
  State<loginpenyewa> createState() => _loginpenyewaState();
}

class _loginpenyewaState extends State<loginpenyewa> {
  late String _email, _pass;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.deepOrange,
            Colors.orangeAccent,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Container(child: Image.asset('assets/kostku1.png')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 30),
                  child: SizedBox(
                    height: 20,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.swap_horizontal_circle,
                              color: Colors.black45,
                              size: 20.0,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login Sebagai Admin",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Username',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Password',
                    ),
                    onChanged: (value) {
                      _pass = value.trim();
                    },
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const Daftarakun()));
                          },
                          child: const Text(
                            'Daftar Akun',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const lupapass()));
                          },
                          child: const Text(
                            'Lupa Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      height: 90,
                      width: 90,
                      child: ElevatedButton(
                        onPressed: () {
                          auth
                              .signInWithEmailAndPassword(
                                  email: _email, password: _pass)
                              .then((_) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const homepenyewa()));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.black,
                            size: 60.0,
                          ),
                        ),
                      ),
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
