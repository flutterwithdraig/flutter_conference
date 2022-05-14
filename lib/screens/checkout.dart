import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/cart/cart_bloc.dart';
import 'package:global_conference/const.dart';
import 'package:global_conference/widgets/cart/index.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CartButton(disableNav: true),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return ListView(
                shrinkWrap: true,
                children: state.items
                    .map(
                      (e) => Dismissible(
                        key: Key(e.code),
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          context
                              .read<CartBloc>()
                              .add(RemoveItemFromCart(e.code));
                        },
                        child: ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<CartBloc>()
                                      .add(ReduceItemQty(e.code));
                                },
                                child: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(e.qty.toString()),
                            ],
                          ),
                          title: Text(e.name),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("£${e.price.toStringAsFixed(2)}"),
                              Text("Total: £${e.total.toStringAsFixed(2)}"),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          AddItemToCartButton(
            cartItem: getAppProduct('event1'),
          ),
          AddItemToCartButton(
            cartItem: getAppProduct('cap1'),
          ),
          AddItemToCartButton(
            cartItem: getAppProduct('tshirt1'),
          ),
          const CheckoutButton(),
        ],
      ),
    );
  }
}
