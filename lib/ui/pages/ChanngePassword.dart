import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:univy_mobile/models/Api_Response.dart';
import 'package:univy_mobile/providers/auth_service.dart';
import 'package:univy_mobile/providers/user_provider.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}
class _ChangePasswordState extends State<ChangePassword> {
  AuthServices get services => GetIt.I<AuthServices>();
  ApiResponse<bool>?_apiResponse;
  final Current_Password = TextEditingController();
  final newpassword = TextEditingController();
  final Reset_Password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context) .user;

    return Container(
      height: 280,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // TextField(
          //   controller: Current_Password,
          //   obscureText: true,
          //   decoration: InputDecoration(
          //     hintText: "كلمة المرور الحالية",
          //   ),
          // ),
          TextField(
            controller: newpassword,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "كلمة المرور الجديدة",
            ),
            onChanged: (value) {},
          ),
          TextField(
            controller: Reset_Password,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "اعد كتابة كلمة المرور الجديدة",
            ),
            onChanged: (value) {},
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 100,
                height: 35,
                child: ElevatedButton(
                  child: Text("حفظ"),
                  style: ButtonStyle(
                      ),
                  onPressed: ()  async {
                    if (newpassword.text != Reset_Password.text) {
                      //print("كلمة المرور الجديدة غير متطابقة");
Get.snackbar(backgroundColor: Colors.redAccent,"عذراً", "كلمة المرور الجديدة غير متطابقة");
                    }else{

                      _apiResponse=  await  services.ChangeCustomerPasword(id: user.id!,password: newpassword.text.trim());

                   if(_apiResponse!.data==true)
                   {
                     Get.back();
                     Get.snackbar(backgroundColor: Colors.greenAccent,"نجاح", "تم تغيير كلمة المرور بنجاح");

                   }
                   else{
                     Get.snackbar( backgroundColor: Colors.redAccent,"خطأ", "يرجى اعادة كتابة كلمة مرور قوية");

                   }
                    }


                  },
                ),
              ),
              Container(
                width: 100,
                height: 35,
                child: ElevatedButton(
                  child: Text("الغاء"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
