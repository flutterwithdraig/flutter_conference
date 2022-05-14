import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/blocs/cart/cart_bloc.dart';
import 'package:global_conference/const.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/widgets/cart/cart_button.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({
    Key? key,
    required this.event,
  }) : super(key: key);

  final ConfEvent event;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          pinned: true,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(event.title),
            background: CachedNetworkImage(
              imageUrl: event.image,
              fit: BoxFit.cover,
            ),
          ),
          actions: const [
            CartButton(),
            SizedBox(width: 16),
          ],
        )
      ],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(event.speakers),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.home, color: AppColors.orange, size: 16),
                const SizedBox(width: 10),
                Text(
                  event.address,
                  style: AppFonts.headline2.copyWith(fontSize: 14),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.schedule, color: AppColors.orange, size: 16),
                const SizedBox(width: 10),
                Text(
                  '${event.start} - ${event.end}',
                  style: AppFonts.headline2.copyWith(fontSize: 14),
                ),
              ],
            ),
            if (event.purchaseCode.isNotEmpty) ...[
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppColors.orange),
                onPressed: () {
                  context.read<CartBloc>().add(
                        AddItemToCart(getAppProduct(event.purchaseCode)),
                      );
                },
                child: const Text('Book this event'),
              ),
            ],
            const SizedBox(height: 15),
            Text(event.details),
          ],
        ),
      ),
    );
  }
}
