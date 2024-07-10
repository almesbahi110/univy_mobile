import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:univy_mobile/constants/colors.dart';
import 'package:univy_mobile/constants/dimensions.dart';
import 'package:univy_mobile/models/Api_Response.dart';
import 'package:univy_mobile/models/ProcessStage.dart';
import 'package:univy_mobile/models/process_requests.dart';
import 'package:univy_mobile/providers/user.dart';
import 'package:univy_mobile/services/processRequest_services.dart';
import 'package:univy_mobile/services/processStages_services.dart';
class ServicesStagesPage extends StatefulWidget {
  UserAuth? user;
  int processId;
  String processInstruction;
   ServicesStagesPage({ this.user,required this.processId,required this.processInstruction,Key? key}) : super(key: key);

  @override
  _ServicesStagesPageState createState() => _ServicesStagesPageState();
}

class _ServicesStagesPageState extends State<ServicesStagesPage> {
  ProcessStageServices get services => GetIt.I<ProcessStageServices>();
  ProcessRequestServices get requestServices =>GetIt.I<ProcessRequestServices>();
  ApiResponse<List<ProcessStage>>?_apiResponse;
  ApiResponse<List<ProcessRequest>>?_apiResponse2;
  bool isLoading = false;
  bool isCreatingProcessRequest = false;
  bool isDeletingProcessRequest = false;
  int currentStep= 0;
 bool isComplete= false;
  bool isAccepted= false;
 bool isRejected= false;
  bool isExecuting= false;
  int processRequestNumber= 0;
//  final _formKey = GlobalKey<FormState>();
  final input =TextEditingController();
  ProcessRequest? processRequest;
  @override
  void initState() {
    _fetchdata();
    super.initState();
  }
  List<Step> getSteps(){
    List<Step> steps = [];
    for(int i = 0;i<_apiResponse!.data!.length;i++){
      var data = _apiResponse!.data![i];
      var newItem= Step(
        state: currentStep > i?StepState.complete:StepState.indexed,
        isActive: currentStep >= i,
        title: Text(
        data.stage!["stageName"],
        style: TextStyle(color: AppColor.mainColor,fontSize: Dimensions.font12)),
        content: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Text(data.stage!["title"],style: TextStyle(color: AppColor.mainColor,fontSize: Dimensions.font10),),
              SizedBox(height: Dimensions.height5,),
              data.state==0?
              TextFormField(
                // validator: (val) {
                //   if ( val == null || val.isEmpty) {
                //     return 'يجب ان لا يكون هذا الحقل فارغاً';
                //   }
                //   return null;
                // },
                style: TextStyle(fontSize: Dimensions.font12,color: AppColor.mainColor),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,

                decoration: InputDecoration(labelText:data.stage!["description"] ,labelStyle: TextStyle(color: Colors.grey,fontSize: Dimensions.font8,),hintTextDirection: TextDirection.ltr,alignLabelWithHint: true),
                controller: input,
              ):Text(data.stage!["description"],style: TextStyle(color: AppColor.mainColor,fontSize: Dimensions.font10),),

          ],),
        ),);
      steps.add(newItem);
    }
    return steps;
  }
  List<Step> _getSteps =[];

  _fetchdata() async {
    setState(() {
      isLoading = true;
    });

    _apiResponse = await services.getProcessStages(widget.processId);
   // _apiResponse2 = await requestServices.getProcessRequestsByProcessId(processId: widget.processId,demanderId: "${widget.user!.id}");
    _apiResponse2 = await requestServices.getProcessRequestsBydemanderId(demanderId: "${widget.user!.id}");
   _getSteps= await getSteps();
   print(_apiResponse2!.data!.length);

    setState(() {
      isLoading = false;
    });
  }
  _refreshSteps() async {
    setState(() {
      isLoading = true;
    });

    _getSteps= await getSteps();

    setState(() {
      isLoading = false;
    });
  }


 Future<void> _refreshdata()async{

   _apiResponse2 = await requestServices.getProcessRequestsByProcessId(processId: widget.processId,demanderId: "${widget.user!.id}");
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
                if(_apiResponse2!.data!.length !=0)
                {
                  if( _apiResponse2!.data![_apiResponse2!.data!.length - 1].processStages!['next']==0)
                  {
                    processRequestNumber=_apiResponse2!.data![_apiResponse2!.data!.length-1].processRequestId!;
                  }

                }
                else{
                  processRequestNumber=0;
                }
                print(processRequestNumber);
                for(int i = 0;i<_apiResponse2!.data!.length;i++){
                if(_apiResponse2!.data![i].processRequestState==0){
                  isExecuting=true;

                }
                if(_apiResponse2!.data![i].processRequestState==1){
                  isAccepted=true;

                }
                if(_apiResponse2!.data![i].processRequestState==2){
                  isRejected=true;

                }
                }
                if(isLoading){
                  return Center(child: CircularProgressIndicator(color: AppColor.lightBlue,));
                }
                if(_apiResponse!.error==true){
                  return Center(child: Text(_apiResponse!.errorMessage.toString()),);
                }
                if(_getSteps.isEmpty){
                  return Center(child: Text(_apiResponse!.errorMessage.toString()),);
                }
                if (isComplete==true)
                {
                  Get.back(result: 'refresh');
                }
                  // صفحة الخدمات الالكترونية

                  return ListView(
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
                              Image.asset(_apiResponse!.data![currentStep].process!['imgUrl'],width:Dimensions.imgWidth40,),
                              Text(
                                _apiResponse!.data![currentStep].process!['processName'].toString(),
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
                      Padding(
                        padding:  EdgeInsets.only(top: Dimensions.height10),
                        child: Center(
                          child: Text(widget.processInstruction,
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2
                            ,style: TextStyle(fontSize: Dimensions.font8,color: AppColor.mainColor,fontWeight: FontWeight.w300,),
                          ),
                        ),
                      ),
                      Stepper(
                        onStepTapped: (step) => setState( ()=> currentStep = step),
                          currentStep: currentStep,
                          physics: ScrollPhysics(),
                          steps: _getSteps,
                          onStepContinue: () async {

                            final isLastStep = currentStep == _getSteps.length - 1;
                            if (isLastStep) {
                              setState(() {
                                isCreatingProcessRequest=true;
                              });

                              final processRequest = ProcessRequest(
                                  note: "note",
                                  employeeId: "${widget.user!.id}",
                                  demanderType: "demanderType",
                                  processRequestNumber: processRequestNumber,
                                  processStagesId: _apiResponse!.data![currentStep].processStagesId,
                                  requestDescraption: input.text.isEmpty?_apiResponse!.data![currentStep].stage!["description"]:input.text
                              );
                              final result = await requestServices.createProcessRequest(processRequest);
                              print(result.errorMessage);
                              final text = result.error==true ? (result.errorMessage ??'an error occurred'):' تم بنجاح';
                              print(text);

                              setState(() {
                                isCreatingProcessRequest=false;
                                _refreshSteps();
                                input.clear();
                              });
                             Get.back(result: 'refresh');
                             Get.snackbar('تمت', "تم بنجاح إرسال "+"${_apiResponse!.data![1].process!['processName']}",backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM,margin: EdgeInsets.only(left:Dimensions.radius20,right: Dimensions.radius20,));


                            }
                            else {
                              setState(() {
                                isCreatingProcessRequest=true;
                              });

                              final processRequest = ProcessRequest(
                                note: "note",
                                  employeeId: "${widget.user!.id}",
                                demanderType: "demanderType",
                                processRequestNumber: processRequestNumber,
                                processStagesId: _apiResponse!.data![currentStep].processStagesId,
                                requestDescraption: input.text.isEmpty?_apiResponse!.data![currentStep].stage!["description"]:input.text
                              );
                              final result = await requestServices.createProcessRequest(processRequest);
                              print(result.errorMessage);
                              final text = result.error==true ? (result.errorMessage ??'an error occurred'):' تم بنجاح';
                              print(text);

                              setState(() {
                                isCreatingProcessRequest=false;
                                currentStep += 1;
                                _refreshSteps();
                                input.clear();
                              });


                            }


                          },
                          onStepCancel:()async{
                            final isLastStep = currentStep == _getSteps.length - 1;
                            if(isLastStep){
                              setState(() {
                                isDeletingProcessRequest=true;
                              });

                              final result = await requestServices.deleteProcessRequest(demanderId: "${widget.user!.id}",processStageId:_apiResponse!.data![currentStep].processStagesId!);
                              final result2 = await requestServices.deleteProcessRequest(demanderId: "${widget.user!.id}",processStageId:_apiResponse!.data![currentStep - 1].processStagesId!);
                              print(result.errorMessage);
                              print(result2.errorMessage);

                              setState(() {
                                isDeletingProcessRequest=false;
                                currentStep -=1;
                                _refreshSteps();
                              });
                            }

                            else {
                              setState(() {
                                isDeletingProcessRequest = true;
                              });

                              final result = await requestServices
                                  .deleteProcessRequest(demanderId: "${widget.user!.id}",
                                  processStageId: _apiResponse!
                                      .data![currentStep - 1].processStagesId!);
                              print(result.errorMessage);

                              setState(() {
                                isDeletingProcessRequest = false;
                                currentStep -= 1;
                                _refreshSteps();
                              });
                            }



                          },
                        controlsBuilder: (context,ControlsDetails details){
                          final isLastStep = currentStep == _getSteps.length - 1;
                          return Container(
                            margin: EdgeInsets.only(top: Dimensions.height50),
                            child: Row(
                              children: [
                                isCreatingProcessRequest==false?Expanded(
                                  child: ElevatedButton(
                                      onPressed: details.onStepContinue,
                                      child: Text(isLastStep?"تأكيد":"التالي")),
                                ):Center(child: CircularProgressIndicator(color: AppColor.lightBlue,)),
                                SizedBox(width: Dimensions.width15,),
                                if( currentStep!=0)
                                  isDeletingProcessRequest==false?Expanded(
                                    child: ElevatedButton(
                                      onPressed: details.onStepCancel,
                                      child: Text("رجوع"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.grey

                                      ),
                                    ),
                                  ):Center(child: CircularProgressIndicator(color: AppColor.lightBlue,)),

                              ],
                            ),
                          );
                        },


                      ),
                    ],
                  );

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
