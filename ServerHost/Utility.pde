public static String generateRoomCode(String ip) {
  String result = "";
  for (int i = 0; i < ip.length(); i++) {
    char ch;
    ch = char((int) ip.charAt(i) + 17);
    if (ch == '?') {
      ch = '-';
    }
    result += ch;
  }
  return result;
}

public static String roomCodeToIp(String code) {
  String result = "";
  for (int i = 0; i < code.length(); i++) {
    char ch;
    if (code.charAt(i) == '-') {
      result += ".";
    } else {
      ch = char((int) code.charAt(i) - 17);
      result += ch;
    }
  }
  return result;
}
