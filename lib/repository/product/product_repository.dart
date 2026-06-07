import '../../data_source/remote/catalog/catalog_service.dart';
import '../../data_source/remote/catalog/model/category_dto_model.dart';
import '../../data_source/remote/catalog/model/product_dto_model.dart';

class ProductRepository {
  final CatalogService _catalogService;

  ProductRepository(this._catalogService);

  Future<CategoryListResponse> getCategories() async {
    return await _catalogService.getCategories();
  }

  Future<ProductListResponse> getProducts({
    String? subPlanId,
    String? categoryId,
    String? search,
    int? page,
    bool? inStock,
  }) async {
    if (subPlanId != null) {
      return await _catalogService.getPlanProducts(
        subPlanId: subPlanId,
        search: search,
        page: page,
        inStock: inStock,
      );
    } else {
      return await _catalogService.getProducts(
        categoryId: categoryId,
        search: search,
        page: page,
        inStock: inStock,
      );
    }
  }

  Future<ProductDtoModel> getProductDetail(
    String productId, {
    String? subPlanId,
  }) async {
    if (subPlanId != null) {
      return await _catalogService.getPlanProductDetail(
        subPlanId: subPlanId,
        id: productId,
      );
    } else {
      return await _catalogService.getProductDetail(productId);
    }
  }
}
