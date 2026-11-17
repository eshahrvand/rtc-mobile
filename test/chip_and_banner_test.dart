import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rtc_mobile/core/models/product_chip_model.dart';
import 'package:rtc_mobile/ui/widget/rtc_chip_item.dart';

void main() {
  group('RtcChipItem multi-select badge tests', () {
    testWidgets('displays only label when count is null or <= 1', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RtcChipItem(
              chip: ProductChipModel(id: 1, label: 'دسته بندی', selectedCount: 1),
              isSelected: true,
              selectedCount: 1,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('دسته بندی'), findsOneWidget);
      expect(find.text('(۱)'), findsNothing);
    });

    testWidgets('displays count badge in Persian digits when count > 1', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RtcChipItem(
              chip: ProductChipModel(id: 1, label: 'دسته بندی', selectedCount: 2),
              isSelected: true,
              selectedCount: 2,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('دسته بندی'), findsOneWidget);
      expect(find.text('(۲)'), findsOneWidget);
    });

    testWidgets('displays count badge in Persian digits when count is 12', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RtcChipItem(
              chip: ProductChipModel(id: 1, label: 'دسته بندی', selectedCount: 12),
              isSelected: true,
              selectedCount: 12,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('دسته بندی'), findsOneWidget);
      expect(find.text('(۱۲)'), findsOneWidget);
    });

    testWidgets('does not display count badge when chip is not selected', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RtcChipItem(
              chip: ProductChipModel(id: 1, label: 'دسته بندی', selectedCount: 3),
              isSelected: false,
              selectedCount: 3,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('دسته بندی'), findsOneWidget);
      expect(find.text('(۳)'), findsNothing);
    });
  });
}
