import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:univy_mobile/constants/colors.dart';
import 'package:univy_mobile/models/Api_Response.dart';
import 'package:univy_mobile/models/employee.dart';
import 'package:univy_mobile/providers/auth_service.dart';
import 'package:univy_mobile/providers/user_provider.dart';
import 'ChanngePassword.dart';
class Profile extends StatefulWidget {
 final BuildContext context;
   Profile({required this.context,Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  AuthServices get services => GetIt.I<AuthServices>();
   ApiResponse<Employee>?_apiResponse;

  bool isLoading = false;
  _fetchEmployee() async {
    setState(() {
      isLoading = true;
    });

    _apiResponse = await services.getById(con:widget.context );


    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    _fetchEmployee();
  }
  @override
  Widget build(BuildContext context) {

    final user=Provider.of<UserProvider>(context) .user;


   // String typ="${user.roles}";
    String typ="tt";
    print(user.name);
    print(user.id);

    return    Builder(builder: (_) {
      if (isLoading) {
        return Center(
            child: CircularProgressIndicator(
              color: Colors.black38,
            ));
      }
      if (_apiResponse!.error == true) {
        return Center(
          child: Text(_apiResponse!.errorMessage.toString()),
        );
      }
      return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 190,
          centerTitle: true,
          backgroundColor: AppColor.mainColor.withOpacity(0.8),
          title: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              SizedBox(height: 10,),
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                maxRadius: 40,
                backgroundImage: AssetImage('assets/images/img.png'),
              ),
              Text(
                "${user.name}",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "${_apiResponse!.data!.employeeName}",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40.0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ListTile(
                trailing: Icon(
                  Icons.home_work_outlined,
                  size: 40,
                  color: Colors.blue,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text(
                      "الجامعة",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${_apiResponse!.data!.administration!['foundation']['foundationName']}"),
                    Divider(
                      color: Colors.black,
                      height: 10,
                      indent: 20,
                    ),
                  ],
                ),
              ),
            ),
            typ=="Student"?  Container(
              padding: EdgeInsets.only(top: 15),
              child: ListTile(
                trailing: Icon(
                  Icons.align_vertical_bottom,
                  size: 40,
                  color: Colors.blue,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "المستوى الدراسي",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text("المستوى الرابع"),
                    Divider(
                      color: Colors.black,
                      height: 10,
                      indent: 20,
                    ),
                  ],
                ),
              ),
            ):  Container(
              padding: EdgeInsets.only(top: 15),
              child: ListTile(
                trailing: Icon(Icons.home_work_outlined,size: 40,color: Colors.blue,),
                title: Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text("النوع",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Text("${_apiResponse!.data!.type}"),
                    Divider(color: Colors.black,height: 10,indent: 20,),
                  ],),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ListTile(
                trailing: Icon(Icons.align_vertical_bottom,size: 40,color: Colors.blue,),
                title: Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text("الكلية",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    Text("${_apiResponse!.data!.administration!['administrationName']}"),
                    Divider(color: Colors.black,height: 10,indent: 20,),
                  ],),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ListTile(
                trailing: const Icon(
                  Icons.phone,
                  size: 40,
                  color: Colors.blue,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text(
                      "رقم الهاتف",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text("${_apiResponse!.data!.phoneNumber}"),
                    Divider(
                      color: Colors.black,
                      height: 10,
                      indent: 20,
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: 15),
              child: ListTile(
                trailing: Icon(
                  Icons.date_range,
                  size: 40,
                  color: Colors.blue,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text(
                      "تاريخ الميلاد",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text("${_apiResponse!.data!.birthdate!.substring(0,10)}"),
                    Divider(
                      color: Colors.black,
                      height: 10,
                      indent: 20,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "انقر لتغيير كلمة المرور",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
                trailing: const Icon(
                  Icons.published_with_changes_outlined,
                  size: 40,
                  color: Colors.blue,
                ),
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      context: context,
                      builder: (BuildContext context) {
                        return  ChangePassword();
                      });

                },
              ),
            ),
          ],
        ),
      )
    );});
  }
}