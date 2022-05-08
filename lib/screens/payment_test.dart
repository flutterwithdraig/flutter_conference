import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/cart/cart_bloc.dart';
import 'package:global_conference/models/cart_item.dart';

class PaymentTest extends StatefulWidget {
  const PaymentTest({Key? key}) : super(key: key);

  @override
  State<PaymentTest> createState() => _PaymentTestState();
}

class _PaymentTestState extends State<PaymentTest> {
  Map<String, dynamic>? _paymentInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Test'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Text(state.noItemsInCart.toString());
              },
            ),
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
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(
                    const AddItemToCart(
                      CartItem(
                        code: 'event1',
                        name: 'Event 1',
                        price: 55.00,
                        type: CartItemType.event,
                      ),
                    ),
                  );
            },
            child: const Text('Add Event 1'),
          ),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(
                    const AddItemToCart(
                      CartItem(
                        code: 'cap1',
                        name: 'Baseball cap',
                        price: 10.99,
                        type: CartItemType.gift,
                      ),
                    ),
                  );
            },
            child: const Text('Add Cap'),
          ),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(
                    const AddItemToCart(
                      CartItem(
                          code: 'tshirt1',
                          name: 'T-shirt',
                          price: 25.50,
                          type: CartItemType.gift,
                          qty: 2),
                    ),
                  );
            },
            child: const Text('Add 2 t-shirts'),
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return TextButton(
                onPressed: state.items.isEmpty
                    ? null
                    : () {
                        context.read<CartBloc>().add(StartPaymentProcess());
                      },
                child: const Text('Checkout'),
              );
            },
          ),
        ],
      ),
    );
  }

  // _initPayment() async {
  //   _paymentInfo =
  //       await context.read<ConferenceRepository>().createPaymentSheet();

  //   await Stripe.instance.initPaymentSheet(
  //     paymentSheetParameters: SetupPaymentSheetParameters(
  //       applePay: true,
  //       googlePay: true,
  //       style: ThemeMode.light,
  //       testEnv: true,
  //       merchantCountryCode: 'GB',
  //       merchantDisplayName: 'Global Conference 2023',
  //       customerId: _paymentInfo!['customer'],
  //       paymentIntentClientSecret: _paymentInfo!['paymentIntent'],
  //       customerEphemeralKeySecret: _paymentInfo!['ephemeralKey'],
  //     ),
  //   );
  //   setState(() {});
  // }

  // _displayPaymentSheet() async {
  //   await Stripe.instance.presentPaymentSheet();
  // }
}
