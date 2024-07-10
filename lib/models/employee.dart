
class Employee{
  String? employeeId;
  int? employeeState;
  String? birthdate;
  String? employeeName;
  String? type;
  String? phoneNumber;
  String? username;
  String? email;
  String? imgUrl;
  String? role;
  int? administrationId;
  int? stateGender;
   Map? administration;
  Employee(
      {
        this.username,
        this.birthdate,
        this.role,
        this.imgUrl,
        this.email,
       this.administration,
        this.employeeState,
        this.employeeId,
        this.employeeName,
        this.stateGender,
        this.phoneNumber,
        this.type,
      //  this.stateGender,
        this.administrationId,
      }
      );

  factory Employee.fromJson(Map<String,dynamic>item){
    return Employee(
      employeeId: item['employeeId'],
      employeeState: item['employeeState'],
      birthdate: item['birthdate'],
      employeeName: item['employeeName'],
      type: item['type'],
      phoneNumber: item['phoneNumber'],
      username: item['username'],
      email: item['email'],
      imgUrl: item['imgUrl'],
      role: item['role'],
      administrationId: item['administrationId'],
      stateGender: item['stateGender'],
      administration: item['administration'],

    );
  }
  Map<String,dynamic> toJson(){
    return  {
      "employeeState": employeeState,
      "employeeId":employeeId,
      "birthdate":birthdate,
      "employeeName":employeeName,
      "type":type,
      "phoneNumber":phoneNumber,
      "username":username,
      "email":email,
      "imgUrl":imgUrl,
      "role":role,
      "administrationId":administrationId,
      "stateGender":stateGender,
      "administration":administration,
    };
  }
}