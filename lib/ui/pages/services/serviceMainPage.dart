import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_it/get_it.dart';
import 'package:univy_mobile/constants/colors.dart';
import 'package:univy_mobile/constants/dimensions.dart';
import 'package:univy_mobile/models/Api_Response.dart';
import 'package:get/get.dart';
import 'package:univy_mobile/models/process.dart';
import 'package:univy_mobile/models/process_requests.dart';
import 'package:univy_mobile/providers/user.dart';
import 'package:univy_mobile/services/processRequest_services.dart';
import 'package:univy_mobile/services/process_service.dart';
import 'package:univy_mobile/ui/pages/services/servicesRequestHistory.dart';
import 'package:univy_mobile/ui/pages/services/servicesStagesPage.dart';
class ServiceMainPage extends StatefulWidget {
 UserAuth? user;
   ServiceMainPage({this.user,Key? key}) : super(key: key);

  @override
  _ServiceMainPageState createState() => _ServiceMainPageState();
}

class _ServiceMainPageState extends State<ServiceMainPage> {
  ProcessServices get services => GetIt.I<ProcessServices>();
  ProcessRequestServices get requestServices =>GetIt.I<ProcessRequestServices>();
  ApiResponse<List<Process>>?_apiResponse;
  ApiResponse<List<ProcessRequest>>?_apiResponse2;
  bool isLoading = false;
  @override
  void initState() {
    _fetchProcess();
    super.initState();
  }

  _fetchProcess() async {
    setState(() {
      isLoading = true;
    });

    _apiResponse = await services.getProcess();
    _apiResponse2 = await requestServices.getAllProcessRequestForOder(demanderId: "${widget.user!.id}");

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(
              color: AppColor.lightBlue,
            ),
          ));
    }
    if (_apiResponse!.error == true) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(_apiResponse!.errorMessage.toString()),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: Dimensions.height15,),
            child: InkWell(
              onTap: () async{

              final refresh= await  Get.to(ServiceRequestsHistory(user: widget.user!),transition: Transition.cupertino,duration: Duration(milliseconds: 900));
             if(refresh=='refresh')
               {
               setState(() {
                 _fetchProcess();
               });
               }
              },
                child: Center(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.notifications,size: Dimensions.height25+5,),),
                     if(_apiResponse2!.data!.length >0)
                      Positioned(
                        top: Dimensions.height15,
                          child: CircleAvatar(
                            child:  Text(_apiResponse2!.data!.length >= 99?'+99':_apiResponse2!.data!.length.toString(),style: TextStyle(color: Colors.white,fontSize:_apiResponse2!.data!.length >= 99? Dimensions.font8-2:Dimensions.font8),),
                            backgroundColor: Colors.orange,radius: Dimensions.font8,)),


                    ],
                  ),
                )
            ),
          ),
        ],
        iconTheme: IconThemeData(color: AppColor.lightBlue),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png",width: Dimensions.imgWidth40),


          ],
        ),
      ),
      body: Column(
        children: [
          Flexible(
              child:GridView.builder(
                padding: EdgeInsets.only(right: Dimensions.width15,left:Dimensions.width15,top:Dimensions.width40 ),
                // physics: NeverScrollableScrollPhysics(),
                //shrinkWrap: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimensions.height25,
                    crossAxisSpacing: Dimensions.height25,
                    childAspectRatio: 1
                ),
                itemCount:_apiResponse!.data!.length,
                itemBuilder: (context, index){
                  if (isLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                          color: AppColor.lightBlue,
                        ));
                  }
                  if (_apiResponse!.error == true) {
                    return Center(
                      child: Text(_apiResponse!.errorMessage.toString()),
                    );
                  }
                  return InkWell(
                    onTap: ()async{
                      if(_apiResponse!.data![index].processState==1){
                       final refresh= await Get.to(ServicesStagesPage(user: widget.user!,processId:_apiResponse!.data![index].processId!,processInstruction: _apiResponse!.data![index].instructions!,),transition: Transition.cupertino,duration: Duration(milliseconds: 900));
                       if(refresh=='refresh')
                       {
                         setState(() {
                           _fetchProcess();
                         });
                       }
                      }

                      },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height10),
                    //  margin:EdgeInsets.only(bottom: Dimensions.height25,) ,
                      //margin: EdgeInsets.all(100),
                      decoration: BoxDecoration(
                          color: AppColor.darkWhite,
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          border: Border.all(
                              color: _apiResponse!.data![index].processState==1?AppColor.lightBlue:Colors.grey,
                              width: 1
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _apiResponse!.data![index].processState==1?Image.asset("assets/images/checked.png",width:Dimensions.imgWidth10,):Icon(Icons.not_interested,color: Colors.grey,size:Dimensions.imgWidth10),
                              Text(
                                _apiResponse!.data![index].processState==1?"متاح":"غير متاح",
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Lemonada",
                                  color:_apiResponse!.data![index].processState==1?Colors.green:Colors.grey,
                                  fontSize: Dimensions.font10,

                                ),),
                            ],
                          ),
                          SizedBox(height: Dimensions.height20,),
                          Image.asset(_apiResponse!.data![index].imgUrl!,width:Dimensions.imgWidth40,),
                          Text(
                            _apiResponse!.data![index].processName.toString(),
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Lemonada",
                              color:_apiResponse!.data![index].processState==1?AppColor.mainColor:Colors.grey,
                              fontSize: Dimensions.font12,

                            ),),
                          //SizedBox(height: Dimensions.width5,),




                        ],
                      ),
                    ),
                  );

                },


              ),
          )
        ],
      ),
    );
  }
}
