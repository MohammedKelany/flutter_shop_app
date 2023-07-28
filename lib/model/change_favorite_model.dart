class ChangeFavoritesModel {
  final bool? status;
  final String? message;

  ChangeFavoritesModel({
    this.status,
    this.message,
  });

  ChangeFavoritesModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        message = json['message'] as String?;
}

