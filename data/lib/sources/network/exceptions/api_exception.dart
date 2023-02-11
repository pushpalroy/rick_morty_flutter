class APIException implements Exception  {

  APIException(this.message, this.statusCode, this.statusText);
  final String message;
  final int statusCode;
  final String statusText;
}