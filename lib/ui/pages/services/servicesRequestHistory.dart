import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:univy_mobile/constants/colors.dart';
import 'package:univy_mobile/constants/dimensions.dart';
import 'package:univy_mobile/models/Api_Response.dart';
import 'package:univy_mobile/models/process_requests.dart';
import 'package:univy_mobile/providers/user.dart';
import 'package:univy_mobile/services/processRequest_services.dart';
import 'package:univy_mobile/ui/pages/services/serviceStagesDetails.dart';
class ServiceRequestsHistory extends StatefulWidget {
  UserAuth? user;
   ServiceRequestsHistory({this.user,Key? key}) : super(key: key);

  @override
  _ServiceRequestsHistoryState createState() => _ServiceRequestsHistoryState();
}


class _ServiceRequestsHistoryState extends State<ServiceRequestsHistory> {
  ProcessRequestServices get requestServices =>GetIt.I<ProcessRequestServices>();
  ApiResponse<List<ProcessRequest>>?_apiResponse;
  bool isLoading = false;
  @override
  void initState() {
    _fetchdata();
    super.initState();
  }
  _fetchdata() async {
    setState(() {
      isLoading = true;
    });


    _apiResponse = await requestServices.getAllProcessRequestForOder(demanderId: "${widget.user!.id}");


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
          child: Text(_apiResponse!.errorMessage.toString(),style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: "Lemonada",
            color:AppColor.mainColor,
            fontSize: Dimensions.font12,

          )),
        ),
      );
    }
    if (isLoading==false){
      bool shouldPop = true;
      return WillPopScope(
        onWillPop:()async{
          Get.back(result: 'refresh');
          return shouldPop;
          // Get.back(result: 'refresh');
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(color: AppColor.lightBlue),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
              onTap: (){
                Get.back(result: 'refresh');
              },
                child: Icon(Icons.arrow_back,)
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo.png",width: Dimensions.imgWidth40),


              ],
            ),
          ),
          body: Builder(
            builder: (_){
              if(isLoading){
                return Center(child: CircularProgressIndicator(color: AppColor.lightBlue,));
              }
              if(_apiResponse!.error==true){
                return Center(child: Text(_apiResponse!.errorMessage.toString(),style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Lemonada",
                  color:AppColor.mainColor,
                  fontSize: Dimensions.font12,

                )));
              }
              if (_apiResponse!.data!.length == 0) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width120,top:Dimensions.width15,left:Dimensions.width120 ),
                      child: Container(
                        //  margin:EdgeInsets.only(bottom: Dimensions.height25,) ,
                        padding: EdgeInsets.only(left: Dimensions.height10,right: Dimensions.height10,top: Dimensions.height15,bottom: Dimensions.height15),
                        decoration: BoxDecoration(
                            color: AppColor.darkWhite,
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            border: Border.all(
                                color: AppColor.lightBlue,
                                width: 1
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('assets/images/service.png',width:Dimensions.imgWidth40,),
                            Text(
                              'سجل العمليات',
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: "Lemonada",
                                color:AppColor.mainColor,
                                fontSize: Dimensions.font12,

                              ),),
                            //SizedBox(height: Dimensions.width5,),




                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.height50+Dimensions.height50,),
                    Icon(Icons.restore_rounded,color: AppColor.lightBlue,size: Dimensions.height50+Dimensions.height15,),
                    SizedBox(height: Dimensions.height10,),
                    Text('لا يوجد أي عملية تم طلبها',  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Lemonada",
                      color:Colors.grey,
                      fontSize: Dimensions.font12,

                    ),),

                  ],
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.width120,top:Dimensions.width15,left:Dimensions.width120 ),
                    child: Container(
                      //  margin:EdgeInsets.only(bottom: Dimensions.height25,) ,
                      padding: EdgeInsets.only(left: Dimensions.height10,right: Dimensions.height10,top: Dimensions.height15,bottom: Dimensions.height15),
                      decoration: BoxDecoration(
                          color: AppColor.darkWhite,
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          border: Border.all(
                              color: AppColor.lightBlue,
                              width: 1
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/service.png',width:Dimensions.imgWidth40,),
                          Text(
                            'سجل العمليات',
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Lemonada",
                              color:AppColor.mainColor,
                              fontSize: Dimensions.font12,

                            ),),
                          //SizedBox(height: Dimensions.width5,),




                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  Flexible(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: Dimensions.radius10,bottom: Dimensions.radius10),
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
                                child: Text(_apiResponse!.errorMessage.toString(),style: TextStyle(color: Colors.blue),),
                              );
                            }
                            if (_apiResponse!.data!.length!=0)
                           {
                             return Container(
                              margin: EdgeInsets.only(bottom: Dimensions.radius10),
                              decoration: BoxDecoration(
                                  color: AppColor.darkWhite,
                                 // borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  border: Border.all(
                                      color: AppColor.lightBlue,
                                      width: 0.5
                                  )
                              ),
                              child: ListTile(
                                onTap: ()async {
                                 // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  ServicesStagesDetails(processRequestNumber: _apiResponse!.data![index].processRequestNumber!)));
                                 final refresh= await Get.to(ServicesStagesDetails(processRequestNumber: _apiResponse!.data![index].processRequestNumber!,user: widget.user!),transition: Transition.cupertino,duration: Duration(milliseconds: 900));
                                  setState(() {
                                    _fetchdata();
                                  });
                                  if(refresh=='refresh')
                                    {
                                      setState(() {
                                        _fetchdata();
                                      });

                                    }

                                },
                                trailing: CircleAvatar(
                                  backgroundColor: AppColor.lightBlue,
                                  radius: Dimensions.radius15,
                                  child: Center(
                                    child: Text('${index + 1}',
                                      textDirection: TextDirection.rtl,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Lemonada",
                                        color:Colors.white,
                                        fontSize: Dimensions.font12,

                                      ),),
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    Text(_apiResponse!.data![index].processStages!['process']['processName'],
                                      textDirection: TextDirection.rtl,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Lemonada",
                                        color:AppColor.mainColor,
                                        fontSize: Dimensions.font12,

                                      ),),
                                    SizedBox(width: Dimensions.width4,),
                                    Image.asset(_apiResponse!.data![index].processStages!['process']['imgUrl'],width:30,),
                                    SizedBox(width: Dimensions.width40,),
                                  ],

                                ),
                                leading:Padding(
                                  padding:  EdgeInsets.only(top: Dimensions.height5),
                                  child: Text( "بتاريخ : "+ _apiResponse!.data![index].dateBegin.toString().substring(0,10),
                                    textDirection: TextDirection.ltr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Lemonada",
                                      color:AppColor.mainColor,
                                      fontSize: Dimensions.font8,

                                    ),),
                                )


                              ),
                            );
                           }
                            return Container();
                          }
                      )
                  ),
                ],
              );

            },
          ),
        ),
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColor.lightBlue,
          ),
        ));
  }
}
