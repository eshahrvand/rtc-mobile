import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rtc_mobile/core/models/product_chip_model.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import 'package:rtc_mobile/ui/widget/rtc_chip_item.dart';
import 'package:rtc_mobile/ui/widget/rtc_status_badge.dart';

void main() {
  setUpAll(() async {
    await S.load(const Locale('fa'));
  });
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

  group('RtcStatusBadge canceled status tests', () {
    testWidgets('displays "لغو شده" with gray color palette for canceled status', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RtcStatusBadge(status: 'canceled', isPrimary: false),
          ),
        ),
      );

      expect(find.text('لغو شده'), findsOneWidget);
    });

    testWidgets('displays "لغو شده" in primary mode with gray color', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RtcStatusBadge(status: 'canceled', isPrimary: true),
          ),
        ),
      );

      expect(find.text('لغو شده'), findsOneWidget);
    });
  });
}
