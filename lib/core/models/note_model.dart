class NoteModel {
  final String id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isPinned;
  final bool isLocked;
  final DateTime? deleteAt;
  final String? pinCode;

  NoteModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.isPinned = false,
    this.isLocked = false,
    this.deleteAt,
    this.pinCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isPinned': isPinned,
      'isLocked': isLocked,
      'deleteAt': deleteAt?.toIso8601String(),
      'pinCode': pinCode,
    };
  }

  factory NoteModel.fromJson(Map<dynamic, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isPinned: json['isPinned'] as bool? ?? false,
      isLocked: json['isLocked'] as bool? ?? false,
      deleteAt: json['deleteAt'] != null 
          ? DateTime.parse(json['deleteAt'] as String) 
          : null,
      pinCode: json['pinCode'] as String?,
    );
  }

  NoteModel copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    bool? isLocked,
    DateTime? deleteAt,
    String? pinCode,
  }) {
    return NoteModel(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      isLocked: isLocked ?? this.isLocked,
      deleteAt: deleteAt ?? this.deleteAt,
      pinCode: pinCode ?? this.pinCode,
    );
  }
}

