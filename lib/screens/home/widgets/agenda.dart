import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/const.dart';
import 'package:global_conference/models/conf_event.dart';

import '../bloc/home_page_bloc.dart';

class Agenda extends StatelessWidget {
  const Agenda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is HomePageInitial) {
          return const CircularProgressIndicator();
        } else if (state is HomePageFailed) {
          return Text(state.message);
        } else if (state is HomePageLoaded) {
          return Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                return EventCard(event: state.events[index]);
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class EventCard extends StatelessWidget {
  final ConfEvent event;
  const EventCard({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/event', arguments: event.id);
      },
      child: Stack(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(event.image),
              ),
            ),
          ),
          Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.lightgrey,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title, style: AppFonts.headline2),
                    Text(event.speakers, style: AppFonts.subtitle),
                  ],
                )
              ]),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(event.start),
                  Text(event.end),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
