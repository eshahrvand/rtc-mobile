import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:rtc_mobile/data_source/remote/report/report_service.dart';
import 'package:rtc_mobile/repository/report/commission_report_repository.dart';

class CommissionTestApi implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  FutureOr<ResponseBody> Function(RequestOptions)? onRequest;

  CommissionReportRepository repository() {
    final dio = Dio(BaseOptions(baseUrl: 'https://commission.test/api/v1/'));
    dio.httpClientAdapter = this;
    return CommissionReportRepository(ReportService(dio));
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    requests.add(options);
    if (onRequest != null) return Future.value(onRequest!(options));
    return Future.value(
      response(
        options.path.endsWith('/summary')
            ? summary(
                year:
                    options.queryParameters['year'] as int? ??
                    Jalali.now().year,
                month:
                    options.queryParameters['month'] as int? ??
                    Jalali.now().month,
              )
            : page(pageNumber: options.queryParameters['page'] as int),
      ),
    );
  }

  static ResponseBody response(Map<String, dynamic> body, {int status = 200}) =>
      ResponseBody.fromString(
        jsonEncode(body),
        status,
        headers: {
          Headers.contentTypeHeader: ['application/json'],
        },
      );

  static Map<String, dynamic> entry(int index) => {
    'id': '${index.toString().padLeft(8, '0')}-5717-4562-b3fc-2c963f66afa6',
    'order_total': 80200000,
    'approved_at': '2026-10-31T09:37:43.520Z',
    'disbursed_at': '2026-10-30T09:37:43.520Z',
    'customer_first_name': 'پیمان',
    'customer_last_name': 'خورسندی',
    'plan_name': 'آپ',
    'sub_plan_duration': 12,
  };

  static Map<String, dynamic> page({
    int pageNumber = 1,
    int count = 123,
    int? entryIndex,
    bool? hasMore,
  }) => {
    'count': count,
    'next': (hasMore ?? pageNumber == 1)
        ? 'https://commission.test/api/v1/reports/commission?page=2'
        : null,
    'previous': pageNumber == 1
        ? null
        : 'https://commission.test/api/v1/reports/commission?page=1',
    'results': [entry(entryIndex ?? pageNumber)],
  };

  static Map<String, dynamic> summary({int year = 1405, int month = 8}) => {
    'year': year,
    'month': month,
    'monthly_sales_total': 2000000000,
    'commission_rate_cash': 5.25,
    'commission_rate_product': 7.5,
    'commission_amount_cash': 105000000,
    'commission_amount_product': 150000000,
    'next_tier_rate_cash': 6,
    'next_tier_rate_product': 8,
    'distance_to_next_tier': 100000000,
  };

  @override
  void close({bool force = false}) {}
}
