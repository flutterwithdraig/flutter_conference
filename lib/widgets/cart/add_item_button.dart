import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/cart/cart_bloc.dart';
import 'package:global_conference/models/cart_item.dart';

class AddItemToCartButton extends StatelessWidget {
  AddItemToCartButton({
    required this.cartItem,
    Widget? child,
    Key? key,
  })  : _child = child ?? Text(cartItem.name),
        super(key: key);
  final CartItem cartItem;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<CartBloc>().add(
              AddItemToCart(cartItem),
            );
      },
      child: _child,
    );
  }
}
