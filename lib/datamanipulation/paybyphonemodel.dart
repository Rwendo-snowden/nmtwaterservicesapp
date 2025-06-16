class SmsDetails {
  final String? transactionId;
  final String? recipientName;
  final String? amountPaid;
  final String? originalMessage;

  SmsDetails({
    this.transactionId,
    this.recipientName,
    this.amountPaid,
    this.originalMessage,
  });

  factory SmsDetails.fromMessage(String messageBody) {
    String? extractedTransactionId;
    String? extractedRecipientName;
    String? extractedAmountPaid;

    final RegExp format1TransactionId =
        RegExp(r"Utambulisho wa Muamala:\s*(\d+)");
    final RegExp format1Recipient = RegExp(r"jina\s*([A-Za-z\s]+)\s*namba");
    final RegExp format1Amount = RegExp(r"Umetuma TSH\s*([\d,]+\.\d+)");

    final RegExp format2TransactionId =
        RegExp(r"^([A-Z0-9]{10,})\s+Imethibitishwa", caseSensitive: false);
    final RegExp format2Amount =
        RegExp(r"Imethibitishwa\s*Tsh([\d,]+\.\d+)", caseSensitive: false);
    final RegExp format2Recipient = RegExp(r"-\s*([A-Za-z\s]+)\s*Tarehe");

    if (format1TransactionId.hasMatch(messageBody)) {
      extractedTransactionId =
          format1TransactionId.firstMatch(messageBody)?.group(1);
      extractedRecipientName =
          format1Recipient.firstMatch(messageBody)?.group(1)?.trim();
      extractedAmountPaid =
          format1Amount.firstMatch(messageBody)?.group(1)?.replaceAll(',', '');
    } else if (format2TransactionId.hasMatch(messageBody)) {
      extractedTransactionId =
          format2TransactionId.firstMatch(messageBody)?.group(1);
      extractedAmountPaid =
          format2Amount.firstMatch(messageBody)?.group(1)?.replaceAll(',', '');
      extractedRecipientName =
          format2Recipient.firstMatch(messageBody)?.group(1)?.trim();
    }

    return SmsDetails(
      transactionId: extractedTransactionId,
      recipientName: extractedRecipientName,
      amountPaid: extractedAmountPaid,
      originalMessage: messageBody,
    );
  }
}
