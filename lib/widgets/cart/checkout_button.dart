import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/cart/cart_bloc.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return TextButton(
          onPressed: state.items.isEmpty
              ? null
              : () {
                  context.read<CartBloc>().add(StartPaymentProcess());
                },
          child: Text('Checkout: £${state.cartTotalPrice.toStringAsFixed(2)}'),
        );
      },
    );
  }
}
