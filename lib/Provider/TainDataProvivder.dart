import 'package:flutter/widgets.dart';
import 'package:rail_mitra/Services/confirmTkt.dart';

class PnrProvider extends ChangeNotifier {
  late Map<String, dynamic> pnrDetails={};
  String tv = "Nothing";
  bool inProgress = false;

  void isInProgress() {
    inProgress = !inProgress;
    notifyListeners();
  }

  void getPntStatus(int pnrNo) async {
    isInProgress();
    pnrDetails = await ConfirmTktService().getPnrDetails(pnrNo);
    isInProgress();
    notifyListeners();
  }



  // void tempo(int pnrNo) async {
  //   tv = (await ConfirmTktService().tmp(pnrNo))!;
  //   notifyListeners();
  // }
}

class TrainScheduleProvider extends ChangeNotifier{
  late Map<String, dynamic> trainSchedule={};
  // String trainSchedule="";
  String tv = "Nothing";
  bool inProgress = false;


  void isInProgress() {
    inProgress = !inProgress;
    notifyListeners();
  }
  void getTrainSchedule(int trainNo) async{
    isInProgress();
    trainSchedule= await ConfirmTktService().getSchedule(trainNo);
    isInProgress();
    notifyListeners();
  }
}
