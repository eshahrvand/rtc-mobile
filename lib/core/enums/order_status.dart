enum OrderStatus {
  preInvoice,
  approved,
  rejected,
  underReview,
  awaitingSettlement,
  expired,
  unknown;

  /// Parses the raw English string received from the server.
  static OrderStatus fromString(String value) {
    switch (value) {
      case 'pre_invoice':
        return OrderStatus.preInvoice;
      case 'approved':
        return OrderStatus.approved;
      case 'reject':
      case 'rejected':
        return OrderStatus.rejected;
      case 'under_review':
        return OrderStatus.underReview;
      case 'awaiting_settlement':
        return OrderStatus.awaitingSettlement;
      case 'expired':
        return OrderStatus.expired;
      default:
        return OrderStatus.unknown;
    }
  }

  /// Returns the Persian display string for UI only.
  String toDisplayString() {
    switch (this) {
      case OrderStatus.preInvoice:
        return 'پیش فاکتور';
      case OrderStatus.approved:
        return 'تایید شده';
      case OrderStatus.rejected:
        return 'رد شده';
      case OrderStatus.underReview:
        return 'در انتظار تایید';
      case OrderStatus.awaitingSettlement:
        return 'در انتظار تسویه';
      case OrderStatus.expired:
        return 'منقضی شده';
      case OrderStatus.unknown:
        return '';
    }
  }
}
