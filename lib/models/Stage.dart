class Stage{
   int? stageId;
   String? stageName;
  int? employeeId;
   Stage(
  {
     this.stageName,
    this.stageId,
   // this.stateGender,
      this.employeeId,
}
      );
   factory Stage.fromJson(Map<String,dynamic>item){
   return Stage(
     stageId: item['stageId'],
     stageName: item['stageName'],
    // stateGender: item['stateGender'],
     employeeId: item['employeeId'],
   );
   }
   Map<String,dynamic> toJson(){
     return  {
      "stageId": stageId,
       "stageName":stageName,
       "employeeId":employeeId,
     };
   }
}