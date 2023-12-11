import 'package:fam_story_frontend/services/user_api_service.dart';

class UserController {

  // 로그인 확인
  static Future<void> loginUser(String email, String password, bool autoLogin) async {
    try {
      // Call the login function from the API service
      int isBelongedToFamily = await UserApiService.postUserLogin(email, password, autoLogin);

      // You can further process the result here, or use it as needed
      print('Login successful. Belonged to family: $isBelongedToFamily');

      // Navigate to the home screen or perform any other actions upon successful login
    } catch (error) {
      // Handle the login error here
      print('Login failed. Error: $error');
      // You might want to show an error message to the user
    }
  }


}
