import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/product_detail_model.dart';
import '../../../../repository/product/product_repository.dart';
import '../../../../locator.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailState());

  final _productRepo = sl<ProductRepository>();

  void init(String productId, {String? subPlanId}) {
    emit(state.copyWith(status: ProductDetailRequestStatus.loading));

    _productRepo.getProductDetail(productId, subPlanId: subPlanId)
        .then((dto) {
          final model = ProductDetailModel(
            id: dto.id,
            name: dto.name,
            price: subPlanId != null 
                ? dto.planPrice?.toString() ?? '۰' 
                : dto.basePrice?.toString() ?? '۰',
            oldPrice: subPlanId != null ? dto.basePrice?.toString() ?? '' : '',
            discountPercent: dto.discountPct?.toString() ?? '۰',
            imageUrls: dto.images?.isNotEmpty == true
                ? dto.images!.map((i) => i.image.file).toList()
                : [dto.featuredImage?.file ?? ''],
            badges: [
               ProductBadgeModel(label: 'موجودی', value: '${dto.stockQty} عدد'),
               ProductBadgeModel(label: 'دسته بندی', value: dto.category.name),
               ProductBadgeModel(label: 'SKU', value: dto.sku),
            ],
            specs: [
              if (dto.technicalDetail != null)
                ProductSpecModel(key: 'مشخصات فنی', value: dto.technicalDetail!),
            ],
            description: dto.description ?? '',
          );

          emit(state.copyWith(
            status: ProductDetailRequestStatus.success,
            product: model,
          ));
        })
        .catchError((Object e) {
          emit(state.copyWith(
            status: ProductDetailRequestStatus.error,
            errorMessage: e.toString(),
          ));
        });
  }

  void onImageSelected(int index) {
    emit(state.copyWith(selectedImageIndex: index));
  }
}
