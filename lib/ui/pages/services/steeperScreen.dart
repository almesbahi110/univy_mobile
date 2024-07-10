// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
// import 'package:univy_mobile/constants/colors.dart';
// import 'package:univy_mobile/constants/dimensions.dart';
// import 'package:univy_mobile/models/Api_Response.dart';
// import 'package:univy_mobile/models/ProcessStage.dart';
// import 'package:univy_mobile/services/processStages_services.dart';
//
// class ServiceSteppter extends StatefulWidget {
//   int idProcess;
//   ServiceSteppter({Key? key,required this.idProcess}) : super(key: key);
//
//   @override
//   _ServiceSteppterState createState() => _ServiceSteppterState();
// }
//
//
// class _ServiceSteppterState extends State<ServiceSteppter> {
//   int currentStep = 0;
//   int _currentStep = 0;
//   int i = 0;
//
//   List<Step> listController = [];
//   int size=0;
//   ProcessStageServices get services => GetIt.I<ProcessStageServices>();
//   ApiResponse<List<ProcessStage>>? _apiResponse;
//   bool isLoading = false;
//   @override
//   void initState() {
//     _fetchProcessStage();
//     sentSet();
//     super.initState();
//
//   }
//   _fetchProcessStage() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     _apiResponse = await services.getProcessStages(widget.idProcess);
//     size =await _apiResponse!.data!.length;
//     sentSet();
//     setState(() {
//       isLoading = false;
//     });
//     //currentStep = _apiResponse!.data!.first.next!;
//     //  print("$currentStep");
//
//   }
//
//   sentSet() {
//     for (i = 0; i < size; i++) {
//       listController.add(
//         Step(
//           state: _currentStep >= i ? StepState.complete : StepState.disabled,
//           //   state:  StepState.complete,
//           title: Text("${_apiResponse!.data![i].stage!["stageName"]}"),
//           content: Text("${_apiResponse!.data![i].process!["instructions"]}"),
//           isActive: _currentStep >= i,
//         ),
//       );
//
//     }
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: context.theme.backgroundColor,
//           iconTheme: IconThemeData(color: AppColor.lightBlue),
//
//           elevation: 0,
//           centerTitle: true,
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset("assets/images/logo.png", width: Dimensions.imgWidth40),
//
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Builder(builder: (_) {
//                 if (isLoading) {
//                   return Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.black38,
//                       ));
//                 }
//                 if (_apiResponse!.error == true) {
//                   return Center(
//                     child: Text(_apiResponse!.errorMessage.toString()),
//                   );
//                 }
//                 return Column(
//                   children: [
//                     Stepper(
//                       type: StepperType.vertical,
//                       currentStep: _currentStep,
//                       steps: listController,
//                       physics: BouncingScrollPhysics(),
//                       onStepTapped: (int step) => setState(() => _currentStep = step),
//                       onStepContinue:
//                       _currentStep < i ? () => setState(
//                             () => _currentStep += 1,
//                       ) : null,
//                       onStepCancel:
//                       _currentStep > 0 ? () => setState(
//                               () => _currentStep -= 1
//                       ) : null,
//                     ),
//                   ],
//                 );
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
//
//
// }
