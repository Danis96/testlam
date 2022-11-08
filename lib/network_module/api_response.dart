/// ApiResponse
///
/// here we are defining response types,
/// and base on these types we will show appropriate widgets in our view
class ApiResponse<T> {
  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  Status status;
  T? data;
  String? message;

  @override
  String toString() {
    return 'Status: $status \n Message : $message \n Data: $data';
  }
}

enum Status { LOADING, COMPLETED, ERROR }
