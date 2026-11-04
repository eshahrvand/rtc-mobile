// Development-only fixtures. Never imported by the production entry point.
import 'package:fl_chart/fl_chart.dart';
import '../../core/models/workspace_models.dart';
import '../../core/models/pre_invoice_model.dart';
import '../../core/models/order_model.dart';
import '../../core/models/line_chart_data_model.dart';
import '../../core/models/quick_access_item_model.dart';
import '../../data_source/remote/profile/model/user_profile_dto_model.dart';
import '../../generated/l10n.dart';
import '../../repository/workspace/workspace_repository.dart';
import '../presenters/dashboard/bloc/dashboard_state.dart';
import '../presenters/dashboard/bloc/dashboard_cubit.dart';
import '../presenters/pre_invoice/bloc/pre_invoice_state.dart';
import '../presenters/pre_invoice/bloc/pre_invoice_cubit.dart';
import '../presenters/orders/bloc/orders_state.dart';
import '../presenters/orders/bloc/orders_cubit.dart';

class WorkspacePreviewData {
  bool accepted = false;
  int nextEmployee = 10;
  final employees = <BranchEmployee>[
    const BranchEmployee(
      id: '1',
      branchId: '1',
      firstName: 'علی',
      lastName: 'موسوی',
      nationalId: '0081234562',
      mobile: '09121234325',
      position: 'حسابدار فروشگاه',
      avatar: 'assets/images/workspace_preview_employee.png',
    ),
    const BranchEmployee(
      id: '2',
      branchId: '1',
      firstName: 'مازیار',
      lastName: 'جلالی',
      nationalId: '0081234562',
      mobile: '09121234325',
      position: 'حسابدار فروشگاه',
      isActive: false,
    ),
    const BranchEmployee(
      id: '3',
      branchId: '1',
      firstName: 'علی',
      lastName: 'سروش',
      nationalId: '0081234562',
      mobile: '09121234325',
      position: 'حسابدار فروشگاه',
    ),
  ];
  static const address = 'تجریش، ابتدای شریعتی، کوچه پروین، پلاک ۲۸، زنگ ۳';
  static const branches = [
    BranchInfo(
      id: '1',
      name: 'تهران - ارگ',
      province: 'تهران',
      city: 'تهران',
      postalCode: '1234567890',
      address: address,
    ),
    BranchInfo(
      id: '2',
      name: 'تهران - جمهوری',
      province: 'تهران',
      city: 'تهران',
      postalCode: '1234567890',
      address: address,
      isActive: false,
    ),
    BranchInfo(
      id: '3',
      name: 'مشهد - ارگ',
      province: 'خراسان رضوی',
      city: 'مشهد',
      postalCode: '1234567890',
      address: address,
    ),
  ];
  static const termsBody =
      'ابزاری است که توسط بانک صادر می‌شود و امکان پرداخت وجه از دارنده آن به پذیرنده را فراهم می‌سازد. در این «ضوابط»، «کیف الکترونیک پول» اختصاراً «کیف» نامیده می‌شود. انجام تراکنش افزایش موجودی کیف، صرفاً پس از صدور آن امکان‌پذیر خواهد بود. به مانده موجودی «کیف»، هیچ سودی تعلق نمی‌گیرد. انجام تراکنش کاهش موجودی موردی حسب توافق با دارنده کیف و به درخواست وی امکان‌پذیر است. سقف تراکنش کیف پول در هر تراکنش ۲٬۰۰۰٬۰۰۰ ریال (معادل دویست هزار تومان) و سقف شارژ و خرید روزانه ۳۰٬۰۰۰٬۰۰۰ ریال (معادل سه میلیون تومان) می‌باشد. حداکثر مانده کیف پول نمی‌تواند بیش از ۳۰٬۰۰۰٬۰۰۰ ریال باشد.';
  TermsDocument get terms => TermsDocument(
    version: '3',
    versionLabel: 'نسخه ۳ - آبان ۱۴۰۵',
    publishedAt: '۱۴۰۵/۰۸/۰۵ - ۱۲:۵۰',
    acceptedAt: accepted ? '۱۴۰۵/۰۸/۱۴ - ۱۰:۰۰' : null,
    markdown:
        '### ضوابط و شرایط ارسال به آدرس مشتری\n\n$termsBody\n\n---\n\n### ضوابط ریفاند\n\n$termsBody',
  );
  TermsDocument get updateTerms => TermsDocument(
    version: '3',
    versionLabel: 'نسخه ۳ - آبان ۱۴۰۵',
    publishedAt: '۱۴۰۵/۰۸/۰۵',
    markdown:
        '### قوانین کیف پول\n\n$termsBody\n\n### قوانین ارسال کالا\n\n$termsBody',
  );
  late final repository = WorkspaceRepository(
    loadTerms: () => Future.value(terms),
    acceptTerms: (version) {
      accepted = true;
      return Future.value(terms);
    },
    checkTerms: () => Future.value(accepted),
    loadBranches: () => Future.value(branches),
    searchBranches: (query) => Future.value(
      branches
          .where(
            (branch) => '${branch.name} ${branch.province} ${branch.city}'
                .contains(query.trim()),
          )
          .toList(),
    ),
    loadEmployees: (id) => Future.value(
      employees.where((employee) => employee.branchId == id).toList(),
    ),
    saveEmployee: (employee) {
      final saved = BranchEmployee(
        id: employee.id.isEmpty ? '${nextEmployee++}' : employee.id,
        branchId: employee.branchId,
        firstName: employee.firstName,
        lastName: employee.lastName,
        nationalId: employee.nationalId,
        mobile: employee.mobile,
        position: employee.position,
        isActive: employee.isActive,
        avatar: employee.avatar,
      );
      employees.removeWhere((item) => item.id == saved.id);
      employees.add(saved);
      return Future.value(saved);
    },
    deleteEmployee: (id) {
      employees.removeWhere((employee) => employee.id == id);
      return Future.value();
    },
    uploadAvatar: (file, userId) => Future.value(file.path),
    submitRefund: (id) => Future.value(),
    loadBanners: () => Future.value(const [
      HomeBanner(
        id: '1',
        image: 'assets/images/workspace_rectangle34625738.png',
        imageAlignmentX: -.9,
        imageScale: 1.0426,
        height: 113,
      ),
      HomeBanner(
        id: '2',
        image: 'assets/images/workspace_rectangle34625736.png',
        imageScale: 1.0423,
        height: 113,
      ),
      HomeBanner(
        id: '3',
        image: 'assets/images/workspace_rectangle34625738.png',
        imageAlignmentX: -.9,
        imageScale: 1.0426,
        height: 113,
      ),
    ]),
  );

  UserProfileDtoModel profile({bool employee = false, bool legal = false}) =>
      UserProfileDtoModel(
        id: 'preview',
        mobile: '09121234325',
        role: employee ? 'employee' : 'agent',
        firstName: employee ? 'مازیار' : 'آرش',
        lastName: employee ? 'جلالی' : 'فرداد',
        isActive: true,
        dateJoined: '2026-01-01',
        agentType: legal ? 'legal' : 'natural',
        email: 'Arash.fardad@gmail.com',
        nationalCode: '0081234562',
        insuranceId: '1234567890',
        agentCode: 'AG-TEH-011',
        address: address,
        creditLimit: 500000000,
        province: const CityProvinceDtoModel(id: '1', name: 'تهران'),
        city: const CityProvinceDtoModel(id: '1', name: 'تهران'),
        manager: const ManagerDtoModel(
          id: '1',
          firstName: 'پاشا',
          lastName: 'نیکچی',
        ),
      );

  DashboardState get dashboard => DashboardState(
    status: DashboardRequestStatus.success,
    quickAccessItems: [
      QuickAccessItemModel(
        title: 'سفارشات تایید شده',
        value: '24',
        currency: '',
        iconPath: 'assets/images/invoice.svg',
        percentage: '18.5%',
      ),
      QuickAccessItemModel(
        title: 'فروش ماهانه',
        value: '68,000,000',
        currency: 'assets/images/rial.svg',
        iconPath: 'assets/images/dollar.svg',
        percentage: '18.5%',
      ),
      QuickAccessItemModel(
        title: 'پورسانت نقدی',
        value: '30,000,000',
        currency: 'assets/images/rial.svg',
        iconPath: 'assets/images/chart-pie.2.svg',
      ),
      QuickAccessItemModel(
        title: 'موجودی کیف پول',
        value: '300,000,000',
        currency: 'assets/images/rial.svg',
        iconPath: 'assets/images/wallet_drawer.svg',
      ),
    ],
    messageText: 'افزایش سهمیه صدور پیش‌فاکتور سفارش شما تا ۱۰٪',
    messageIconPath: 'assets/images/alert.svg',
    lineChartData: [
      LineChartDataModel(
        line1Data: List.generate(
          30,
          (i) => FlSpot(i + 1, 20 + i * 2.0 + i % 4),
        ),
        line2Data: List.generate(
          24,
          (i) => FlSpot(i + 1, 35 + i * 2.0 + i % 3),
        ),
      ),
    ],
    pieChart1Title: S.current.orderStatusChartTitle,
    pieChart2Title: S.current.salesByCategoryChartTitle,
    barChartTitle: S.current.plansSalesChartTitle,
  );

  PreInvoiceState invoice({
    bool review = false,
    bool deliverToCustomer = false,
    bool otherRecipient = false,
  }) {
    return PreInvoiceState(
      status: PreInvoiceRequestStatus.success,
      currentStep: review ? PreInvoiceStep.review : PreInvoiceStep.customerInfo,
      customerIdQuery: '0081234562',
      isNationalIdValid: true,
      isExistingCustomer: true,
      selectedCreditPlanId: '1',
      creditPlans: [
        CreditPlanItemModel(
          id: '1',
          logo: 'assets/images/rtc_logo.png',
          providerName: 'آپ',
          planName: 'آپ - ۱۲ ماهه',
          validityDuration: '2',
        ),
      ],
      customerInfo: CustomerInfoModel(
        id: '1',
        firstName: 'سامان',
        lastName: 'راد',
        nationalId: '0081234562',
        phoneNumber: '09126042179',
        postalCode: '1944693446',
        address: address,
        isOrderSentToCustomerAddress: deliverToCustomer,
        isOtherRecipient: otherRecipient,
        recipientName: otherRecipient ? 'سامان پارسی' : '',
        recipientNationalId: otherRecipient ? '0081234562' : '',
      ),
      allProducts: [
        PreInvoiceProductModel(
          id: 'preview-product',
          name: 'یخچال فریزر ساید RTC',
          imageUrl: 'assets/images/frame1.png',
          price: '8,000,000',
          inventory: '10',
          consumerUnitPrice: 9000000,
        ),
      ],
      cartItems: [
        CartItemModel(
          productId: 'preview-product',
          name: 'یخچال فریزر ساید RTC',
          imageUrl: 'assets/images/frame1.png',
          price: '8,000,000',
          quantity: 2,
          consumerUnitPrice: 9000000,
        ),
      ],
      payableAmount: '16,000,000',
      totalAmount: '17,250,000',
      totalDiscounts: '1,250,000',
    );
  }

  OrderDetailModel get order => OrderDetailModel(
    id: 'preview-order',
    status: 'under_review',
    remainingTime: '',
    products: [],
    customer: OrderCustomerModel(
      name: 'سامان راد',
      phone: '09126042179',
      nationalCode: '0081234562',
      postalCode: '1944693446',
      address: address,
    ),
    documents: [],
    financialSummary: FinancialSummaryModel(
      basePrice: '124,000,000',
      totalDiscount: '0',
      finalAmount: '124,000,000',
    ),
    operations: [],
    history: [],
    payments: [],
  );
}

class PreviewPreInvoiceCubit extends PreInvoiceCubit {
  PreviewPreInvoiceCubit(
    PreInvoiceState state, {
    List<BranchInfo>? branches,
    bool startFromBeginning = false,
  }) : super(initialState: state, branches: branches) {
    if (startFromBeginning) {
      emit(
        this.state.copyWith(
          currentStep: steps.first,
          selectedCreditPlanId: null,
        ),
      );
    }
  }
  @override
  void init() {}

  @override
  void goToStep(PreInvoiceStep step) {
    if (canContinue || steps.indexOf(step) < steps.indexOf(state.currentStep)) {
      if (step == PreInvoiceStep.branch ||
          !branchSelection.state.requiresSelection ||
          branchSelection.state.selected != null) {
        emit(state.copyWith(currentStep: step));
      }
    }
  }

  @override
  void submitPreInvoice() {}
  @override
  void submitAndClear() {}
}

class PreviewDashboardCubit extends DashboardCubit {
  PreviewDashboardCubit(DashboardState state) : super(initialState: state);
  @override
  void init() {}
}

class PreviewOrdersCubit extends OrdersCubit {
  PreviewOrdersCubit(OrderDetailModel order)
    : super(
        listenToLinks: false,
        initialState: OrdersState(
          selectedOrder: order,
          selectedTabIndex: 1,
          status: OrdersRequestStatus.success,
          clearanceStep: ClearanceStep.success,
          disburseOperation: const OrderOperationModel(
            step: 1,
            title: 'عملیات تخلیه',
            status: 'انجام شده',
            isCompleted: true,
          ),
        ),
      );
  @override
  void fetchOrders({OrdersState? rollbackState}) =>
      emit(state.copyWith(status: OrdersRequestStatus.success));
  @override
  void fetchNextPage() {}
  @override
  void fetchOrderDetail(String orderId, {String? paymentOutcome}) {}
  @override
  Future<void> printPreInvoice(String orderId) => Future.value();
}
