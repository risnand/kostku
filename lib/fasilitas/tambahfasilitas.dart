import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectmppl/home.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class tambahfasilitas extends StatefulWidget {
  const tambahfasilitas({super.key});

  @override
  State<tambahfasilitas> createState() => _tambahfasilitasState();
}

class _tambahfasilitasState extends State<tambahfasilitas> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _kondisiController = TextEditingController();
  File? _image;

  Future<void> _selectImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<String> _uploadImage(String imageName) async {
    if (_image != null) {
      firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref().child('Fasilitas/$imageName');
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!);
      await uploadTask.whenComplete(() => null);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const home()),
            ); // Kembali ke halaman sebelumnya
          },
        ),
        title: const Text(
          'Fasilitas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 80,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddFormDialog(context); // Tampilkan form tambah data
            },
            color: Colors.white, // Ubah warna ikon
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('fasilitas').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    // Process and display the data from the snapshot
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        String nama = document['nama'];
                        int harga = document['harga'];

                        // Widget untuk menampilkan data
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Image.network(document['img']),
                            title: Text(nama),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Unit: ${document['unit']}'),
                                Text('Kondisi: ${document['kondisi']}'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    // Handle error state
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Show loading indicator
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Data Fasilitas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                controller: _hargaController,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _unitController,
                decoration: const InputDecoration(
                  labelText: 'Unit',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _kondisiController,
                decoration: const InputDecoration(
                  labelText: 'Kondisi',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _selectImage(); // Mengambil gambar dari galeri
                },
                child: const Text('Unggah Gambar'),
              ),
              if (_image != null) // Menampilkan gambar terpilih
                Image.file(_image!),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addDataToFasilitas(); // Tambahkan data ke koleksi fasilitas
                Navigator.pop(context); // Tutup dialog
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addDataToFasilitas() async {
    String nama = _namaController.text;
    int harga = int.tryParse(_hargaController.text) ?? 0;
    int unit = int.tryParse(_unitController.text) ?? 0;
    String kondisi = _kondisiController.text;
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('fasilitas').get();

    int totalData = snapshot.size;

    // Mengunggah gambar dan mendapatkan URL gambar yang diunggah
    String imageUrl = await _uploadImage('fasilitas_${totalData + 1}');

    // Menambahkan data ke koleksi fasilitas
    FirebaseFirestore.instance.collection('fasilitas').add({
      'id': totalData + 1,
      'img': imageUrl,
      'nama': nama,
      'harga': harga,
      'unit': unit,
      'kondisi': kondisi,
    });
  }
}
