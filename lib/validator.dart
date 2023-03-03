class ValidatorApp {
  static checkNull({String? text, bool isTextFiled = false}) {
    if (text == "null" || text == null || text == "") {
      return isTextFiled ? "Không bỏ trống" : "Đang cập nhật";
    } else {
      return isTextFiled ? null : text;
    }
  }

  static checkPass({String? text, String? text2, bool confirm = false}) {
    RegExp isPass = RegExp(
        "^(?=.{8,}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%^&*(),.?:{}|<>]).*");
    if (text == "null" || text == null || text == "") {
      return "Không bỏ trống";
    } else if (!isPass.hasMatch(text)) {
      return " Mật khẩu phải đủ 8 ký tự bao gồm ít nhất  1 chữ hoa\n - 1 chữ thường - 1 chữ số - 1 kí tự dặc biệt";
    } else if (text != text2 && confirm) {
      return "Mật khẩu không khớp";
    } else {
      return null;
    }
  }

  static checkEmail({
    String? text,
  }) {
    var isEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (text == "null" || text == null || text == "") {
      return "Không bỏ trống";
    } else if (!isEmail.hasMatch(text)) {
      return "Email không đúng định dạng";
    } else {
      return null;
    }
  }

  static checkPhone({
    String? text,
  }) {
    if (text == "null" || text == null || text == "") {
      return "Không bỏ trống";
    } else if (text.length != 10 || !text.startsWith("0")) {
      return "Số điện thoại không đúng định dạng";
    } else {
      return null;
    }
  }
}
