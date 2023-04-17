class ChatResModel {
  ChatResModel({
    required this.id,
    required this.user,
    required this.chatId,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String user;
  String chatId;
  String message;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory ChatResModel.fromJson(Map<String, dynamic> json) => ChatResModel(
        id: json["_id"],
        user: json["user"],
        chatId: json["chatId"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "chatId": chatId,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
