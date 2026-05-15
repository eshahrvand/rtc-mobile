import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtc_mobile/config/config.dart';
import '../../../../../data/models/product_detail_model.dart';
import 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailState());

  void init(String productId) {
    emit(state.copyWith(status: ProductDetailRequestStatus.loading));

    // TODO: replace with real repository call
    // sl<ProductRepository>().getProductDetail(productId)

    // Mock data based on screenshots
    final mockProduct = ProductDetailModel(
      id: productId,
      name: 'یخچال ۵۵ فوت RTC مدل Smart TV 4K مدل COOLING 880',
      price: '۲۲,۴۹۰,۰۰۰',
      oldPrice: '۲۸,۹۰۰,۰۰۰',
      discountPercent: '۲۰٪',
      imageUrls: List.generate(5, (_) => '$baseImage/frame1.png'),
      badges: [
        ProductBadgeModel(label: 'موجودی', value: '۱۲ عدد'),
        ProductBadgeModel(label: 'دسته بندی', value: 'یخچال فریزر'),
        ProductBadgeModel(label: 'SKU', value: '۱۲۳۴۵۶۷۸'),
      ],
      specs: [
        ProductSpecModel(key: 'با ضمانت', value: '۲۴ ماهه پاسارگاد'),
        ProductSpecModel(key: 'گنجایش قسمت یخچال', value: '۳۶۰ لیتر'),
        ProductSpecModel(key: 'گنجایش قسمت فریزر', value: '۹۰ لیتر'),
        ProductSpecModel(key: 'رنگ', value: 'سفید و سیلور'),
        ProductSpecModel(key: 'دارای موتور اینورتر', value: '(کم مصرف)'),
        ProductSpecModel(key: 'دارای آبریز متصل به آب شهر', value: ''),
        ProductSpecModel(key: 'نوفراست', value: '(بدون برفک)'),
        ProductSpecModel(key: 'قابلیت انجماد سریع', value: '(فقط برای فریزر)'),
        ProductSpecModel(key: 'کشوی میوه و سبزیجات', value: 'دارد'),
        ProductSpecModel(key: 'نور لمسی عمودی', value: ''),
        ProductSpecModel(key: 'طبقات شیشه ای نشکن', value: ''),
        ProductSpecModel(key: 'سطح مصرف انرژی', value: 'A+ در یخچال'),
        ProductSpecModel(key: 'تکنولوژی سیستم هوای چندگانه', value: ''),
        ProductSpecModel(key: 'یخساز اتوماتیک فقط در فریزر', value: ''),
        ProductSpecModel(key: 'ابعاد', value: '۱۸۰ * ۴۰ * ۱۶ (سانتی متر)'),
        ProductSpecModel(key: '۷ روز تضمین بازگشت کالا', value: ''),
      ],
      description: 'یخچال فریزر دوقلو از ال تی سی مدل ۸۸۰ موتور اینورتر در گریدهای مختلف و فریزر دوقلو در سی تی سی قرار می گیرند. گنجایش بالای دستگاه امکان سود دهی و فریز کردن مقدار زیادی مواد غذایی را فراهم می کند. قسمت یخچال دوقلو ال تی سی مدل ۸۸۰ دارای ۵ طبقه است که در کشور پایین ترین قسمت آن ۳ کشو قرار گرفته شده است.',
    );

    // Following .then().catchError() pattern as requested
    Future.delayed(const Duration(milliseconds: 500))
        .then((_) {
          emit(state.copyWith(
            status: ProductDetailRequestStatus.success,
            product: mockProduct,
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
