import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone/view/home/controller/home_cubit.dart';

class HistoryMeetingView extends StatelessWidget {
  const HistoryMeetingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: HomeCubit.get(context).meetingsHistoryStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('There is some error happened'),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('The History is empty!'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Room Name: ${(snapshot.data! as dynamic).docs[index]['meetingName']}',
                  ),
                  subtitle: Text(
                    'Joined on ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}',
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
