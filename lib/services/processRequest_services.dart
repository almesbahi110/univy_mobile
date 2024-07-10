import 'package:univy_mobile/models/Api_Response.dart';
import 'package:univy_mobile/models/process_requests.dart';
import 'dart:convert';
import 'package:http/http.dart' as http ;

class ProcessRequestServices {
  static const API = 'http://univyhikma-001-site1.btempurl.com/api';
  static const headers = {
    'content-type': 'application/json',
    // 'Content-Type': 'application/json'
  };
  Future <ApiResponse<List<ProcessRequest>>> getProcessRequestsBydemanderId({required String demanderId}){
    return http.get(Uri.parse(API+'/ProcessRequest/GetAllProcessRequestsByDemanderId?demanderId=$demanderId'))
        .then((data) {
      if(data.statusCode==200){
        final jsonData = jsonDecode(data.body);
        final funds = <ProcessRequest>[];
        for(var item in jsonData){

          funds.add(ProcessRequest.fromJson(item));
        }
        return ApiResponse<List<ProcessRequest>>(data: funds);
      }
      return ApiResponse<List<ProcessRequest>>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((e)=>  ApiResponse<List<ProcessRequest>>(error: true ,errorMessage: 'error occured $e'));
  }


  Future <ApiResponse<List<ProcessRequest>>> getProcessRequestsByProcessId({required int processId,required String demanderId}){
    return http.get(Uri.parse(API+'/ProcessRequest/GetAllProcessRequestsByProcessIdAndDemanderId?ProcessId=$processId&demanderId=$demanderId'))
        .then((data) {
      if(data.statusCode==200){
        final jsonData = jsonDecode(data.body);
        final funds = <ProcessRequest>[];
        for(var item in jsonData){

          funds.add(ProcessRequest.fromJson(item));
        }
        return ApiResponse<List<ProcessRequest>>(data: funds);
      }
      return ApiResponse<List<ProcessRequest>>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((e)=>  ApiResponse<List<ProcessRequest>>(error: true ,errorMessage: 'error occured $e'));
  }
  Future <ApiResponse<List<ProcessRequest>>> getAllProcessRequestForOder({required String demanderId}){
    return http.get(Uri.parse(API+'/ProcessRequest/AllProcessRequestForOder?demanderId=$demanderId'))
        .then((data) {
      if(data.statusCode==200){
        final jsonData = jsonDecode(data.body);
        final funds = <ProcessRequest>[];
        for(var item in jsonData){

          funds.add(ProcessRequest.fromJson(item));
        }
        return ApiResponse<List<ProcessRequest>>(data: funds);
      }
      return ApiResponse<List<ProcessRequest>>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((e)=>  ApiResponse<List<ProcessRequest>>(error: true ,errorMessage: 'error occured $e'));
  }
  Future <ApiResponse<List<ProcessRequest>>> getAllProcessRequestByRequestNumber({required int processRequestNumber}){
    return http.get(Uri.parse(API+'/ProcessRequest/processRequestNumber?processRequestNumber=$processRequestNumber'))
        .then((data) {
      if(data.statusCode==200){
        final jsonData = jsonDecode(data.body);
        final funds = <ProcessRequest>[];
        for(var item in jsonData){

          funds.add(ProcessRequest.fromJson(item));
        }
        return ApiResponse<List<ProcessRequest>>(data: funds);
      }
      return ApiResponse<List<ProcessRequest>>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((e)=>  ApiResponse<List<ProcessRequest>>(error: true ,errorMessage: 'error occured $e'));
  }



  Future <ApiResponse<bool>> createProcessRequest(ProcessRequest item){
    return http.post(Uri.parse(API+'/ProcessRequest'),
        headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      if(data.statusCode==201){
        return ApiResponse<bool>(data:true);
      }
      return ApiResponse<bool>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((e)=>  ApiResponse<bool>(error: true ,errorMessage: '${e.toString()} '));
  }









  Future <ApiResponse<bool>> deleteProcessRequest({required int processStageId,required String demanderId}){
    return http.delete(Uri.parse(API+'/ProcessRequest/DeletedataByprocessStageIdAndDemanderId?demanderId=$demanderId&processStagesId=$processStageId'),headers: headers)
        .then((data) {
      if(data.statusCode==204){
        return ApiResponse<bool>(data:true);
      }
      return ApiResponse<bool>(error: true ,errorMessage: 'error occured${data.statusCode}');
    }
    ).catchError((_)=>  ApiResponse<bool>(error: true ,errorMessage: 'error occured'));
  }




  Future <ApiResponse<bool>> deleteProcessRequestByProcessId({required int processId,
    required String demanderId}){
    return http.delete(
Uri.parse(API+'/ProcessRequest/DeletedataByprocessIdAndDemanderId?demanderId=$demanderId&processId=$processId'),
        headers: headers)
        .then((data) {
      if(data.statusCode==204){
        return ApiResponse<bool>(data:true);
      }
      return ApiResponse<bool>(error: true ,errorMessage: 'error occured${data.statusCode}');
    }
    ).catchError((_)=>  ApiResponse<bool>(error: true ,errorMessage: 'error occured'));
  }



  Future <ApiResponse<bool>> deleteProcessRequestByProcessRequestNumberAndDemednerId({required int processRequestNumber,required String demanderId}){
    return http.delete(Uri.parse(API+'/ProcessRequest/DeletedataByProcessRequestNumberAndDemanderId?ProcessRequestNumber=$processRequestNumber&demanderId=$demanderId'),headers: headers)
        .then((data) {
      if(data.statusCode==204){
        return ApiResponse<bool>(data:true);
      }
      return ApiResponse<bool>(error: true ,errorMessage: 'error occured${data.statusCode}');
    }
    ).catchError((_)=>  ApiResponse<bool>(error: true ,errorMessage: 'error occured'));
  }

}