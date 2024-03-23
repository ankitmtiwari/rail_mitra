
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PnrShortDetails extends StatelessWidget {
  final Map ticketData;
  final Function(int pntNumber)? onReload;

  PnrShortDetails(
      {super.key, required this.ticketData, required this.onReload});

  String? nameNumber;

  TextStyle textStyle = const TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w300, fontFamily: 'Lucid');

  @override
  Widget build(BuildContext context) {
    final List pDetails = ticketData['PassengerStatus'];
    List<Row> passengerStatus() {
      return List.generate(
          pDetails.length,
          (i) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Passenger ${pDetails[i]['Number']}"),
                  Text(
                    pDetails[i]['BookingBerthCode'] != null
                        ? "${pDetails[i]['BookingStatus']} | ${pDetails[i]['BookingBerthCode']}"
                        : pDetails[i]['BookingStatus'],
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    pDetails[i]['CurrentBerthCode'] != null
                        ? "${pDetails[i]['CurrentStatus']} | ${pDetails[i]['CurrentBerthCode']}"
                        : pDetails[i]['CurrentStatus'],
                    // "${pDetails[i]['CurrentStatus']}",
                    textAlign: TextAlign.right,
                  )
                ],
              ));
    }

    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Card(
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1.0, color: Colors.blue),
              borderRadius: BorderRadius.circular(12)),
          // margin: const EdgeInsets.all(10.0),
          borderOnForeground: true,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(12),
          //   border: Border.all(color: Colors.blue, width: 1.1),
          // ),
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: SizedBox(
              width: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${ticketData['TrainName']} (${ticketData['TrainNo']})",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blue,
                    indent: MediaQuery.of(context).size.width * 0.1,
                    endIndent: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Departure",
                        style: textStyle,
                      ),
                      Text(
                        "Arrival",
                        style: textStyle,
                      )
                    ],
                  ),
                  ticketData['InformationMessage'] != null
                      ? Text(ticketData['InformationMessage'])
                      : const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${ticketData["DepartureTime"]} hrs',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      Container(
                        height: 15.0,
                        width: 15.0,
                        padding: const EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.black),
                        child: Container(
                          height: 10.0,
                          width: 10.0,
                          margin: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.green),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 19.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('${ticketData["Duration"]} hrs')),
                      Container(
                        height: 15.0,
                        width: 15.0,
                        padding: const EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.black),
                        child: Container(
                          height: 10.0,
                          width: 10.0,
                          margin: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.red),
                        ),
                      ),
                      Text(
                        '${ticketData["ArrivalTime"]} hrs',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMMMEd().format(DateFormat("dd-MM-yyyy")
                            .parse(ticketData['SourceDoj'])),
                        // style: textStyle,
                      ),
                      Text(
                        DateFormat.yMMMEd().format(DateFormat("dd-MM-yyyy")
                            .parse(ticketData['DestinationDoj'])),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          '${ticketData['BoardingStationName']} - ${ticketData['BoardingPoint']}',
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                            '${ticketData['ReservationUptoName']} - ${ticketData['ReservationUpto']}',
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.clip,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Passenger Status :",
                      textAlign: TextAlign.left,
                      style: textStyle,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: const Text(
                          "Passenger No.",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const Text(
                            "Booking Status",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: const Text(
                            "Current Status",
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                  Column(
                    children: passengerStatus(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ticketData['ChartPrepared'] == false
                          ? "Chart Not Prepared"
                          : "Chart Prepared"),
                      IconButton(
                        icon: const Icon(Icons.refresh_outlined),
                        tooltip: "Click To Reload",
                        onPressed: () {
                          onReload!(int.parse(ticketData['Pnr']));
                        },
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Expected Platform Number: ",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(ticketData['ExpectedPlatformNo'])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Booking Fare *",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text("₹${ticketData['BookingFare']}/-")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Current Fare *",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text("₹${ticketData['TicketFare']}/-")
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
