import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pembukuan {
  final int biaya;
  final DateTime date;
  final String keterangan;
  final bool status;

  Pembukuan({
    required this.biaya,
    required this.date,
    required this.keterangan,
    required this.status,
  });
}

class pembukuan extends StatelessWidget {
  final List<Pembukuan> dummyData;

  const pembukuan({Key? key, required this.dummyData}) : super(key: key);

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
              Navigator.of(context).pop();
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
        ),
        body: SingleChildScrollView(
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
                itemCount: dummyData.length,
                itemBuilder: (BuildContext context, int index) {
                  Pembukuan data = dummyData[index];

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
                              padding: const EdgeInsets.fromLTRB(10, 0, 60, 0),
                              child: Text(
                                DateFormat('dd').format(data.date),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                data.keterangan,
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
                                  padding: const EdgeInsets.only(left: 60.0),
                                  child: Text(
                                    data.status ? "Pemasukan" : "Pengeluaran",
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
                                  DateFormat('MMM yyyy').format(data.date),
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
                                data.biaya.toString(),
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
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: pembukuan(dummyData: dummyData),
    );
  }
}

List<Pembukuan> dummyData = [
  Pembukuan(
    biaya: 50000,
    date: DateTime.now(),
    keterangan: 'Pembelian barang',
    status: true,
  ),
  Pembukuan(
    biaya: 70000,
    date: DateTime.now(),
    keterangan: 'Pembayaran tagihan',
    status: false,
  ),
];
