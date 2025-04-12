// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zyptopulse/main.dart';

void main() {
  testWidgets('App loads and displays ZyptoPulse', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('ZyptoPulse'), findsOneWidget);
  });
}

