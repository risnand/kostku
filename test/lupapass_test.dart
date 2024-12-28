import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projectmppl/testfiledart/lupapassTest.dart';

void main() {
  group('lupapass Widget Test', () {
    testWidgets('Password reset success', (WidgetTester tester) async {
      
      await tester.pumpWidget(MaterialApp(
        home: lupapass(),
      ));

      final emailTextField = find.byType(TextField);
      await tester.enterText(emailTextField, 'test@example.com');

      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pump();

      expect(find.text('cek email anda untuk mereset password'), findsOneWidget);
    });

    testWidgets('Password reset failed', (WidgetTester tester) async {
      
      await tester.pumpWidget(MaterialApp(
        home: lupapass(),
      ));

 
      final emailTextField = find.byType(TextField);
      await tester.enterText(emailTextField, 'invalidemail');

      await tester.tap(find.byType(ElevatedButton).last);
      await tester.pump();

      expect(find.text('Email tidak valid'), findsOneWidget);
    });
  });
}
