import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_dto_model.freezed.dart';
part 'report_dto_model.g.dart';

@freezed
class ReportSummaryDtoModel with _$ReportSummaryDtoModel {
  const factory ReportSummaryDtoModel({
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_line_items') int? totalLineItems,
    @JsonKey(name: 'unique_customers') int? uniqueCustomers,
    @JsonKey(name: 'avg_order_amount') double? avgOrderAmount,
    @JsonKey(name: 'avg_items_per_order') double? avgItemsPerOrder,
    @JsonKey(name: 'avg_sales_per_agent') double? avgSalesPerAgent,
    @JsonKey(name: 'avg_sales_per_category') double? avgSalesPerCategory,
    @JsonKey(name: 'avg_sales_per_subplan') double? avgSalesPerSubplan,
  }) = _ReportSummaryDtoModel;

  factory ReportSummaryDtoModel.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryDtoModelFromJson(json);
}

@freezed
class SalesOverviewResponse with _$SalesOverviewResponse {
  const factory SalesOverviewResponse({
    required int count,
    String? next,
    String? previous,
    required List<SalesOverviewDtoModel> results,
  }) = _SalesOverviewResponse;

  factory SalesOverviewResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesOverviewResponseFromJson(json);
}

@freezed
class SalesOverviewDtoModel with _$SalesOverviewDtoModel {
  const factory SalesOverviewDtoModel({
    required String id,
    @JsonKey(name: 'agent_id') String? agentId,
    @JsonKey(name: 'order_total') double? orderTotal,
    @JsonKey(name: 'line_item_count') int? lineItemCount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'agent_first_name') String? agentFirstName,
    @JsonKey(name: 'agent_last_name') String? agentLastName,
    @JsonKey(name: 'agent_code') String? agentCode,
    @JsonKey(name: 'regional_manager_first_name') String? regionalManagerFirstName,
    @JsonKey(name: 'regional_manager_last_name') String? regionalManagerLastName,
    @JsonKey(name: 'regional_manager_code') String? regionalManagerCode,
    @JsonKey(name: 'province_name') String? provinceName,
    @JsonKey(name: 'city_name') String? cityName,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'sub_plan_duration') int? subPlanDuration,
  }) = _SalesOverviewDtoModel;

  factory SalesOverviewDtoModel.fromJson(Map<String, dynamic> json) =>
      _$SalesOverviewDtoModelFromJson(json);
}

@freezed
class SalesByPlanResponse with _$SalesByPlanResponse {
  const factory SalesByPlanResponse({
    required int count,
    String? next,
    String? previous,
    required List<SalesByPlanDtoModel> results,
  }) = _SalesByPlanResponse;

  factory SalesByPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesByPlanResponseFromJson(json);
}

@freezed
class SalesByPlanDtoModel with _$SalesByPlanDtoModel {
  const factory SalesByPlanDtoModel({
    @JsonKey(name: 'sub_plan_id') required String subPlanId,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'sub_plan_duration') int? subPlanDuration,
    @JsonKey(name: 'total_line_items') int? totalLineItems,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
  }) = _SalesByPlanDtoModel;

  factory SalesByPlanDtoModel.fromJson(Map<String, dynamic> json) =>
      _$SalesByPlanDtoModelFromJson(json);
}

@freezed
class SalesByCategoryResponse with _$SalesByCategoryResponse {
  const factory SalesByCategoryResponse({
    required int count,
    String? next,
    String? previous,
    required List<SalesByCategoryDtoModel> results,
  }) = _SalesByCategoryResponse;

  factory SalesByCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesByCategoryResponseFromJson(json);
}

@freezed
class SalesByCategoryDtoModel with _$SalesByCategoryDtoModel {
  const factory SalesByCategoryDtoModel({
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'parent_category_name') String? parentCategoryName,
    @JsonKey(name: 'product_count') int? productCount,
    @JsonKey(name: 'total_line_items') int? totalLineItems,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
  }) = _SalesByCategoryDtoModel;

  factory SalesByCategoryDtoModel.fromJson(Map<String, dynamic> json) =>
      _$SalesByCategoryDtoModelFromJson(json);
}

@freezed
class SalesByProductResponse with _$SalesByProductResponse {
  const factory SalesByProductResponse({
    required int count,
    String? next,
    String? previous,
    required List<SalesByProductDtoModel> results,
  }) = _SalesByProductResponse;

  factory SalesByProductResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesByProductResponseFromJson(json);
}

@freezed
class SalesByProductDtoModel with _$SalesByProductDtoModel {
  const factory SalesByProductDtoModel({
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'product_sku') String? productSku,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'base_price') String? basePrice,
    @JsonKey(name: 'stock_qty') int? stockQty,
    @JsonKey(name: 'total_orders') int? totalOrders,
    @JsonKey(name: 'total_sales_amount') double? totalSalesAmount,
  }) = _SalesByProductDtoModel;

  factory SalesByProductDtoModel.fromJson(Map<String, dynamic> json) =>
      _$SalesByProductDtoModelFromJson(json);
}
