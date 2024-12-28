import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:projectmppl/testfiledart/pembukuanTest.dart'; // Sesuaikan dengan path file pembukuan.dart



void main() {
  group('Pembukuan Widget Test', () {
    testWidgets('Valid Data Input Test', (WidgetTester tester) async {
      
      await tester.pumpWidget(MaterialApp(
        home: pembukuan(dummyData: dummyData),
      ));

    
      expect(find.text('Pembelian barang'), findsOneWidget);
      expect(find.text('Pembayaran tagihan'), findsOneWidget);
    });


testWidgets('Invalid Data Handling Test', (WidgetTester tester) async {

  List<Pembukuan> invalidDummyData = [
  
    Pembukuan(
      biaya: 50000,
      date: DateTime(2000), 
      keterangan: 'Pembelian barang',
      status: true,
    ),
    
    Pembukuan(
      biaya: 70000,
      date: DateTime.now(),
      keterangan: 'Pembayaran tagihan',
      status: FutureBuilder.debugRethrowError, 
    ),
  ];

  await tester.pumpWidget(MaterialApp(
    home: pembukuan(dummyData: invalidDummyData),
  ));

  expect(find.text('Pembelian barang'), findsOneWidget);
  expect(find.text('Pembayaran tagihan'), findsOneWidget);
});

  });
}
