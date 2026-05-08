class OrderModel {
  final String orderNo;
  final String date;
  final int quantity;
  final double totalAmount;
  final String status; // 'Delivered', 'Processing', 'Canceled'
  final List<String> productImages;

  OrderModel({
    required this.orderNo,
    required this.date,
    required this.quantity,
    required this.totalAmount,
    required this.status,
    required this.productImages,
  });
}

class ReviewModel {
  final String userName;
  final String userAvatar;
  final int rating;
  final String comment;
  final String date;
  final String productName;
  final String productImage;
  final double productPrice;

  ReviewModel({
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });
}

class NotificationModel {
  final String title;
  final String subtitle;
  final String productImage;
  final String tag; // 'New', 'Hot', ''
  bool isRead;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.productImage,
    required this.tag,
    this.isRead = false,
  });
}

class ShippingAddress {
  String name;
  String address;
  String zipcode;
  String country;
  String city;
  bool isDefault;

  ShippingAddress({
    required this.name,
    required this.address,
    required this.zipcode,
    required this.country,
    required this.city,
    this.isDefault = false,
  });
}

class PaymentCard {
  final String logoAsset;
  final String cardNumber;
  final String cardHolder;
  final String expiry;
  bool isDefault;

  PaymentCard({
    required this.logoAsset,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiry,
    this.isDefault = false,
  });
}