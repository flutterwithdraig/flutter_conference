import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_conference/const.dart';

import '../bloc/home_page_bloc.dart';

class DateRow extends StatelessWidget {
  const DateRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is HomePageLoaded) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [8, 9, 10, 11]
                    .map((e) => DateBox(
                          day: e,
                          active: state.day == e,
                        ))
                    .toList()

                // const [
                //   DateBox(text: '8'),
                //   DateBox(text: '9', active: true),
                //   DateBox(text: '10'),
                //   DateBox(text: '11'),
                // ],
                );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class DateBox extends StatelessWidget {
  final int day;
  final bool active;
  const DateBox({
    required this.day,
    this.active = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          context
              .read<HomePageBloc>()
              .add(LoadEventByDay(day: active ? 0 : day));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: active ? AppColors.orange : AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            day.toString(),
            style: TextStyle(
              color: active ? AppColors.grey : Colors.white,
              fontSize: 29,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
