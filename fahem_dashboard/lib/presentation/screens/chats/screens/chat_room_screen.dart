import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahem_dashboard/core/network/firebase_constants.dart';
import 'package:fahem_dashboard/core/resources/colors_manager.dart';
import 'package:fahem_dashboard/core/resources/constants_manager.dart';
import 'package:fahem_dashboard/core/resources/strings_manager.dart';
import 'package:fahem_dashboard/core/resources/values_manager.dart';
import 'package:fahem_dashboard/core/utilities/extensions.dart';
import 'package:fahem_dashboard/core/utilities/methods.dart';
import 'package:fahem_dashboard/data/models/chats/chat_model.dart';
import 'package:fahem_dashboard/data/models/chats/message_model.dart';
import 'package:fahem_dashboard/presentation/screens/chats/controllers/chat_room_provider.dart';
import 'package:fahem_dashboard/presentation/screens/chats/widgets/message_item.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_button.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/custom/custom_text_form_field.dart';
import 'package:fahem_dashboard/presentation/shared/widgets/default_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomScreen extends StatefulWidget {
  final ChatModel chatModel;

  const ChatRoomScreen({super.key, required this.chatModel});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late ChatRoomProvider chatRoomProvider;
  final TextEditingController _textEditingControllerMessage = TextEditingController();
  List<String?> timeStampDates = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    chatRoomProvider = Provider.of<ChatRoomProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Methods.getDirection(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: CustomScrollView(
            slivers: [
              DefaultSliverAppBar(customTitle: widget.chatModel.name),
              SliverPadding(
                padding: const EdgeInsets.all(SizeManager.s16),
                sliver: SliverToBoxAdapter(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: chatRoomProvider.streamMessages(userId: widget.chatModel.chatId),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: ConstantsManager.scrollToMaxChatDuration),
                            );
                          }
                        });
                        return Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _scrollController,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                MessageModel messageModel = MessageModel.fromJson(snapshot.data!.docs[index].data());
                                String timeStamp = Methods.formatDate(milliseconds: int.parse(messageModel.timeStamp), isDateOnly: true);
                                timeStampDates.contains(timeStamp) ? timeStampDates.add(null) : timeStampDates.add(timeStamp);
                                return MessageItem(messageModel: messageModel, senderId: FirebaseConstants.senderId, date: timeStampDates[index]);
                              },
                              separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s15),
                              itemCount: snapshot.data!.docs.length,
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: ColorsManager.grey100,
                            //     boxShadow: [BoxShadow(color: ColorsManager.black.withOpacity(0.1), blurRadius: SizeManager.s2, spreadRadius: SizeManager.s1)],
                            //   ),
                            //   child: Column(
                            //     children: [
                            //
                            //     ],
                            //   ),
                            // ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s16),
                  child: CustomTextFormField(
                    controller: _textEditingControllerMessage,
                    hintText: Methods.getText(StringsManager.typeYourMessageHere).toCapitalized(),
                    suffixIcon: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: CustomButton(
                        onPressed: () async {
                          if(_textEditingControllerMessage.text.trim().isNotEmpty) {
                            chatRoomProvider.onPressedAddChatAndMessage(
                              context: context,
                              senderId: FirebaseConstants.senderId,
                              message: _textEditingControllerMessage.text.trim(),
                              chat: widget.chatModel,
                            );
                            _textEditingControllerMessage.clear();
                          }
                        },
                        buttonType: ButtonType.icon,
                        iconData: Icons.send,
                        buttonColor: ColorsManager.lightPrimaryColor,
                        iconColor: ColorsManager.white,
                        width: SizeManager.s60,
                        height: SizeManager.s50,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: SizeManager.s16),
                    isSupportClearSuffixIcon: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Directionality(
      textDirection: Methods.getDirection(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.lightPrimaryColor,
          title: Text(widget.chatModel.name),
          elevation: SizeManager.s0,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: chatRoomProvider.streamMessages(userId: widget.chatModel.chatId),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: ConstantsManager.scrollToMaxChatDuration),
                  );
                }
              });
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(SizeManager.s16),
                      itemBuilder: (context, index) {
                        MessageModel messageModel = MessageModel.fromJson(snapshot.data!.docs[index].data());
                        String timeStamp = Methods.formatDate(milliseconds: int.parse(messageModel.timeStamp), isDateOnly: true);
                        timeStampDates.contains(timeStamp) ? timeStampDates.add(null) : timeStampDates.add(timeStamp);
                        return MessageItem(messageModel: messageModel, senderId: FirebaseConstants.senderId, date: timeStampDates[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: SizeManager.s15),
                      itemCount: snapshot.data!.docs.length,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.grey100,
                      boxShadow: [BoxShadow(color: ColorsManager.black.withOpacity(0.1), blurRadius: SizeManager.s2, spreadRadius: SizeManager.s1)],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(SizeManager.s16),
                          child: CustomTextFormField(
                            controller: _textEditingControllerMessage,
                            borderColor: ColorsManager.grey300,
                            hintText: Methods.getText(StringsManager.typeYourMessageHere).toCapitalized(),
                            borderRadius: SizeManager.s10,
                            contentPadding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
                            // suffixIconPadding: EdgeInsets.zero,
                            // suffixIcon: Container(
                            //   decoration: const BoxDecoration(
                            //     color: ColorsManager.primaryColor,
                            //     borderRadius: BorderRadiusDirectional.only(
                            //       topEnd: Radius.circular(SizeManager.s10),
                            //       bottomEnd: Radius.circular(SizeManager.s10),
                            //     ),
                            //   ),
                            //   child: IconButton(
                            //     onPressed: () async {
                            //       if(_textEditingControllerMessage.text.trim().isNotEmpty) {
                            //         chatRoomProvider.onPressedAddChatAndMessage(
                            //           context: context,
                            //           senderId: FirebaseConstants.senderId,
                            //           message: _textEditingControllerMessage.text.trim(),
                            //           userModel: userModel,
                            //         );
                            //         _textEditingControllerMessage.clear();
                            //       }
                            //     },
                            //     icon: const Icon(Icons.send, color: ColorsManager.white),
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingControllerMessage.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}