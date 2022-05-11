part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final int noItemsInCart;
  final double cartTotalPrice;

  const CartState({
    required this.items,
    required this.noItemsInCart,
    required this.cartTotalPrice,
  });

  @override
  List<Object> get props => [items, noItemsInCart, cartTotalPrice];

  CartState copyWith({
    List<CartItem>? items,
    int? noItemsInCart,
    double? cartTotalPrice,
  }) {
    return CartState(
      items: items ?? this.items,
      noItemsInCart: noItemsInCart ?? this.noItemsInCart,
      cartTotalPrice: cartTotalPrice ?? this.cartTotalPrice,
    );
  }
}
