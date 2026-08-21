import 'dart:io';

class DepositRequestModel {
  final num amount;
  final String receiptNumber;
  final File receiptImage;

  DepositRequestModel({
    required this.amount,
    required this.receiptNumber,
    required this.receiptImage,
  });

}
  