class getBigViewSupportTicket {
  String? id;
  String? userId;
  String? description;
  String? status;
  String? ticketNumber;
  Map<String, dynamic>? category;

  getBigViewSupportTicket({
    this.id,
    this.userId,
    this.description,
    this.status,
    this.ticketNumber,
    this.category,
  });

  factory getBigViewSupportTicket.fromJson(Map<String, dynamic> json) {
    return getBigViewSupportTicket(
      id: json['_id'],
      userId: json['userId'],
      description: json['description'],
      status: json['status'],
      ticketNumber: json['ticketNumber'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "userId": userId,
      "description": description,
      "status": status,
      "ticketNumber": ticketNumber,
      "category": category,
    };
  }
}
