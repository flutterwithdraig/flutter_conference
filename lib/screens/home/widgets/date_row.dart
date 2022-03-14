import 'package:flutter/material.dart';
import 'package:global_conference/const.dart';

class DateRow extends StatelessWidget {
  const DateRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          DateBox(text: '8'),
          DateBox(text: '9', active: true),
          DateBox(text: '10'),
          DateBox(text: '11'),
        ],
      ),
    );
  }
}

class DateBox extends StatelessWidget {
  final String text;
  final bool active;
  const DateBox({
    required this.text,
    this.active = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active ? AppColors.orange : AppColors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: active ? AppColors.grey : Colors.white,
            fontSize: 29,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
