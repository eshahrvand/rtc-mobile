import '../../data_source/remote/catalog/catalog_service.dart';
import '../../data_source/remote/catalog/model/product_dto_model.dart';

class ProductRepository {
  final CatalogService _catalogService;

  ProductRepository(this._catalogService);

  Future<ProductListResponse> getProducts({
    String? subPlanId,
    String? categoryId,
    String? search,
    int? page,
  }) async {
    if (subPlanId != null) {
      return await _catalogService.getPlanProducts(
        sub_plan_id: subPlanId,
        search: search,
        page: page,
      );
    } else {
      return await _catalogService.getProducts(
        categoryId: categoryId,
        search: search,
        page: page,
      );
    }
  }

  Future<ProductDtoModel> getProductDetail(String productId, {String? subPlanId}) async {
    if (subPlanId != null) {
      return await _catalogService.getPlanProductDetail(
        sub_plan_id: subPlanId,
        id: productId,
      );
    } else {
      return await _catalogService.getProductDetail(productId);
    }
  }
}
