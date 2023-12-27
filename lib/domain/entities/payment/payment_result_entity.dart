// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentResultEntity {
  final String method;
  final int returnCode;
  final String returnMessage;
  final int subReturnCode;
  final String subReturnMessage;
  final String zpTransToken;
  final String orderUrl;
  final String orderToken;
  PaymentResultEntity({
    required this.method,
    required this.returnCode,
    required this.returnMessage,
    required this.subReturnCode,
    required this.subReturnMessage,
    required this.zpTransToken,
    required this.orderUrl,
    required this.orderToken,
  });
}
