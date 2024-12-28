import 'package:flutter/material.dart';
import 'login/Login.dart';

class passbaru extends StatelessWidget {
  const passbaru({super.key});


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
                    'Masukan Password',
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Password Baru',
                    ),
                  ),
                ),

                const SizedBox(height: 60),
                Row(
                  children: [
                    const Column(
                      children: [
                      ],
                    ),
                    const SizedBox(width: 80,),
                    Padding(
                      padding: const EdgeInsets.only(left: 180.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(80))
                        ),
                        height: 90,
                        width: 90,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Login()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // <-- Radius
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
