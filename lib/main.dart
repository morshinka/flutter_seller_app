import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_seller_app/bloc/Add_image/add_image_bloc.dart';
import 'package:flutter_seller_app/bloc/Add_product/add_product_bloc.dart';
import 'package:flutter_seller_app/bloc/Categories/categories_bloc.dart';
import 'package:flutter_seller_app/bloc/Product/product_bloc.dart';
import 'package:flutter_seller_app/data/datasource/firebase_messaging_remote_datasource.dart';
import 'package:flutter_seller_app/pages/dashboard/seller_dashboard_page.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/logout/logout_bloc.dart';
import 'bloc/register/register_bloc.dart';
import 'data/datasource/auth_local_datasource.dart';
import 'firebase_options.dart';
import 'pages/auth/auth_pages.dart';
import 'pages/utils/light_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingRemoteDatasource().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => CategoriesBloc(),
        ),
        BlocProvider(
          create: (context) => AddImageBloc(),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: light,
        home: FutureBuilder<bool>(
          future: AuthLocalDatasource().isLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData && snapshot.data!) {
              return const SellerDashboardPage();
            } else {
              return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
