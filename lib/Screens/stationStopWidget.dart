import 'package:flutter/material.dart';

class StationStopWidget extends StatelessWidget {
  Map trainData;
  final Function(int pntNumber)? onReload;

  StationStopWidget(
      {super.key, required this.onReload, required this.trainData});

  @override
  Widget build(BuildContext context) {
    List schedule = trainData['Schedule'];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: schedule.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: MediaQuery.of(context).size.width*0.8,
          child: ListTile(
            leading: Text(schedule[index]['StationName']),
          ),
        );
      },
    );
  }
}
