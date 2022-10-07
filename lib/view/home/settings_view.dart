import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/components/custom_button.dart';
import 'package:zoom_clone/core/router/router.dart';
import 'package:zoom_clone/view/home/controller/home_cubit.dart';
import 'package:zoom_clone/view/login/login_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        return Column(
          children: [
            CustomButton(
              child: const Text('Log Out'),
              onPressed: () async {
                await cubit.signOut();
                MagicRouter.navigateAndPopAll(const LoginView());
              },
            ),
          ],
        );
      },
    );
  }
}
