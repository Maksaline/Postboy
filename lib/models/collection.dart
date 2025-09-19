class Collection {
  String method;
  String name;
  String? url;
  Map<String, String>? headers;
  Map<String, String>? body;
  String? authToken;
  Map<String, Map<String, dynamic>>? automation;
  int? count;
  Map<String, String>? expected;
  bool saved;
  final int id;
  bool jsonOn;
  bool authOn;
  bool expectedOn;
  bool automationOn;
  
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
    this.jsonOn = false,
    this.authOn = false,
    this.expectedOn = false,
    this.automationOn = false,
  });
}