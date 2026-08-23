// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderListResponseImpl _$$OrderListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$OrderListResponseImpl(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => OrderDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$OrderListResponseImplToJson(
  _$OrderListResponseImpl instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

_$OrderDtoModelImpl _$$OrderDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderDtoModelImpl(
  id: json['id'] as String,
  customer: CustomerDtoModel.fromJson(json['customer'] as Map<String, dynamic>),
  subPlan: WalletSubPlanDtoModel.fromJson(
    json['sub_plan'] as Map<String, dynamic>,
  ),
  status: json['status'] as String,
  total: (json['total'] as num).toDouble(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String?,
  lines: (json['lines'] as List<dynamic>?)
      ?.map((e) => OrderLineDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  documents: (json['documents'] as List<dynamic>?)
      ?.map(
        (e) => OrderDocumentDetailDtoModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  rejectionNote: json['rejection_note'] as String?,
  settlementTrackingCode: json['settlement_tracking_code'] as String?,
  deliveryToAgent: json['delivery_to_agent'] as bool?,
  agent: json['agent'] == null
      ? null
      : OrderAgentDtoModel.fromJson(json['agent'] as Map<String, dynamic>),
  payments: (json['payments'] as List<dynamic>?)
      ?.map((e) => PaymentDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  remainingTime: json['remaining_time'] == null
      ? null
      : RemainingTimeDtoModel.fromJson(
          json['remaining_time'] as Map<String, dynamic>,
        ),
  disbursementRecords: (json['disbursement_records'] as List<dynamic>?)
      ?.map(
        (e) => DisbursementRecordDtoModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  settlementRecords: (json['settlement_records'] as List<dynamic>?)
      ?.map((e) => SettlementRecordDtoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  assignedSalesReviewer: json['assigned_sales_reviewer'] as String?,
  assignedFinanceReviewer: json['assigned_finance_reviewer'] as String?,
);

Map<String, dynamic> _$$OrderDtoModelImplToJson(_$OrderDtoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer': instance.customer,
      'sub_plan': instance.subPlan,
      'status': instance.status,
      'total': instance.total,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'lines': instance.lines,
      'documents': instance.documents,
      'rejection_note': instance.rejectionNote,
      'settlement_tracking_code': instance.settlementTrackingCode,
      'delivery_to_agent': instance.deliveryToAgent,
      'agent': instance.agent,
      'payments': instance.payments,
      'remaining_time': instance.remainingTime,
      'disbursement_records': instance.disbursementRecords,
      'settlement_records': instance.settlementRecords,
      'assigned_sales_reviewer': instance.assignedSalesReviewer,
      'assigned_finance_reviewer': instance.assignedFinanceReviewer,
    };

_$DisbursementRecordDtoModelImpl _$$DisbursementRecordDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$DisbursementRecordDtoModelImpl(
  gateway: json['gateway'] as String?,
  amount: (json['amount'] as num).toDouble(),
  reference: json['reference'] as String?,
  status: json['status'] as String?,
  createdAt: json['created_at'] as String?,
  gatewayMetadata: json['gateway_metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$DisbursementRecordDtoModelImplToJson(
  _$DisbursementRecordDtoModelImpl instance,
) => <String, dynamic>{
  'gateway': instance.gateway,
  'amount': instance.amount,
  'reference': instance.reference,
  'status': instance.status,
  'created_at': instance.createdAt,
  'gateway_metadata': instance.gatewayMetadata,
};

_$SettlementRecordDtoModelImpl _$$SettlementRecordDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$SettlementRecordDtoModelImpl(
  id: json['id'] as String?,
  amount: (json['amount'] as num).toDouble(),
  paymentType: json['payment_type'] as String?,
  status: json['status'] as String?,
  createdAt: json['created_at'] as String?,
  trackingCode: json['tracking_code'] as String?,
  gateway: json['gateway'] as String?,
  reference: json['reference'] as String?,
);

Map<String, dynamic> _$$SettlementRecordDtoModelImplToJson(
  _$SettlementRecordDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'payment_type': instance.paymentType,
  'status': instance.status,
  'created_at': instance.createdAt,
  'tracking_code': instance.trackingCode,
  'gateway': instance.gateway,
  'reference': instance.reference,
};

_$PaymentDtoModelImpl _$$PaymentDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$PaymentDtoModelImpl(
  id: json['id'] as String?,
  amount: (json['amount'] as num).toDouble(),
  paymentType: json['payment_type'] as String?,
  createdAt: json['created_at'] as String?,
  trackingCode: json['tracking_code'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$$PaymentDtoModelImplToJson(
  _$PaymentDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'payment_type': instance.paymentType,
  'created_at': instance.createdAt,
  'tracking_code': instance.trackingCode,
  'status': instance.status,
};

_$OrderAgentDtoModelImpl _$$OrderAgentDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderAgentDtoModelImpl(
  id: json['id'] as String,
  mobile: json['mobile'] as String,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
);

Map<String, dynamic> _$$OrderAgentDtoModelImplToJson(
  _$OrderAgentDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'mobile': instance.mobile,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
};

_$OrderDocumentDetailDtoModelImpl _$$OrderDocumentDetailDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderDocumentDetailDtoModelImpl(
  id: json['id'] as String,
  documentType: json['document_type'] as String,
  file: OrderFileDtoModel.fromJson(json['file'] as Map<String, dynamic>),
  uploadedById: json['uploaded_by_id'] as String?,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$$OrderDocumentDetailDtoModelImplToJson(
  _$OrderDocumentDetailDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'document_type': instance.documentType,
  'file': instance.file,
  'uploaded_by_id': instance.uploadedById,
  'created_at': instance.createdAt,
};

_$OrderFileDtoModelImpl _$$OrderFileDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderFileDtoModelImpl(
  id: json['id'] as String,
  category: json['category'] as String,
  originalName: json['original_name'] as String,
  mimeType: json['mime_type'] as String,
  sizeBytes: (json['size_bytes'] as num?)?.toInt(),
  file: json['file'] as String,
);

Map<String, dynamic> _$$OrderFileDtoModelImplToJson(
  _$OrderFileDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'original_name': instance.originalName,
  'mime_type': instance.mimeType,
  'size_bytes': instance.sizeBytes,
  'file': instance.file,
};

_$OrderLineDtoModelImpl _$$OrderLineDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderLineDtoModelImpl(
  id: json['id'] as String,
  product: OrderProductSummaryDtoModel.fromJson(
    json['product'] as Map<String, dynamic>,
  ),
  quantity: (json['quantity'] as num).toInt(),
  unitPriceAtCreation: (json['unit_price_at_creation'] as num).toDouble(),
  discountPctAtCreation: (json['discount_pct_at_creation'] as num?)?.toDouble(),
  discountAmountAtCreation: (json['discount_amount_at_creation'] as num?)
      ?.toDouble(),
  lineTotal: (json['line_total'] as num).toDouble(),
);

Map<String, dynamic> _$$OrderLineDtoModelImplToJson(
  _$OrderLineDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'product': instance.product,
  'quantity': instance.quantity,
  'unit_price_at_creation': instance.unitPriceAtCreation,
  'discount_pct_at_creation': instance.discountPctAtCreation,
  'discount_amount_at_creation': instance.discountAmountAtCreation,
  'line_total': instance.lineTotal,
};

_$OrderProductSummaryDtoModelImpl _$$OrderProductSummaryDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$OrderProductSummaryDtoModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  sku: json['sku'] as String,
  featuredImage: json['featured_image'] == null
      ? null
      : ImageDtoModel.fromJson(json['featured_image'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$OrderProductSummaryDtoModelImplToJson(
  _$OrderProductSummaryDtoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sku': instance.sku,
  'featured_image': instance.featuredImage,
};

_$OrderCreateRequestImpl _$$OrderCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OrderCreateRequestImpl(
  customerId: json['customer'] as String,
  subPlanId: json['sub_plan'] as String,
  lines: (json['lines'] as List<dynamic>)
      .map((e) => OrderLineRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
  documents: (json['documents'] as List<dynamic>)
      .map((e) => OrderDocumentRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
  deliveryToAgent: json['delivery_to_agent'] as bool,
);

Map<String, dynamic> _$$OrderCreateRequestImplToJson(
  _$OrderCreateRequestImpl instance,
) => <String, dynamic>{
  'customer': instance.customerId,
  'sub_plan': instance.subPlanId,
  'lines': instance.lines,
  'documents': instance.documents,
  'delivery_to_agent': instance.deliveryToAgent,
};

_$OrderLineRequestImpl _$$OrderLineRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OrderLineRequestImpl(
  productId: json['product'] as String,
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$$OrderLineRequestImplToJson(
  _$OrderLineRequestImpl instance,
) => <String, dynamic>{
  'product': instance.productId,
  'quantity': instance.quantity,
};

_$OrderDocumentRequestImpl _$$OrderDocumentRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OrderDocumentRequestImpl(
  documentType: json['document_type'] as String,
  fileId: json['file'] as String,
);

Map<String, dynamic> _$$OrderDocumentRequestImplToJson(
  _$OrderDocumentRequestImpl instance,
) => <String, dynamic>{
  'document_type': instance.documentType,
  'file': instance.fileId,
};

_$OrderDocumentResponseImpl _$$OrderDocumentResponseImplFromJson(
  Map<String, dynamic> json,
) => _$OrderDocumentResponseImpl(
  id: json['id'] as String,
  documentType: json['document_type'] as String,
  file: OrderFileDtoModel.fromJson(json['file'] as Map<String, dynamic>),
  uploadedById: json['uploaded_by_id'] as String,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$$OrderDocumentResponseImplToJson(
  _$OrderDocumentResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'document_type': instance.documentType,
  'file': instance.file,
  'uploaded_by_id': instance.uploadedById,
  'created_at': instance.createdAt,
};

_$RemainingTimeDtoModelImpl _$$RemainingTimeDtoModelImplFromJson(
  Map<String, dynamic> json,
) => _$RemainingTimeDtoModelImpl(
  days: (json['days'] as num).toInt(),
  hours: (json['hours'] as num).toInt(),
  minutes: (json['minutes'] as num).toInt(),
  seconds: (json['seconds'] as num).toInt(),
);

Map<String, dynamic> _$$RemainingTimeDtoModelImplToJson(
  _$RemainingTimeDtoModelImpl instance,
) => <String, dynamic>{
  'days': instance.days,
  'hours': instance.hours,
  'minutes': instance.minutes,
  'seconds': instance.seconds,
};
