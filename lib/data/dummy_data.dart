import '../models/product_model.dart';
import '../models/order_model.dart';

final List<ProductModel> dummyProducts = [
  ProductModel(
    id: '1',
    name: 'Black Simple Lamp',
    category: 'Chair',
    price: 12.00,
    imagePath: 'assets/images/lamp/lamp1.jpg',
    rating: 4.5,
    reviewCount: 50,
    description: 'Lampu simpel berwarna hitam yang elegan untuk ruangan Anda.',
    colors: ['#000000', '#8B6914', '#C0C0C0'],
  ),
  ProductModel(
    id: '2',
    name: 'Minimal Stand',
    category: 'Table',
    price: 25.00,
    imagePath: 'assets/images/chair/kursi1.jpg',
    rating: 4.5,
    reviewCount: 50,
    description: 'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. ',
    colors: ['#FFFFFF', '#8B6914', '#D2B48C'],
  ),
  ProductModel(
    id: '3',
    name: 'Coffee Chair',
    category: 'Chair',
    price: 12.00,
    imagePath: 'assets/images/chair/kursi2.jpg',
    rating: 4.3,
    reviewCount: 30,
    description: 'Kursi coffee yang nyaman untuk bersantai.',
    colors: ['#87CEEB', '#000000', '#FFFFFF'],
  ),
  ProductModel(
    id: '4',
    name: 'Simple Desk',
    category: 'Table',
    price: 12.00,
    imagePath: 'assets/images/table/meja1.jpg',
    rating: 4.0,
    reviewCount: 25,
    description: 'Meja simpel dengan desain minimalis yang modern.',
    colors: ['#8B6914', '#000000', '#FFFFFF'],
  ),
  ProductModel(
    id: '5',
    name: 'Minimal Stand',
    category: 'Table',
    price: 50.00,
    imagePath: 'assets/images/chair/kursi3.jpg',
    rating: 4.5,
    reviewCount: 50,
    description: 'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. ',
    colors: ['#8B6914', '#000000', '#FFFFFF'],
  ),
  ProductModel(
    id: '6',
    name: 'Minimal Stand',
    category: 'Table',
    price: 50.00,
    imagePath: 'assets/images/chair/kursi4.png',
    rating: 4.0,
    reviewCount: 25,
    description: 'Meja simpel dengan desain minimalis yang modern.',
    colors: ['#8B6914', '#000000', '#FFFFFF'],
  ),
  ProductModel(
    id: '7',
    name: 'Minimal Stand',
    category: 'Table',
    price: 25.00,
    imagePath: 'assets/images/chair/kursi5.png',
    rating: 4.0,
    reviewCount: 25,
    description: 'Meja simpel dengan desain minimalis yang modern.',
    colors: ['#8B6914', '#000000', '#FFFFFF'],
  ),
  ProductModel(
    id: '8',
    name: 'Minimal Stand',
    category: 'Table',
    price: 25.00,
    imagePath: 'assets/images/lamp/lamp2.png',
    rating: 4.0,
    reviewCount: 25,
    description: 'Meja simpel dengan desain minimalis yang modern.',
    colors: ['#8B6914', '#000000', '#FFFFFF'],
  ),
];

// ── Orders ──────────────────────────────────────────────────
final List<OrderModel> dummyOrders = [
  OrderModel(
    orderNo: 'No238562312',
    date: '20/03/2020',
    quantity: 3,
    totalAmount: 150,
    status: 'Canceled',
    productImages: ['assets/images/chair/kursi1.jpg'],
  ),
  OrderModel(
    orderNo: 'No238562312',
    date: '20/03/2020',
    quantity: 3,
    totalAmount: 150,
    status: 'Processing',
    productImages: ['assets/images/chair/kursi2.jpg'],
  ),
  OrderModel(
    orderNo: 'No238562312',
    date: '20/03/2020',
    quantity: 3,
    totalAmount: 150,
    status: 'Delivered',
    productImages: ['assets/images/lamp/lamp1.jpg'],
  ),
];

// ── Reviews ──────────────────────────────────────────────────
final List<ReviewModel> dummyReviews = [
  ReviewModel(
    userName: 'Bruno Fernandes',
    userAvatar: '',
    rating: 5,
    comment:
        'Nice Furniture with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app. Besides, color is also the same and quality is very good despite very cheap price',
    date: '20/03/2020',
    productName: 'Coffee Table',
    productImage: 'assets/images/chair/kursi1.jpg',
    productPrice: 50.00,
  ),
  ReviewModel(
    userName: 'Kristin Watson',
    userAvatar: '',
    rating: 5,
    comment:
        'Nice Furniture with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app. Besides, color is also the same and quality is very good despite very cheap price',
    date: '20/03/2020',
    productName: 'Coffee Table',
    productImage: 'assets/images/chair/kursi2.jpg',
    productPrice: 50.00,
  ),
  ReviewModel(
    userName: 'Arlene McCoy',
    userAvatar: '',
    rating: 5,
    comment:
        'Nice Furniture with good delivery. The delivery time is very fast. Then products look like exactly the picture in the app.',
    date: '20/03/2020',
    productName: 'Coffee Table',
    productImage: 'assets/images/lamp/lamp1.jpg',
    productPrice: 50.00,
  ),
];

// ── Notifications ─────────────────────────────────────────────
final List<NotificationModel> dummyNotifications = [
  NotificationModel(
    title: 'Your order #123456789 has been shipped successfully',
    subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    productImage: 'assets/images/chair/kursi1.jpg',
    tag: 'New',
  ),
  NotificationModel(
    title: 'Your order #123456789 has been shipped',
    subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    productImage: 'assets/images/chair/kursi3.jpg',
    tag: 'New',
  ),
  NotificationModel(
    title: 'Your order #123456789 has been confirmed',
    subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    productImage: 'assets/images/chair/kursi2.jpg',
    tag: 'Hot',
  ),
  NotificationModel(
    title: 'Discover hot sale furnitures this week.',
    subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    productImage: 'assets/images/lamp/lamp1.jpg',
    tag: 'Hot',
  ),
  NotificationModel(
    title: 'Your order #123456789 has been canceled',
    subtitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    productImage: 'assets/images/lamp/lamp2.png',
    tag: '',
  ),
];

// ── Shipping Addresses ────────────────────────────────────────
final List<ShippingAddress> dummyAddresses = [
  ShippingAddress(
    name: 'Bruno Fernandes',
    address: '25 rue Robert Latouche, Nice, 06200, Côte D\'azur, France',
    zipcode: '06200',
    country: 'France',
    city: 'Nice',
    isDefault: true,
  ),
  ShippingAddress(
    name: 'Bruno Fernandes',
    address: '25 rue Robert Latouche, Nice, 06200, Côte D\'azur, France',
    zipcode: '06200',
    country: 'France',
    city: 'Nice',
    isDefault: false,
  ),
  ShippingAddress(
    name: 'Bruno Fernandes',
    address: '25 rue Robert Latouche, Nice, 06200, Côte D\'azur, France',
    zipcode: '06200',
    country: 'France',
    city: 'Nice',
    isDefault: false,
  ),
];

// ── Payment Cards ─────────────────────────────────────────────
final List<PaymentCard> dummyCards = [
  PaymentCard(
    logoAsset: 'assets/images/logo/cardpay1.png',
    cardNumber: '**** **** **** 3947',
    cardHolder: 'Jennyfer Doe',
    expiry: '05/23',
    isDefault: true,
  ),
  PaymentCard(
    logoAsset: 'assets/images/logo/cardpay2.png',
    cardNumber: '**** **** **** 3947',
    cardHolder: 'Jennyfer Doe',
    expiry: '05/23',
    isDefault: false,
  ),
];

final List<String> categories = ['Popular', 'Chair', 'Table', 'Armchair', 'Bed'];