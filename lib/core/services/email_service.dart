import 'dart:convert';
import 'package:fahem/core/utilities/my_providers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fahem/core/error/exceptions.dart';

class EmailService {
  static const String _emailServiceEndPoint = 'https://api.emailjs.com/api/v1.0/email/send';
  static const String _serviceId = 'service_33gsamy';
  static const String _templateId = 'template_wzfe50f';
  static const String _userId = 'HsT0Fx0iBCg9cxRSr';

  static Future<void> sendEmail({
    required String emailAddress,
    required String subject,
    required String message,
  }) async {
    try {
      Map<String, String> headers = {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      };
      Map<String, dynamic> body = {
        'service_id': _serviceId,
        'template_id': _templateId,
        'user_id': _userId,
        'template_params': {
          'to': emailAddress,
          'subject': subject,
          'message': message,
        },
      };

      final http.Response response = await http.post(
        Uri.parse(_emailServiceEndPoint),
        headers: headers,
        body: json.encode(body),
      );

      if(response.statusCode == 200) {}
      else {
        debugPrint('sendEmailError: ${response.statusCode} / ${response.reasonPhrase}');
        throw ServerException(messageAr: 'حدث خطأ أثناء الاتصال بالخادم', messageEn: 'an error occurred while connecting to the server');
      }
    }
    on ServerException catch(error) {
      throw ServerException(messageAr: error.messageAr, messageEn: error.messageEn);
    }
    catch(error) {
      debugPrint('sendEmailError: ${error.toString()}');
      throw ServerException(messageAr: 'حدث خطأ حاول مرة اخرى', messageEn: 'an error occurred try again');
    }
  }

  static String messageTemplate({required String verificationCode}) {

    String messageAr = '''
مرحبا

يوجد طلب لتغيير كلمة السر الخاصة بك!

اذا لم تقم بطلب تعيين كلمة السر تجاهل هذه الرسالة

استخدم هذا الكود لاعادة تعيين كلمة سر حسابك : [$verificationCode]

تطبيق فاهم
''';

    String messageEn = '''
Hi,
There was a request to change your password!

If you did not make this request then please ignore this email.

Otherwise, please use this code to change your password: [$verificationCode].

Fahem App
''';

    return MyProviders.appProvider.isEnglish ? messageEn : messageAr;
  }
}