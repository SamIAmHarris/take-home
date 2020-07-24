class Result<T> {
  Status status;
  T data;
  String message;

  Result.success(this.data) : status = Status.SUCCESS;

  Result.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { SUCCESS, ERROR }