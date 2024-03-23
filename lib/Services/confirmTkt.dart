import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ConfirmTktService {
  String url = "https://www.confirmtkt.com/";
  String errorMessage = "ignore";
  Future<Map<String, dynamic>> getPnrDetails(int pnrNo) async {
    String fUrl = "${url}pnr-status/$pnrNo";
    RegExp regex = RegExp(r".*data\s*=(.*\});", caseSensitive: false);
    try {
      http.Response res = await http.get(Uri.parse(fUrl));
      var match = regex.firstMatch(res.body.toString())?.group(1);
      return json.decode(match!.toString());
    } on SocketException {
      errorMessage = "Internal Server Error!";
      return {"Error": errorMessage};
    } on http.ClientException {
      errorMessage = "Internet Connection Error!";
      return {"Error": errorMessage};
    }
  }

  Future<Map<String,dynamic>> getSchedule(int trainNo) async{
    String fUrl = "${url}train-schedule/$trainNo";
    RegExp regex = RegExp(r".*data\s*=\s*'\s*(.*\})';", caseSensitive: false);
    try {
      http.Response res = await http.get(Uri.parse(fUrl));
      var match = regex.firstMatch(res.body.toString())?.group(1);
      return json.decode(match!.toString());
      // return res.body.toString();
    } on SocketException {
      errorMessage = "Internal Server Error!";
      return {"Error": errorMessage};
      // return errorMessage;
    } on http.ClientException {
      errorMessage = "Internet Connection Error!";
      return {"Error": errorMessage};
      // return errorMessage;
    }
  }

  // Future<String?> tmp(int pnrNo) async {
  //   String fUrl = "$url/$pnrNo";
  //   RegExp regex = RegExp(r".*data\s*=(.*\});", caseSensitive: false);
  //   try {
  //     http.Response res = await http.get(Uri.parse(fUrl));
  //     try {
  //       var match = regex.firstMatch(res.body.toString())?.group(2);
  //       return match;
  //     } on RangeError catch (e) {
  //       errorMessage="Server Failed!!";
  //       return errorMessage;
  //     }
  //   } on SocketException {
  //     errorMessage = "Internal Server Error!";
  //     return errorMessage;
  //   } on http.ClientException {
  //     errorMessage = "Internet Connection Error!";
  //     return errorMessage;
  //   }
  // }
}
