enum Status { LOADING, SUCCESS, ERROR }

class ResourceState<T> {
  Status status;
  T? data;
  Exception? exception;

  ResourceState.loading() : status = Status.LOADING;
  ResourceState.success(this.data) : status = Status.SUCCESS;
  ResourceState.error(this.exception) : status = Status.ERROR;
}
