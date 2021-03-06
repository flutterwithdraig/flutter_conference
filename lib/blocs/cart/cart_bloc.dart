import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:global_conference/blocs/auth/auth_bloc.dart';
import 'package:global_conference/models/cart_item.dart';
import 'package:global_conference/repositories/conference.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required ConferenceRepository conferenceRepository,
    required AuthBloc authBloc,
  })  : _conferenceRepository = conferenceRepository,
        _authBloc = authBloc,
        super(
            const CartState(items: [], noItemsInCart: 0, cartTotalPrice: 0.0)) {
    on<AddItemToCart>(_addItem);
    on<RemoveItemFromCart>(_removeItem);
    on<ReduceItemQty>(_reduceQty);
    on<StartPaymentProcess>(_startPayment);
  }

  final ConferenceRepository _conferenceRepository;
  final AuthBloc _authBloc;

  List _totalItemsInList(List<CartItem> items) {
    if (items.isEmpty) return [0, 0.0];

    int count = 0;
    double total = 0.0;
    for (var i in items) {
      count += i.qty;
      total += i.price * i.qty;
    }
    return [count, total];
  }

  FutureOr<void> _addItem(AddItemToCart event, Emitter<CartState> emit) {
    List<CartItem> items = List.from(state.items);
    CartItem newItem = event.item;

    final existingItemIndex = items.indexWhere((i) => i.code == newItem.code);
    if (existingItemIndex != -1) {
      final existingItem = items[existingItemIndex];

      if (!singleItem.contains(newItem.type)) {
        newItem = existingItem.copyWith(qty: existingItem.qty + newItem.qty);
      }
      items[existingItemIndex] = newItem;
    } else {
      items.add(newItem);
    }

    final totals = _totalItemsInList(items);
    emit(state.copyWith(
        items: items, noItemsInCart: totals[0], cartTotalPrice: totals[1]));
  }

  FutureOr<void> _removeItem(
      RemoveItemFromCart event, Emitter<CartState> emit) {
    final index = state.items.indexWhere((i) => i.code == event.code);
    if (index == -1) {
      return null;
    }

    List<CartItem> items = List.from(state.items);
    items.removeAt(index);
    final totals = _totalItemsInList(items);
    emit(state.copyWith(
        items: items, noItemsInCart: totals[0], cartTotalPrice: totals[1]));
  }

  FutureOr<void> _reduceQty(ReduceItemQty event, Emitter<CartState> emit) {
    final index = state.items.indexWhere((i) => i.code == event.code);
    if (index == -1) {
      return null;
    }
    List<CartItem> items = List.from(state.items);
    final item = items[index];
    if (item.qty > 1) {
      items[index] = item.copyWith(qty: item.qty - 1);
    } else {
      items.removeAt(index);
    }

    final totals = _totalItemsInList(items);
    emit(state.copyWith(
        items: items, noItemsInCart: totals[0], cartTotalPrice: totals[1]));
  }

  FutureOr<void> _startPayment(
      StartPaymentProcess event, Emitter<CartState> emit) async {
    Map<String, dynamic> _paymentInfo =
        await _conferenceRepository.createPaymentSheet(jsonEncode(state.items));

    print(_paymentInfo);

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        style: ThemeMode.light,
        testEnv: true,
        merchantCountryCode: 'GB',
        merchantDisplayName: 'Global Conference 2023',
        customerId: _paymentInfo['customer'],
        paymentIntentClientSecret: _paymentInfo['paymentIntent'],
        customerEphemeralKeySecret: _paymentInfo['ephemeralKey'],
      ),
    );

    try {
      await Stripe.instance.presentPaymentSheet();

      for (var i = 0; i < state.items.length; i++) {
        if (state.items[i].code.startsWith('event')) {
          _authBloc.add(AuthAddPaidEvent(state.items[i].code));
        }
      }
      emit(state.copyWith(items: [], noItemsInCart: 0));
    } on StripeException catch (e) {
      print(e.error.localizedMessage);
    }
  }
}
