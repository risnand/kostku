import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../home.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[700],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const home()),
            );
          },
        ),
        title: const Text('Grafik Keuangan'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrangeAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('keuangan').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!.docs;
              final pemasukan = data.where((doc) => doc['status'] == true);
              final pengeluaran = data.where((doc) => doc['status'] == false);

              // Menghitung total pemasukan dan pengeluaran
              int totalPemasukan = 0;
              int totalPengeluaran = 0;
              for (var doc in pemasukan) {
                totalPemasukan += int.parse(doc['biaya'].toString());
              }
              for (var doc in pengeluaran) {
                totalPengeluaran += int.parse(doc['biaya'].toString());
              }

              final chartData = [
                ChartData('Pemasukan', totalPemasukan),
                ChartData('Pengeluaran', totalPengeluaran),
              ];

              final totalSaldo = totalPemasukan - totalPengeluaran;

              return Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        PieSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.label,
                          yValueMapper: (ChartData data, _) => data.value,
                          dataLabelMapper: (ChartData data, _) =>
                          '${data.value}',
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Total Pemasukan: $totalPemasukan',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Total Pengeluaran: $totalPengeluaran',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Total Saldo: $totalSaldo',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class ChartData {
  final String label;
  final int value;

  ChartData(this.label, this.value);
}
