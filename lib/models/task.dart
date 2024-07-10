class Task{
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;


  Task({
    this.title,
    this.date,
    this.color,
    this.endTime,
    this.id,
    this.isCompleted,
    this.note,
    this.remind,
    this.repeat,
    this.startTime
});

  Task.fromJson(Map<String,dynamic> json)
  {
    startTime=json['startTime'];
    repeat=json['repeat'];
    remind=json['remind'];
    note=json['note'];
    isCompleted=json['isCompleted'];
    id=json['id'];
    endTime=json['endTime'];
    color=json['color'];
    date=json['date'];
    title=json['title'];
  }

  Map<String,dynamic> toJson()
  {
    final Map<String,dynamic> data= new Map<String,dynamic>();
    data['title']=this.title;
    data['date']=this.date;
    data['color']=this.color;
    data['endTime']=this.endTime;
    data['id']=this.id;
    data['isCompleted']=this.isCompleted;
    data['note']=this.note;
    data['remind']=this.remind;
    data['repeat']=this.repeat;
    data['startTime']=this.startTime;
    return data;
  }

}