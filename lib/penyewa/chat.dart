import 'package:flutter/material.dart';
import 'package:projectmppl/penyewa/homepenyewa.dart';
import 'package:url_launcher/url_launcher.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.deepOrange,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left,
              size: 70.0,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const homepenyewa()));
            },
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KostKu',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.0),
                child: Text(
                  'Kontak Pengelola Kost',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 1000,
                  height: 20,
                  color: Colors.yellow[100],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: const BorderSide(
                        width: 5.0,
                        color: Colors.green,
                      )),
                  onPressed: () {
                    _wasyarif();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 1000,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(top: 10, left: 5.0),
                              child: Text(
                                'Bu Santi',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Icon(Icons.call),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                'Nomor                        : ',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: const Text(
                                '08213123131',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(bottom: 10, left: 5.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: const BorderSide(
                        width: 5.0,
                        color: Colors.green,
                      )),
                  onPressed: () {
                    _wasyarif1();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 1000,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(top: 10, left: 5.0),
                              child: Text(
                                'Dahan',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Icon(Icons.call),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                'Nomor                        : ',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: const Text(
                                '08213123164',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding:
                              EdgeInsets.only(bottom: 10, left: 5.0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _wasyarif() async {
    String nomorhp = '083111778069';
    var url = 'https://wa.me/+6283111778069';
    await launch(url);
  }

  void _wasyarif1() async {
    String nomorhp = '082336964704';
    var url = 'https://wa.me/+6282336964704';
    await launch(url);
  }
}