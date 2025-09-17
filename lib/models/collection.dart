class Collection {
  String method;
  String name;
  String? url;
  Map<String, dynamic>? headers;
  Map<String, dynamic>? body;
  String? authToken;
  Map<String, Map<String, dynamic>>? automation;
  int? count;
  Map<String, String>? expected;
  bool saved;
  final int id;
  
  Collection({
    required this.method,
    required this.name,
    required this.id,
    this.url,
    this.headers,
    this.body,
    this.authToken,
    this.automation,
    this.count,
    this.expected,
    this.saved = false,
  });
}