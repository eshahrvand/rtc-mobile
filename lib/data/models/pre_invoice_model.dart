class CreditPlanItemModel {
  final String id;
  final String logo;
  final String providerName;
  final String planName;
  final String validityDuration;

  CreditPlanItemModel({
    required this.id,
    required this.logo,
    required this.providerName,
    required this.planName,
    required this.validityDuration,
  });
}

class PreInvoiceProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final String? oldPrice;
  final String? discount;
  final String inventory;
  final bool isAvailable;

  PreInvoiceProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
    this.discount,
    required this.inventory,
    this.isAvailable = true,
  });
}

class CartItemModel {
  final String productId;
  final String name;
  final String imageUrl;
  final String price;
  final String? discount;
  final int quantity;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.discount,
    required this.quantity,
  });
}

class CustomerInfoModel {
  final String firstName;
  final String lastName;
  final String nationalId;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final bool isOrderSentToCustomerAddress;

  CustomerInfoModel({
    required this.firstName,
    required this.lastName,
    required this.nationalId,
    required this.phoneNumber,
    required this.postalCode,
    required this.address,
    this.isOrderSentToCustomerAddress = false,
  });

  CustomerInfoModel copyWith({
    String? firstName,
    String? lastName,
    String? nationalId,
    String? phoneNumber,
    String? postalCode,
    String? address,
    bool? isOrderSentToCustomerAddress,
  }) {
    return CustomerInfoModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nationalId: nationalId ?? this.nationalId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      postalCode: postalCode ?? this.postalCode,
      address: address ?? this.address,
      isOrderSentToCustomerAddress: isOrderSentToCustomerAddress ?? this.isOrderSentToCustomerAddress,
    );
  }
}

class PreInvoiceChipModel {
  final int id;
  final String label;
  final bool opensBottomSheet;

  PreInvoiceChipModel({
    required this.id,
    required this.label,
    this.opensBottomSheet = false,
  });
}
