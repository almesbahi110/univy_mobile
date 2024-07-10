import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:univy_mobile/constants/colors.dart';
import 'package:univy_mobile/constants/dimensions.dart';
import 'package:univy_mobile/models/Api_Response.dart';
import 'package:univy_mobile/models/process_requests.dart';
import 'package:univy_mobile/providers/user.dart';

import 'package:univy_mobile/services/processRequest_services.dart';



class ServicesStagesDetails extends StatefulWidget {
  UserAuth user;
  int processRequestNumber;

  ServicesStagesDetails({required this.user,required this.processRequestNumber,Key? key}) : super(key: key);

  @override
  _ServicesStagesDetailsState createState() => _ServicesStagesDetailsState();
}

class _ServicesStagesDetailsState extends State<ServicesStagesDetails> {
  ProcessRequestServices get requestServices =>GetIt.I<ProcessRequestServices>();
  ApiResponse<List<ProcessRequest>>?_apiResponse;
  bool isLoading = false;
  bool isComplete= false;
  bool isAccepted= false;
  bool isRejected= false;
  bool isExecuting= false;
  bool isCreatingProcessRequest = false;
  bool isDeletingProcessRequest = false;
  @override
  void initState() {
    _fetchdata();
    super.initState();
  }


  _fetchdata() async {
    setState(() {
      isLoading = true;
    });


    _apiResponse = await requestServices.getAllProcessRequestByRequestNumber(processRequestNumber: widget.processRequestNumber);

    setState(() {
      isLoading = false;
    });
  }



  Future<void> _refreshdata()async{

    _apiResponse = await requestServices.getAllProcessRequestByRequestNumber(processRequestNumber: widget.processRequestNumber);
    setState(() {
      isLoading = false;
      isAccepted= false;
      isRejected= false;
      isExecuting= false;
    });
  }




  @override
  Widget build(BuildContext context){
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
    if (isLoading==false)
    {
      return
        RefreshIndicator(
          backgroundColor: Colors.white,
          color: AppColor.lightBlue,
          onRefresh: _refreshdata,
          child: Scaffold(
            appBar: AppBar(
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
            backgroundColor: Colors.white,
            body: Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary:AppColor.lightBlue)
              ),
              child: Builder(
                  builder: (_) {

                    for(int i = 0;i<_apiResponse!.data!.length;i++){
                      if(_apiResponse!.data![i].processRequestState==0){
                        isExecuting=true;

                      }
                      if(_apiResponse!.data![i].processRequestState==1){
                        isAccepted=true;

                      }
                      if(_apiResponse!.data![i].processRequestState==2){
                        isRejected=true;

                      }
                    }
                    if(isLoading){
                      return Center(child: CircularProgressIndicator(color: AppColor.lightBlue,));
                    }
                    if(_apiResponse!.error==true){
                      return Center(child: Text(_apiResponse!.errorMessage.toString()),);
                    }
                    //صفحة البيانات للعملية

                      return Column(
                        children: [
                          SizedBox(height: Dimensions.height10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(_apiResponse!.data![0].processStages!['process']['imgUrl'],width:Dimensions.imgWidth20,),
                              SizedBox(width: Dimensions.width2,),
                              Text(
                                " بيانات "+_apiResponse!.data![0].processStages!['process']['processName'].toString(),
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Lemonada",
                                  color:AppColor.mainColor,
                                  fontSize: Dimensions.font10,

                                ),),
                              //SizedBox(height: Dimensions.width5,),




                            ],
                          ),
                          SizedBox(height: Dimensions.height20,),
                          isExecuting==true&&isAccepted==true&&isRejected==false || isExecuting==true&&isAccepted==false&&isRejected==false?Icon(Icons.access_time,color: Colors.lightBlue,size: Dimensions.width40,):isAccepted==true&&isRejected==false&&isRejected==false?Icon(Icons.verified_user_rounded,color: Colors.green,size: Dimensions.width40,):Icon(Icons.cancel_outlined,color: Colors.red,size: Dimensions.width40,),
                          Text(
                            isExecuting==true&&isAccepted==true&&isRejected==false || isExecuting==true&&isAccepted==false&&isRejected==false? "طلبك مازال قيد المراجعة فد يستغرق ذلك 24 ساعة":isAccepted==true&&isRejected==false&&isRejected==false?"تم قبول طلبك بنجاح ...":"عذرا تم رفض طلبك ",
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: "Lemonada",
                              color: Colors.grey,
                              fontSize: Dimensions.font10,

                            ),),
                          SizedBox(height: Dimensions.height5,),
                          isDeletingProcessRequest==false? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary:isExecuting==true&&isAccepted==true&&isRejected==false || isExecuting==true&&isAccepted==false&&isRejected==false?AppColor.darkBlue:isAccepted==true&&isRejected==false&&isRejected==false?Colors.green:Colors.red,
                              ),
                              child: Text(isExecuting==true&&isAccepted==true&&isRejected==false || isExecuting==true&&isAccepted==false&&isRejected==false? "إلغاء العملية":isAccepted==true&&isRejected==false&&isRejected==false?"تم":"إنهاء",style: TextStyle(color: Colors.white),),
                              onPressed: ()async{
                                setState(() {
                                  isDeletingProcessRequest=true;
                                });
                                final result = await requestServices.deleteProcessRequestByProcessRequestNumberAndDemednerId(processRequestNumber:_apiResponse!.data![0].processRequestNumber!,demanderId: widget.user.id!);
                                setState(() {
                                  isDeletingProcessRequest=false;
                                });
                               // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ServiceRequestsHistory()));
                                Get.back(result: 'refresh');

                               // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  ServiceRequestsHistory()));


                              }):Center(child: CircularProgressIndicator(color: AppColor.lightBlue,)),


                          SizedBox(height: Dimensions.height10,),
                          Flexible(
                            child:GridView.builder(
                              padding: EdgeInsets.only(right: Dimensions.width40,left:Dimensions.width40,top:Dimensions.width2 ),
                              // physics: NeverScrollableScrollPhysics(),
                              //shrinkWrap: false,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: Dimensions.height20,
                                crossAxisSpacing: Dimensions.height25,
                                childAspectRatio: 3,
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

                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: Dimensions.height10),
                                    //  margin:EdgeInsets.only(bottom: Dimensions.height25,) ,
                                    //margin: EdgeInsets.all(100),
                                    decoration: BoxDecoration(
                                        color: AppColor.darkWhite,
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        border: Border.all(
                                            color: _apiResponse!.data![index].processRequestState==0?AppColor.darkBlue:_apiResponse!.data![index].processRequestState==1?Colors.green:Colors.red,
                                            width: 1
                                        )
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _apiResponse!.data![index].processStages!['stage']['title'],
                                              textDirection: TextDirection.rtl,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Lemonada",
                                                color:  _apiResponse!.data![index].processRequestState==0?AppColor.darkBlue:_apiResponse!.data![index].processRequestState==1?Colors.green:Colors.red,
                                                fontSize: Dimensions.font8,

                                              ),),
                                          ],
                                        ),
                                        SizedBox(height: Dimensions.height10,),
                                        Text(
                                          _apiResponse!.data![index].processStages!['stage']['stageName'],
                                          textDirection: TextDirection.rtl,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Lemonada",
                                            color:AppColor.mainColor,
                                            fontSize: Dimensions.font8,

                                          ),),
                                        SizedBox(height: Dimensions.height5,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            _apiResponse!.data![index].processRequestState==1?Image.asset("assets/images/checked.png",width:Dimensions.imgWidth10,):_apiResponse!.data![index].processRequestState==2?Icon(Icons.cancel,color: Colors.red,size:Dimensions.imgWidth10):Icon(Icons.access_time,color: AppColor.darkBlue,size:Dimensions.imgWidth10),
                                            SizedBox(width: Dimensions.width2,),
                                            Text(
                                              _apiResponse!.data![index].processRequestState==1?"تمت":_apiResponse!.data![index].processRequestState==2?"رٌفضت":"قيد المراجعة",
                                              textDirection: TextDirection.rtl,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontFamily: "Lemonada",
                                                color:AppColor.mainColor,
                                                fontSize: Dimensions.font8,

                                              ),),
                                          ],),



                                      ],
                                    ),
                                  ),
                                );

                              },


                            ),
                          ),


                        ],
                      );

                    // صفحة الخدمات الالكترونية



                  }
              ),
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
