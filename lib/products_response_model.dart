// ignore_for_file: no_leading_underscores_for_local_identifiers

class ProductsResponseModel {
  ProductsResponseModel({
    required this.msg,
    required this.data,
  });
  late final String msg;
  late final List<Data> data;
  ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.body,
    required this.message,
    required this.topic,
    required this.notificationType,
    required this.icon,
  });
  late final String id;
  late final String title;
  late final String body;
  late final String message;
  late final String topic;
  late final String notificationType;
  late final String icon;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    body = json['body'];
    message = json['message'];
    topic = json['topic'];
    notificationType = json['notificationType'];
    icon = json['icon'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['message'] = message;
    data['topic'] = topic;
    data['notificationType'] = notificationType;
    data['icon'] = icon;
    return data;
  }
}
