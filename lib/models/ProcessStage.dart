class ProcessStage{
  int? processStagesId;
  int? processId;
  int? stageId;
  int? order;
  int? next;
  int? state;
  Map? process;
  Map? stage;
  ProcessStage(
      {
        this.processId,
        this.processStagesId,
        this.stageId,
        this.process,
        this.stage,
        // this.stateGender,
        this.order,
        this.next,
        this.state,
      }
      );
  factory ProcessStage.fromJson(Map<String,dynamic>item){
    return ProcessStage(
      processStagesId: item['processStagesId'],
      processId: item['processId'],
      stageId: item['stageId'],
      // stateGender: item['stateGender'],
      order: item['order'],
      next: item['next'],
      state: item['state'],
      process: item['process'],
      stage: item['stage'],
    );
  }
  Map<String,dynamic> toJson(){
    return  {
      "processStagesId": processStagesId,
      "processId":processId,
      "order":order,
      "stageId":stageId,
      "next":next,
      "state":state,
      "process":process,
      "stage":stage,
    };
  }





}