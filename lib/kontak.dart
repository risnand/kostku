import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';

class Kontak extends StatelessWidget {
  const Kontak({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Kontak',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const home()),
            );
          },
        ),
        backgroundColor: Colors.orange[700], // Warna appbar
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('penyewa').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada data.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent, // Warna teks
                ),
              ),
            );
          } else {
            final penyewaList = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: penyewaList.length,
              itemBuilder: (context, index) {
                final penyewa = penyewaList[index].data();
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.orange[100],
                  child: GestureDetector(
                    onTap: () async {
                      final url = 'https://wa.me/+62${penyewa['nomor_hp']}';
                      await launch(url);
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(penyewa['img']),
                      ),
                      title: Text(
                        penyewa['nama'] as String,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade600,
                        ),
                      ),
                      subtitle: Text(
                        "0${penyewa['nomor_hp']}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange.shade600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
