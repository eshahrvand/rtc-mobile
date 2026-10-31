import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:rtc_mobile/data_source/remote/dashboard/dashboard_service.dart';
import 'package:rtc_mobile/ui/presenters/dashboard/mapper/dashboard_mapper.dart';

void main() {
  test(
    'full-month response with future null sales reaches the chart mapper',
    () async {
      final payload = File(
        'test/fixtures/dashboard_daily_chart_full_month.json',
      ).readAsStringSync();
      final dio = Dio(BaseOptions(baseUrl: 'https://api.rtciran.com/api/v1/'));
      addTearDown(dio.close);
      late Uri requestUri;
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            requestUri = options.uri;
            handler.resolve(
              Response<List<dynamic>>(
                requestOptions: options,
                statusCode: 200,
                data: jsonDecode(payload) as List<dynamic>,
                headers: Headers.fromMap({
                  Headers.contentTypeHeader: ['application/json'],
                }),
              ),
            );
          },
        ),
      );

      final data = await DashboardService(dio).getDailyChart();

      expect(requestUri.path, '/api/v1/dashboard/daily-chart');
      expect(requestUri.queryParametersAll, {
        'full_month': ['true'],
      });
      expect(data, hasLength(30));
      expect(data.first.totalSalesAmount, 0);
      expect(data[8].totalSalesAmount, 44785200000);
      expect(data[9].totalSalesAmount, isNull);
      expect(data[10].previousTotalSalesAmount, 19722620000);
      expect(data.where((day) => day.totalSalesAmount == null), hasLength(21));

      final chart = DashboardMapper.mapLineChartData(
        data,
        today: Jalali.fromDateTime(DateTime(2026, 10, 31)),
      );
      expect(chart.line1Data, hasLength(30));
      expect(chart.line1Data.last.x, 30);
      expect(chart.line1Data[28].y, 109741370000);
      expect(chart.line2Data, hasLength(9));
      expect(chart.line2Data.last.x, 9);
      expect(chart.line2Data.last.y, 44785200000);
      expect(chart.line2Data[6].y, 0);
      expect(chart.line2Data.every((spot) => spot.y.isFinite), isTrue);
    },
  );
}
