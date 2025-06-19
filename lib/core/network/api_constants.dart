class ApiConstants {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  
  // Endpoints
  static const String searchMeals = '/search.php';
  static const String lookupMeal = '/lookup.php';
  static const String randomMeal = '/random.php';
  static const String listCategories = '/categories.php';
  static const String filterByCategory = '/filter.php';
  static const String listAreas = '/list.php?a=list';
  static const String filterByArea = '/filter.php';
  static const String listIngredients = '/list.php?i=list';
  static const String filterByIngredient = '/filter.php';
  
  // Parameters
  static const String paramSearch = 's';
  static const String paramMealId = 'i';
  static const String paramCategory = 'c';
  static const String paramArea = 'a';
  static const String paramIngredient = 'i';
  
  // Default headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);
}
