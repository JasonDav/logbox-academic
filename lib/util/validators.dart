class Validators {
  static String? password(String? pass, {String? other}) {
    print(pass);
    if (pass == null || pass.isEmpty) {
      return 'Password cannot be empty.';
    }

    if (pass.length < 7) {
      return 'Password needs to be 8 or more characters.';
    }

    if (other != null && pass != other) {
      return 'Passwords do not match.';
    }

    // todo: add password validation regex
    return null;
  }

    static String? username(String? username, {String? other}) {
    print(username);
    if (username == null || username.isEmpty) {
      return 'Username cannot be empty.';
    }

    if (username.length < 5) {
      return 'Username needs to be 5 or more characters.';
    }

    if (other != null && username != other) {
      return 'Usernames do not match.';
    }

    // todo: add username validation regex
    return null;
  }

  static String? email(String? email, {String? other}) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty.';
    }

    if (other != null && email != other) {
      return 'Emails do not match.';
    }

    // todo: add email validation regex
    return null;
  }
}

typedef ValidatorCallback = String? Function(String? value);
