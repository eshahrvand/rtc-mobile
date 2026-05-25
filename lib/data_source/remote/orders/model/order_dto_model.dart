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
