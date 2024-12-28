import 'package:flutter/material.dart';
import 'package:projectmppl/login/Login.dart';

class lupapass extends StatefulWidget {
  const lupapass({Key? key}) : super(key: key);

  @override
  State<lupapass> createState() => _lupapassState();
}

class _lupapassState extends State<lupapass> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    final String email = _emailController.text.trim();
    
    if (isValidEmail(email)) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('cek email anda untuk mereset password'),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text('Email tidak valid'),
          );
        },
      );
    }
  }

  bool isValidEmail(String email) {
    // Sederhana saja, cek apakah email memiliki "@" dan "."
    return email.contains('@') && email.contains('.');
  }

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
                    'Masukan Email anda untuk reset Password',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
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
                      hintText: 'Email',
                    ),
                    controller: _emailController,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(80))),
                        height: 90,
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // <-- Radius
                            ),
                          ),
                          child: const RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.black,
                              size: 60.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 75),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(80))),
                        height: 90,
                        width: 90,
                        child: ElevatedButton(
                          onPressed: passwordReset,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // <-- Radius
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
