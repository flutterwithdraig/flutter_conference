part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final int noItemsInCart;

  const CartState({
    required this.items,
    required this.noItemsInCart,
  });

  @override
  List<Object> get props => [items, noItemsInCart];

  CartState copyWith({
    List<CartItem>? items,
    int? noItemsInCart,
  }) {
    return CartState(
      items: items ?? this.items,
      noItemsInCart: noItemsInCart ?? this.noItemsInCart,
    );
  }
}
