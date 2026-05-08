import 'package:flutter/foundation.dart';
import '../models/order_model.dart';
import '../data/dummy_data.dart';

class ProfileProvider with ChangeNotifier {
  String _name = 'Kristin Watson';
  String _email = 'bruno203@gmail.com';
  String _password = '**************';

  List<ShippingAddress> _addresses = List.from(dummyAddresses);
  List<PaymentCard> _cards = List.from(dummyCards);
  List<NotificationModel> _notifications = List.from(dummyNotifications);

  bool _salesNotif = true;
  bool _newArrivalsNotif = false;
  bool _deliveryNotif = false;

  // Getters
  String get name => _name;
  String get email => _email;
  String get password => _password;
  List<ShippingAddress> get addresses => _addresses;
  List<PaymentCard> get cards => _cards;
  List<NotificationModel> get notifications => _notifications;
  bool get salesNotif => _salesNotif;
  bool get newArrivalsNotif => _newArrivalsNotif;
  bool get deliveryNotif => _deliveryNotif;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void updateProfile(String name, String email) {
    _name = name;
    _email = email;
    notifyListeners();
  }

  void addAddress(ShippingAddress address) {
    _addresses.add(address);
    notifyListeners();
  }

  void setDefaultAddress(int index) {
    for (int i = 0; i < _addresses.length; i++) {
      _addresses[i].isDefault = i == index;
    }
    notifyListeners();
  }

  void removeAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }

  void addCard(PaymentCard card) {
    _cards.add(card);
    notifyListeners();
  }

  void setDefaultCard(int index) {
    for (int i = 0; i < _cards.length; i++) {
      _cards[i].isDefault = i == index;
    }
    notifyListeners();
  }

  void markAllRead() {
    for (final n in _notifications) {
      n.isRead = true;
    }
    notifyListeners();
  }

  void toggleSalesNotif(bool val) {
    _salesNotif = val;
    notifyListeners();
  }

  void toggleNewArrivalsNotif(bool val) {
    _newArrivalsNotif = val;
    notifyListeners();
  }

  void toggleDeliveryNotif(bool val) {
    _deliveryNotif = val;
    notifyListeners();
  }
}