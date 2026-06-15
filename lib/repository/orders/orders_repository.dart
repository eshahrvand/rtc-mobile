import 'package:intl/intl.dart';
import 'package:rtc_mobile/generated/l10n.dart';
import '../../core/utils/date_time_utils.dart';
import '../../data/models/customer_model.dart';
import '../../data/models/order_model.dart';
import '../../data_source/remote/orders/model/order_dto_model.dart';
import '../../data_source/remote/orders/orders_service.dart';

import '../../core/enums/order_status.dart';

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

  Future<dynamic> disburseInitiate(String orderId, double amount) {
    return _service.disburseInitiate(orderId, {'disbursement_amount': amount});
  }

  Future<dynamic> disburse(String orderId, [Map<String, dynamic>? body]) {
    return _service.disburse(orderId, body ?? {});
  }

  Future<dynamic> settleInitiate(String id, String method, {double? amount}) {
    final body = {
      'method': method,
      if (method == 'wallet_debit' && amount != null) 'amount': amount,
    };
    return _service.settleInitiate(id, body);
  }

  Future<dynamic> settle(String id, String method, {String? trackingCode}) {
    final body = {
      'method': method,
      'payload': (method == 'card_to_card' && trackingCode != null)
          ? {'tracking_code': trackingCode}
          : {},
    };
    return _service.settle(id, body);
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
            final dateStr = DateTimeUtils.formatToJalali(dto.createdAt);

            final totalQuantity = (dto.lines ?? []).fold<int>(
              0,
              (sum, line) => sum + line.quantity,
            );

            return OrderSummaryModel(
              id: dto.id,
              orderId: dto.id.substring(0, 8).toUpperCase(),
              // Placeholder for real order ID if missing
              customerName:
                  '${dto.customer.firstName} ${dto.customer.lastName}',
              itemCount: S.current.itemCount(totalQuantity),
              status: dto.status,
              dateTime: dateStr,
              amount: _formatCurrency(dto.total),
            );
          }).toList();
        });
  }

  Future<List<CustomerOrderItemModel>> getCustomerOrders(String customerId) {
    return _service.getOrders(customerId: customerId).then((response) {
      return response.results.map((dto) {
        final dateStr = DateTimeUtils.formatToJalaliDate(dto.createdAt);

        return CustomerOrderItemModel(
          orderId: dto.id,
          amount: _formatCurrency(dto.total),
          date: dateStr,
          status: dto.status,
        );
      }).toList();
    });
  }

  Future<OrderDetailModel> getOrderDetails(String id) {
    return _service.getOrderById(id).then((dto) {
      final dateStr = _formatJalaliDateTime(dto.createdAt);

      String remainingTimeStr = '';
      if (dto.remainingTime != null) {
        final rt = dto.remainingTime!;
        if (rt.days > 0) {
          remainingTimeStr = '${rt.days} ${S.current.dayUnit}';
        } else if (rt.hours > 0) {
          remainingTimeStr = '${rt.hours} ${S.current.hourUnit}';
        } else if (rt.minutes > 0) {
          remainingTimeStr = '${rt.minutes} ${S.current.minuteUnit}';
        }
      }

      final history = [
        OrderHistoryModel(
          label: S.current.registrationDateLabel,
          value: dateStr,
        ),
      ];

      // Add clearance date if successful record exists
      final successDisburse = (dto.disbursementRecords ?? []).firstWhere(
        (r) => r.status == 'success' || r.status == S.current.success,
        orElse: () => const DisbursementRecordDtoModel(amount: 0),
      );
      if (successDisburse.createdAt != null) {
        history.add(
          OrderHistoryModel(
            label: S.current.clearanceDateLabelColon,
            value: _formatJalaliDateTime(successDisburse.createdAt!),
          ),
        );
      }

      // Add settlement date if successful record exists
      final successSettle = (dto.settlementRecords ?? []).firstWhere(
        (s) => s.status == 'success' || s.status == S.current.success,
        orElse: () => const SettlementRecordDtoModel(amount: 0),
      );
      if (successSettle.createdAt != null) {
        history.add(
          OrderHistoryModel(
            label: S.current.settlementDateLabel,
            value: _formatJalaliDateTime(successSettle.createdAt!),
          ),
        );
      }

      double totalBasePrice = 0;
      double totalDiscountAmount = 0;

      final products = (dto.lines ?? []).map((line) {
        final unitPrice = line.unitPriceAtCreation;
        final discountPct = line.discountPctAtCreation ?? 0;
        final discountAmountPerUnit = line.discountAmountAtCreation ?? 0;

        double originalPrice = unitPrice + discountAmountPerUnit;

        if (discountAmountPerUnit == 0 &&
            discountPct > 0 &&
            discountPct < 100) {
          originalPrice = unitPrice / (1 - (discountPct / 100));
        }

        totalBasePrice += (originalPrice * line.quantity);
        totalDiscountAmount += (originalPrice - unitPrice) * line.quantity;

        return OrderProductModel(
          name: line.product.name,
          price: _formatCurrency(unitPrice),
          quantity: line.quantity.toString(),
          imageUrl: line.product.featuredImage?.file ?? '',
          oldPrice: originalPrice > unitPrice
              ? _formatCurrency(originalPrice)
              : null,
          discount: discountPct > 0
              ? '${discountPct.toStringAsFixed(0)}٪'
              : null,
        );
      }).toList();

      return OrderDetailModel(
        id: dto.id,
        status: dto.status,
        remainingTime: remainingTimeStr,
        // Need API support or calculation if available
        isSettled:
            OrderStatus.fromString(dto.status) == OrderStatus.approved ||
            OrderStatus.fromString(dto.status) == OrderStatus.rejected,
        rejectionReason: dto.rejectionNote,
        creditPlan: CreditPlanModel(
          provider: dto.subPlan.creditPlan?.name ?? '',
          planName: dto.subPlan.name,
          priceIncrease: '', // Need clarification on where this comes from
          validityPeriod:
              '${dto.subPlan.repaymentDurationMonths} ${S.current.monthUnit}',
        ),
        products: products,
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
          basePrice: _formatCurrency(totalBasePrice),
          totalDiscount: _formatCurrency(totalDiscountAmount),
          finalAmount: _formatCurrency(dto.total),
        ),
        payments: (dto.payments ?? []).map((p) {
          final pDateStr = DateTimeUtils.formatToJalaliDate(p.createdAt ?? '');

          return OrderPaymentModel(
            amount: _formatCurrency(p.amount),
            type: p.paymentType ?? '',
            date: pDateStr,
            trackingCode: p.trackingCode,
            status: p.status,
          );
        }).toList(),
        operations: [],
        history: history,
        disbursementRecords: (dto.disbursementRecords ?? []).map((r) {
          return DisbursementRecordModel(
            gateway: r.gateway ?? '',
            amount: _formatCurrency(r.amount),
            reference: r.reference ?? '',
            status: r.status ?? '',
            createdAt: r.createdAt ?? '',
          );
        }).toList(),
        settlementRecords: (dto.settlementRecords ?? []).map((s) {
          return SettlementRecordModel(
            id: s.id ?? '',
            amount: _formatCurrency(s.amount),
            paymentType: s.paymentType ?? s.gateway ?? '',
            status: s.status ?? '',
            createdAt: s.createdAt ?? '',
            trackingCode: s.trackingCode ?? s.reference,
          );
        }).toList(),
        assignedSalesReviewer: dto.assignedSalesReviewer,
        assignedFinanceReviewer: dto.assignedFinanceReviewer,
      );
    });
  }

  String _formatJalaliDateTime(String dateStr) {
    return DateTimeUtils.formatToJalali(dateStr, separator: ' - ');
  }

  String _mapDocType(String type) {
    switch (type) {
      case 'national_id_front':
        return S.current.nationalIdFront;
      case 'supporting':
      case 'disbursement_proof':
        return S.current.otherDocuments;
      default:
        return type;
    }
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat('#,###', 'en_US');
    return formatter.format(value.abs().toInt());
  }
}
