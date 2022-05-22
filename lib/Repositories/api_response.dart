class APIResponse<T>{
  T? data;
  final bool error;
  String? message;

  APIResponse({this.data,this.error=false,this.message});
}