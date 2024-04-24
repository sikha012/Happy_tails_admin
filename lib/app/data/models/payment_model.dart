import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  final int? paymentId;
  final int? userId;
  final int? orderId;
  final int? grandTotal;
  final String? paymentToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;
  final DateTime? orderDate;
  final int? totalAmount;
  final String? orderStatus;

  PaymentModel({
    this.paymentId,
    this.userId,
    this.orderId,
    this.grandTotal,
    this.paymentToken,
    this.createdAt,
    this.updatedAt,
    this.userName,
    this.orderDate,
    this.totalAmount,
    this.orderStatus,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        paymentId: json["payment_id"],
        userId: json["user_id"],
        orderId: json["order_id"],
        grandTotal: json["grand_total"],
        paymentToken: json["payment_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userName: json["user_name"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        totalAmount: json["total_amount"],
        orderStatus: json["order_status"],
      );

  Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "user_id": userId,
        "order_id": orderId,
        "grand_total": grandTotal,
        "payment_token": paymentToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_name": userName,
        "order_date": orderDate?.toIso8601String(),
        "total_amount": totalAmount,
        "order_status": orderStatus,
      };
}
