import 'package:flutter/material.dart';
import 'package:walaaprovider/core/models/category_model.dart';
import 'package:walaaprovider/core/models/order_model.dart';
import 'package:walaaprovider/core/models/product_model.dart';
import 'package:walaaprovider/features/addcategorypage/addcategory_screen.dart';
import 'package:walaaprovider/features/addproduct/presentation/screens/addproduct_screen.dart';
import 'package:walaaprovider/features/auth/editprofile/presentation/screens/editprofile.dart';
import 'package:walaaprovider/features/auth/newpassword/model/new_password_model.dart';
import 'package:walaaprovider/features/auth/newpassword/new_password.dart';
import 'package:walaaprovider/features/auth/register/presentation/screens/register.dart';
import 'package:walaaprovider/features/auth/verification/presentation/cubit/verfication_cubit.dart';
import 'package:walaaprovider/features/auth/verification/presentation/screens/verfiication_screen.dart';
import 'package:walaaprovider/features/forgotpassword/forget_password.dart';
import 'package:walaaprovider/features/navigation_bottom/screens/navigation_bottom.dart';
import 'package:walaaprovider/features/payment_screen/payment_page.dart';
import 'package:walaaprovider/features/payment_with_qr_page/presentation/screens/payment_with_qr.dart';
import 'package:walaaprovider/features/privacy_terms/presentation/screen/privacy&terms.dart';
import 'package:walaaprovider/features/scan/presentation/screens/scan_page.dart';

import '../../features/auth/login/presentation/screens/login.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/loginPage';
  static const String newpassRoute = '/newpassPage';
  static const String registerRoute = '/registerPage';
  static const String forgotpassRoute = '/forgotpassPage';
  static const String editprofileRoute = '/editprofileage';
  static const String paymentRoute = '/paymentRoute';
  static const String verficationRoute = '/verficationPage';
  static const String termsprivacyRoute = '/termsprivacyPage';
  static const String addCategoryRoute = '/addCategoryRoute';
  static const String addProductRoute = '/addProductRoute';
  static const String paymentqrRoute = '/paymentqrRoute';
  static const String qrRoute = '/qrRoute';
  static const NavigationBottomRoute = '/NavigationBottom';
}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case Routes.newpassRoute:
        NewPasswordModel newPasswordModel =
            settings.arguments as NewPasswordModel;

        return MaterialPageRoute(
          builder: (context) => NewPassword(newPasswordModel: newPasswordModel),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case Routes.forgotpassRoute:
        return MaterialPageRoute(
          builder: (context) => ForgetPasswordScreen(),
        );
      case Routes.editprofileRoute:
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(),
        );
      case Routes.paymentRoute:
        String url = settings.arguments as String;

        return MaterialPageRoute(
          builder: (context) => paymetPage(url: url),
        );
      case Routes.verficationRoute:
        List<dynamic> data = settings.arguments as List<dynamic>;

        return MaterialPageRoute(
          builder: (context) =>
              VerificationScreen(phone: data[0], orderModel: data[1]),
        );
      case Routes.NavigationBottomRoute:
        return MaterialPageRoute(
          builder: (context) => NavigationBottom(),
        );
      case Routes.termsprivacyRoute:
        String title = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => PrivacyAndTermsScreen(title: title),
        );
      case Routes.addCategoryRoute:
        CategoryModel categoryModel = settings.arguments as CategoryModel;
        return MaterialPageRoute(
          builder: (context) => AddCategory(categoryModel: categoryModel),
        );
      case Routes.addProductRoute:
        ProductModel productModel = settings.arguments as ProductModel;

        return MaterialPageRoute(
          builder: (context) => AddProduct(productModel: productModel),
        );

      case Routes.paymentqrRoute:
        OrderModel orderModel = settings.arguments as OrderModel;
        return MaterialPageRoute(
          builder: (context) => PaymentWithQrPage(orderModel: orderModel),
        );
      case Routes.qrRoute:
        return MaterialPageRoute(
          builder: (context) => Scanpage(),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(''),
        ),
      ),
    );
  }
}
