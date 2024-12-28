import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:projectmppl/home.dart';
import 'package:projectmppl/testfiledart/loginTest.dart';

void main() {
  group('Login Test', () {
    testWidgets('Login with valid email and password',
        (WidgetTester tester) async {
      // Mock FirebaseAuth instance
      final auth = MockFirebaseAuth();

      // Build our widget
      await tester.pumpWidget(
        MaterialApp(
          home: login(auth: auth),
        ),
      );

      await tester.enterText(
          find.byKey(const Key('emailTextField')), 'rysa@gmail.com');
      await tester.enterText(
          find.byKey(const Key('passwordTextField')), '123456');

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.byType(home), findsOneWidget);
    });

    testWidgets('Login with invalid email and password',
        (WidgetTester tester) async {
      // Mock FirebaseAuth instance
      final auth = MockFirebaseAuth();

      await tester.pumpWidget(
        MaterialApp(
          home: login(auth: auth),
        ),
      );

      await tester.enterText(
          find.byKey(const Key('emailTextField')), 'invalidemail');
      await tester.enterText(
          find.byKey(const Key('passwordTextField')), '12345');

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.byType(home), findsOneWidget);
    });
  });
}
