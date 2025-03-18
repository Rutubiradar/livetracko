class staticData {
  static String logInTime = "00:00";
  static String comapanyName = 'medicare';
  static String baseUrl = '';

  static String get profileUrl =>
      'https://livetracko.com/$comapanyName/api/upload/documents/';

  static String get baseMenuUrl =>
      'https://livetracko.com/$comapanyName/uploads/menus/';

  static String get baseGenericUrl =>
      'https://livetracko.com/$comapanyName/upload/generic/';
  static String get baseGenericImageUrl =>
      'https://livetracko.com/$comapanyName/api/upload/generic/';

  static String get baseSubCategoryUrl =>
      'https://livetracko.com/$comapanyName/uploads/category/';

  static String get collateralsUrl =>
      'https://livetracko.com/$comapanyName/uploads/collateral/';

  static String get logoUrl => 'https://livetracko.com/$comapanyName/uploads/';
}
