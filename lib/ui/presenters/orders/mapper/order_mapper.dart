import 'package:rtc_mobile/core/enums/order_status.dart';
import 'package:rtc_mobile/core/utils/currency_formatter.dart';
import 'package:rtc_mobile/core/utils/date_time_utils.dart';
import 'package:rtc_mobile/data_source/remote/orders/model/order_dto_model.dart';
import 'package:rtc_mobile/generated/l10n.dart';

import '../../../../core/models/customer_model.dart';
import '../../../../core/models/order_model.dart';

class OrderMapper {
  static String formatDisplayId(String id) {
    if (id.contains('-')) {
      return id.split('-').first.toUpperCase();
    }
    return id.substring(0, id.length > 8 ? 8 : id.length).toUpperCase();
  }

  static OrderSummaryModel mapToSummary(OrderDtoModel dto) {
    final dateStr = DateTimeUtils.formatToJalali(dto.createdAt);
    final totalQuantity = (dto.lines ?? []).fold<int>(
      0,
      (sum, line) => sum + line.quantity,
    );

    return OrderSummaryModel(
      id: dto.id,
      orderId: formatDisplayId(dto.id),
      customerName: '${dto.customer.firstName} ${dto.customer.lastName}',
      itemCount: S.current.itemCount(totalQuantity),
      status: dto.status,
      dateTime: dateStr,
      amount: dto.total.formatCurrency,
    );
  }

  static OrderDetailModel mapToDetail(OrderDtoModel dto) {
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
      OrderHistoryModel(label: S.current.registrationDateLabel, value: dateStr),
    ];

    if (dto.status == 'expired') {
      history.add(
        OrderHistoryModel(
          label: S.current.expireDateLabel,
          value: dto.updatedAt != null
              ? _formatJalaliDateTime(dto.updatedAt!)
              : dateStr,
        ),
      );
    }

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

      if (discountAmountPerUnit == 0 && discountPct > 0 && discountPct < 100) {
        originalPrice = unitPrice / (1 - (discountPct / 100));
      }

      totalBasePrice += (originalPrice * line.quantity);
      totalDiscountAmount += (originalPrice - unitPrice) * line.quantity;

      return OrderProductModel(
        name: line.product.name,
        price: unitPrice.formatCurrency,
        quantity: line.quantity.toString(),
        imageUrl: line.product.featuredImage?.file ?? '',
        oldPrice: originalPrice > unitPrice
            ? originalPrice.formatCurrency
            : null,
        discount: discountPct > 0 ? '${discountPct.toStringAsFixed(0)}٪' : null,
      );
    }).toList();

    return OrderDetailModel(
      id: dto.id,
      status: dto.status,
      remainingTime: remainingTimeStr,
      isSettled:
          OrderStatus.fromString(dto.status) == OrderStatus.approved ||
          OrderStatus.fromString(dto.status) == OrderStatus.rejected,
      rejectionReason: dto.rejectionNote,
      creditPlan: CreditPlanModel(
        provider: dto.subPlan.creditPlan?.name ?? '',
        planName: dto.subPlan.name,
        priceIncrease: '',
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
        basePrice: totalBasePrice.formatCurrency,
        totalDiscount: totalDiscountAmount.formatCurrency,
        finalAmount: dto.total.formatCurrency,
      ),
      payments: (dto.payments ?? []).map((p) {
        final pDateStr = DateTimeUtils.formatToJalaliDate(p.createdAt ?? '');

        return OrderPaymentModel(
          amount: p.amount.formatCurrency,
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
          amount: r.amount.formatCurrency,
          reference: r.reference ?? '',
          status: r.status ?? '',
          createdAt: r.createdAt ?? '',
        );
      }).toList(),
      settlementRecords: (dto.settlementRecords ?? []).map((s) {
        return SettlementRecordModel(
          id: s.id ?? '',
          amount: s.amount.formatCurrency,
          paymentType: s.paymentType ?? s.gateway ?? '',
          status: s.status ?? '',
          createdAt: s.createdAt ?? '',
          trackingCode: s.trackingCode ?? s.reference,
        );
      }).toList(),
      assignedSalesReviewer: dto.assignedSalesReviewer,
      assignedFinanceReviewer: dto.assignedFinanceReviewer,
    );
  }

  static CustomerOrderItemModel mapToCustomerOrderItem(OrderDtoModel dto) {
    return CustomerOrderItemModel(
      orderId: formatDisplayId(dto.id),
      amount: dto.total.formatCurrency,
      date: DateTimeUtils.formatToJalaliDate(dto.createdAt),
      status: dto.status,
    );
  }

  static String _formatJalaliDateTime(String dateStr) {
    return DateTimeUtils.formatToJalali(dateStr, separator: ' - ');
  }

  static String _mapDocType(String type) {
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
}
