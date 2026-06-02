import 'package:flutter/material.dart';

class OrderSummaryModel {
  final String id;
  final String orderId;
  final String customerName;
  final String itemCount;
  final String status;
  final String dateTime;
  final String amount;
  final Color? statusColor;
  final Color? statusBgColor;

  OrderSummaryModel({
    required this.id,
    required this.orderId,
    required this.customerName,
    required this.itemCount,
    required this.status,
    required this.dateTime,
    required this.amount,
    this.statusColor,
    this.statusBgColor,
  });
}

class OrderDetailModel {
  final String id;
  final String status;
  final String remainingTime;
  final CreditPlanModel? creditPlan;
  final List<OrderProductModel> products;
  final OrderCustomerModel customer;
  final List<OrderDocumentModel> documents;
  final FinancialSummaryModel financialSummary;
  final List<OrderOperationModel> operations;
  final List<OrderHistoryModel> history;
  final List<OrderPaymentModel> payments;
  final String? rejectionReason;
  final bool isSettled;
  final List<DisbursementRecordModel> disbursementRecords;
  final List<SettlementRecordModel> settlementRecords;

  OrderDetailModel({
    required this.id,
    required this.status,
    required this.remainingTime,
    this.creditPlan,
    required this.products,
    required this.customer,
    required this.documents,
    required this.financialSummary,
    required this.operations,
    required this.history,
    required this.payments,
    this.rejectionReason,
    this.isSettled = false,
    this.disbursementRecords = const [],
    this.settlementRecords = const [],
  });
}

class DisbursementRecordModel {
  final String gateway;
  final String amount;
  final String reference;
  final String status;
  final String createdAt;

  DisbursementRecordModel({
    required this.gateway,
    required this.amount,
    required this.reference,
    required this.status,
    required this.createdAt,
  });
}

class SettlementRecordModel {
  final String id;
  final String amount;
  final String paymentType;
  final String status;
  final String createdAt;
  final String? trackingCode;

  SettlementRecordModel({
    required this.id,
    required this.amount,
    required this.paymentType,
    required this.status,
    required this.createdAt,
    this.trackingCode,
  });
}

class CreditPlanModel {
  final String provider;
  final String planName;
  final String priceIncrease;
  final String validityPeriod;

  CreditPlanModel({
    required this.provider,
    required this.planName,
    required this.priceIncrease,
    required this.validityPeriod,
  });
}

class OrderProductModel {
  final String name;
  final String price;
  final String? discount;
  final String? oldPrice;
  final String quantity;
  final String imageUrl;

  OrderProductModel({
    required this.name,
    required this.price,
    this.discount,
    this.oldPrice,
    required this.quantity,
    required this.imageUrl,
  });
}

class OrderCustomerModel {
  final String name;
  final String phone;
  final String nationalCode;
  final String postalCode;
  final String address;

  OrderCustomerModel({
    required this.name,
    required this.phone,
    required this.nationalCode,
    required this.postalCode,
    required this.address,
  });
}

class OrderDocumentModel {
  final String title;
  final String fileName;
  final String fileSize;
  final String iconPath;
  final String? url;

  OrderDocumentModel({
    required this.title,
    required this.fileName,
    required this.fileSize,
    required this.iconPath,
    this.url,
  });
}

class FinancialSummaryModel {
  final String basePrice;
  final String totalDiscount;
  final String finalAmount;

  FinancialSummaryModel({
    required this.basePrice,
    required this.totalDiscount,
    required this.finalAmount,
  });
}

class OrderOperationModel {
  final int step;
  final String title;
  final String status;
  final bool isCompleted;

  const OrderOperationModel({
    required this.step,
    required this.title,
    required this.status,
    required this.isCompleted,
  });
}

class OrderHistoryModel {
  final String label;
  final String value;

  OrderHistoryModel({
    required this.label,
    required this.value,
  });
}

class OrderPaymentModel {
  final String amount;
  final String type;
  final String date;
  final String? trackingCode;
  final String? status;

  OrderPaymentModel({
    required this.amount,
    required this.type,
    required this.date,
    this.trackingCode,
    this.status,
  });
}
