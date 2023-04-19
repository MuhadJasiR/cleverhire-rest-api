class ChatResModel {
  ChatResModel({
    this.id,
    this.user,
    this.chatId,
    required this.message,
    required this.createdAt,
  });

  String? id;
  String? user;
  String? chatId;
  String message;
  DateTime createdAt;

  factory ChatResModel.fromJson(Map<String, dynamic> json) => ChatResModel(
        id: json["_id"],
        user: json["user"],
        chatId: json["chatId"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "chatId": chatId,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
      };
}
