import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:projectmppl/home.dart';
import 'package:projectmppl/testfiledart/daftarakunTest.dart';


void main() {
  
  group('Create Account Test', () {
    testWidgets('Create account with valid email and password', (WidgetTester tester) async {
      // Mock FirebaseAuth instance
      final auth = MockFirebaseAuth();

      
      await tester.pumpWidget(
        MaterialApp(
          home: Daftarakun(auth: auth),
        ),
      );

      await tester.enterText(find.byKey(const Key('emailTextField')), 'rysa@gmail.com');
      await tester.enterText(find.byKey(const Key('passwordTextField')), '123456');

      await tester.tap(find.byKey(const Key('createAccountButton')));
      await tester.pumpAndSettle();

      expect(find.byType(home), findsOneWidget);
    });

    testWidgets('Create account with invalid email', (WidgetTester tester) async {
    
      // Mock FirebaseAuth instance
      final auth = MockFirebaseAuth();

      await tester.pumpWidget(
        MaterialApp(
          home: Daftarakun(auth: auth),
        ),
      );

     await tester.enterText(
          find.byKey(const Key('emailTextField')), 'invalidemail');
      await tester.enterText(
          find.byKey(const Key('passwordTextField')), '12345');

      
      await tester.tap(find.byKey(const Key('createAccountButton')));
      await tester.pumpAndSettle();

      
      expect(find.byType(home), findsOneWidget);
    });
  });
}
