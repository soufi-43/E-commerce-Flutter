class UnprocessedEntity implements Exception {
  @override
  String toString() {
    return 'Missing fields';
  }
}

class LoginFailed implements Exception {
  @override
  String toString() {
    return 'credentials rejected';
  }
}

class RedirectionFound implements Exception {
  @override
  String toString() {
    return 'too many redirections';
  }
}

class ResourceNotFound implements Exception {
  String message;

  ResourceNotFound(this.message);

  @override
  String toString() {
    return "resource not ${this.message} found";
  }
}

class NoInternetConnection implements Exception {

  @override
  String toString() {
    return ' no internet is available';
  }


}

class PropertyIsRequired implements Exception{
  String field  ;
  PropertyIsRequired(this.field);
  @override
  String toString() {
    return 'Property ${this.field} is field';
  }
}

