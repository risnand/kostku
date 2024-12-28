import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectmppl/home.dart';
import 'package:intl/intl.dart';

class pembukuan extends StatefulWidget {
  const pembukuan({super.key});

  @override
  _pembukuanState createState() => _pembukuanState();
}



class _pembukuanState extends State<pembukuan> {
  final TextEditingController _biayaController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();
  bool _status = false;
  final List<bool> _statusOptions = [true, false];

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Tambah Data'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _biayaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Biaya'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _keteranganController,
                      decoration: const InputDecoration(labelText: 'Keterangan'),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('Status:'),
                        const SizedBox(width: 10),
                        DropdownButton<bool>(
                          value: _status,
                          onChanged: (bool? value) {
                            setState(() {
                              _status = value ?? false;
                            });
                          },
                          items: _statusOptions
                              .map<DropdownMenuItem<bool>>((bool? value) {
                            return DropdownMenuItem<bool>(
                              value: value ?? false,
                              child: Text(
                                  value == true ? 'Pemasukan' : 'Pengeluaran'),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue,
                    elevation: 0,
                  ),
                  onPressed: () async {
                    QuerySnapshot snapshot = await FirebaseFirestore.instance
                        .collection('fasilitas')
                        .get();

                    int totalData = snapshot.size;
                    FirebaseFirestore.instance.collection('keuangan').add({
                      'id': totalData + 1,
                      'biaya': int.parse(_biayaController.text),
                      'date': Timestamp.now(),
                      'keterangan': _keteranganController.text,
                      'status': _status,
                    });

                    Navigator.of(context).pop();
                  },
                  child: const Text('Tambah'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Batal'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                MaterialPageRoute(builder: (context) => const home()),
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
                  'Pembukuan',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                _showAddDialog();
              },
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('keuangan').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            List<DocumentSnapshot> documents = snapshot.data!.docs;

            return SingleChildScrollView(
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> data =
                          documents[index].data() as Map<String, dynamic>;

                      return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: 1000,
                        decoration: BoxDecoration(
                          color: Colors.yellow[200],
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, 2),
                                blurRadius: 2)
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 60, 0),
                                  child: Text(
                                    DateFormat('dd')
                                        .format(data['date'].toDate()),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data['keterangan'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.only(left: 60.0),
                                      child: Text(
                                        data['status']
                                            ? "Pemasukan"
                                            : "Pengeluaran",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      DateFormat('MMM yyyy')
                                          .format(data['date'].toDate()),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    data['biaya'].toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

