import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../data/models/product_detail_model.dart';

part 'product_detail_state.freezed.dart';

enum ProductDetailRequestStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState({
    @Default(ProductDetailRequestStatus.initial) ProductDetailRequestStatus status,
    @Default('') String errorMessage,
    ProductDetailModel? product,
    @Default(0) int selectedImageIndex,
  }) = _ProductDetailState;
}
