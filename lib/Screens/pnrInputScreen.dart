import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rail_mitra/Provider/TainDataProvivder.dart';
import 'package:rail_mitra/Screens/pnrShortDetailsScreen.dart';

class PnrDetailsScreen extends StatefulWidget {
  const PnrDetailsScreen({super.key});

  @override
  State<PnrDetailsScreen> createState() => _PnrDetailsScreenState();
}

class _PnrDetailsScreenState extends State<PnrDetailsScreen> {
  TextEditingController pnrInputController = TextEditingController();

  final _pnrFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PNR Details"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Consumer<PnrProvider>(
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
                          key: _pnrFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  autofocus: false,
                                  // textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value == null || value.length != 10) {
                                      return 'Invalid PNR Number';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) =>
                                      {pnrInputController.text = value},
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  controller: pnrInputController,
                                  decoration: const InputDecoration(
                                      // contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                          gapPadding: 11.5,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      hintText: 'Enter PNR Number Here..',
                                      labelText: "PNR Number"),
                                ),
                              ),
                              FilledButton(
                                onPressed: () {
                                  // print(pnrInputController.text);
                                  if (_pnrFormKey.currentState!.validate()) {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);

                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    providerHelp.getPntStatus(
                                        int.parse(pnrInputController.text));
                                  }
                                },
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.blue)),
                                child: const Text('Get Current Status'),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Text(
                                providerHelp.pnrDetails['Error'] ?? "",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 18.0),
                              ),
                              providerHelp.pnrDetails['TrainNo'] != null
                                  ? PnrShortDetails(
                                      ticketData: providerHelp.pnrDetails,
                                      onReload: providerHelp.getPntStatus,
                                    )
                                  : const SizedBox()
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
