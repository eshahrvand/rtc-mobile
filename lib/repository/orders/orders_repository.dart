import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../data/models/customer_model.dart';
import '../../data/models/order_model.dart';
import '../../data_source/remote/orders/model/order_dto_model.dart';
import '../../data_source/remote/orders/orders_service.dart';

class OrdersRepository {
  final OrdersService _service;

  OrdersRepository(this._service);

  Future<OrderDtoModel> createOrder(OrderCreateRequest request) {
    final body = request.toJson();
    // Ensure lines are serialized to List<Map>
    body['lines'] = request.lines.map((l) => l.toJson()).toList();
    // Ensure documents are serialized to List<Map>
    body['documents'] = request.documents.map((d) => d.toJson()).toList();
    return _service.createOrder(body);
  }

  Future<OrderDocumentResponse> addOrderDocument(
    String orderId,
    OrderDocumentRequest request,
  ) {
    return _service.addOrderDocument(orderId, request.toJson());
  }

  Future<List<OrderSummaryModel>> getOrders({
    List<String>? status,
    String? subPlanId,
    String? createdAfter,
    String? createdBefore,
    String? search,
    int? page,
    int? pageSize,
  }) {
    return _service
        .getOrders(
          status: status,
          subPlanId: subPlanId,
          createdAfter: createdAfter,
          createdBefore: createdBefore,
          search: search,
          page: page,
          pageSize: pageSize,
        )
        .then((response) {
          return response.results.map((dto) {
            final dateTime = DateTime.parse(dto.createdAt);
            final jalali = Jalali.fromDateTime(dateTime);
            final dateStr =
                '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')} | ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

            return OrderSummaryModel(
              id: dto.id,
              orderId: dto.id.substring(0, 8).toUpperCase(),
              // Placeholder for real order ID if missing
              customerName:
                  '${dto.customer.firstName} ${dto.customer.lastName}',
              itemCount: '${dto.lines?.length ?? 0} کالا',
              status: _mapStatus(dto.status),
              dateTime: dateStr,
              amount: _formatCurrency(dto.total),
            );
          }).toList();
        });
  }

  Future<List<CustomerOrderItemModel>> getCustomerOrders(String customerId) {
    return _service.getOrders(customerId: customerId).then((response) {
      return response.results.map((dto) {
        final dateTime = DateTime.parse(dto.createdAt);
        final jalali = Jalali.fromDateTime(dateTime);
        final dateStr =
            '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')}';

        return CustomerOrderItemModel(
          orderId: dto.id,
          amount: _formatCurrency(dto.total),
          date: dateStr,
          status: _mapStatus(dto.status),
        );
      }).toList();
    });
  }

  Future<OrderDetailModel> getOrderDetails(String id) {
    return _service.getOrderById(id).then((dto) {
      final dateTime = DateTime.parse(dto.createdAt);
      final jalali = Jalali.fromDateTime(dateTime);
      final dateStr =
          '${jalali.year}/${jalali.month.toString().padLeft(2, '0')}/${jalali.day.toString().padLeft(2, '0')} - ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

      final statusStr = _mapStatus(dto.status);

      return OrderDetailModel(
        id: dto.id,
        status: statusStr,
        remainingTime: '',
        // Need API support or calculation if available
        isSettled: dto.status == 'approved' || dto.status == 'rejected',
        rejectionReason: dto.rejectionNote,
        creditPlan: CreditPlanModel(
          provider: dto.subPlan.creditPlan?.name ?? '',
          planName: dto.subPlan.name,
          priceIncrease: '', // Need clarification on where this comes from
          validityPeriod: '${dto.subPlan.repaymentDurationMonths} ماهه',
        ),
        products: (dto.lines ?? []).map((line) {
          return OrderProductModel(
            name: line.product.name,
            price: _formatCurrency(line.unitPriceAtCreation),
            quantity: line.quantity.toString(),
            imageUrl:
                '', // Product image not in order line DTO, might need product detail call or baseImageUrl
          );
        }).toList(),
        customer: OrderCustomerModel(
          name: '${dto.customer.firstName} ${dto.customer.lastName}',
          phone: dto.customer.mobile,
          nationalCode: dto.customer.nationalId,
          postalCode: dto.customer.postalCode,
          address: dto.customer.address,
        ),
        documents: (dto.documents ?? []).map((doc) {
          final sizeInBytes = doc.file.sizeBytes ?? 0;
          String sizeStr;
          if (sizeInBytes < 1024) {
            // Display small files or 0-size as KB 0
            sizeStr = 'KB ${(sizeInBytes / 1024).toStringAsFixed(0)}';
          } else if (sizeInBytes < 1024 * 1024) {
            sizeStr = 'KB ${(sizeInBytes / 1024).toStringAsFixed(1)}';
          } else {
            sizeStr = 'MB ${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)}';
          }

          return OrderDocumentModel(
            title: _mapDocType(doc.documentType),
            fileName: doc.file.originalName,
            fileSize: sizeStr,
            url: doc.file.file,
            iconPath: 'assets/images/alert.svg',
          );
        }).toList(),
        financialSummary: FinancialSummaryModel(
          basePrice: _formatCurrency(dto.total),
          totalDiscount: '۰',
          finalAmount: _formatCurrency(dto.total),
        ),
        operations: [
          OrderOperationModel(
            step: 1,
            title: 'عملیات تخلیه',
            status: dto.deliveryToAgent == true ? 'انجام شده' : '',
            isCompleted: dto.deliveryToAgent == true,
          ),
          OrderOperationModel(
            step: 2,
            title: 'عملیات تسویه',
            status: dto.status == 'approved' ? 'انجام شده' : '',
            isCompleted: dto.status == 'approved',
          ),
        ],
        history: [OrderHistoryModel(label: 'تاریخ ثبت:', value: dateStr)],
      );
    });
  }

  String _mapDocType(String type) {
    switch (type) {
      case 'national_id_front':
        return 'کارت ملی - روی';
      case 'supporting':
        return 'سایر مدارک';
      default:
        return type;
    }
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat('#,###', 'en_US');
    return formatter.format(value.abs().toInt());
  }

  String _mapStatus(String status) {
    switch (status) {
      case 'pre_invoice':
        return 'پیش فاکتور';
      case 'approved':
        return 'تایید شده';
      case 'rejected':
        return 'رد شده';
      case 'pending':
        return 'در انتظار تایید';
      case 'waiting_settlement':
        return 'در انتظار تسویه';
      case 'expired':
        return 'منقضی شده';
      default:
        return status;
    }
  }
}
