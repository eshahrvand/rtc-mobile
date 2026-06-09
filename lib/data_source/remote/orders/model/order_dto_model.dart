import 'package:freezed_annotation/freezed_annotation.dart';
import '../../customers/model/customer_dto_model.dart';
import '../../wallet/model/wallet_dto_model.dart';
import '../../catalog/model/product_dto_model.dart';

part 'order_dto_model.freezed.dart';

part 'order_dto_model.g.dart';

@freezed
class OrderListResponse with _$OrderListResponse {
  const factory OrderListResponse({
    required int count,
    String? next,
    String? previous,
    required List<OrderDtoModel> results,
  }) = _OrderListResponse;

  factory OrderListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderListResponseFromJson(json);
}

@freezed
class OrderDtoModel with _$OrderDtoModel {
  const factory OrderDtoModel({
    required String id,
    required CustomerDtoModel customer,
    @JsonKey(name: 'sub_plan') required WalletSubPlanDtoModel subPlan,
    required String status,
    required double total,
    @JsonKey(name: 'created_at') required String createdAt,
    List<OrderLineDtoModel>? lines,
    List<OrderDocumentDetailDtoModel>? documents,
    @JsonKey(name: 'rejection_note') String? rejectionNote,
    @JsonKey(name: 'settlement_tracking_code') String? settlementTrackingCode,
    @JsonKey(name: 'delivery_to_agent') bool? deliveryToAgent,
    OrderAgentDtoModel? agent,
    List<PaymentDtoModel>? payments,
    @JsonKey(name: 'remaining_time') RemainingTimeDtoModel? remainingTime,
    @JsonKey(name: 'disbursement_records')
    List<DisbursementRecordDtoModel>? disbursementRecords,
    @JsonKey(name: 'settlement_records')
    List<SettlementRecordDtoModel>? settlementRecords,
    @JsonKey(name: 'assigned_sales_reviewer') String? assignedSalesReviewer,
    @JsonKey(name: 'assigned_finance_reviewer') String? assignedFinanceReviewer,
  }) = _OrderDtoModel;

  factory OrderDtoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoModelFromJson(json);
}

@freezed
class DisbursementRecordDtoModel with _$DisbursementRecordDtoModel {
  const factory DisbursementRecordDtoModel({
    String? gateway,
    required double amount,
    String? reference,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _DisbursementRecordDtoModel;

  factory DisbursementRecordDtoModel.fromJson(Map<String, dynamic> json) =>
      _$DisbursementRecordDtoModelFromJson(json);
}

@freezed
class SettlementRecordDtoModel with _$SettlementRecordDtoModel {
  const factory SettlementRecordDtoModel({
    String? id,
    required double amount,
    @JsonKey(name: 'payment_type') String? paymentType,
    String? status,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'tracking_code') String? trackingCode,
    String? gateway,
    String? reference,
  }) = _SettlementRecordDtoModel;

  factory SettlementRecordDtoModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementRecordDtoModelFromJson(json);
}

@freezed
class PaymentDtoModel with _$PaymentDtoModel {
  const factory PaymentDtoModel({
    String? id,
    required double amount,
    @JsonKey(name: 'payment_type') String? paymentType,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'tracking_code') String? trackingCode,
    String? status,
  }) = _PaymentDtoModel;

  factory PaymentDtoModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoModelFromJson(json);
}

@freezed
class OrderAgentDtoModel with _$OrderAgentDtoModel {
  const factory OrderAgentDtoModel({
    required String id,
    required String mobile,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
  }) = _OrderAgentDtoModel;

  factory OrderAgentDtoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderAgentDtoModelFromJson(json);
}

@freezed
class OrderDocumentDetailDtoModel with _$OrderDocumentDetailDtoModel {
  const factory OrderDocumentDetailDtoModel({
    required String id,
    @JsonKey(name: 'document_type') required String documentType,
    required OrderFileDtoModel file,
    @JsonKey(name: 'uploaded_by_id') String? uploadedById,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _OrderDocumentDetailDtoModel;

  factory OrderDocumentDetailDtoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDocumentDetailDtoModelFromJson(json);
}

@freezed
class OrderFileDtoModel with _$OrderFileDtoModel {
  const factory OrderFileDtoModel({
    required String id,
    required String category,
    @JsonKey(name: 'original_name') required String originalName,
    @JsonKey(name: 'mime_type') required String mimeType,
    @JsonKey(name: 'size_bytes') int? sizeBytes,
    required String file,
  }) = _OrderFileDtoModel;

  factory OrderFileDtoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderFileDtoModelFromJson(json);
}

@freezed
class OrderLineDtoModel with _$OrderLineDtoModel {
  const factory OrderLineDtoModel({
    required String id,
    required OrderProductSummaryDtoModel product,
    required int quantity,
    @JsonKey(name: 'unit_price_at_creation') required double unitPriceAtCreation,
    @JsonKey(name: 'discount_pct_at_creation') double? discountPctAtCreation,
    @JsonKey(name: 'discount_amount_at_creation') double? discountAmountAtCreation,
    @JsonKey(name: 'line_total') required double lineTotal,
  }) = _OrderLineDtoModel;

  factory OrderLineDtoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderLineDtoModelFromJson(json);
}

@freezed
class OrderProductSummaryDtoModel with _$OrderProductSummaryDtoModel {
  const factory OrderProductSummaryDtoModel({
    required String id,
    required String name,
    required String sku,
    @JsonKey(name: 'featured_image') ImageDtoModel? featuredImage,
  }) = _OrderProductSummaryDtoModel;

  factory OrderProductSummaryDtoModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductSummaryDtoModelFromJson(json);
}

@freezed
class OrderCreateRequest with _$OrderCreateRequest {
  const factory OrderCreateRequest({
    @JsonKey(name: 'customer') required String customerId,
    @JsonKey(name: 'sub_plan') required String subPlanId,
    required List<OrderLineRequest> lines,
    required List<OrderDocumentRequest> documents,
    @JsonKey(name: 'delivery_to_agent') required bool deliveryToAgent,
  }) = _OrderCreateRequest;

  factory OrderCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateRequestFromJson(json);
}

@freezed
class OrderLineRequest with _$OrderLineRequest {
  const factory OrderLineRequest({
    @JsonKey(name: 'product') required String productId,
    required int quantity,
  }) = _OrderLineRequest;

  factory OrderLineRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderLineRequestFromJson(json);
}

@freezed
class OrderDocumentRequest with _$OrderDocumentRequest {
  const factory OrderDocumentRequest({
    @JsonKey(name: 'document_type') required String documentType,
    @JsonKey(name: 'file') required String fileId,
  }) = _OrderDocumentRequest;

  factory OrderDocumentRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderDocumentRequestFromJson(json);
}

@freezed
class OrderDocumentResponse with _$OrderDocumentResponse {
  const factory OrderDocumentResponse({
    required String id,
    @JsonKey(name: 'document_type') required String documentType,
    required OrderFileDtoModel file,
    @JsonKey(name: 'uploaded_by_id') required String uploadedById,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _OrderDocumentResponse;

  factory OrderDocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDocumentResponseFromJson(json);
}

@freezed
class RemainingTimeDtoModel with _$RemainingTimeDtoModel {
  const factory RemainingTimeDtoModel({
    required int days,
    required int hours,
    required int minutes,
    required int seconds,
  }) = _RemainingTimeDtoModel;

  factory RemainingTimeDtoModel.fromJson(Map<String, dynamic> json) =>
      _$RemainingTimeDtoModelFromJson(json);
}
