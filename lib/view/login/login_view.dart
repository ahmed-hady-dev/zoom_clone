import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/components/custom_button.dart';
import 'package:zoom_clone/core/router/router.dart';
import 'package:zoom_clone/view/home/home_view.dart';
import 'package:zoom_clone/view/login/controller/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<LoginCubit>(context);
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Start or Join a meeting',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.05),
                  child: Image.asset('assets/images/onboarding.jpg'),
                ),
                CustomButton(
                    child: state is GoogleSignInLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(color: Colors.white),
                            ),
                          )
                        : const Text(
                            'Google Sign In',
                            style: TextStyle(fontSize: 17),
                          ),
                    onPressed: () async {
                      await cubit.signInWithGoogle(context: context);
                      MagicRouter.navigateAndPopAll(const HomeView());
                      print('------------Done----------');
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
