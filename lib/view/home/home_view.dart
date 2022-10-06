import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/constants/colors.dart';
import 'package:zoom_clone/view/home/controller/home_cubit.dart';
import 'package:zoom_clone/view/home/meeting_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = BlocProvider.of<HomeCubit>(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Meet & Chat'),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: backgroundColor,
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: footerColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) => cubit.changePage(index),
              unselectedFontSize: 14.0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.comment_bank),
                  label: 'Meet & Char',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.lock_clock),
                  label: 'Meetings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Contacts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: 'Settings',
                ),
              ],
            ),
            body: cubit.homePages[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
