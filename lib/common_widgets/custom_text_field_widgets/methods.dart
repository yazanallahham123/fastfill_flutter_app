bool validateMobile(String? value) {
  String pattern = r'(^(?:[+0]9)?[0-9]{7,12}$)';
  RegExp regExp = new RegExp(pattern);
  if (value==null|| value.length == 0 || !regExp.hasMatch(value))
    return false;
  return true;
}

bool validateName(String? value) {
  if (value==null|| value.length == 0)
    return false;
  return true;
}


bool isStrongPassword(String password)=>(password.length > 7);

bool isFilled(String? value)=>(value != "");