class ApiResponse<T>{
  T? data;
  bool error = false;
  String? errorMessage;
  ApiResponse({this.data,this.errorMessage,this.error=false});
}