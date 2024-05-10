import 'package:fahem/core/resources/colors_manager.dart';
import 'package:fahem/core/resources/routes_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/chats/chat_model.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  final ChatModel chatModel;

  const ChatItem({super.key, required this.chatModel});

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.chatRoomRoute, arguments: widget.chatModel),
      child: Container(
        padding: const EdgeInsets.all(SizeManager.s10),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          border: Border.all(color: ColorsManager.grey300),
          borderRadius: BorderRadius.circular(SizeManager.s10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chatModel.name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: SizeManager.s5),
            Text(
              widget.chatModel.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: SizeManager.s5),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                Methods.formatDate(milliseconds: int.parse(widget.chatModel.timeStamp)),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}