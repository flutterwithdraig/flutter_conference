import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/cart/cart_bloc.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    this.disableNav = false,
    Key? key,
  }) : super(key: key);

  final bool disableNav;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (!disableNav) {
              Navigator.pushNamed(context, '/checkout');
            }
          },
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              const Icon(Icons.shopping_cart_rounded),
              Positioned(
                bottom: 10,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    state.noItemsInCart.toString(),
                    style: const TextStyle(fontSize: 8),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
