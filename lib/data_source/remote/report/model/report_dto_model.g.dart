// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportSummaryDtoModelImpl _$$ReportSummaryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$ReportSummaryDtoModelImpl(
  totalSalesAmount: (json['total_sales_amount'] as num?)?.toDouble(),
  totalOrders: (json['total_orders'] as num?)?.toInt(),
  totalLineItems: (json['total_line_items'] as num?)?.toInt(),
  uniqueCustomers: (json['unique_customers'] as num?)?.toInt(),
  avgOrderAmount: (json['avg_order_amount'] as num?)?.toDouble(),
  avgItemsPerOrder: (json['avg_items_per_order'] as num?)?.toDouble(),
  avgSalesPerAgent: (json['avg_sales_per_agent'] as num?)?.toDouble(),
  avgSalesPerCategory: (json['avg_sales_per_category'] as num?)?.toDouble(),
  avgSalesPerSubplan: (json['avg_sales_per_subplan'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$ReportSummaryDtoModelImplToJson(
  _$ReportSummaryDtoModelImpl instance,
) => <String, dynamic>{
  'total_sales_amount': instance.totalSalesAmount,
  'total_orders': instance.totalOrders,
  'total_line_items': instance.totalLineItems,
  'unique_customers': instance.uniqueCustomers,
  'avg_order_amount': instance.avgOrderAmount,
  'avg_items_per_order': instance.avgItemsPerOrder,
  'avg_sales_per_agent': instance.avgSalesPerAgent,
  'avg_sales_per_category': instance.avgSalesPerCategory,
  'avg_sales_per_subplan': instance.avgSalesPerSubplan,
};

_$SalesOverviewResponseImpl _$$SalesOverviewResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SalesOverviewResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => SalesOverviewDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SalesOverviewResponseImplToJson(
  _$SalesOverviewResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$SalesOverviewDtoModelImpl _$$SalesOverviewDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$SalesOverviewDtoModelImpl(
  id: json['id'] as String,
  agentId: json['agent_id'] as String?,
  orderTotal: (json['order_total'] as num?)?.toDouble(),
  lineItemCount: (json['line_item_count'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
  agentFirstName: json['agent_first_name'] as String?,
  agentLastName: json['agent_last_name'] as String?,
  agentCode: json['agent_code'] as String?,
  regionalManagerFirstName: json['regional_manager_first_name'] as String?,
  regionalManagerLastName: json['regional_manager_last_name'] as String?,
  regionalManagerCode: json['regional_manager_code'] as String?,
  provinceName: json['province_name'] as String?,
  cityName: json['city_name'] as String?,
  planName: json['plan_name'] as String?,
  subPlanDuration: (json['sub_plan_duration'] as num?)?.toInt(),
);

Map<String, dynamic> _$$SalesOverviewDtoModelImplToJson(
  _$SalesOverviewDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'agent_id': instance.agentId,
  'order_total': instance.orderTotal,
  'line_item_count': instance.lineItemCount,
  'created_at': instance.createdAt,
  'agent_first_name': instance.agentFirstName,
  'agent_last_name': instance.agentLastName,
  'agent_code': instance.agentCode,
  'regional_manager_first_name': instance.regionalManagerFirstName,
  'regional_manager_last_name': instance.regionalManagerLastName,
  'regional_manager_code': instance.regionalManagerCode,
  'province_name': instance.provinceName,
  'city_name': instance.cityName,
  'plan_name': instance.planName,
  'sub_plan_duration': instance.subPlanDuration,
};

_$SalesByPlanResponseImpl _$$SalesByPlanResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SalesByPlanResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => SalesByPlanDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SalesByPlanResponseImplToJson(
  _$SalesByPlanResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$SalesByPlanDtoModelImpl _$$SalesByPlanDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$SalesByPlanDtoModelImpl(
  subPlanId: json['sub_plan_id'] as String,
  planName: json['plan_name'] as String?,
  subPlanDuration: (json['sub_plan_duration'] as num?)?.toInt(),
  totalLineItems: (json['total_line_items'] as num?)?.toInt(),
  totalOrders: (json['total_orders'] as num?)?.toInt(),
  totalSalesAmount: (json['total_sales_amount'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$SalesByPlanDtoModelImplToJson(
  _$SalesByPlanDtoModelImpl instance,
) => <String, dynamic>{
  'sub_plan_id': instance.subPlanId,
  'plan_name': instance.planName,
  'sub_plan_duration': instance.subPlanDuration,
  'total_line_items': instance.totalLineItems,
  'total_orders': instance.totalOrders,
  'total_sales_amount': instance.totalSalesAmount,
};

_$SalesByCategoryResponseImpl _$$SalesByCategoryResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SalesByCategoryResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => SalesByCategoryDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SalesByCategoryResponseImplToJson(
  _$SalesByCategoryResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$SalesByCategoryDtoModelImpl _$$SalesByCategoryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$SalesByCategoryDtoModelImpl(
  categoryId: json['category_id'] as String,
  categoryName: json['category_name'] as String?,
  parentCategoryName: json['parent_category_name'] as String?,
  productCount: (json['product_count'] as num?)?.toInt(),
  totalLineItems: (json['total_line_items'] as num?)?.toInt(),
  totalOrders: (json['total_orders'] as num?)?.toInt(),
  totalSalesAmount: (json['total_sales_amount'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$SalesByCategoryDtoModelImplToJson(
  _$SalesByCategoryDtoModelImpl instance,
) => <String, dynamic>{
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'parent_category_name': instance.parentCategoryName,
  'product_count': instance.productCount,
  'total_line_items': instance.totalLineItems,
  'total_orders': instance.totalOrders,
  'total_sales_amount': instance.totalSalesAmount,
};

_$SalesByProductResponseImpl _$$SalesByProductResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SalesByProductResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => SalesByProductDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$SalesByProductResponseImplToJson(
  _$SalesByProductResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$SalesByProductDtoModelImpl _$$SalesByProductDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$SalesByProductDtoModelImpl(
  productId: json['product_id'] as String,
  productName: json['product_name'] as String?,
  productSku: json['product_sku'] as String?,
  categoryName: json['category_name'] as String?,
  basePrice: json['base_price'] as String?,
  stockQty: (json['stock_qty'] as num?)?.toInt(),
  totalOrders: (json['total_orders'] as num?)?.toInt(),
  totalSalesAmount: (json['total_sales_amount'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$SalesByProductDtoModelImplToJson(
  _$SalesByProductDtoModelImpl instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'product_name': instance.productName,
  'product_sku': instance.productSku,
  'category_name': instance.categoryName,
  'base_price': instance.basePrice,
  'stock_qty': instance.stockQty,
  'total_orders': instance.totalOrders,
  'total_sales_amount': instance.totalSalesAmount,
};
