import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartScreen extends StatelessWidget {
  final List<Map<String, Object>> dummyData;

  const ChartScreen({Key? key, required this.dummyData}) : super(key: key);

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
            Navigator.of(context).pop();
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
        child: _buildChart(),
      ),
    );
  }

  Widget _buildChart() {
    if (dummyData.isNotEmpty) {
      final pemasukan = dummyData.where((data) => data['status'] == true);
      final pengeluaran = dummyData.where((data) => data['status'] == false);

      int totalPemasukan = pemasukan.fold(0, (sum, data) => sum + (data['biaya'] as int));
      int totalPengeluaran = pengeluaran.fold(0, (sum, data) => sum + (data['biaya'] as int));

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
                  dataLabelMapper: (ChartData data, _) => '${data.value}',
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
      return const Center(child: Text('No data available'));
    }
  }
}

class ChartData {
  final String label;
  final int value;

  ChartData(this.label, this.value);
}
