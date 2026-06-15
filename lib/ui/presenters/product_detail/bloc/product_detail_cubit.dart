import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/network_helper.dart';
import '../../../../data/models/product_detail_model.dart';
import '../../../../generated/l10n.dart';
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
                label: S.current.plan,
                value: subPlanName ?? dto.name,
                iconPath: null,
              ),
            );
          }

          if (dto.stockQty > 0) {
            badges.add(
              ProductBadgeModel(
                label: S.current.inventory,
                value: '${dto.stockQty} ${S.current.unitCount}',
              ),
            );
          } else {
            badges.add(
              ProductBadgeModel(label: S.current.outOfStockLabel, value: ''),
            );
          }

          badges.addAll([
            ProductBadgeModel(
              label: S.current.category,
              value: dto.category.name,
            ),
            ProductBadgeModel(label: S.current.sku, value: dto.sku),
          ]);

          final List<String> imageUrls = [];
          if (dto.featuredImage != null) {
            imageUrls.add(dto.featuredImage!.file);
          }
          if (dto.images != null && dto.images!.isNotEmpty) {
            imageUrls.addAll(dto.images!.map((i) => i.image.file));
          }

          final formatter = NumberFormat('#,###', 'en_US');

          final currentPrice = subPlanId != null
              ? dto.planPrice ?? 0
              : dto.basePrice ?? 0;

          num? finalOldPrice = dto.oldPrice;

          if (finalOldPrice == null &&
              dto.discountPct != null &&
              dto.discountPct! > 0) {
            finalOldPrice = currentPrice / (1 - (dto.discountPct! / 100));
          }

          if (subPlanId == null) {
            finalOldPrice ??= dto.basePrice;
          }

          final model = ProductDetailModel(
            id: dto.id,
            name: dto.name,
            price: formatter.format(currentPrice),
            oldPrice: finalOldPrice != null ? formatter.format(finalOldPrice) : '',
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
        .catchError((e) {
          _handleError(e);
          return null;
        });
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
