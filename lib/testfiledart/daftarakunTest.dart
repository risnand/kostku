import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../home.dart';
import '../login/Login.dart';

class Daftarakun extends StatefulWidget {
  final FirebaseAuth auth; // Tambahkan properti FirebaseAuth
  const Daftarakun({Key? key, required this.auth}) : super(key: key);

  @override
  State<Daftarakun> createState() => _DaftarakunState();
}

class _DaftarakunState extends State<Daftarakun> {
  late String _email, _pass;


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
                Center(
                  child: Container(child: Image.asset('assets/kostku1.png')),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Daftar Akun Baru',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    key: const Key('emailTextField'), // Key untuk email text field
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Email',
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
                    key: const Key('passwordTextField'), // Key untuk password text field
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
                      setState(() {
                        _pass = value.trim();
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                      ),
                      height: MediaQuery.of(context).size.width * 0.25,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: ElevatedButton(
                        key: const Key('createAccountButton'), // Key untuk tombol create account
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const home(),
                            ),
                          );
                        },
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.black,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * (1 / 3.1)),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                        ),
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            try {
                              widget.auth
                                  .createUserWithEmailAndPassword(
                                      email: _email, password: _pass)
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("Berhasil Membuat Akun!"),
                                  ),
                                );
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Gagal membuat akun: $e"),
                                ),
                              );
                            }
                          },
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.black,
                              size: MediaQuery.of(context).size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    )
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
