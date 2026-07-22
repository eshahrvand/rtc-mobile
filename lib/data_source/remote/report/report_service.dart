import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/report_dto_model.dart';

part 'report_service.g.dart';

@RestApi()
abstract class ReportService {
  factory ReportService(Dio dio, {String baseUrl}) = _ReportService;

  @GET('reports/sales/overview')
  Future<SalesOverviewResponse> getSalesOverview({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('sub_plan') String? subPlanId,
    @Query('search') String? search,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  @GET('reports/sales/overview/summary')
  Future<ReportSummaryDtoModel> getSalesOverviewSummary({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('sub_plan') String? subPlanId,
    @Query('search') String? search,
  });

  @GET('reports/sales/by-plan')
  Future<SalesByPlanResponse> getSalesByPlan({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('search') String? search,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  @GET('reports/sales/by-plan/summary')
  Future<ReportSummaryDtoModel> getSalesByPlanSummary({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('search') String? search,
  });

  @GET('reports/sales/by-category')
  Future<SalesByCategoryResponse> getSalesByCategory({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('parent_category') String? parentCategoryId,
    @Query('search') String? search,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  @GET('reports/sales/by-category/summary')
  Future<ReportSummaryDtoModel> getSalesByCategorySummary({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('parent_category') String? parentCategoryId,
    @Query('search') String? search,
  });

  @GET('reports/sales/by-product')
  Future<SalesByProductResponse> getSalesByProduct({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('category') String? categoryId,
    @Query('sub_plan') String? subPlanId,
    @Query('search') String? search,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
  });

  @GET('reports/sales/by-product/summary')
  Future<ReportSummaryDtoModel> getSalesByProductSummary({
    @Query('date_from') String? dateFrom,
    @Query('date_to') String? dateTo,
    @Query('category') String? categoryId,
    @Query('sub_plan') String? subPlanId,
    @Query('search') String? search,
  });
}
