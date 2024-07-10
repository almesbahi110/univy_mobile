

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http ;
import 'package:univy_mobile/controllers/task_cotroller.dart';
import 'package:univy_mobile/models/Api_Response.dart';
import 'package:univy_mobile/models/process.dart';
class ProcessServices {
  final TaskController _taskController=Get.put(TaskController());
  static const API = 'http://univyhikma-001-site1.btempurl.com/api';
  static const headers = {'Content-Type': 'application/json'};
  Future <ApiResponse<List<Process>>> getProcess() {
    return http.get(Uri.parse(API + '/Process/All'))
        .then((data) async{
      if (data.statusCode == 200) {

        final jsonData = jsonDecode(data.body);
        final funds = <Process>[];
        for (var item in jsonData) {
          funds.add(Process.fromJson(item));
        }

        return ApiResponse<List<Process>>(data: funds);
      }
      return ApiResponse<List<Process>>(
          error: true, errorMessage: 'error occured');
    }
    ).catchError((_) =>
        ApiResponse<List<Process>>(error: true, errorMessage: 'error occured'));
  }
  Future <ApiResponse<List<Process>>> getProcessStages(int id){
    return http.get(Uri.parse(API+'/ProcessStages/idprocess?idprocess='+id.toString()),)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = jsonDecode(data.body);
        final funds = <Process>[];
        for (var item in jsonData) {
          funds.add(Process.fromJson(item));
        }
        return ApiResponse<List<Process>>(data: funds);
      }
      return ApiResponse<List<Process>>(
          error: true, errorMessage: 'error occured');
    }
    ).catchError((_) =>
        ApiResponse<List<Process>>(error: true, errorMessage: 'error occured'));
  }
}