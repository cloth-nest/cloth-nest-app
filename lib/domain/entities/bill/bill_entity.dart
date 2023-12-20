// ignore_for_file: public_member_api_docs, sort_constructors_first
class BillEntity {
  final double total;
  final double shippingFee;
  final double totalBeforeVAT;
  final double totalAfterVAT;
  final double vatFee;

  BillEntity({
    required this.total,
    required this.shippingFee,
    required this.totalBeforeVAT,
    required this.totalAfterVAT,
    required this.vatFee,
  });
}
