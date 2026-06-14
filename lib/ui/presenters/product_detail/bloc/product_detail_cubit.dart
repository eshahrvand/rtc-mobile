import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../../data/models/product_detail_model.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../../locator.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailState());

  final _productRepo = sl<ProductRepository>();

  void init(String productId, {String? subPlanId, String? subPlanName}) {
    emit(state.copyWith(status: ProductDetailRequestStatus.loading));

    _productRepo
        .getProductDetail(productId, subPlanId: subPlanId)
        .then((dto) {
          final List<ProductBadgeModel> badges = [];


          if (subPlanId != null) {
            badges.add(
              ProductBadgeModel(
                label: 'طرح',
                value: subPlanName ?? dto.name,
                iconPath: null,
              ),
            );
          }

          if (dto.stockQty > 0) {
            badges.add(
              ProductBadgeModel(label: 'موجودی', value: '${dto.stockQty} عدد'),
            );
          } else {
            badges.add(ProductBadgeModel(label: 'ناموجود', value: ''));
          }

          badges.addAll([
            ProductBadgeModel(label: 'دسته بندی', value: dto.category.name),
            ProductBadgeModel(label: 'SKU', value: dto.sku),
          ]);

          final List<String> imageUrls = [];
          if (dto.featuredImage != null) {
            imageUrls.add(dto.featuredImage!.file);
          }
          if (dto.images != null && dto.images!.isNotEmpty) {
            imageUrls.addAll(dto.images!.map((i) => i.image.file));
          }

          final model = ProductDetailModel(
            id: dto.id,
            name: dto.name,
            price: subPlanId != null
                ? dto.planPrice?.toString() ?? '۰'
                : dto.basePrice?.toString() ?? '۰',
            oldPrice: subPlanId != null ? dto.basePrice?.toString() ?? '' : '',
            discountPercent: dto.discountPct != null && dto.discountPct != 0
                ? '${dto.discountPct}%'
                : '۰',
            imageUrls: imageUrls.isNotEmpty ? imageUrls : [''],
            badges: badges,
            specs: [
              if (dto.technicalDetail != null)
                ProductSpecModel(
                  key: 'مشخصات فنی',
                  value: dto.technicalDetail!,
                ),
            ],
            description: dto.description ?? '',
          );

          emit(
            state.copyWith(
              status: ProductDetailRequestStatus.success,
              product: model,
            ),
          );
        })
        .catchError(_handleError);
  }

  void onImageSelected(int index) {
    emit(state.copyWith(selectedImageIndex: index));
  }

  void _handleError(Object e) {
    if (isClosed) return;

    NetworkHelper.getNetworkErrorMessage().then((networkMessage) {
      if (isClosed) return;

      final finalMessage = networkMessage ?? e.toString();

      emit(
        state.copyWith(
          status: ProductDetailRequestStatus.error,
          errorMessage: finalMessage,
        ),
      );
    });
  }
}
