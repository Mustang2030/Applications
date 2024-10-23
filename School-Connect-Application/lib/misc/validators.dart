String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'please enter your email address';
  } else if (!RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value)) {
    return 'please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'please enter your password';
  } else if (value.length < 8) {
    return 'password must be 8 characters';
  } else if (!value.contains("@")) {
    return "password must have the '@' symbol";
  }
  return null;
}

String? validateCap(String? value) {
  if (value == null || value.isEmpty) {
    return "Please don't leave this empty";
  }
  return null;
}

String? validateNum(String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill in this part";
  } else if (value.length == 10) {
    return null;
  }
  return null;
}

String? validateId(String? value) {
  if (value == null || value.isEmpty) {
    return "Please fill in this part";
  } else if (value.length == 13) {
    return "Please enter a correct ID number";
  }
  return null;
}
