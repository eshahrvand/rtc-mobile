import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'model/category_dto_model.dart';
import 'model/product_dto_model.dart';

part 'catalog_service.g.dart';

@RestApi()
abstract class CatalogService {
  factory CatalogService(Dio dio, {String baseUrl}) = _CatalogService;

  @GET('catalog/categories')
  Future<CategoryListResponse> getCategories();

  // Type 1: General Catalog
  @GET('catalog/products')
  Future<ProductListResponse> getProducts({
    @Query('category') String? categoryId,
    @Query('in_stock') bool? inStock,
    @Query('is_active') bool? isActive,
    @Query('ordering') String? ordering,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
    @Query('search') String? search,
    @Query('sub_plan') String? subPlanId,
  });

  @GET('catalog/products/{id}')
  Future<ProductDtoModel> getProductDetail(@Path('id') String id);

  // Type 2: Plan-based Catalog
  @GET('plans/sub-plans/{sub_plan_id}/products')
  Future<ProductListResponse> getPlanProducts({
    @Path('sub_plan_id') required String subPlanId,
    @Query('ordering') String? ordering,
    @Query('page') int? page,
    @Query('page_size') int? pageSize,
    @Query('search') String? search,
  });

  @GET('plans/sub-plans/{sub_plan_id}/products/{id}')
  Future<ProductDtoModel> getPlanProductDetail({
    @Path('sub_plan_id') required String subPlanId,
    @Path('id') required String id,
  });
}
