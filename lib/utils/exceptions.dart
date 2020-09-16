///In this file all custom exception are stored.

///This exception is throw when the server cant be reached
class ServerException implements Exception {
  String _message;

  ServerException([String message = '5xx error, server might be offline']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

///This exception is throw when a 404 error appears
class StatusCode4Exception implements Exception {
  String _message;

  StatusCode4Exception([String message = '404 Error']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
