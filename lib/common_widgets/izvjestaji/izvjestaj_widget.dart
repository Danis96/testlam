import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lamp/theme/color_helper.dart';

class IzvjestajWidget extends StatelessWidget {
  const IzvjestajWidget({
    required this.description,
    required this.name,
    required this.date,
    required this.amount,
    required this.total,
    Key? key,
  }) : super(key: key);

  final String description;
  final String name;
  final String date;
  final int amount;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: _buildCard(context),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      child: Container(
        height: 75,
        decoration: BoxDecoration(border: Border.all(color: ColorHelper.lampLightGray.color), borderRadius: BorderRadius.all(Radius.circular(11.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_firstRow(), _secondRow()],
        ),
      ),
    );
  }

  Widget _firstRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '$description: ',
                style: TextStyle(color: ColorHelper.lampGray.color, fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                name,
                style: TextStyle(color: ColorHelper.lampGray.color, fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          amount > 0
              ? Text(
                  '+ $amount',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: ColorHelper.lampGreen.color),
                )
              : Text(
                  '$amount',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: ColorHelper.lampRed.color),
                )
        ],
      ),
    );
  }

  Widget _secondRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                date,
                style: TextStyle(fontSize: 16, color: ColorHelper.lampGray.color, fontWeight: FontWeight.w300),
              ),
              Text(
                ' iznos $amount KM',
                style: TextStyle(fontSize: 16, color: ColorHelper.lampGray.color, fontWeight: FontWeight.w300),
              )
            ],
          ),
          Text(
            ' bodova',
            style: TextStyle(fontSize: 16, color: ColorHelper.lampGray.color, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
