import 'package:freezed_annotation/freezed_annotation.dart';
import '../../customers/model/customer_dto_model.dart';
import '../../wallet/model/wallet_dto_model.dart';

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

  factory OrderListResponse.fromJson(Map<String, dynamic> json) => _$OrderListResponseFromJson(json);
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
  }) = _OrderDtoModel;

  factory OrderDtoModel.fromJson(Map<String, dynamic> json) => _$OrderDtoModelFromJson(json);
}

@freezed
class OrderCreateRequest with _$OrderCreateRequest {
  const factory OrderCreateRequest({
    @JsonKey(name: 'customer_id') required String customerId,
    @JsonKey(name: 'sub_plan_id') required String subPlanId,
    required List<OrderLineRequest> lines,
    @JsonKey(name: 'delivery_to_agent') required bool deliveryToAgent,
  }) = _OrderCreateRequest;

  factory OrderCreateRequest.fromJson(Map<String, dynamic> json) => _$OrderCreateRequestFromJson(json);
}

@freezed
class OrderLineRequest with _$OrderLineRequest {
  const factory OrderLineRequest({
    @JsonKey(name: 'product_id') required String productId,
    required int quantity,
  }) = _OrderLineRequest;

  factory OrderLineRequest.fromJson(Map<String, dynamic> json) => _$OrderLineRequestFromJson(json);
}

@freezed
class OrderDocumentRequest with _$OrderDocumentRequest {
  const factory OrderDocumentRequest({
    @JsonKey(name: 'document_type') required String documentType,
    @JsonKey(name: 'file_id') required String fileId,
  }) = _OrderDocumentRequest;

  factory OrderDocumentRequest.fromJson(Map<String, dynamic> json) => _$OrderDocumentRequestFromJson(json);
}

@freezed
class OrderDocumentResponse with _$OrderDocumentResponse {
  const factory OrderDocumentResponse({
    required String id,
    @JsonKey(name: 'document_type') required String documentType,
    @JsonKey(name: 'file_id') required String fileId,
    @JsonKey(name: 'uploaded_by_id') required String uploadedById,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _OrderDocumentResponse;

  factory OrderDocumentResponse.fromJson(Map<String, dynamic> json) => _$OrderDocumentResponseFromJson(json);
}
