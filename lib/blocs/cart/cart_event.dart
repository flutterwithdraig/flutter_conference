part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartEvent {
  final CartItem item;
  const AddItemToCart(this.item);
  @override
  List<Object> get props => [item];
}

class RemoveItemFromCart extends CartEvent {
  final String code;
  const RemoveItemFromCart(this.code);
  @override
  List<Object> get props => [code];
}

class ReduceItemQty extends CartEvent {
  final String code;
  const ReduceItemQty(this.code);
  @override
  List<Object> get props => [code];
}

class StartPaymentProcess extends CartEvent {}
