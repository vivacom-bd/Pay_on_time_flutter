class APIResponse<T>{
  T? data;
  final bool error;
  String? errorMessage;

  APIResponse({this.data,this.error=false,this.errorMessage});
}