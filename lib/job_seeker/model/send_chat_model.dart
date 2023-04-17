class SendChatModel {
  SendChatModel({
    required this.message,
    required this.receiverId,
  });

  String message;
  String receiverId;

  factory SendChatModel.fromJson(Map<String, dynamic> json) => SendChatModel(
        message: json["message"],
        receiverId: json["receiverId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "receiverId": receiverId,
      };
}
