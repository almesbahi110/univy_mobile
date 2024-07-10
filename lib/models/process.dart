class Process{
  int? processId;
  String? processName;
  String? instructions;
  String? imgUrl;
  int?processState;
  int? administrationId;
  Process(
      {
        this.processName,
        this.processId,
        this.instructions,
        this.imgUrl,
        this.administrationId,
        this.processState
      }
      );
  factory Process.fromJson(Map<String,dynamic>item){
    return Process(
      processId: item['processId'],
      processName: item['processName'],
      imgUrl: item['imgUrl'],
      instructions: item['instructions'],
      administrationId: item['administrationId'],
      processState: item['processState'],
    );

  }

  Map<String,dynamic> toJson(){
    return  {
      "instructions": instructions,
      "imgUrl": imgUrl,
      "processName":processName,
      "administrationId":administrationId,
      "processState":processState
    };
  }




}