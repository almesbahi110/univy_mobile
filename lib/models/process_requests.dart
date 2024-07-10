

class ProcessRequest{
  int? processRequestId;
  String? dateBegin;
  String? note;
  String? requestDescraption;
  String? employeeId;
  String? demanderType;
  int? processRequestState;
  int? processRequestNumber;
  int? processStagesId;
  Map? processStages;
  Map? employee;
  ProcessRequest(
      {
        this.processRequestId,
        this.dateBegin,
        this.note,
        this.requestDescraption,
        this.employeeId,
        this.demanderType,
        this.processStagesId,
        this.processStages,
        this.processRequestState,
        this.processRequestNumber,
        this.employee,

      }
      );
  factory ProcessRequest.fromJson(Map<String,dynamic>item){
    return ProcessRequest(
      processRequestId: item['processRequestId'],
      dateBegin: item['dateBegin'],
      note: item['note'],
      requestDescraption: item['requestDescraption'],
      // stateGender: item['stateGender'],
      employeeId: item['employeeId'],
      employee: item['employee'],
      demanderType: item['demanderType'],
      processStagesId: item['processStagesId'],
      processStages: item['processStages'],
      processRequestState: item['processRequestState'],
      processRequestNumber: item['processRequestNumber'],

    );
  }
  Map<String,dynamic> toJson(){
    return  {
      "processRequestId": processRequestId,
      "dateBegin": dateBegin,
      "note":note,
      "requestDescraption":requestDescraption,
      "demanderId":employeeId,
      "employee":employee,
      "demanderType":demanderType,
      "processStagesId":processStagesId,
      "processStages":processStages,
      "processRequestState":processRequestState,
      "processRequestNumber":processRequestNumber,

    };
  }





}