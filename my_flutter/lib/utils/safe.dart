///处理安全

///解析Int
int safeInt(dynamic s, {int defaultValue = 0}) {
  if (null == s) {
    return defaultValue;
  }

  if (s is int) {
    return s;
  }

  if (s is num) {
    return s.toInt();
  }

  if (s is String) {
    return int.tryParse(s) ?? defaultValue;
  }

  return defaultValue;
}
