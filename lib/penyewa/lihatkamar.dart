import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:projectmppl/penyewa/homepenyewa.dart';

class lihatkamar extends StatefulWidget {
  const lihatkamar({super.key});

  @override
  State<lihatkamar> createState() => _lihatkamarState();
}

class _lihatkamarState extends State<lihatkamar> {
  TextEditingController namaController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController nomorHPController = TextEditingController();
  bool status = false;
  DateTime? tanggalKeluar;
  DateTime? tanggalMasuk;
  String imgURL = "";
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const homepenyewa()),
            );
          },
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KostKu',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Text(
                'Data Penyewa',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('kamar').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          QuerySnapshot kamarDocs = snapshot.data!;
          return ListView.builder(
            itemCount: kamarDocs.size,
            itemBuilder: (context, index) {
              DocumentSnapshot kamarDoc = kamarDocs.docs[index];
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('penyewa')
                    .where('id_kamar', isEqualTo: kamarDoc['id'])
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  QuerySnapshot penyewaDocs = snapshot.data!;
                  DocumentSnapshot? penyewaDoc;

                  if (penyewaDocs.size > 0) {
                    // If there are tenants for this room, get the first tenant data
                    penyewaDoc = penyewaDocs.docs[0];
                  }

                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      width: 1000,
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    'Kamar No ${kamarDoc['id']}',
                                    style: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (penyewaDoc != null) ...[
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Nama : ',
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${penyewaDoc['nama']}',
                                          style: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Nomor HP: ',
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '0${penyewaDoc['nomor_hp']}',
                                          style: const TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 100,
                              child: InkWell(
                                onTap: () {
                                  // Show enlarged image here
                                },
                                child: Image.network(
                                  kamarDoc['img'],
                                  // Menggunakan link gambar dari penyewaDoc['img']
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void tambahDataPenyewa(int idKamar) async {
    try {
      String nama = namaController.text;
      int nominal = int.parse(nominalController.text);
      int nomorHP = int.parse(nomorHPController.text);

      String imageName = path.basename(selectedImage!.path);
      firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('KTP')
          .child(imageName);

      // Upload gambar ke Firebase Storage
      await storageReference.putFile(selectedImage!);

      // Dapatkan URL gambar yang diunggah
      String imageUrl = await storageReference.getDownloadURL();
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('penyewa').get();
      int totalData = snapshot.size;

      Map<String, dynamic> data = {
        'id': totalData,
        'id_kamar': idKamar,
        'nama': nama,
        'nominal': nominal,
        'nomor_hp': nomorHP,
        'status': status,
        'tanggal_keluar': tanggalKeluar,
        'tanggal_masuk': tanggalMasuk,
        'img': imageUrl,
      };

      await FirebaseFirestore.instance.collection('penyewa').add(data);

      setState(() {
        namaController.clear();
        nominalController.clear();
        nomorHPController.clear();
        status = false;
        imgURL = "";
      });
    } catch (e) {
      print('Error adding tenant data: $e');
    }
  }

  Future<void> getImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }
}
