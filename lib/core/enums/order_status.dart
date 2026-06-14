import 'package:rtc_mobile/generated/l10n.dart';

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
        return S.current.preInvoice;
      case OrderStatus.approved:
        return S.current.statusApproved;
      case OrderStatus.rejected:
        return S.current.statusRejected;
      case OrderStatus.underReview:
        return S.current.statusPending;
      case OrderStatus.awaitingSettlement:
        return S.current.statusWaitingSettlement;
      case OrderStatus.expired:
        return S.current.statusExpired;
      case OrderStatus.unknown:
        return '';
    }
  }
}
