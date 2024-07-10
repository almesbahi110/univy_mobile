class Foundation{
   int? foundationId;
   String? location;
   String? foundationName;
  int? foundationState;
   Foundation(
  {
     this.location,
    this.foundationId,
      this.foundationName,
      this.foundationState,
}
      );
   factory Foundation.fromJson(Map<String,dynamic>item){
   return Foundation(
     foundationId: item['foundationId'],
     location: item['location'],
     foundationName: item['foundationName'],
     foundationState: item['foundationState'],
   );
   }
   Map<String,dynamic> toJson(){
     return  {
      "foundationId": foundationId,
       "location":location,
       "foundationName":foundationName,
       "foundationState":foundationState,
     };
   }





}