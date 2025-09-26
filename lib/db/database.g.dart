// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RequestsTable extends Requests with TableInfo<$RequestsTable, Request> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('New Request'),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('GET'),
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedResponseMeta = const VerificationMeta(
    'expectedResponse',
  );
  @override
  late final GeneratedColumn<String> expectedResponse = GeneratedColumn<String>(
    'expected_response',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _automationMeta = const VerificationMeta(
    'automation',
  );
  @override
  late final GeneratedColumn<String> automation = GeneratedColumn<String>(
    'automation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _authTokenMeta = const VerificationMeta(
    'authToken',
  );
  @override
  late final GeneratedColumn<String> authToken = GeneratedColumn<String>(
    'auth_token',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _headersMeta = const VerificationMeta(
    'headers',
  );
  @override
  late final GeneratedColumn<String> headers = GeneratedColumn<String>(
    'headers',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jsonOnMeta = const VerificationMeta('jsonOn');
  @override
  late final GeneratedColumn<bool> jsonOn = GeneratedColumn<bool>(
    'json_on',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("json_on" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _authOnMeta = const VerificationMeta('authOn');
  @override
  late final GeneratedColumn<bool> authOn = GeneratedColumn<bool>(
    'auth_on',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auth_on" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _expectedOnMeta = const VerificationMeta(
    'expectedOn',
  );
  @override
  late final GeneratedColumn<bool> expectedOn = GeneratedColumn<bool>(
    'expected_on',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("expected_on" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _automationOnMeta = const VerificationMeta(
    'automationOn',
  );
  @override
  late final GeneratedColumn<bool> automationOn = GeneratedColumn<bool>(
    'automation_on',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("automation_on" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    url,
    method,
    body,
    expectedResponse,
    automation,
    authToken,
    headers,
    count,
    jsonOn,
    authOn,
    expectedOn,
    automationOn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'requests';
  @override
  VerificationContext validateIntegrity(
    Insertable<Request> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('expected_response')) {
      context.handle(
        _expectedResponseMeta,
        expectedResponse.isAcceptableOrUnknown(
          data['expected_response']!,
          _expectedResponseMeta,
        ),
      );
    }
    if (data.containsKey('automation')) {
      context.handle(
        _automationMeta,
        automation.isAcceptableOrUnknown(data['automation']!, _automationMeta),
      );
    }
    if (data.containsKey('auth_token')) {
      context.handle(
        _authTokenMeta,
        authToken.isAcceptableOrUnknown(data['auth_token']!, _authTokenMeta),
      );
    }
    if (data.containsKey('headers')) {
      context.handle(
        _headersMeta,
        headers.isAcceptableOrUnknown(data['headers']!, _headersMeta),
      );
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('json_on')) {
      context.handle(
        _jsonOnMeta,
        jsonOn.isAcceptableOrUnknown(data['json_on']!, _jsonOnMeta),
      );
    }
    if (data.containsKey('auth_on')) {
      context.handle(
        _authOnMeta,
        authOn.isAcceptableOrUnknown(data['auth_on']!, _authOnMeta),
      );
    }
    if (data.containsKey('expected_on')) {
      context.handle(
        _expectedOnMeta,
        expectedOn.isAcceptableOrUnknown(data['expected_on']!, _expectedOnMeta),
      );
    }
    if (data.containsKey('automation_on')) {
      context.handle(
        _automationOnMeta,
        automationOn.isAcceptableOrUnknown(
          data['automation_on']!,
          _automationOnMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Request map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Request(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      url:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}url'],
          )!,
      method:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}method'],
          )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      ),
      expectedResponse: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expected_response'],
      ),
      automation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}automation'],
      ),
      authToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auth_token'],
      ),
      headers: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}headers'],
      ),
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      ),
      jsonOn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}json_on'],
          )!,
      authOn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}auth_on'],
          )!,
      expectedOn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}expected_on'],
          )!,
      automationOn:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}automation_on'],
          )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $RequestsTable createAlias(String alias) {
    return $RequestsTable(attachedDatabase, alias);
  }
}

class Request extends DataClass implements Insertable<Request> {
  final int id;
  final String name;
  final String url;
  final String method;
  final String? body;
  final String? expectedResponse;
  final String? automation;
  final String? authToken;
  final String? headers;
  final int? count;
  final bool jsonOn;
  final bool authOn;
  final bool expectedOn;
  final bool automationOn;
  final DateTime? createdAt;
  const Request({
    required this.id,
    required this.name,
    required this.url,
    required this.method,
    this.body,
    this.expectedResponse,
    this.automation,
    this.authToken,
    this.headers,
    this.count,
    required this.jsonOn,
    required this.authOn,
    required this.expectedOn,
    required this.automationOn,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['url'] = Variable<String>(url);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    if (!nullToAbsent || expectedResponse != null) {
      map['expected_response'] = Variable<String>(expectedResponse);
    }
    if (!nullToAbsent || automation != null) {
      map['automation'] = Variable<String>(automation);
    }
    if (!nullToAbsent || authToken != null) {
      map['auth_token'] = Variable<String>(authToken);
    }
    if (!nullToAbsent || headers != null) {
      map['headers'] = Variable<String>(headers);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    map['json_on'] = Variable<bool>(jsonOn);
    map['auth_on'] = Variable<bool>(authOn);
    map['expected_on'] = Variable<bool>(expectedOn);
    map['automation_on'] = Variable<bool>(automationOn);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  RequestsCompanion toCompanion(bool nullToAbsent) {
    return RequestsCompanion(
      id: Value(id),
      name: Value(name),
      url: Value(url),
      method: Value(method),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      expectedResponse:
          expectedResponse == null && nullToAbsent
              ? const Value.absent()
              : Value(expectedResponse),
      automation:
          automation == null && nullToAbsent
              ? const Value.absent()
              : Value(automation),
      authToken:
          authToken == null && nullToAbsent
              ? const Value.absent()
              : Value(authToken),
      headers:
          headers == null && nullToAbsent
              ? const Value.absent()
              : Value(headers),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      jsonOn: Value(jsonOn),
      authOn: Value(authOn),
      expectedOn: Value(expectedOn),
      automationOn: Value(automationOn),
      createdAt:
          createdAt == null && nullToAbsent
              ? const Value.absent()
              : Value(createdAt),
    );
  }

  factory Request.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Request(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String>(json['url']),
      method: serializer.fromJson<String>(json['method']),
      body: serializer.fromJson<String?>(json['body']),
      expectedResponse: serializer.fromJson<String?>(json['expectedResponse']),
      automation: serializer.fromJson<String?>(json['automation']),
      authToken: serializer.fromJson<String?>(json['authToken']),
      headers: serializer.fromJson<String?>(json['headers']),
      count: serializer.fromJson<int?>(json['count']),
      jsonOn: serializer.fromJson<bool>(json['jsonOn']),
      authOn: serializer.fromJson<bool>(json['authOn']),
      expectedOn: serializer.fromJson<bool>(json['expectedOn']),
      automationOn: serializer.fromJson<bool>(json['automationOn']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String>(url),
      'method': serializer.toJson<String>(method),
      'body': serializer.toJson<String?>(body),
      'expectedResponse': serializer.toJson<String?>(expectedResponse),
      'automation': serializer.toJson<String?>(automation),
      'authToken': serializer.toJson<String?>(authToken),
      'headers': serializer.toJson<String?>(headers),
      'count': serializer.toJson<int?>(count),
      'jsonOn': serializer.toJson<bool>(jsonOn),
      'authOn': serializer.toJson<bool>(authOn),
      'expectedOn': serializer.toJson<bool>(expectedOn),
      'automationOn': serializer.toJson<bool>(automationOn),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  Request copyWith({
    int? id,
    String? name,
    String? url,
    String? method,
    Value<String?> body = const Value.absent(),
    Value<String?> expectedResponse = const Value.absent(),
    Value<String?> automation = const Value.absent(),
    Value<String?> authToken = const Value.absent(),
    Value<String?> headers = const Value.absent(),
    Value<int?> count = const Value.absent(),
    bool? jsonOn,
    bool? authOn,
    bool? expectedOn,
    bool? automationOn,
    Value<DateTime?> createdAt = const Value.absent(),
  }) => Request(
    id: id ?? this.id,
    name: name ?? this.name,
    url: url ?? this.url,
    method: method ?? this.method,
    body: body.present ? body.value : this.body,
    expectedResponse:
        expectedResponse.present
            ? expectedResponse.value
            : this.expectedResponse,
    automation: automation.present ? automation.value : this.automation,
    authToken: authToken.present ? authToken.value : this.authToken,
    headers: headers.present ? headers.value : this.headers,
    count: count.present ? count.value : this.count,
    jsonOn: jsonOn ?? this.jsonOn,
    authOn: authOn ?? this.authOn,
    expectedOn: expectedOn ?? this.expectedOn,
    automationOn: automationOn ?? this.automationOn,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  Request copyWithCompanion(RequestsCompanion data) {
    return Request(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      url: data.url.present ? data.url.value : this.url,
      method: data.method.present ? data.method.value : this.method,
      body: data.body.present ? data.body.value : this.body,
      expectedResponse:
          data.expectedResponse.present
              ? data.expectedResponse.value
              : this.expectedResponse,
      automation:
          data.automation.present ? data.automation.value : this.automation,
      authToken: data.authToken.present ? data.authToken.value : this.authToken,
      headers: data.headers.present ? data.headers.value : this.headers,
      count: data.count.present ? data.count.value : this.count,
      jsonOn: data.jsonOn.present ? data.jsonOn.value : this.jsonOn,
      authOn: data.authOn.present ? data.authOn.value : this.authOn,
      expectedOn:
          data.expectedOn.present ? data.expectedOn.value : this.expectedOn,
      automationOn:
          data.automationOn.present
              ? data.automationOn.value
              : this.automationOn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Request(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('method: $method, ')
          ..write('body: $body, ')
          ..write('expectedResponse: $expectedResponse, ')
          ..write('automation: $automation, ')
          ..write('authToken: $authToken, ')
          ..write('headers: $headers, ')
          ..write('count: $count, ')
          ..write('jsonOn: $jsonOn, ')
          ..write('authOn: $authOn, ')
          ..write('expectedOn: $expectedOn, ')
          ..write('automationOn: $automationOn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    url,
    method,
    body,
    expectedResponse,
    automation,
    authToken,
    headers,
    count,
    jsonOn,
    authOn,
    expectedOn,
    automationOn,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Request &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url &&
          other.method == this.method &&
          other.body == this.body &&
          other.expectedResponse == this.expectedResponse &&
          other.automation == this.automation &&
          other.authToken == this.authToken &&
          other.headers == this.headers &&
          other.count == this.count &&
          other.jsonOn == this.jsonOn &&
          other.authOn == this.authOn &&
          other.expectedOn == this.expectedOn &&
          other.automationOn == this.automationOn &&
          other.createdAt == this.createdAt);
}

class RequestsCompanion extends UpdateCompanion<Request> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> url;
  final Value<String> method;
  final Value<String?> body;
  final Value<String?> expectedResponse;
  final Value<String?> automation;
  final Value<String?> authToken;
  final Value<String?> headers;
  final Value<int?> count;
  final Value<bool> jsonOn;
  final Value<bool> authOn;
  final Value<bool> expectedOn;
  final Value<bool> automationOn;
  final Value<DateTime?> createdAt;
  const RequestsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.method = const Value.absent(),
    this.body = const Value.absent(),
    this.expectedResponse = const Value.absent(),
    this.automation = const Value.absent(),
    this.authToken = const Value.absent(),
    this.headers = const Value.absent(),
    this.count = const Value.absent(),
    this.jsonOn = const Value.absent(),
    this.authOn = const Value.absent(),
    this.expectedOn = const Value.absent(),
    this.automationOn = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RequestsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.method = const Value.absent(),
    this.body = const Value.absent(),
    this.expectedResponse = const Value.absent(),
    this.automation = const Value.absent(),
    this.authToken = const Value.absent(),
    this.headers = const Value.absent(),
    this.count = const Value.absent(),
    this.jsonOn = const Value.absent(),
    this.authOn = const Value.absent(),
    this.expectedOn = const Value.absent(),
    this.automationOn = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Request> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? url,
    Expression<String>? method,
    Expression<String>? body,
    Expression<String>? expectedResponse,
    Expression<String>? automation,
    Expression<String>? authToken,
    Expression<String>? headers,
    Expression<int>? count,
    Expression<bool>? jsonOn,
    Expression<bool>? authOn,
    Expression<bool>? expectedOn,
    Expression<bool>? automationOn,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (method != null) 'method': method,
      if (body != null) 'body': body,
      if (expectedResponse != null) 'expected_response': expectedResponse,
      if (automation != null) 'automation': automation,
      if (authToken != null) 'auth_token': authToken,
      if (headers != null) 'headers': headers,
      if (count != null) 'count': count,
      if (jsonOn != null) 'json_on': jsonOn,
      if (authOn != null) 'auth_on': authOn,
      if (expectedOn != null) 'expected_on': expectedOn,
      if (automationOn != null) 'automation_on': automationOn,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RequestsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? url,
    Value<String>? method,
    Value<String?>? body,
    Value<String?>? expectedResponse,
    Value<String?>? automation,
    Value<String?>? authToken,
    Value<String?>? headers,
    Value<int?>? count,
    Value<bool>? jsonOn,
    Value<bool>? authOn,
    Value<bool>? expectedOn,
    Value<bool>? automationOn,
    Value<DateTime?>? createdAt,
  }) {
    return RequestsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      method: method ?? this.method,
      body: body ?? this.body,
      expectedResponse: expectedResponse ?? this.expectedResponse,
      automation: automation ?? this.automation,
      authToken: authToken ?? this.authToken,
      headers: headers ?? this.headers,
      count: count ?? this.count,
      jsonOn: jsonOn ?? this.jsonOn,
      authOn: authOn ?? this.authOn,
      expectedOn: expectedOn ?? this.expectedOn,
      automationOn: automationOn ?? this.automationOn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (expectedResponse.present) {
      map['expected_response'] = Variable<String>(expectedResponse.value);
    }
    if (automation.present) {
      map['automation'] = Variable<String>(automation.value);
    }
    if (authToken.present) {
      map['auth_token'] = Variable<String>(authToken.value);
    }
    if (headers.present) {
      map['headers'] = Variable<String>(headers.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (jsonOn.present) {
      map['json_on'] = Variable<bool>(jsonOn.value);
    }
    if (authOn.present) {
      map['auth_on'] = Variable<bool>(authOn.value);
    }
    if (expectedOn.present) {
      map['expected_on'] = Variable<bool>(expectedOn.value);
    }
    if (automationOn.present) {
      map['automation_on'] = Variable<bool>(automationOn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RequestsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('method: $method, ')
          ..write('body: $body, ')
          ..write('expectedResponse: $expectedResponse, ')
          ..write('automation: $automation, ')
          ..write('authToken: $authToken, ')
          ..write('headers: $headers, ')
          ..write('count: $count, ')
          ..write('jsonOn: $jsonOn, ')
          ..write('authOn: $authOn, ')
          ..write('expectedOn: $expectedOn, ')
          ..write('automationOn: $automationOn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RequestsTable requests = $RequestsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [requests];
}

typedef $$RequestsTableCreateCompanionBuilder =
    RequestsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> url,
      Value<String> method,
      Value<String?> body,
      Value<String?> expectedResponse,
      Value<String?> automation,
      Value<String?> authToken,
      Value<String?> headers,
      Value<int?> count,
      Value<bool> jsonOn,
      Value<bool> authOn,
      Value<bool> expectedOn,
      Value<bool> automationOn,
      Value<DateTime?> createdAt,
    });
typedef $$RequestsTableUpdateCompanionBuilder =
    RequestsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> url,
      Value<String> method,
      Value<String?> body,
      Value<String?> expectedResponse,
      Value<String?> automation,
      Value<String?> authToken,
      Value<String?> headers,
      Value<int?> count,
      Value<bool> jsonOn,
      Value<bool> authOn,
      Value<bool> expectedOn,
      Value<bool> automationOn,
      Value<DateTime?> createdAt,
    });

class $$RequestsTableFilterComposer
    extends Composer<_$AppDatabase, $RequestsTable> {
  $$RequestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expectedResponse => $composableBuilder(
    column: $table.expectedResponse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get automation => $composableBuilder(
    column: $table.automation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authToken => $composableBuilder(
    column: $table.authToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get headers => $composableBuilder(
    column: $table.headers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get jsonOn => $composableBuilder(
    column: $table.jsonOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get authOn => $composableBuilder(
    column: $table.authOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get expectedOn => $composableBuilder(
    column: $table.expectedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get automationOn => $composableBuilder(
    column: $table.automationOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $RequestsTable> {
  $$RequestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expectedResponse => $composableBuilder(
    column: $table.expectedResponse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get automation => $composableBuilder(
    column: $table.automation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authToken => $composableBuilder(
    column: $table.authToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get headers => $composableBuilder(
    column: $table.headers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get jsonOn => $composableBuilder(
    column: $table.jsonOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get authOn => $composableBuilder(
    column: $table.authOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get expectedOn => $composableBuilder(
    column: $table.expectedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get automationOn => $composableBuilder(
    column: $table.automationOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RequestsTable> {
  $$RequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get expectedResponse => $composableBuilder(
    column: $table.expectedResponse,
    builder: (column) => column,
  );

  GeneratedColumn<String> get automation => $composableBuilder(
    column: $table.automation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get authToken =>
      $composableBuilder(column: $table.authToken, builder: (column) => column);

  GeneratedColumn<String> get headers =>
      $composableBuilder(column: $table.headers, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<bool> get jsonOn =>
      $composableBuilder(column: $table.jsonOn, builder: (column) => column);

  GeneratedColumn<bool> get authOn =>
      $composableBuilder(column: $table.authOn, builder: (column) => column);

  GeneratedColumn<bool> get expectedOn => $composableBuilder(
    column: $table.expectedOn,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get automationOn => $composableBuilder(
    column: $table.automationOn,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RequestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RequestsTable,
          Request,
          $$RequestsTableFilterComposer,
          $$RequestsTableOrderingComposer,
          $$RequestsTableAnnotationComposer,
          $$RequestsTableCreateCompanionBuilder,
          $$RequestsTableUpdateCompanionBuilder,
          (Request, BaseReferences<_$AppDatabase, $RequestsTable, Request>),
          Request,
          PrefetchHooks Function()
        > {
  $$RequestsTableTableManager(_$AppDatabase db, $RequestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RequestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$RequestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String?> body = const Value.absent(),
                Value<String?> expectedResponse = const Value.absent(),
                Value<String?> automation = const Value.absent(),
                Value<String?> authToken = const Value.absent(),
                Value<String?> headers = const Value.absent(),
                Value<int?> count = const Value.absent(),
                Value<bool> jsonOn = const Value.absent(),
                Value<bool> authOn = const Value.absent(),
                Value<bool> expectedOn = const Value.absent(),
                Value<bool> automationOn = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => RequestsCompanion(
                id: id,
                name: name,
                url: url,
                method: method,
                body: body,
                expectedResponse: expectedResponse,
                automation: automation,
                authToken: authToken,
                headers: headers,
                count: count,
                jsonOn: jsonOn,
                authOn: authOn,
                expectedOn: expectedOn,
                automationOn: automationOn,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String?> body = const Value.absent(),
                Value<String?> expectedResponse = const Value.absent(),
                Value<String?> automation = const Value.absent(),
                Value<String?> authToken = const Value.absent(),
                Value<String?> headers = const Value.absent(),
                Value<int?> count = const Value.absent(),
                Value<bool> jsonOn = const Value.absent(),
                Value<bool> authOn = const Value.absent(),
                Value<bool> expectedOn = const Value.absent(),
                Value<bool> automationOn = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
              }) => RequestsCompanion.insert(
                id: id,
                name: name,
                url: url,
                method: method,
                body: body,
                expectedResponse: expectedResponse,
                automation: automation,
                authToken: authToken,
                headers: headers,
                count: count,
                jsonOn: jsonOn,
                authOn: authOn,
                expectedOn: expectedOn,
                automationOn: automationOn,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RequestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RequestsTable,
      Request,
      $$RequestsTableFilterComposer,
      $$RequestsTableOrderingComposer,
      $$RequestsTableAnnotationComposer,
      $$RequestsTableCreateCompanionBuilder,
      $$RequestsTableUpdateCompanionBuilder,
      (Request, BaseReferences<_$AppDatabase, $RequestsTable, Request>),
      Request,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RequestsTableTableManager get requests =>
      $$RequestsTableTableManager(_db, _db.requests);
}
