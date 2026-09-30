import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kuis_si_c/main.dart';

void main() {
  testWidgets('Culinarizz login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CulinarizzApp());

    // Pastikan judul aplikasi Culinarizz tampil di layar awal (Login Page)
    expect(find.text('Culinarizz'), findsOneWidget);

    // Pastikan tombol login tampil
    expect(find.text('MASUK (LOGIN)'), findsOneWidget);

    // Pastikan field input username dan password dapat ditemukan
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
