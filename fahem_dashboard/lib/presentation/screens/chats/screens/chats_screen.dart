import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahem_dashboard/core/network/firebase_constants.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/chats/chat_model.dart';
import 'package:fahem_dashboard/presentation/screens/chats/widgets/chat_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {

  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection(FirebaseConstants.chatsCollection).orderBy(FirebaseConstants.timeStampField, descending: true).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        else {
          return Directionality(
            textDirection: Methods.getDirection(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  const DefaultSliverAppBar(title: StringsManager.chats),
                  SliverPadding(
                    padding: const EdgeInsets.all(SizeManager.s16),
                    sliver: SliverList.separated(
                      itemBuilder: (context, index) => ChatItem(chatModel: ChatModel.fromJson(snapshot.data!.docs[index].data())),
                      separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s10),
                      itemCount: snapshot.data!.docs.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}