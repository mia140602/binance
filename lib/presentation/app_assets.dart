class AppAssets {
  static String _getAssetPath(String asset) {
    return "assets/icons/$asset.png";
  }

  static String searchIcon = _getAssetPath("search");
  static const String avatar = "assets/icons/avatar.png";
  static String btc = _getAssetPath("btc");
  static String usdt = _getAssetPath("usdt");
  static String clock = _getAssetPath("clock");
  static String expand = _getAssetPath("expand");
  static const String globe = "assets/icons/globe.png";
  static const String lightLogo = "assets/icons/binance.png";
  static const String darkLogo = "assets/icons/binance.png";
  static const String menu = "assets/icons/menu.png";
  static String dropDown = _getAssetPath("drop_down");
  static String dropDownBordered = _getAssetPath("drop_down_bordered");
  static String arrowUp = _getAssetPath("arrow_up");
  static String arrowDown = _getAssetPath("arrow_down");
  static String candleChart = _getAssetPath("candle_chart");
  static String info = _getAssetPath("info");
  static String scanIcon = _getAssetPath("scan");
  static String headphoneIcon = _getAssetPath("headphone");
  static String bellringIcon = _getAssetPath("bell-ring");
  static String coinIcon = _getAssetPath("coin");

}
class NavAssets {
  static String _getAssetPath(String asset) {
    return "assets/icons/bottom_nav_icon/$asset.png";
  }

  static String marketIcons = _getAssetPath("bar-chart");
  static String tradesIcons =  _getAssetPath("exchange");
  static String futuresIcons =  _getAssetPath("future");
  static String wallets =  _getAssetPath("money-bag");
}
