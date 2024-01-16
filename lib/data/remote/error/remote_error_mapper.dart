class RemoteErrorMapper {
  static Exception getException(dynamic error) {
    if (error is Exception) {
      return error;
    } else {
      return Exception(error.toString());
    }
  }
}
