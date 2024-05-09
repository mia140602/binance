import 'package:intl/intl.dart';

class ParserUtil {
  static String clampDigits(String value, [int limit = 7]) {
    try {
      final split = value.split('');
      String result = "";

      final splitLength = split.length;

      int length = 0;
      int index = 0;
      while (length < limit && index <= splitLength - 1) {
        if (int.tryParse(split[index]) != null) {
          length++;
        }
        result += split[index];
        index++;
      }
      return result;
    } catch (e) {
      return value;
    }
  }

  static String formatPrice(String value) {
    double? numValue = double.tryParse(value.replaceAll(',', '.'));
    if (numValue == null) return value;

    // Định dạng cho giá theo kiểu Đức
    NumberFormat priceFormat = NumberFormat("#,##0.0", "de_DE");
    return priceFormat.format(numValue);
  }

  static String formatAmount(String value) {
    double? numValue = double.tryParse(value.replaceAll(',', '.'));
    if (numValue == null) return value;

    // Định dạng cho giá theo kiểu Đức
    NumberFormat priceFormat = NumberFormat("#,##0.000", "de_DE");
    return priceFormat.format(numValue);
  }

  static String formatTotal(String value) {
    double? numValue = double.tryParse(value);
    if (numValue == null) return value;

    // Định dạng cho tổng với viết tắt
    NumberFormat totalFormat = NumberFormat.compact(locale: "en_US");
    return totalFormat.format(numValue);
  }
}
