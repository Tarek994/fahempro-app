import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fahem/core/error/failure.dart';
import 'package:fahem/core/network/firebase_constants.dart';
import 'package:fahem/core/resources/strings_manager.dart';
import 'package:fahem/core/services/notification_service.dart';
import 'package:fahem/core/utilities/dialogs.dart';
import 'package:fahem/core/utilities/enums.dart';
import 'package:fahem/core/utilities/extensions.dart';
import 'package:fahem/core/utilities/methods.dart';
import 'package:fahem/data/models/chats/chat_model.dart';
import 'package:fahem/data/models/chats/message_model.dart';
import 'package:fahem/domain/usecases/chats/add_chat_usecase.dart';
import 'package:fahem/domain/usecases/chats/add_message_usecase.dart';
import 'package:fahem/domain/usecases/chats/update_message_mode_usecase.dart';
import 'package:flutter/material.dart';

class ChatRoomProvider with ChangeNotifier {
  final AddChatUseCase _addChatUseCase;
  final AddMessageUseCase _addMessageUseCase;
  final UpdateMessageModeUseCase _updateMessageModeUseCase;

  ChatRoomProvider(this._addChatUseCase, this._addMessageUseCase, this._updateMessageModeUseCase);

  Future<Either<Failure, void>> addChatImpl(AddChatParameters parameters) async {
    return await _addChatUseCase.call(parameters);
  }

  Future<Either<Failure, void>> addMessageImpl(AddMessageParameters parameters) async {
    return await _addMessageUseCase.call(parameters);
  }

  Future<Either<Failure, void>> updateMessageModeImpl(UpdateMessageModeParameters parameters) async {
    return await _updateMessageModeUseCase.call(parameters);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  changeIsLoading(bool isLoading) {_isLoading = isLoading; notifyListeners();}

  Stream<QuerySnapshot<Map<String, dynamic>>> streamMessages({required String userId}) {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.chatsCollection)
        .doc(userId)
        .collection(FirebaseConstants.messagesSubCollection)
        .orderBy(FirebaseConstants.timeStampField, descending: false)
        .snapshots();
  }

  Future<void> onPressedAddChatAndMessage({
    required BuildContext context,
    required String senderId,
    required String message,
    required String chatId,
    required String chatName,
  }) async {
    ChatModel chatModel = ChatModel(
      chatId: chatId,
      name: chatName,
      lastMessage: message,
      timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    MessageModel messageModel = MessageModel(
      messageId: Methods.getRandomId(),
      chatId: chatId,
      senderId: senderId,
      text: message,
      messageMode: MessageMode.send,
      timeStamp: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    // Add Chat
    AddChatParameters addChatParameters = AddChatParameters(
      chatModel: chatModel,
    );
    Either<Failure, void> response1 = await addChatImpl(addChatParameters);
    response1.fold((failure) async  {
      Dialogs.failureOccurred(context: context, failure: failure);
    }, (_) async  {
      // Add Message
      AddMessageParameters parameters = AddMessageParameters(
        messageModel: messageModel,
      );
      Either<Failure, void> response2 = await addMessageImpl(parameters);
      response2.fold((failure) async  {
        Dialogs.failureOccurred(context: context, failure: failure);
      }, (_) async {
        NotificationService.pushNotification(
          topic: FirebaseConstants.fahemDashboardTopic,
          title: '${"رسالة من"} ${chatModel.name}',
          body: message,
        );
      });
    });
  }

  Future<void> onLongPressDeleteMessage(BuildContext context, String senderId, String  messageId) async {
    FocusScope.of(context).unfocus();
    Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantDeleteMessage).toCapitalized()).then((value) async {
      if(value) {
        // Update messageMode
        changeIsLoading(true);
        UpdateMessageModeParameters parameters = UpdateMessageModeParameters(senderId, messageId, MessageMode.delete);
        Either<Failure, void> response = await updateMessageModeImpl(parameters);
        response.fold((failure) async {
          changeIsLoading(false);
          Dialogs.failureOccurred(context: context, failure: failure);
        }, (_) async {
          changeIsLoading(false);
        });
      }
    });
  }

  Future<void> onLongPressRetrieveMessage(BuildContext context, String senderId, String  messageId) async {
    FocusScope.of(context).unfocus();
    Dialogs.showBottomSheetConfirmation(context: context, message: Methods.getText(StringsManager.doYouWantRetrieveMessage).toCapitalized()).then((value) async {
      if(value) {
        // Update messageMode
        changeIsLoading(true);
        UpdateMessageModeParameters parameters = UpdateMessageModeParameters(senderId, messageId, MessageMode.send);
        Either<Failure, void> response = await updateMessageModeImpl(parameters);
        response.fold((failure) async {
          changeIsLoading(false);
          Dialogs.failureOccurred(context: context, failure: failure);
        }, (_) async {
          changeIsLoading(false);
        });
      }
    });
  }
}