import 'package:flutter/material.dart';
import 'package:zoom_clone/components/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          CustomButton(text: 'Google Sign In', onPressed: () {}),
        ],
      ),
    );
  }
}
