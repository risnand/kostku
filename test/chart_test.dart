import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:projectmppl/testfiledart/chartTest.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  group('ChartScreen Widget Test', () {
    testWidgets('ChartScreen renders chart when there is data', (WidgetTester tester) async {
      final dummyData = [
        {'biaya': 50000, 'status': true}, 
        {'biaya': 30000, 'status': false}, 
        {'biaya': 20000, 'status': true}, 
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: ChartScreen(dummyData: dummyData),
        ),
      );

      expect(find.byType(SfCircularChart), findsOneWidget);
    });

    testWidgets('ChartScreen does not render chart when there is no data', (WidgetTester tester) async {
      final dummyData = <Map<String, Object>>[];

      await tester.pumpWidget(
        MaterialApp(
          home: ChartScreen(dummyData: dummyData),
        ),
      );

      expect(find.byType(SfCircularChart), findsNothing);
    });
  });
}