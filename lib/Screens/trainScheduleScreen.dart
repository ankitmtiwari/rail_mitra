import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rail_mitra/Screens/stationStopWidget.dart';

import '../Provider/TainDataProvivder.dart';

class TrainScheduleScreen extends StatefulWidget {
  const TrainScheduleScreen({super.key});

  @override
  State<TrainScheduleScreen> createState() => _TrainScheduleScreenState();
}

class _TrainScheduleScreenState extends State<TrainScheduleScreen> {
  final TextEditingController _trainNoController = TextEditingController();
  final _scheduleFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("PNR Details"),
        //   backgroundColor: Colors.blue,
        //   foregroundColor: Colors.white,
        // ),
        body: Consumer<TrainScheduleProvider>(
            builder: ((context, providerHelp, child) => Stack(children: [
                  GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: SizedBox(
                      child: SingleChildScrollView(
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: _scheduleFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  autofocus: false,
                                  // textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value == null || value.length != 5) {
                                      return 'Invalid Train Number';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) =>
                                      {_trainNoController.text = value},
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(5)
                                  ],
                                  controller: _trainNoController,
                                  decoration: const InputDecoration(
                                      // contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                          gapPadding: 11.5,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      hintText: 'Enter Train Number Here..',
                                      labelText: "Train Number"),
                                ),
                              ),
                              Center(
                                child: FilledButton(
                                  onPressed: () {
                                    // print(pnrInputController.text);
                                    if (_scheduleFormKey.currentState!
                                        .validate()) {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);

                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      providerHelp.getTrainSchedule(
                                          int.parse(_trainNoController.text));
                                    }
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.blue)),
                                  child: const Text('Get Schedule'),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              // Text(providerHelp.trainSchedule['TrainNo'].toString()),
                              // Text(providerHelp.trainSchedule['Source']),
                              // Text(providerHelp.trainSchedule['SourceCode']),
                              // Text(providerHelp.trainSchedule['Destination']),
                              // Text(providerHelp.trainSchedule['DestinationCode']),
                              // Text(providerHelp.trainSchedule['Schedule'][0]['StationName']),
                              // Text(providerHelp.trainSchedule['Schedule'][0]['intermediateStations'][0]['StationName']),
                              // Text(providerHelp.trainSchedule['Schedule'][0]['intermediateStations'][2]['StationName']),
                              Text(
                                providerHelp.trainSchedule['ErrorMsg'] ?? "",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 18.0),
                              ),
                              Text(
                                providerHelp.trainSchedule['Message'] ?? "",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 18.0),
                              ),
                              providerHelp.trainSchedule['TrainNo'] != null
                                  ? SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Card(
                                            child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment
                                                      .titleHeight,
                                              horizontalTitleGap:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                              leading: const Text("Arrival"),
                                              title: const Text("Station Name"),
                                              subtitle: const Text(
                                                  "Dist. Platform no"),
                                              trailing: const Text("Departure"),
                                            ),
                                          ),
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: providerHelp
                                                .trainSchedule['Schedule']
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              List schedule = providerHelp
                                                  .trainSchedule['Schedule'];
                                              return Card(
                                                surfaceTintColor:
                                                    Colors.transparent,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    child: ListTile(
                                                      titleAlignment:
                                                          ListTileTitleAlignment
                                                              .titleHeight,
                                                      horizontalTitleGap:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.08,
                                                      leading: Text(schedule[
                                                                      index][
                                                                  'ArrivalTime']
                                                              .toString()
                                                              .isEmpty
                                                          ? "Start"
                                                          : schedule[index]
                                                              ['ArrivalTime']),
                                                      title: Text(
                                                          schedule[index]
                                                              ['StationName']),
                                                      subtitle: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "${schedule[index]['Distance']} km"),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                          ),
                                                          Text(schedule[index][
                                                                      'ExpectedPlatformNo'] ==
                                                                  null
                                                              ? "Platform -"
                                                              : "Platform ${schedule[index]['ExpectedPlatformNo']}"),
                                                        ],
                                                      ),
                                                      trailing: Text(schedule[
                                                                      index][
                                                                  'DepartureTime']
                                                              .toString()
                                                              .isEmpty
                                                          ? "End"
                                                          : schedule[index][
                                                              'DepartureTime']),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox()
                              // providerHelp.trainSchedule['TrainNo'] != null
                              //     ? StationStopWidget(
                              //         trainData: providerHelp.trainSchedule,
                              //         onReload: providerHelp.getTrainSchedule)
                              //     : const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  providerHelp.inProgress
                      ? Center(
                          child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.black26.withOpacity(0.25),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              )),
                        )
                      : Container()
                ]))));
  }
}
