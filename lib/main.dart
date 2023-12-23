import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_seller_app/bloc/Categories/categories_bloc.dart';
import 'package:flutter_seller_app/bloc/Product/product_bloc.dart';
import 'package:flutter_seller_app/pages/dashboard/seller_dashboard_page.dart';

import 'bloc/login/login_bloc.dart';
import 'bloc/logout/logout_bloc.dart';
import 'bloc/register/register_bloc.dart';
import 'data/datasource/auth_local_datasource.dart';
import 'pages/auth/auth_pages.dart';
import 'pages/utils/light_themes.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const SellerDashboardPage(),
//     );
//   }
// }

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
