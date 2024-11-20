import 'package:GoDentist/app/common/routes/app_pages.dart';
import 'package:GoDentist/app/presentation/screen/auth/forgot_password_screen.dart';
import 'package:GoDentist/app/presentation/screen/auth/signin_screen.dart';
import 'package:GoDentist/app/presentation/screen/auth/signup_screen.dart';
import 'package:GoDentist/app/presentation/screen/detection/detection_screen.dart';
import 'package:GoDentist/app/presentation/screen/detection/take_picture_screen.dart';
import 'package:GoDentist/app/presentation/screen/doctor/doctor_screen.dart';
import 'package:GoDentist/app/presentation/screen/home/list_clinic_screen.dart';
import 'package:GoDentist/app/presentation/screen/main/main_screen.dart';
import 'package:GoDentist/app/presentation/screen/profile/change_password_screen.dart';
import 'package:GoDentist/app/presentation/screen/profile/profile_screen.dart';
import 'package:GoDentist/app/presentation/screen/profile/update_profile.dart';
import 'package:GoDentist/app/presentation/screen/reminder/reminder_screen.dart';
import 'package:GoDentist/app/presentation/screen/setting/privacy_policy_screen.dart';
import 'package:GoDentist/app/presentation/screen/splash/splash_screen.dart';
import 'package:GoDentist/app/presentation/screen/welcome/welcome_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static const String initial = Routes.splash;
  static const String afterLogin = Routes.main;
  static const String welcome = Routes.welcome;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.welcome,
      page: () => WelcomeScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: Routes.register,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: Routes.forgot,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: Routes.main,
      page: () => MainScreen(),
    ),
    GetPage(
      name: Routes.reminder,
      page: () => ReminderScreen(),
    ),
    GetPage(
      name: Routes.doctor,
      page: () => DoctorScreen(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.updateProfile,
      page: () => UpdateProfile(),
    ),
    GetPage(
      name: Routes.detection,
      page: () => DetectionScreen(),
    ),
    GetPage(
      name: Routes.takePicture,
      page: () => TakePictureScreen(),
    ),
    GetPage(
      name: Routes.privacy,
      page: () => PrivacyPolicyScreen(),
    ),
    GetPage(
      name: Routes.listClinic,
      page: () => ListClinicScreen(),
    ),
  ];
}
