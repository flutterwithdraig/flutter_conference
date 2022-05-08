import 'package:equatable/equatable.dart';

enum CartItemType { event, gift }

List<CartItemType> singleItem = [CartItemType.event];

class CartItem extends Equatable {
  final String code;
  final String name;
  final double price;
  final CartItemType type;
  final int qty;

  const CartItem({
    required this.code,
    required this.name,
    required this.price,
    required this.type,
    this.qty = 1,
  });

  double get total => price * qty;

  @override
  List<Object?> get props => [code, name, price, qty, type];

  Map<String, dynamic> toJson() => {'code': code, 'qty': qty};

  CartItem copyWith({
    String? code,
    String? name,
    double? price,
    CartItemType? type,
    int? qty,
  }) {
    return CartItem(
      code: code ?? this.code,
      name: name ?? this.name,
      price: price ?? this.price,
      type: type ?? this.type,
      qty: qty ?? this.qty,
    );
  }
}
