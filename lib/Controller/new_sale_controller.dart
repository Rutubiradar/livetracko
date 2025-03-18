import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <String, int>{}.obs; // productId -> quantity
  var productPrices = <String, double>{}.obs; // productId -> price

  void updatePrice(String productId, double productPrice) {
    // if (productPrices.containsKey(productId)) {
    productPrices[productId] = productPrice;

    // }
  }

  String getPrice(String productId) {
    return productPrices[productId].toString();
  }

  void addToCart(String productId) {
    if (cartItems.containsKey(productId)) {
      cartItems[productId] = cartItems[productId]! + 1;
    } else {
      cartItems[productId] = 1;
    }
  }

  void removeFromCart(String productId) {
    if (cartItems.containsKey(productId) && cartItems[productId]! > 1) {
      cartItems[productId] = cartItems[productId]! - 1;
    } else {
      cartItems.remove(productId);
    }
  }

  void modifyQty(int qty, String productId) {
    if (qty == 0) {
      cartItems.remove(productId);
    } else {
      cartItems[productId] = qty;
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  int getQuantity(String productId) {
    return cartItems[productId] ?? 0;
  }

  int get totalItems => cartItems.length;

  int get totalQuantity => cartItems.values.fold(0, (sum, qty) => sum + qty);
}
