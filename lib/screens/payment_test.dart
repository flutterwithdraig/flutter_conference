import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:global_conference/repositories/conference.dart';

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
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: _paymentInfo != null ? null : _initPayment,
              child: const Text('Initialise')),
          TextButton(
              onPressed: _paymentInfo != null ? _displayPaymentSheet : null,
              child: const Text('Make Payment'))
        ],
      ),
    );
  }

  _initPayment() async {
    _paymentInfo =
        await context.read<ConferenceRepository>().createPaymentSheet();

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        style: ThemeMode.light,
        testEnv: true,
        merchantCountryCode: 'GB',
        merchantDisplayName: 'Global Conference 2023',
        customerId: _paymentInfo!['customer'],
        paymentIntentClientSecret: _paymentInfo!['paymentIntent'],
        customerEphemeralKeySecret: _paymentInfo!['ephemeralKey'],
      ),
    );
    setState(() {});
  }

  _displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }
}
