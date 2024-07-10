// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:univyweb/Widget/snacbar.dart';
// import 'package:univyweb/providers/error_handling.dart';
// import 'package:univyweb/providers/user.dart';
// import 'package:univyweb/providers/user_provider.dart';
//
//
// class AuthService {
//   String myUri01 = "http://univyemen-001-site1.ftempurl.com/api/Authentication/login";
//
//   void signInUser(
//       {required BuildContext context, required String email, required String password}) async {
//     try {
//
//       http.Response res = await http.post(
//           Uri.parse(myUri01),
//           body: jsonEncode({
//             'username': email,
//             'password': password
//           }),
//           headers: <String, String>{
//             'content-type': 'application/json',
//           }
//       );
//
//       httpErrorHandel(
//           response: res,
//           context: context,
//           onSuccess: () async {
//
//             Provider.of<UserProvider>(context, listen: false).setUser(res.body);
//             showSnackBar(context, "sssssssssss");
//           //  Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
//           }
//       );
//
//     } catch (err) {
//       showSnackBar(context, err.toString());
//     }
//   }
//
//
// }






















import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert';


import 'package:univy_mobile/models/Api_Response.dart';
import 'package:http/http.dart' as http ;
import 'package:univy_mobile/models/Foundation.dart';
import 'package:univy_mobile/models/employee.dart';
import 'package:univy_mobile/providers/user.dart';
import 'package:univy_mobile/providers/user_provider.dart';


class AuthServices{

  static const API= 'http://almesbahiyemen-001-site1.btempurl.com/api';
  static const headers ={
    'content-type': 'application/json',

    // 'Content-Type': 'application/json'
  };
  Future <ApiResponse<Employee>> getById({required BuildContext con}){
 final user=Provider.of<UserProvider>(con) .user;
 String userId=user.id!;
 print("yyyyyyyyyyyy");
print(user.id);
 //   return http.get(Uri.parse(API+'/Employee/${user.id}'))
    return http.get(Uri.parse(API+'/Employee/$userId'))
        .then((data) {
          print(data.statusCode);
          print(data.body);

      if(data.statusCode==200){
        final jsonData = jsonDecode(data.body);

        var ss=Employee.fromJson(jsonData);
    //    print("=========");
       // print(ss.employeeName);


        return ApiResponse<Employee>(data: ss);
      }
      return ApiResponse<Employee>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((d)=> ApiResponse<Employee>(error: true ,errorMessage: 'error occured ${d.toString()}'));
  }


  Future <ApiResponse<List<Employee>>> getEmployee(){
    return http.get(Uri.parse(API+'/Employee/All'))
        .then((data) {
      if(data.statusCode==200){
        final jsonData = jsonDecode(data.body);
        final funds = <Employee>[];
        for(var item in jsonData){

          funds.add(Employee.fromJson(item));
        }
        return ApiResponse<List<Employee>>(data: funds);
      }
      return ApiResponse<List<Employee>>(error: true ,errorMessage: 'error occured');
    }
    ).catchError((_)=>  ApiResponse<List<Employee>>(error: true ,errorMessage: 'error occured'));
  }


  Future <ApiResponse<List<Foundation>>> getAllFoundation(){
    return http.get(Uri.parse("http://almesbahiyemen-001-site1.btempurl.com/api/Foundation/All"))
        .then((data) {
      if(data.statusCode==200){
        final jsonData = jsonDecode(data.body);
        final funds = <Foundation>[];
        for(var item in jsonData){

          funds.add(Foundation.fromJson(item));
        }
        return ApiResponse<List<Foundation>>(data: funds);
      }
      return ApiResponse<List<Foundation>>(error: true ,errorMessage: 'error occured');
    }
    ).catchError((_)=>  ApiResponse<List<Foundation>>(error: true ,errorMessage: 'error occured'));
  }

//
//
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
//   }//{required StringUserAuth username,required String password}
  Future <ApiResponse<UserAuth>> createAuth({required BuildContext context,
    required String username,required String password}){
    return http.post(Uri.parse("http://almesbahiyemen-001-site1.btempurl.com/api/Authentication/login"),
      headers: headers,  body: jsonEncode({
      'username':username, 'password':password}),)
        .then((data) {
      if(data.statusCode==200){
        final jsonData = jsonDecode(data.body);
        print("$jsonData");
        UserAuth  funds= UserAuth();
        funds.token=jsonData["token"];
        funds.roles=jsonData["roles"];
        funds.name=jsonData["name"];
        funds.id=jsonData["id"];
        funds.isAuthenticated=jsonData["isAuthenticated"];
        funds.email=jsonData["email"];
        funds.username=jsonData["username"];
        funds.message=jsonData["message"];
        Provider.of<UserProvider>(context, listen: false).setUser(data.body);
        return ApiResponse<UserAuth>(data:funds);
      }
      if(data.statusCode==400){
        final jsonData = jsonDecode(data.body);
        //print("$jsonData");
        UserAuth  funds= UserAuth();
        funds.token=jsonData["token"];
        funds.roles=jsonData["roles"];
        funds.name=jsonData["name"];
        funds.id=jsonData["id"];
        funds.isAuthenticated=jsonData["isAuthenticated"];
        funds.email=jsonData["email"];
        funds.username=jsonData["username"];
        funds.message=jsonData["message"];
        return ApiResponse<UserAuth>(data:funds);
      }
      return ApiResponse<UserAuth>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((e)=>  ApiResponse<bool>(error: true ,errorMessage: '${e.toString()} ssssss'));
  }
    // return http.post(Uri.parse(API+'/Employee'),headers: headers,body: json.encode(item.toJson()))
    //     .then((data) {
    //   if(data.statusCode==201){
    //     print("=============================");
    //     print("ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
    //     return ApiResponse<bool>(data:true);
    //
    //
    //   }
    //   return ApiResponse<bool>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    // }
    // ).catchError((e)=>  ApiResponse<bool>(error: true ,errorMessage: '${e.toString()}'));
 // }
  Future <ApiResponse<bool>> updateEmployee(int id,Employee item){
    return http.put(Uri.parse(API+'/Employee/${id}'),headers: headers,body: json.encode(item.toJson()))
        .then((data) {
      if(data.statusCode==204){
        return ApiResponse<bool>(data:true);
      }
      return ApiResponse<bool>(error: true ,errorMessage: 'error occured ${data.statusCode}');
    }
    ).catchError((e)=>  ApiResponse<bool>(error: true ,errorMessage: 'error occured ${e.toString()}'));
  }
  Future <ApiResponse<bool>> deleteEmployee(int id){
    return http.delete(Uri.parse(API+'/Employee/${id}'),headers: headers)
        .then((data) {
      if(data.statusCode==204){
        return ApiResponse<bool>(data:true);
      }
      return ApiResponse<bool>(error: true ,errorMessage: 'عذرا الموظف مرتبط بالادارة');
    }
    ).catchError((_)=>  ApiResponse<bool>(error: true ,errorMessage: 'error occured'));
  }




  Future <ApiResponse<bool>> ChangeCustomerPasword({required String id,
    required String password}){

   return http.put(
       Uri.parse(API+"/Authentication/ChangeCustomerPasword?userId=$id&password=$password"),
       headers: headers)
       .then((data) {
         print("sassssssss");
         print(data.statusCode);
     if(data.statusCode==200){

       return ApiResponse<bool>(data:true);
     }
     return ApiResponse<bool>(error: true ,errorMessage: 'عذرا ');
   }
   ).catchError((_)=>  ApiResponse<bool>(error: true ,errorMessage: 'error occured'));

  }

}