class ApiResponse<T>{
  final T data;
  final bool isLocalDB;

  ApiResponse(this.data, this.isLocalDB);
}