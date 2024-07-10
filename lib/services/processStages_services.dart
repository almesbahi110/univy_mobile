import 'package:univy_mobile/models/Api_Response.dart';
import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:univy_mobile/models/ProcessStage.dart';

class ProcessStageServices{
  static const API= 'http://univyhikma-001-site1.btempurl.com/api';
  static const headers ={
    'content-type': 'application/json',
    // 'Content-Type': 'application/json'
  };
  Future <ApiResponse<List<ProcessStage>>> getProcessStages(int id){
    return http.get(Uri.parse(API+'/ProcessStages/idprocess?idprocess='+id.toString()))
        .then((data) {
      if(data.statusCode==200){
        final jsonData = jsonDecode(data.body);
        final funds = <ProcessStage>[];
        for(var item in jsonData){

          funds.add(ProcessStage.fromJson(item));
        }
        return ApiResponse<List<ProcessStage>>(data: funds);
      }
      return ApiResponse<List<ProcessStage>>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((e)=>  ApiResponse<List<ProcessStage>>(error: true ,errorMessage: 'error occured $e'));
  }
//   Future <ApiResponse<BankIdModel>> getFund(String id){
//     return http.get(Uri.parse(API+'/Bank/'+id),)
//         .then((data) {
//       if(data.statusCode==200){
//         final jsonData = jsonDecode(data.body);
//
//
//         return ApiResponse<BankIdModel>(data: BankIdModel.fromJson(jsonData));
//       }
//       return ApiResponse<BankIdModel>(error: true ,errorMessage: 'error occured');
//     }
//     ).catchError((_)=>  ApiResponse<BankIdModel>(error: true ,errorMessage: 'error occured'));
//   }
  Future <ApiResponse<bool>> createProcessStage(ProcessStage item){
    return http.post(Uri.parse(API+'/ProcessStages'),headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      if(data.statusCode==201){
        print("=============================");
        print("ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
        return ApiResponse<bool>(data:true);
      }
      return ApiResponse<bool>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((e)=>  ApiResponse<bool>(error: true ,errorMessage: '${e.toString()} '));
  }


  Future <ApiResponse<bool>> updateProcessStage(int id,ProcessStage item){
    return http.put(Uri.parse(API+'/ProcessStages/${id}'),
        headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      if(data.statusCode==204){
        return ApiResponse<bool>(data:true);
      }
      return ApiResponse<bool>(error: true ,errorMessage: 'تم التعديل بنجاح');
    }
    ).catchError((_)=>  ApiResponse<bool>(error: true ,errorMessage: 'error occured'));
  }




  Future <ApiResponse<bool>> deleteProcessStages(int id){
    return http.delete(Uri.parse(API+'/ProcessStages/$id'),headers: headers)
        .then((data) {
      if(data.statusCode==204){
        return ApiResponse<bool>(data:true);
      }
      return ApiResponse<bool>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((_)=>  ApiResponse<bool>(error: true ,errorMessage: 'error occured'));
  }
}