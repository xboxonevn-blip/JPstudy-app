// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemTypeMeta =
      const VerificationMeta('itemType');
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
      'item_type', aliasedName, false,
      check: () => itemType.isIn(const ['vocab', 'kanji', 'grammar']),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
      'term', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _readingMeta =
      const VerificationMeta('reading');
  @override
  late final GeneratedColumn<String> reading = GeneratedColumn<String>(
      'reading', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _meaningMeta =
      const VerificationMeta('meaning');
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
      'meaning', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exampleMeta =
      const VerificationMeta('example');
  @override
  late final GeneratedColumn<String> example = GeneratedColumn<String>(
      'example', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, itemType, term, reading, meaning, example, tags, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(Insertable<Item> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_type')) {
      context.handle(_itemTypeMeta,
          itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta));
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('term')) {
      context.handle(
          _termMeta, term.isAcceptableOrUnknown(data['term']!, _termMeta));
    } else if (isInserting) {
      context.missing(_termMeta);
    }
    if (data.containsKey('reading')) {
      context.handle(_readingMeta,
          reading.isAcceptableOrUnknown(data['reading']!, _readingMeta));
    }
    if (data.containsKey('meaning')) {
      context.handle(_meaningMeta,
          meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta));
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('example')) {
      context.handle(_exampleMeta,
          example.isAcceptableOrUnknown(data['example']!, _exampleMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      itemType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_type'])!,
      term: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}term'])!,
      reading: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reading']),
      meaning: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meaning'])!,
      example: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}example']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String itemType;
  final String term;
  final String? reading;
  final String meaning;
  final String? example;
  final String? tags;
  final String createdAt;
  const Item(
      {required this.id,
      required this.itemType,
      required this.term,
      this.reading,
      required this.meaning,
      this.example,
      this.tags,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_type'] = Variable<String>(itemType);
    map['term'] = Variable<String>(term);
    if (!nullToAbsent || reading != null) {
      map['reading'] = Variable<String>(reading);
    }
    map['meaning'] = Variable<String>(meaning);
    if (!nullToAbsent || example != null) {
      map['example'] = Variable<String>(example);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      itemType: Value(itemType),
      term: Value(term),
      reading: reading == null && nullToAbsent
          ? const Value.absent()
          : Value(reading),
      meaning: Value(meaning),
      example: example == null && nullToAbsent
          ? const Value.absent()
          : Value(example),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      createdAt: Value(createdAt),
    );
  }

  factory Item.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      itemType: serializer.fromJson<String>(json['itemType']),
      term: serializer.fromJson<String>(json['term']),
      reading: serializer.fromJson<String?>(json['reading']),
      meaning: serializer.fromJson<String>(json['meaning']),
      example: serializer.fromJson<String?>(json['example']),
      tags: serializer.fromJson<String?>(json['tags']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemType': serializer.toJson<String>(itemType),
      'term': serializer.toJson<String>(term),
      'reading': serializer.toJson<String?>(reading),
      'meaning': serializer.toJson<String>(meaning),
      'example': serializer.toJson<String?>(example),
      'tags': serializer.toJson<String?>(tags),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Item copyWith(
          {int? id,
          String? itemType,
          String? term,
          Value<String?> reading = const Value.absent(),
          String? meaning,
          Value<String?> example = const Value.absent(),
          Value<String?> tags = const Value.absent(),
          String? createdAt}) =>
      Item(
        id: id ?? this.id,
        itemType: itemType ?? this.itemType,
        term: term ?? this.term,
        reading: reading.present ? reading.value : this.reading,
        meaning: meaning ?? this.meaning,
        example: example.present ? example.value : this.example,
        tags: tags.present ? tags.value : this.tags,
        createdAt: createdAt ?? this.createdAt,
      );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      id: data.id.present ? data.id.value : this.id,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      term: data.term.present ? data.term.value : this.term,
      reading: data.reading.present ? data.reading.value : this.reading,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      example: data.example.present ? data.example.value : this.example,
      tags: data.tags.present ? data.tags.value : this.tags,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('term: $term, ')
          ..write('reading: $reading, ')
          ..write('meaning: $meaning, ')
          ..write('example: $example, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, itemType, term, reading, meaning, example, tags, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.itemType == this.itemType &&
          other.term == this.term &&
          other.reading == this.reading &&
          other.meaning == this.meaning &&
          other.example == this.example &&
          other.tags == this.tags &&
          other.createdAt == this.createdAt);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> itemType;
  final Value<String> term;
  final Value<String?> reading;
  final Value<String> meaning;
  final Value<String?> example;
  final Value<String?> tags;
  final Value<String> createdAt;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.itemType = const Value.absent(),
    this.term = const Value.absent(),
    this.reading = const Value.absent(),
    this.meaning = const Value.absent(),
    this.example = const Value.absent(),
    this.tags = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String itemType,
    required String term,
    this.reading = const Value.absent(),
    required String meaning,
    this.example = const Value.absent(),
    this.tags = const Value.absent(),
    required String createdAt,
  })  : itemType = Value(itemType),
        term = Value(term),
        meaning = Value(meaning),
        createdAt = Value(createdAt);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? itemType,
    Expression<String>? term,
    Expression<String>? reading,
    Expression<String>? meaning,
    Expression<String>? example,
    Expression<String>? tags,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemType != null) 'item_type': itemType,
      if (term != null) 'term': term,
      if (reading != null) 'reading': reading,
      if (meaning != null) 'meaning': meaning,
      if (example != null) 'example': example,
      if (tags != null) 'tags': tags,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? itemType,
      Value<String>? term,
      Value<String?>? reading,
      Value<String>? meaning,
      Value<String?>? example,
      Value<String?>? tags,
      Value<String>? createdAt}) {
    return ItemsCompanion(
      id: id ?? this.id,
      itemType: itemType ?? this.itemType,
      term: term ?? this.term,
      reading: reading ?? this.reading,
      meaning: meaning ?? this.meaning,
      example: example ?? this.example,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (example.present) {
      map['example'] = Variable<String>(example.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('term: $term, ')
          ..write('reading: $reading, ')
          ..write('meaning: $meaning, ')
          ..write('example: $example, ')
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CardsTable extends Cards with TableInfo<$CardsTable, Card> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
      'item_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (id)'));
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
      'due_date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _intervalDaysMeta =
      const VerificationMeta('intervalDays');
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
      'interval_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _easeMeta = const VerificationMeta('ease');
  @override
  late final GeneratedColumn<double> ease = GeneratedColumn<double>(
      'ease', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(2.2));
  static const VerificationMeta _lapsesMeta = const VerificationMeta('lapses');
  @override
  late final GeneratedColumn<int> lapses = GeneratedColumn<int>(
      'lapses', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastGradeMeta =
      const VerificationMeta('lastGrade');
  @override
  late final GeneratedColumn<String> lastGrade = GeneratedColumn<String>(
      'last_grade', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isLeechMeta =
      const VerificationMeta('isLeech');
  @override
  late final GeneratedColumn<int> isLeech = GeneratedColumn<int>(
      'is_leech', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        itemId,
        dueDate,
        intervalDays,
        ease,
        lapses,
        lastGrade,
        isLeech,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(Insertable<Card> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('interval_days')) {
      context.handle(
          _intervalDaysMeta,
          intervalDays.isAcceptableOrUnknown(
              data['interval_days']!, _intervalDaysMeta));
    }
    if (data.containsKey('ease')) {
      context.handle(
          _easeMeta, ease.isAcceptableOrUnknown(data['ease']!, _easeMeta));
    }
    if (data.containsKey('lapses')) {
      context.handle(_lapsesMeta,
          lapses.isAcceptableOrUnknown(data['lapses']!, _lapsesMeta));
    }
    if (data.containsKey('last_grade')) {
      context.handle(_lastGradeMeta,
          lastGrade.isAcceptableOrUnknown(data['last_grade']!, _lastGradeMeta));
    }
    if (data.containsKey('is_leech')) {
      context.handle(_isLeechMeta,
          isLeech.isAcceptableOrUnknown(data['is_leech']!, _isLeechMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Card map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Card(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_id'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}due_date'])!,
      intervalDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval_days'])!,
      ease: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ease'])!,
      lapses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lapses'])!,
      lastGrade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_grade']),
      isLeech: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_leech'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }
}

class Card extends DataClass implements Insertable<Card> {
  final int id;
  final int itemId;
  final String dueDate;
  final int intervalDays;
  final double ease;
  final int lapses;
  final String? lastGrade;
  final int isLeech;
  final String createdAt;
  final String updatedAt;
  const Card(
      {required this.id,
      required this.itemId,
      required this.dueDate,
      required this.intervalDays,
      required this.ease,
      required this.lapses,
      this.lastGrade,
      required this.isLeech,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    map['due_date'] = Variable<String>(dueDate);
    map['interval_days'] = Variable<int>(intervalDays);
    map['ease'] = Variable<double>(ease);
    map['lapses'] = Variable<int>(lapses);
    if (!nullToAbsent || lastGrade != null) {
      map['last_grade'] = Variable<String>(lastGrade);
    }
    map['is_leech'] = Variable<int>(isLeech);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      dueDate: Value(dueDate),
      intervalDays: Value(intervalDays),
      ease: Value(ease),
      lapses: Value(lapses),
      lastGrade: lastGrade == null && nullToAbsent
          ? const Value.absent()
          : Value(lastGrade),
      isLeech: Value(isLeech),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Card.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Card(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      dueDate: serializer.fromJson<String>(json['dueDate']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      ease: serializer.fromJson<double>(json['ease']),
      lapses: serializer.fromJson<int>(json['lapses']),
      lastGrade: serializer.fromJson<String?>(json['lastGrade']),
      isLeech: serializer.fromJson<int>(json['isLeech']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'dueDate': serializer.toJson<String>(dueDate),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'ease': serializer.toJson<double>(ease),
      'lapses': serializer.toJson<int>(lapses),
      'lastGrade': serializer.toJson<String?>(lastGrade),
      'isLeech': serializer.toJson<int>(isLeech),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Card copyWith(
          {int? id,
          int? itemId,
          String? dueDate,
          int? intervalDays,
          double? ease,
          int? lapses,
          Value<String?> lastGrade = const Value.absent(),
          int? isLeech,
          String? createdAt,
          String? updatedAt}) =>
      Card(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        dueDate: dueDate ?? this.dueDate,
        intervalDays: intervalDays ?? this.intervalDays,
        ease: ease ?? this.ease,
        lapses: lapses ?? this.lapses,
        lastGrade: lastGrade.present ? lastGrade.value : this.lastGrade,
        isLeech: isLeech ?? this.isLeech,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Card copyWithCompanion(CardsCompanion data) {
    return Card(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      ease: data.ease.present ? data.ease.value : this.ease,
      lapses: data.lapses.present ? data.lapses.value : this.lapses,
      lastGrade: data.lastGrade.present ? data.lastGrade.value : this.lastGrade,
      isLeech: data.isLeech.present ? data.isLeech.value : this.isLeech,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Card(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('dueDate: $dueDate, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('ease: $ease, ')
          ..write('lapses: $lapses, ')
          ..write('lastGrade: $lastGrade, ')
          ..write('isLeech: $isLeech, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemId, dueDate, intervalDays, ease,
      lapses, lastGrade, isLeech, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Card &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.dueDate == this.dueDate &&
          other.intervalDays == this.intervalDays &&
          other.ease == this.ease &&
          other.lapses == this.lapses &&
          other.lastGrade == this.lastGrade &&
          other.isLeech == this.isLeech &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardsCompanion extends UpdateCompanion<Card> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<String> dueDate;
  final Value<int> intervalDays;
  final Value<double> ease;
  final Value<int> lapses;
  final Value<String?> lastGrade;
  final Value<int> isLeech;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.ease = const Value.absent(),
    this.lapses = const Value.absent(),
    this.lastGrade = const Value.absent(),
    this.isLeech = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CardsCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    required String dueDate,
    this.intervalDays = const Value.absent(),
    this.ease = const Value.absent(),
    this.lapses = const Value.absent(),
    this.lastGrade = const Value.absent(),
    this.isLeech = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  })  : itemId = Value(itemId),
        dueDate = Value(dueDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Card> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<String>? dueDate,
    Expression<int>? intervalDays,
    Expression<double>? ease,
    Expression<int>? lapses,
    Expression<String>? lastGrade,
    Expression<int>? isLeech,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (dueDate != null) 'due_date': dueDate,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (ease != null) 'ease': ease,
      if (lapses != null) 'lapses': lapses,
      if (lastGrade != null) 'last_grade': lastGrade,
      if (isLeech != null) 'is_leech': isLeech,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CardsCompanion copyWith(
      {Value<int>? id,
      Value<int>? itemId,
      Value<String>? dueDate,
      Value<int>? intervalDays,
      Value<double>? ease,
      Value<int>? lapses,
      Value<String?>? lastGrade,
      Value<int>? isLeech,
      Value<String>? createdAt,
      Value<String>? updatedAt}) {
    return CardsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      dueDate: dueDate ?? this.dueDate,
      intervalDays: intervalDays ?? this.intervalDays,
      ease: ease ?? this.ease,
      lapses: lapses ?? this.lapses,
      lastGrade: lastGrade ?? this.lastGrade,
      isLeech: isLeech ?? this.isLeech,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (ease.present) {
      map['ease'] = Variable<double>(ease.value);
    }
    if (lapses.present) {
      map['lapses'] = Variable<int>(lapses.value);
    }
    if (lastGrade.present) {
      map['last_grade'] = Variable<String>(lastGrade.value);
    }
    if (isLeech.present) {
      map['is_leech'] = Variable<int>(isLeech.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('dueDate: $dueDate, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('ease: $ease, ')
          ..write('lapses: $lapses, ')
          ..write('lastGrade: $lastGrade, ')
          ..write('isLeech: $isLeech, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SentencesTable extends Sentences
    with TableInfo<$SentencesTable, Sentence> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SentencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
      'item_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (id)'));
  static const VerificationMeta _sentenceMeta =
      const VerificationMeta('sentence');
  @override
  late final GeneratedColumn<String> sentence = GeneratedColumn<String>(
      'sentence', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clozeMeta = const VerificationMeta('cloze');
  @override
  late final GeneratedColumn<String> cloze = GeneratedColumn<String>(
      'cloze', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
      'answer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('example'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, itemId, sentence, cloze, answer, kind, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sentences';
  @override
  VerificationContext validateIntegrity(Insertable<Sentence> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    }
    if (data.containsKey('sentence')) {
      context.handle(_sentenceMeta,
          sentence.isAcceptableOrUnknown(data['sentence']!, _sentenceMeta));
    } else if (isInserting) {
      context.missing(_sentenceMeta);
    }
    if (data.containsKey('cloze')) {
      context.handle(
          _clozeMeta, cloze.isAcceptableOrUnknown(data['cloze']!, _clozeMeta));
    }
    if (data.containsKey('answer')) {
      context.handle(_answerMeta,
          answer.isAcceptableOrUnknown(data['answer']!, _answerMeta));
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sentence map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sentence(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_id']),
      sentence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sentence'])!,
      cloze: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cloze']),
      answer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answer']),
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SentencesTable createAlias(String alias) {
    return $SentencesTable(attachedDatabase, alias);
  }
}

class Sentence extends DataClass implements Insertable<Sentence> {
  final int id;
  final int? itemId;
  final String sentence;
  final String? cloze;
  final String? answer;
  final String kind;
  final String createdAt;
  const Sentence(
      {required this.id,
      this.itemId,
      required this.sentence,
      this.cloze,
      this.answer,
      required this.kind,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<int>(itemId);
    }
    map['sentence'] = Variable<String>(sentence);
    if (!nullToAbsent || cloze != null) {
      map['cloze'] = Variable<String>(cloze);
    }
    if (!nullToAbsent || answer != null) {
      map['answer'] = Variable<String>(answer);
    }
    map['kind'] = Variable<String>(kind);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  SentencesCompanion toCompanion(bool nullToAbsent) {
    return SentencesCompanion(
      id: Value(id),
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      sentence: Value(sentence),
      cloze:
          cloze == null && nullToAbsent ? const Value.absent() : Value(cloze),
      answer:
          answer == null && nullToAbsent ? const Value.absent() : Value(answer),
      kind: Value(kind),
      createdAt: Value(createdAt),
    );
  }

  factory Sentence.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sentence(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int?>(json['itemId']),
      sentence: serializer.fromJson<String>(json['sentence']),
      cloze: serializer.fromJson<String?>(json['cloze']),
      answer: serializer.fromJson<String?>(json['answer']),
      kind: serializer.fromJson<String>(json['kind']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int?>(itemId),
      'sentence': serializer.toJson<String>(sentence),
      'cloze': serializer.toJson<String?>(cloze),
      'answer': serializer.toJson<String?>(answer),
      'kind': serializer.toJson<String>(kind),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Sentence copyWith(
          {int? id,
          Value<int?> itemId = const Value.absent(),
          String? sentence,
          Value<String?> cloze = const Value.absent(),
          Value<String?> answer = const Value.absent(),
          String? kind,
          String? createdAt}) =>
      Sentence(
        id: id ?? this.id,
        itemId: itemId.present ? itemId.value : this.itemId,
        sentence: sentence ?? this.sentence,
        cloze: cloze.present ? cloze.value : this.cloze,
        answer: answer.present ? answer.value : this.answer,
        kind: kind ?? this.kind,
        createdAt: createdAt ?? this.createdAt,
      );
  Sentence copyWithCompanion(SentencesCompanion data) {
    return Sentence(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      sentence: data.sentence.present ? data.sentence.value : this.sentence,
      cloze: data.cloze.present ? data.cloze.value : this.cloze,
      answer: data.answer.present ? data.answer.value : this.answer,
      kind: data.kind.present ? data.kind.value : this.kind,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sentence(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('sentence: $sentence, ')
          ..write('cloze: $cloze, ')
          ..write('answer: $answer, ')
          ..write('kind: $kind, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, itemId, sentence, cloze, answer, kind, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sentence &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.sentence == this.sentence &&
          other.cloze == this.cloze &&
          other.answer == this.answer &&
          other.kind == this.kind &&
          other.createdAt == this.createdAt);
}

class SentencesCompanion extends UpdateCompanion<Sentence> {
  final Value<int> id;
  final Value<int?> itemId;
  final Value<String> sentence;
  final Value<String?> cloze;
  final Value<String?> answer;
  final Value<String> kind;
  final Value<String> createdAt;
  const SentencesCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.sentence = const Value.absent(),
    this.cloze = const Value.absent(),
    this.answer = const Value.absent(),
    this.kind = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SentencesCompanion.insert({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    required String sentence,
    this.cloze = const Value.absent(),
    this.answer = const Value.absent(),
    this.kind = const Value.absent(),
    required String createdAt,
  })  : sentence = Value(sentence),
        createdAt = Value(createdAt);
  static Insertable<Sentence> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<String>? sentence,
    Expression<String>? cloze,
    Expression<String>? answer,
    Expression<String>? kind,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (sentence != null) 'sentence': sentence,
      if (cloze != null) 'cloze': cloze,
      if (answer != null) 'answer': answer,
      if (kind != null) 'kind': kind,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SentencesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? itemId,
      Value<String>? sentence,
      Value<String?>? cloze,
      Value<String?>? answer,
      Value<String>? kind,
      Value<String>? createdAt}) {
    return SentencesCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      sentence: sentence ?? this.sentence,
      cloze: cloze ?? this.cloze,
      answer: answer ?? this.answer,
      kind: kind ?? this.kind,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (sentence.present) {
      map['sentence'] = Variable<String>(sentence.value);
    }
    if (cloze.present) {
      map['cloze'] = Variable<String>(cloze.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SentencesCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('sentence: $sentence, ')
          ..write('cloze: $cloze, ')
          ..write('answer: $answer, ')
          ..write('kind: $kind, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ErrorsTable extends Errors with TableInfo<$ErrorsTable, Error> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ErrorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
      'item_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (id)'));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      check: () => source.isIn(const ['C', 'D']),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _errorTypeMeta =
      const VerificationMeta('errorType');
  @override
  late final GeneratedColumn<String> errorType = GeneratedColumn<String>(
      'error_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resolvedMeta =
      const VerificationMeta('resolved');
  @override
  late final GeneratedColumn<int> resolved = GeneratedColumn<int>(
      'resolved', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, itemId, source, errorType, note, createdAt, resolved];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'errors';
  @override
  VerificationContext validateIntegrity(Insertable<Error> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('error_type')) {
      context.handle(_errorTypeMeta,
          errorType.isAcceptableOrUnknown(data['error_type']!, _errorTypeMeta));
    } else if (isInserting) {
      context.missing(_errorTypeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('resolved')) {
      context.handle(_resolvedMeta,
          resolved.isAcceptableOrUnknown(data['resolved']!, _resolvedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Error map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Error(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_id']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      errorType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_type'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
      resolved: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}resolved'])!,
    );
  }

  @override
  $ErrorsTable createAlias(String alias) {
    return $ErrorsTable(attachedDatabase, alias);
  }
}

class Error extends DataClass implements Insertable<Error> {
  final int id;
  final int? itemId;
  final String source;
  final String errorType;
  final String? note;
  final String createdAt;
  final int resolved;
  const Error(
      {required this.id,
      this.itemId,
      required this.source,
      required this.errorType,
      this.note,
      required this.createdAt,
      required this.resolved});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<int>(itemId);
    }
    map['source'] = Variable<String>(source);
    map['error_type'] = Variable<String>(errorType);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['resolved'] = Variable<int>(resolved);
    return map;
  }

  ErrorsCompanion toCompanion(bool nullToAbsent) {
    return ErrorsCompanion(
      id: Value(id),
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      source: Value(source),
      errorType: Value(errorType),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      resolved: Value(resolved),
    );
  }

  factory Error.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Error(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int?>(json['itemId']),
      source: serializer.fromJson<String>(json['source']),
      errorType: serializer.fromJson<String>(json['errorType']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      resolved: serializer.fromJson<int>(json['resolved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int?>(itemId),
      'source': serializer.toJson<String>(source),
      'errorType': serializer.toJson<String>(errorType),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
      'resolved': serializer.toJson<int>(resolved),
    };
  }

  Error copyWith(
          {int? id,
          Value<int?> itemId = const Value.absent(),
          String? source,
          String? errorType,
          Value<String?> note = const Value.absent(),
          String? createdAt,
          int? resolved}) =>
      Error(
        id: id ?? this.id,
        itemId: itemId.present ? itemId.value : this.itemId,
        source: source ?? this.source,
        errorType: errorType ?? this.errorType,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        resolved: resolved ?? this.resolved,
      );
  Error copyWithCompanion(ErrorsCompanion data) {
    return Error(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      source: data.source.present ? data.source.value : this.source,
      errorType: data.errorType.present ? data.errorType.value : this.errorType,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      resolved: data.resolved.present ? data.resolved.value : this.resolved,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Error(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('source: $source, ')
          ..write('errorType: $errorType, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('resolved: $resolved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, itemId, source, errorType, note, createdAt, resolved);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Error &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.source == this.source &&
          other.errorType == this.errorType &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.resolved == this.resolved);
}

class ErrorsCompanion extends UpdateCompanion<Error> {
  final Value<int> id;
  final Value<int?> itemId;
  final Value<String> source;
  final Value<String> errorType;
  final Value<String?> note;
  final Value<String> createdAt;
  final Value<int> resolved;
  const ErrorsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.source = const Value.absent(),
    this.errorType = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.resolved = const Value.absent(),
  });
  ErrorsCompanion.insert({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    required String source,
    required String errorType,
    this.note = const Value.absent(),
    required String createdAt,
    this.resolved = const Value.absent(),
  })  : source = Value(source),
        errorType = Value(errorType),
        createdAt = Value(createdAt);
  static Insertable<Error> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<String>? source,
    Expression<String>? errorType,
    Expression<String>? note,
    Expression<String>? createdAt,
    Expression<int>? resolved,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (source != null) 'source': source,
      if (errorType != null) 'error_type': errorType,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (resolved != null) 'resolved': resolved,
    });
  }

  ErrorsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? itemId,
      Value<String>? source,
      Value<String>? errorType,
      Value<String?>? note,
      Value<String>? createdAt,
      Value<int>? resolved}) {
    return ErrorsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      source: source ?? this.source,
      errorType: errorType ?? this.errorType,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      resolved: resolved ?? this.resolved,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (errorType.present) {
      map['error_type'] = Variable<String>(errorType.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (resolved.present) {
      map['resolved'] = Variable<int>(resolved.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ErrorsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('source: $source, ')
          ..write('errorType: $errorType, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('resolved: $resolved')
          ..write(')'))
        .toString();
  }
}

class $TestsTable extends Tests with TableInfo<$TestsTable, Test> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tests';
  @override
  VerificationContext validateIntegrity(Insertable<Test> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Test map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Test(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TestsTable createAlias(String alias) {
    return $TestsTable(attachedDatabase, alias);
  }
}

class Test extends DataClass implements Insertable<Test> {
  final int id;
  final String title;
  final String createdAt;
  const Test({required this.id, required this.title, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  TestsCompanion toCompanion(bool nullToAbsent) {
    return TestsCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
    );
  }

  factory Test.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Test(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Test copyWith({int? id, String? title, String? createdAt}) => Test(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
      );
  Test copyWithCompanion(TestsCompanion data) {
    return Test(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Test(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Test &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt);
}

class TestsCompanion extends UpdateCompanion<Test> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> createdAt;
  const TestsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TestsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String createdAt,
  })  : title = Value(title),
        createdAt = Value(createdAt);
  static Insertable<Test> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TestsCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<String>? createdAt}) {
    return TestsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TestAttemptsTable extends TestAttempts
    with TableInfo<$TestAttemptsTable, TestAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TestAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  @override
  late final GeneratedColumn<int> testId = GeneratedColumn<int>(
      'test_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tests (id)'));
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
      'score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _detailJsonMeta =
      const VerificationMeta('detailJson');
  @override
  late final GeneratedColumn<String> detailJson = GeneratedColumn<String>(
      'detail_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, testId, score, detailJson, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'test_attempts';
  @override
  VerificationContext validateIntegrity(Insertable<TestAttempt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('test_id')) {
      context.handle(_testIdMeta,
          testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('detail_json')) {
      context.handle(
          _detailJsonMeta,
          detailJson.isAcceptableOrUnknown(
              data['detail_json']!, _detailJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TestAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TestAttempt(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      testId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}test_id']),
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}score'])!,
      detailJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}detail_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TestAttemptsTable createAlias(String alias) {
    return $TestAttemptsTable(attachedDatabase, alias);
  }
}

class TestAttempt extends DataClass implements Insertable<TestAttempt> {
  final int id;
  final int? testId;
  final double score;
  final String? detailJson;
  final String createdAt;
  const TestAttempt(
      {required this.id,
      this.testId,
      required this.score,
      this.detailJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || testId != null) {
      map['test_id'] = Variable<int>(testId);
    }
    map['score'] = Variable<double>(score);
    if (!nullToAbsent || detailJson != null) {
      map['detail_json'] = Variable<String>(detailJson);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  TestAttemptsCompanion toCompanion(bool nullToAbsent) {
    return TestAttemptsCompanion(
      id: Value(id),
      testId:
          testId == null && nullToAbsent ? const Value.absent() : Value(testId),
      score: Value(score),
      detailJson: detailJson == null && nullToAbsent
          ? const Value.absent()
          : Value(detailJson),
      createdAt: Value(createdAt),
    );
  }

  factory TestAttempt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TestAttempt(
      id: serializer.fromJson<int>(json['id']),
      testId: serializer.fromJson<int?>(json['testId']),
      score: serializer.fromJson<double>(json['score']),
      detailJson: serializer.fromJson<String?>(json['detailJson']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'testId': serializer.toJson<int?>(testId),
      'score': serializer.toJson<double>(score),
      'detailJson': serializer.toJson<String?>(detailJson),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  TestAttempt copyWith(
          {int? id,
          Value<int?> testId = const Value.absent(),
          double? score,
          Value<String?> detailJson = const Value.absent(),
          String? createdAt}) =>
      TestAttempt(
        id: id ?? this.id,
        testId: testId.present ? testId.value : this.testId,
        score: score ?? this.score,
        detailJson: detailJson.present ? detailJson.value : this.detailJson,
        createdAt: createdAt ?? this.createdAt,
      );
  TestAttempt copyWithCompanion(TestAttemptsCompanion data) {
    return TestAttempt(
      id: data.id.present ? data.id.value : this.id,
      testId: data.testId.present ? data.testId.value : this.testId,
      score: data.score.present ? data.score.value : this.score,
      detailJson:
          data.detailJson.present ? data.detailJson.value : this.detailJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TestAttempt(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('score: $score, ')
          ..write('detailJson: $detailJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, testId, score, detailJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TestAttempt &&
          other.id == this.id &&
          other.testId == this.testId &&
          other.score == this.score &&
          other.detailJson == this.detailJson &&
          other.createdAt == this.createdAt);
}

class TestAttemptsCompanion extends UpdateCompanion<TestAttempt> {
  final Value<int> id;
  final Value<int?> testId;
  final Value<double> score;
  final Value<String?> detailJson;
  final Value<String> createdAt;
  const TestAttemptsCompanion({
    this.id = const Value.absent(),
    this.testId = const Value.absent(),
    this.score = const Value.absent(),
    this.detailJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TestAttemptsCompanion.insert({
    this.id = const Value.absent(),
    this.testId = const Value.absent(),
    this.score = const Value.absent(),
    this.detailJson = const Value.absent(),
    required String createdAt,
  }) : createdAt = Value(createdAt);
  static Insertable<TestAttempt> custom({
    Expression<int>? id,
    Expression<int>? testId,
    Expression<double>? score,
    Expression<String>? detailJson,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testId != null) 'test_id': testId,
      if (score != null) 'score': score,
      if (detailJson != null) 'detail_json': detailJson,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TestAttemptsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? testId,
      Value<double>? score,
      Value<String?>? detailJson,
      Value<String>? createdAt}) {
    return TestAttemptsCompanion(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      score: score ?? this.score,
      detailJson: detailJson ?? this.detailJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<int>(testId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (detailJson.present) {
      map['detail_json'] = Variable<String>(detailJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('testId: $testId, ')
          ..write('score: $score, ')
          ..write('detailJson: $detailJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewLogsTable extends ReviewLogs
    with TableInfo<$ReviewLogsTable, ReviewLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cards (id)'));
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
      'grade', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCorrectMeta =
      const VerificationMeta('isCorrect');
  @override
  late final GeneratedColumn<int> isCorrect = GeneratedColumn<int>(
      'is_correct', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, cardId, grade, isCorrect, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_logs';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(_isCorrectMeta,
          isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta));
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grade'])!,
      isCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_correct'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ReviewLogsTable createAlias(String alias) {
    return $ReviewLogsTable(attachedDatabase, alias);
  }
}

class ReviewLog extends DataClass implements Insertable<ReviewLog> {
  final int id;
  final int cardId;
  final String grade;
  final int isCorrect;
  final String createdAt;
  const ReviewLog(
      {required this.id,
      required this.cardId,
      required this.grade,
      required this.isCorrect,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['grade'] = Variable<String>(grade);
    map['is_correct'] = Variable<int>(isCorrect);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  ReviewLogsCompanion toCompanion(bool nullToAbsent) {
    return ReviewLogsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      grade: Value(grade),
      isCorrect: Value(isCorrect),
      createdAt: Value(createdAt),
    );
  }

  factory ReviewLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewLog(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      grade: serializer.fromJson<String>(json['grade']),
      isCorrect: serializer.fromJson<int>(json['isCorrect']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'grade': serializer.toJson<String>(grade),
      'isCorrect': serializer.toJson<int>(isCorrect),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  ReviewLog copyWith(
          {int? id,
          int? cardId,
          String? grade,
          int? isCorrect,
          String? createdAt}) =>
      ReviewLog(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        grade: grade ?? this.grade,
        isCorrect: isCorrect ?? this.isCorrect,
        createdAt: createdAt ?? this.createdAt,
      );
  ReviewLog copyWithCompanion(ReviewLogsCompanion data) {
    return ReviewLog(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      grade: data.grade.present ? data.grade.value : this.grade,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewLog(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('grade: $grade, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cardId, grade, isCorrect, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewLog &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.grade == this.grade &&
          other.isCorrect == this.isCorrect &&
          other.createdAt == this.createdAt);
}

class ReviewLogsCompanion extends UpdateCompanion<ReviewLog> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<String> grade;
  final Value<int> isCorrect;
  final Value<String> createdAt;
  const ReviewLogsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.grade = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReviewLogsCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required String grade,
    required int isCorrect,
    required String createdAt,
  })  : cardId = Value(cardId),
        grade = Value(grade),
        isCorrect = Value(isCorrect),
        createdAt = Value(createdAt);
  static Insertable<ReviewLog> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<String>? grade,
    Expression<int>? isCorrect,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (grade != null) 'grade': grade,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReviewLogsCompanion copyWith(
      {Value<int>? id,
      Value<int>? cardId,
      Value<String>? grade,
      Value<int>? isCorrect,
      Value<String>? createdAt}) {
    return ReviewLogsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      grade: grade ?? this.grade,
      isCorrect: isCorrect ?? this.isCorrect,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<int>(isCorrect.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewLogsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('grade: $grade, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AttemptsTable extends Attempts with TableInfo<$AttemptsTable, Attempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
      'item_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (id)'));
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cards (id)'));
  static const VerificationMeta _sentenceIdMeta =
      const VerificationMeta('sentenceId');
  @override
  late final GeneratedColumn<int> sentenceId = GeneratedColumn<int>(
      'sentence_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sentences (id)'));
  static const VerificationMeta _testIdMeta = const VerificationMeta('testId');
  @override
  late final GeneratedColumn<int> testId = GeneratedColumn<int>(
      'test_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tests (id)'));
  static const VerificationMeta _testAttemptIdMeta =
      const VerificationMeta('testAttemptId');
  @override
  late final GeneratedColumn<int> testAttemptId = GeneratedColumn<int>(
      'test_attempt_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES test_attempts (id)'));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      check: () =>
          source.isIn(const ['srs', 'sentence', 'test', 'quiz', 'manual']),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
      'prompt', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _responseMeta =
      const VerificationMeta('response');
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
      'response', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _expectedMeta =
      const VerificationMeta('expected');
  @override
  late final GeneratedColumn<String> expected = GeneratedColumn<String>(
      'expected', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCorrectMeta =
      const VerificationMeta('isCorrect');
  @override
  late final GeneratedColumn<int> isCorrect = GeneratedColumn<int>(
      'is_correct', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
      'score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _durationMsMeta =
      const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
      'duration_ms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        itemId,
        cardId,
        sentenceId,
        testId,
        testAttemptId,
        source,
        prompt,
        response,
        expected,
        isCorrect,
        score,
        durationMs,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attempts';
  @override
  VerificationContext validateIntegrity(Insertable<Attempt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    }
    if (data.containsKey('sentence_id')) {
      context.handle(
          _sentenceIdMeta,
          sentenceId.isAcceptableOrUnknown(
              data['sentence_id']!, _sentenceIdMeta));
    }
    if (data.containsKey('test_id')) {
      context.handle(_testIdMeta,
          testId.isAcceptableOrUnknown(data['test_id']!, _testIdMeta));
    }
    if (data.containsKey('test_attempt_id')) {
      context.handle(
          _testAttemptIdMeta,
          testAttemptId.isAcceptableOrUnknown(
              data['test_attempt_id']!, _testAttemptIdMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(_promptMeta,
          prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta));
    }
    if (data.containsKey('response')) {
      context.handle(_responseMeta,
          response.isAcceptableOrUnknown(data['response']!, _responseMeta));
    }
    if (data.containsKey('expected')) {
      context.handle(_expectedMeta,
          expected.isAcceptableOrUnknown(data['expected']!, _expectedMeta));
    }
    if (data.containsKey('is_correct')) {
      context.handle(_isCorrectMeta,
          isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attempt(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_id']),
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_id']),
      sentenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sentence_id']),
      testId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}test_id']),
      testAttemptId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}test_attempt_id']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      prompt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prompt']),
      response: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}response']),
      expected: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}expected']),
      isCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_correct']),
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}score']),
      durationMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_ms']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AttemptsTable createAlias(String alias) {
    return $AttemptsTable(attachedDatabase, alias);
  }
}

class Attempt extends DataClass implements Insertable<Attempt> {
  final int id;
  final int? itemId;
  final int? cardId;
  final int? sentenceId;
  final int? testId;
  final int? testAttemptId;
  final String source;
  final String? prompt;
  final String? response;
  final String? expected;
  final int? isCorrect;
  final double? score;
  final int? durationMs;
  final String createdAt;
  const Attempt(
      {required this.id,
      this.itemId,
      this.cardId,
      this.sentenceId,
      this.testId,
      this.testAttemptId,
      required this.source,
      this.prompt,
      this.response,
      this.expected,
      this.isCorrect,
      this.score,
      this.durationMs,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || itemId != null) {
      map['item_id'] = Variable<int>(itemId);
    }
    if (!nullToAbsent || cardId != null) {
      map['card_id'] = Variable<int>(cardId);
    }
    if (!nullToAbsent || sentenceId != null) {
      map['sentence_id'] = Variable<int>(sentenceId);
    }
    if (!nullToAbsent || testId != null) {
      map['test_id'] = Variable<int>(testId);
    }
    if (!nullToAbsent || testAttemptId != null) {
      map['test_attempt_id'] = Variable<int>(testAttemptId);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || prompt != null) {
      map['prompt'] = Variable<String>(prompt);
    }
    if (!nullToAbsent || response != null) {
      map['response'] = Variable<String>(response);
    }
    if (!nullToAbsent || expected != null) {
      map['expected'] = Variable<String>(expected);
    }
    if (!nullToAbsent || isCorrect != null) {
      map['is_correct'] = Variable<int>(isCorrect);
    }
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<double>(score);
    }
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  AttemptsCompanion toCompanion(bool nullToAbsent) {
    return AttemptsCompanion(
      id: Value(id),
      itemId:
          itemId == null && nullToAbsent ? const Value.absent() : Value(itemId),
      cardId:
          cardId == null && nullToAbsent ? const Value.absent() : Value(cardId),
      sentenceId: sentenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sentenceId),
      testId:
          testId == null && nullToAbsent ? const Value.absent() : Value(testId),
      testAttemptId: testAttemptId == null && nullToAbsent
          ? const Value.absent()
          : Value(testAttemptId),
      source: Value(source),
      prompt:
          prompt == null && nullToAbsent ? const Value.absent() : Value(prompt),
      response: response == null && nullToAbsent
          ? const Value.absent()
          : Value(response),
      expected: expected == null && nullToAbsent
          ? const Value.absent()
          : Value(expected),
      isCorrect: isCorrect == null && nullToAbsent
          ? const Value.absent()
          : Value(isCorrect),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      createdAt: Value(createdAt),
    );
  }

  factory Attempt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attempt(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int?>(json['itemId']),
      cardId: serializer.fromJson<int?>(json['cardId']),
      sentenceId: serializer.fromJson<int?>(json['sentenceId']),
      testId: serializer.fromJson<int?>(json['testId']),
      testAttemptId: serializer.fromJson<int?>(json['testAttemptId']),
      source: serializer.fromJson<String>(json['source']),
      prompt: serializer.fromJson<String?>(json['prompt']),
      response: serializer.fromJson<String?>(json['response']),
      expected: serializer.fromJson<String?>(json['expected']),
      isCorrect: serializer.fromJson<int?>(json['isCorrect']),
      score: serializer.fromJson<double?>(json['score']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int?>(itemId),
      'cardId': serializer.toJson<int?>(cardId),
      'sentenceId': serializer.toJson<int?>(sentenceId),
      'testId': serializer.toJson<int?>(testId),
      'testAttemptId': serializer.toJson<int?>(testAttemptId),
      'source': serializer.toJson<String>(source),
      'prompt': serializer.toJson<String?>(prompt),
      'response': serializer.toJson<String?>(response),
      'expected': serializer.toJson<String?>(expected),
      'isCorrect': serializer.toJson<int?>(isCorrect),
      'score': serializer.toJson<double?>(score),
      'durationMs': serializer.toJson<int?>(durationMs),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Attempt copyWith(
          {int? id,
          Value<int?> itemId = const Value.absent(),
          Value<int?> cardId = const Value.absent(),
          Value<int?> sentenceId = const Value.absent(),
          Value<int?> testId = const Value.absent(),
          Value<int?> testAttemptId = const Value.absent(),
          String? source,
          Value<String?> prompt = const Value.absent(),
          Value<String?> response = const Value.absent(),
          Value<String?> expected = const Value.absent(),
          Value<int?> isCorrect = const Value.absent(),
          Value<double?> score = const Value.absent(),
          Value<int?> durationMs = const Value.absent(),
          String? createdAt}) =>
      Attempt(
        id: id ?? this.id,
        itemId: itemId.present ? itemId.value : this.itemId,
        cardId: cardId.present ? cardId.value : this.cardId,
        sentenceId: sentenceId.present ? sentenceId.value : this.sentenceId,
        testId: testId.present ? testId.value : this.testId,
        testAttemptId:
            testAttemptId.present ? testAttemptId.value : this.testAttemptId,
        source: source ?? this.source,
        prompt: prompt.present ? prompt.value : this.prompt,
        response: response.present ? response.value : this.response,
        expected: expected.present ? expected.value : this.expected,
        isCorrect: isCorrect.present ? isCorrect.value : this.isCorrect,
        score: score.present ? score.value : this.score,
        durationMs: durationMs.present ? durationMs.value : this.durationMs,
        createdAt: createdAt ?? this.createdAt,
      );
  Attempt copyWithCompanion(AttemptsCompanion data) {
    return Attempt(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      sentenceId:
          data.sentenceId.present ? data.sentenceId.value : this.sentenceId,
      testId: data.testId.present ? data.testId.value : this.testId,
      testAttemptId: data.testAttemptId.present
          ? data.testAttemptId.value
          : this.testAttemptId,
      source: data.source.present ? data.source.value : this.source,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      response: data.response.present ? data.response.value : this.response,
      expected: data.expected.present ? data.expected.value : this.expected,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      score: data.score.present ? data.score.value : this.score,
      durationMs:
          data.durationMs.present ? data.durationMs.value : this.durationMs,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attempt(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('cardId: $cardId, ')
          ..write('sentenceId: $sentenceId, ')
          ..write('testId: $testId, ')
          ..write('testAttemptId: $testAttemptId, ')
          ..write('source: $source, ')
          ..write('prompt: $prompt, ')
          ..write('response: $response, ')
          ..write('expected: $expected, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('score: $score, ')
          ..write('durationMs: $durationMs, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      itemId,
      cardId,
      sentenceId,
      testId,
      testAttemptId,
      source,
      prompt,
      response,
      expected,
      isCorrect,
      score,
      durationMs,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attempt &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.cardId == this.cardId &&
          other.sentenceId == this.sentenceId &&
          other.testId == this.testId &&
          other.testAttemptId == this.testAttemptId &&
          other.source == this.source &&
          other.prompt == this.prompt &&
          other.response == this.response &&
          other.expected == this.expected &&
          other.isCorrect == this.isCorrect &&
          other.score == this.score &&
          other.durationMs == this.durationMs &&
          other.createdAt == this.createdAt);
}

class AttemptsCompanion extends UpdateCompanion<Attempt> {
  final Value<int> id;
  final Value<int?> itemId;
  final Value<int?> cardId;
  final Value<int?> sentenceId;
  final Value<int?> testId;
  final Value<int?> testAttemptId;
  final Value<String> source;
  final Value<String?> prompt;
  final Value<String?> response;
  final Value<String?> expected;
  final Value<int?> isCorrect;
  final Value<double?> score;
  final Value<int?> durationMs;
  final Value<String> createdAt;
  const AttemptsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.sentenceId = const Value.absent(),
    this.testId = const Value.absent(),
    this.testAttemptId = const Value.absent(),
    this.source = const Value.absent(),
    this.prompt = const Value.absent(),
    this.response = const Value.absent(),
    this.expected = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.score = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AttemptsCompanion.insert({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.sentenceId = const Value.absent(),
    this.testId = const Value.absent(),
    this.testAttemptId = const Value.absent(),
    required String source,
    this.prompt = const Value.absent(),
    this.response = const Value.absent(),
    this.expected = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.score = const Value.absent(),
    this.durationMs = const Value.absent(),
    required String createdAt,
  })  : source = Value(source),
        createdAt = Value(createdAt);
  static Insertable<Attempt> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<int>? cardId,
    Expression<int>? sentenceId,
    Expression<int>? testId,
    Expression<int>? testAttemptId,
    Expression<String>? source,
    Expression<String>? prompt,
    Expression<String>? response,
    Expression<String>? expected,
    Expression<int>? isCorrect,
    Expression<double>? score,
    Expression<int>? durationMs,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (cardId != null) 'card_id': cardId,
      if (sentenceId != null) 'sentence_id': sentenceId,
      if (testId != null) 'test_id': testId,
      if (testAttemptId != null) 'test_attempt_id': testAttemptId,
      if (source != null) 'source': source,
      if (prompt != null) 'prompt': prompt,
      if (response != null) 'response': response,
      if (expected != null) 'expected': expected,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (score != null) 'score': score,
      if (durationMs != null) 'duration_ms': durationMs,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AttemptsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? itemId,
      Value<int?>? cardId,
      Value<int?>? sentenceId,
      Value<int?>? testId,
      Value<int?>? testAttemptId,
      Value<String>? source,
      Value<String?>? prompt,
      Value<String?>? response,
      Value<String?>? expected,
      Value<int?>? isCorrect,
      Value<double?>? score,
      Value<int?>? durationMs,
      Value<String>? createdAt}) {
    return AttemptsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      cardId: cardId ?? this.cardId,
      sentenceId: sentenceId ?? this.sentenceId,
      testId: testId ?? this.testId,
      testAttemptId: testAttemptId ?? this.testAttemptId,
      source: source ?? this.source,
      prompt: prompt ?? this.prompt,
      response: response ?? this.response,
      expected: expected ?? this.expected,
      isCorrect: isCorrect ?? this.isCorrect,
      score: score ?? this.score,
      durationMs: durationMs ?? this.durationMs,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (sentenceId.present) {
      map['sentence_id'] = Variable<int>(sentenceId.value);
    }
    if (testId.present) {
      map['test_id'] = Variable<int>(testId.value);
    }
    if (testAttemptId.present) {
      map['test_attempt_id'] = Variable<int>(testAttemptId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (expected.present) {
      map['expected'] = Variable<String>(expected.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<int>(isCorrect.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttemptsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('cardId: $cardId, ')
          ..write('sentenceId: $sentenceId, ')
          ..write('testId: $testId, ')
          ..write('testAttemptId: $testAttemptId, ')
          ..write('source: $source, ')
          ..write('prompt: $prompt, ')
          ..write('response: $response, ')
          ..write('expected: $expected, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('score: $score, ')
          ..write('durationMs: $durationMs, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MistakesTable extends Mistakes with TableInfo<$MistakesTable, Mistake> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MistakesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
      'item_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES items (id)'));
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cards (id)'));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      check: () =>
          source.isIn(const ['srs', 'sentence', 'test', 'quiz', 'manual']),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _mistakeCountMeta =
      const VerificationMeta('mistakeCount');
  @override
  late final GeneratedColumn<int> mistakeCount = GeneratedColumn<int>(
      'mistake_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _lastMistakeAtMeta =
      const VerificationMeta('lastMistakeAt');
  @override
  late final GeneratedColumn<String> lastMistakeAt = GeneratedColumn<String>(
      'last_mistake_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastAttemptIdMeta =
      const VerificationMeta('lastAttemptId');
  @override
  late final GeneratedColumn<int> lastAttemptId = GeneratedColumn<int>(
      'last_attempt_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES attempts (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, itemId, cardId, source, mistakeCount, lastMistakeAt, lastAttemptId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mistakes';
  @override
  VerificationContext validateIntegrity(Insertable<Mistake> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('mistake_count')) {
      context.handle(
          _mistakeCountMeta,
          mistakeCount.isAcceptableOrUnknown(
              data['mistake_count']!, _mistakeCountMeta));
    }
    if (data.containsKey('last_mistake_at')) {
      context.handle(
          _lastMistakeAtMeta,
          lastMistakeAt.isAcceptableOrUnknown(
              data['last_mistake_at']!, _lastMistakeAtMeta));
    } else if (isInserting) {
      context.missing(_lastMistakeAtMeta);
    }
    if (data.containsKey('last_attempt_id')) {
      context.handle(
          _lastAttemptIdMeta,
          lastAttemptId.isAcceptableOrUnknown(
              data['last_attempt_id']!, _lastAttemptIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {itemId, source},
      ];
  @override
  Mistake map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mistake(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}item_id'])!,
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}card_id']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      mistakeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mistake_count'])!,
      lastMistakeAt: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_mistake_at'])!,
      lastAttemptId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_attempt_id']),
    );
  }

  @override
  $MistakesTable createAlias(String alias) {
    return $MistakesTable(attachedDatabase, alias);
  }
}

class Mistake extends DataClass implements Insertable<Mistake> {
  final int id;
  final int itemId;
  final int? cardId;
  final String source;
  final int mistakeCount;
  final String lastMistakeAt;
  final int? lastAttemptId;
  const Mistake(
      {required this.id,
      required this.itemId,
      this.cardId,
      required this.source,
      required this.mistakeCount,
      required this.lastMistakeAt,
      this.lastAttemptId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    if (!nullToAbsent || cardId != null) {
      map['card_id'] = Variable<int>(cardId);
    }
    map['source'] = Variable<String>(source);
    map['mistake_count'] = Variable<int>(mistakeCount);
    map['last_mistake_at'] = Variable<String>(lastMistakeAt);
    if (!nullToAbsent || lastAttemptId != null) {
      map['last_attempt_id'] = Variable<int>(lastAttemptId);
    }
    return map;
  }

  MistakesCompanion toCompanion(bool nullToAbsent) {
    return MistakesCompanion(
      id: Value(id),
      itemId: Value(itemId),
      cardId:
          cardId == null && nullToAbsent ? const Value.absent() : Value(cardId),
      source: Value(source),
      mistakeCount: Value(mistakeCount),
      lastMistakeAt: Value(lastMistakeAt),
      lastAttemptId: lastAttemptId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptId),
    );
  }

  factory Mistake.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mistake(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      cardId: serializer.fromJson<int?>(json['cardId']),
      source: serializer.fromJson<String>(json['source']),
      mistakeCount: serializer.fromJson<int>(json['mistakeCount']),
      lastMistakeAt: serializer.fromJson<String>(json['lastMistakeAt']),
      lastAttemptId: serializer.fromJson<int?>(json['lastAttemptId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'cardId': serializer.toJson<int?>(cardId),
      'source': serializer.toJson<String>(source),
      'mistakeCount': serializer.toJson<int>(mistakeCount),
      'lastMistakeAt': serializer.toJson<String>(lastMistakeAt),
      'lastAttemptId': serializer.toJson<int?>(lastAttemptId),
    };
  }

  Mistake copyWith(
          {int? id,
          int? itemId,
          Value<int?> cardId = const Value.absent(),
          String? source,
          int? mistakeCount,
          String? lastMistakeAt,
          Value<int?> lastAttemptId = const Value.absent()}) =>
      Mistake(
        id: id ?? this.id,
        itemId: itemId ?? this.itemId,
        cardId: cardId.present ? cardId.value : this.cardId,
        source: source ?? this.source,
        mistakeCount: mistakeCount ?? this.mistakeCount,
        lastMistakeAt: lastMistakeAt ?? this.lastMistakeAt,
        lastAttemptId:
            lastAttemptId.present ? lastAttemptId.value : this.lastAttemptId,
      );
  Mistake copyWithCompanion(MistakesCompanion data) {
    return Mistake(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      source: data.source.present ? data.source.value : this.source,
      mistakeCount: data.mistakeCount.present
          ? data.mistakeCount.value
          : this.mistakeCount,
      lastMistakeAt: data.lastMistakeAt.present
          ? data.lastMistakeAt.value
          : this.lastMistakeAt,
      lastAttemptId: data.lastAttemptId.present
          ? data.lastAttemptId.value
          : this.lastAttemptId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Mistake(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('cardId: $cardId, ')
          ..write('source: $source, ')
          ..write('mistakeCount: $mistakeCount, ')
          ..write('lastMistakeAt: $lastMistakeAt, ')
          ..write('lastAttemptId: $lastAttemptId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, itemId, cardId, source, mistakeCount, lastMistakeAt, lastAttemptId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mistake &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.cardId == this.cardId &&
          other.source == this.source &&
          other.mistakeCount == this.mistakeCount &&
          other.lastMistakeAt == this.lastMistakeAt &&
          other.lastAttemptId == this.lastAttemptId);
}

class MistakesCompanion extends UpdateCompanion<Mistake> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<int?> cardId;
  final Value<String> source;
  final Value<int> mistakeCount;
  final Value<String> lastMistakeAt;
  final Value<int?> lastAttemptId;
  const MistakesCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.source = const Value.absent(),
    this.mistakeCount = const Value.absent(),
    this.lastMistakeAt = const Value.absent(),
    this.lastAttemptId = const Value.absent(),
  });
  MistakesCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    this.cardId = const Value.absent(),
    required String source,
    this.mistakeCount = const Value.absent(),
    required String lastMistakeAt,
    this.lastAttemptId = const Value.absent(),
  })  : itemId = Value(itemId),
        source = Value(source),
        lastMistakeAt = Value(lastMistakeAt);
  static Insertable<Mistake> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<int>? cardId,
    Expression<String>? source,
    Expression<int>? mistakeCount,
    Expression<String>? lastMistakeAt,
    Expression<int>? lastAttemptId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (cardId != null) 'card_id': cardId,
      if (source != null) 'source': source,
      if (mistakeCount != null) 'mistake_count': mistakeCount,
      if (lastMistakeAt != null) 'last_mistake_at': lastMistakeAt,
      if (lastAttemptId != null) 'last_attempt_id': lastAttemptId,
    });
  }

  MistakesCompanion copyWith(
      {Value<int>? id,
      Value<int>? itemId,
      Value<int?>? cardId,
      Value<String>? source,
      Value<int>? mistakeCount,
      Value<String>? lastMistakeAt,
      Value<int?>? lastAttemptId}) {
    return MistakesCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      cardId: cardId ?? this.cardId,
      source: source ?? this.source,
      mistakeCount: mistakeCount ?? this.mistakeCount,
      lastMistakeAt: lastMistakeAt ?? this.lastMistakeAt,
      lastAttemptId: lastAttemptId ?? this.lastAttemptId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (mistakeCount.present) {
      map['mistake_count'] = Variable<int>(mistakeCount.value);
    }
    if (lastMistakeAt.present) {
      map['last_mistake_at'] = Variable<String>(lastMistakeAt.value);
    }
    if (lastAttemptId.present) {
      map['last_attempt_id'] = Variable<int>(lastAttemptId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MistakesCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('cardId: $cardId, ')
          ..write('source: $source, ')
          ..write('mistakeCount: $mistakeCount, ')
          ..write('lastMistakeAt: $lastMistakeAt, ')
          ..write('lastAttemptId: $lastAttemptId')
          ..write(')'))
        .toString();
  }
}

abstract class _$JPStudyDatabase extends GeneratedDatabase {
  _$JPStudyDatabase(QueryExecutor e) : super(e);
  $JPStudyDatabaseManager get managers => $JPStudyDatabaseManager(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $CardsTable cards = $CardsTable(this);
  late final $SentencesTable sentences = $SentencesTable(this);
  late final $ErrorsTable errors = $ErrorsTable(this);
  late final $TestsTable tests = $TestsTable(this);
  late final $TestAttemptsTable testAttempts = $TestAttemptsTable(this);
  late final $ReviewLogsTable reviewLogs = $ReviewLogsTable(this);
  late final $AttemptsTable attempts = $AttemptsTable(this);
  late final $MistakesTable mistakes = $MistakesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        items,
        cards,
        sentences,
        errors,
        tests,
        testAttempts,
        reviewLogs,
        attempts,
        mistakes
      ];
}

typedef $$ItemsTableCreateCompanionBuilder = ItemsCompanion Function({
  Value<int> id,
  required String itemType,
  required String term,
  Value<String?> reading,
  required String meaning,
  Value<String?> example,
  Value<String?> tags,
  required String createdAt,
});
typedef $$ItemsTableUpdateCompanionBuilder = ItemsCompanion Function({
  Value<int> id,
  Value<String> itemType,
  Value<String> term,
  Value<String?> reading,
  Value<String> meaning,
  Value<String?> example,
  Value<String?> tags,
  Value<String> createdAt,
});

final class $$ItemsTableReferences
    extends BaseReferences<_$JPStudyDatabase, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardsTable, List<Card>> _cardsRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.cards,
          aliasName: $_aliasNameGenerator(db.items.id, db.cards.itemId));

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SentencesTable, List<Sentence>>
      _sentencesRefsTable(_$JPStudyDatabase db) =>
          MultiTypedResultKey.fromTable(db.sentences,
              aliasName:
                  $_aliasNameGenerator(db.items.id, db.sentences.itemId));

  $$SentencesTableProcessedTableManager get sentencesRefs {
    final manager = $$SentencesTableTableManager($_db, $_db.sentences)
        .filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sentencesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ErrorsTable, List<Error>> _errorsRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.errors,
          aliasName: $_aliasNameGenerator(db.items.id, db.errors.itemId));

  $$ErrorsTableProcessedTableManager get errorsRefs {
    final manager = $$ErrorsTableTableManager($_db, $_db.errors)
        .filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_errorsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AttemptsTable, List<Attempt>> _attemptsRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.attempts,
          aliasName: $_aliasNameGenerator(db.items.id, db.attempts.itemId));

  $$AttemptsTableProcessedTableManager get attemptsRefs {
    final manager = $$AttemptsTableTableManager($_db, $_db.attempts)
        .filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attemptsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MistakesTable, List<Mistake>> _mistakesRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.mistakes,
          aliasName: $_aliasNameGenerator(db.items.id, db.mistakes.itemId));

  $$MistakesTableProcessedTableManager get mistakesRefs {
    final manager = $$MistakesTableTableManager($_db, $_db.mistakes)
        .filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mistakesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ItemsTableFilterComposer
    extends Composer<_$JPStudyDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get term => $composableBuilder(
      column: $table.term, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reading => $composableBuilder(
      column: $table.reading, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meaning => $composableBuilder(
      column: $table.meaning, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get example => $composableBuilder(
      column: $table.example, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> cardsRefs(
      Expression<bool> Function($$CardsTableFilterComposer f) f) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sentencesRefs(
      Expression<bool> Function($$SentencesTableFilterComposer f) f) {
    final $$SentencesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sentences,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SentencesTableFilterComposer(
              $db: $db,
              $table: $db.sentences,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> errorsRefs(
      Expression<bool> Function($$ErrorsTableFilterComposer f) f) {
    final $$ErrorsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.errors,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ErrorsTableFilterComposer(
              $db: $db,
              $table: $db.errors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> attemptsRefs(
      Expression<bool> Function($$AttemptsTableFilterComposer f) f) {
    final $$AttemptsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableFilterComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> mistakesRefs(
      Expression<bool> Function($$MistakesTableFilterComposer f) f) {
    final $$MistakesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableFilterComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer
    extends Composer<_$JPStudyDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemType => $composableBuilder(
      column: $table.itemType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get term => $composableBuilder(
      column: $table.term, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reading => $composableBuilder(
      column: $table.reading, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meaning => $composableBuilder(
      column: $table.meaning, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get example => $composableBuilder(
      column: $table.example, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$JPStudyDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get term =>
      $composableBuilder(column: $table.term, builder: (column) => column);

  GeneratedColumn<String> get reading =>
      $composableBuilder(column: $table.reading, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get example =>
      $composableBuilder(column: $table.example, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> cardsRefs<T extends Object>(
      Expression<T> Function($$CardsTableAnnotationComposer a) f) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> sentencesRefs<T extends Object>(
      Expression<T> Function($$SentencesTableAnnotationComposer a) f) {
    final $$SentencesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sentences,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SentencesTableAnnotationComposer(
              $db: $db,
              $table: $db.sentences,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> errorsRefs<T extends Object>(
      Expression<T> Function($$ErrorsTableAnnotationComposer a) f) {
    final $$ErrorsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.errors,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ErrorsTableAnnotationComposer(
              $db: $db,
              $table: $db.errors,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> attemptsRefs<T extends Object>(
      Expression<T> Function($$AttemptsTableAnnotationComposer a) f) {
    final $$AttemptsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableAnnotationComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> mistakesRefs<T extends Object>(
      Expression<T> Function($$MistakesTableAnnotationComposer a) f) {
    final $$MistakesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.itemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableAnnotationComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ItemsTableTableManager extends RootTableManager<
    _$JPStudyDatabase,
    $ItemsTable,
    Item,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableAnnotationComposer,
    $$ItemsTableCreateCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder,
    (Item, $$ItemsTableReferences),
    Item,
    PrefetchHooks Function(
        {bool cardsRefs,
        bool sentencesRefs,
        bool errorsRefs,
        bool attemptsRefs,
        bool mistakesRefs})> {
  $$ItemsTableTableManager(_$JPStudyDatabase db, $ItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> itemType = const Value.absent(),
            Value<String> term = const Value.absent(),
            Value<String?> reading = const Value.absent(),
            Value<String> meaning = const Value.absent(),
            Value<String?> example = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              ItemsCompanion(
            id: id,
            itemType: itemType,
            term: term,
            reading: reading,
            meaning: meaning,
            example: example,
            tags: tags,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String itemType,
            required String term,
            Value<String?> reading = const Value.absent(),
            required String meaning,
            Value<String?> example = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            required String createdAt,
          }) =>
              ItemsCompanion.insert(
            id: id,
            itemType: itemType,
            term: term,
            reading: reading,
            meaning: meaning,
            example: example,
            tags: tags,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ItemsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {cardsRefs = false,
              sentencesRefs = false,
              errorsRefs = false,
              attemptsRefs = false,
              mistakesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cardsRefs) db.cards,
                if (sentencesRefs) db.sentences,
                if (errorsRefs) db.errors,
                if (attemptsRefs) db.attempts,
                if (mistakesRefs) db.mistakes
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cardsRefs)
                    await $_getPrefetchedData<Item, $ItemsTable, Card>(
                        currentTable: table,
                        referencedTable:
                            $$ItemsTableReferences._cardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableReferences(db, table, p0).cardsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.itemId == item.id),
                        typedResults: items),
                  if (sentencesRefs)
                    await $_getPrefetchedData<Item, $ItemsTable, Sentence>(
                        currentTable: table,
                        referencedTable:
                            $$ItemsTableReferences._sentencesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableReferences(db, table, p0).sentencesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.itemId == item.id),
                        typedResults: items),
                  if (errorsRefs)
                    await $_getPrefetchedData<Item, $ItemsTable, Error>(
                        currentTable: table,
                        referencedTable:
                            $$ItemsTableReferences._errorsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableReferences(db, table, p0).errorsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.itemId == item.id),
                        typedResults: items),
                  if (attemptsRefs)
                    await $_getPrefetchedData<Item, $ItemsTable, Attempt>(
                        currentTable: table,
                        referencedTable:
                            $$ItemsTableReferences._attemptsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableReferences(db, table, p0).attemptsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.itemId == item.id),
                        typedResults: items),
                  if (mistakesRefs)
                    await $_getPrefetchedData<Item, $ItemsTable, Mistake>(
                        currentTable: table,
                        referencedTable:
                            $$ItemsTableReferences._mistakesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ItemsTableReferences(db, table, p0).mistakesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.itemId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ItemsTableProcessedTableManager = ProcessedTableManager<
    _$JPStudyDatabase,
    $ItemsTable,
    Item,
    $$ItemsTableFilterComposer,
    $$ItemsTableOrderingComposer,
    $$ItemsTableAnnotationComposer,
    $$ItemsTableCreateCompanionBuilder,
    $$ItemsTableUpdateCompanionBuilder,
    (Item, $$ItemsTableReferences),
    Item,
    PrefetchHooks Function(
        {bool cardsRefs,
        bool sentencesRefs,
        bool errorsRefs,
        bool attemptsRefs,
        bool mistakesRefs})>;
typedef $$CardsTableCreateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  required int itemId,
  required String dueDate,
  Value<int> intervalDays,
  Value<double> ease,
  Value<int> lapses,
  Value<String?> lastGrade,
  Value<int> isLeech,
  required String createdAt,
  required String updatedAt,
});
typedef $$CardsTableUpdateCompanionBuilder = CardsCompanion Function({
  Value<int> id,
  Value<int> itemId,
  Value<String> dueDate,
  Value<int> intervalDays,
  Value<double> ease,
  Value<int> lapses,
  Value<String?> lastGrade,
  Value<int> isLeech,
  Value<String> createdAt,
  Value<String> updatedAt,
});

final class $$CardsTableReferences
    extends BaseReferences<_$JPStudyDatabase, $CardsTable, Card> {
  $$CardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$JPStudyDatabase db) =>
      db.items.createAlias($_aliasNameGenerator(db.cards.itemId, db.items.id));

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ReviewLogsTable, List<ReviewLog>>
      _reviewLogsRefsTable(_$JPStudyDatabase db) =>
          MultiTypedResultKey.fromTable(db.reviewLogs,
              aliasName:
                  $_aliasNameGenerator(db.cards.id, db.reviewLogs.cardId));

  $$ReviewLogsTableProcessedTableManager get reviewLogsRefs {
    final manager = $$ReviewLogsTableTableManager($_db, $_db.reviewLogs)
        .filter((f) => f.cardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AttemptsTable, List<Attempt>> _attemptsRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.attempts,
          aliasName: $_aliasNameGenerator(db.cards.id, db.attempts.cardId));

  $$AttemptsTableProcessedTableManager get attemptsRefs {
    final manager = $$AttemptsTableTableManager($_db, $_db.attempts)
        .filter((f) => f.cardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attemptsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MistakesTable, List<Mistake>> _mistakesRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.mistakes,
          aliasName: $_aliasNameGenerator(db.cards.id, db.mistakes.cardId));

  $$MistakesTableProcessedTableManager get mistakesRefs {
    final manager = $$MistakesTableTableManager($_db, $_db.mistakes)
        .filter((f) => f.cardId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mistakesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CardsTableFilterComposer
    extends Composer<_$JPStudyDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get ease => $composableBuilder(
      column: $table.ease, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lapses => $composableBuilder(
      column: $table.lapses, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastGrade => $composableBuilder(
      column: $table.lastGrade, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isLeech => $composableBuilder(
      column: $table.isLeech, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> reviewLogsRefs(
      Expression<bool> Function($$ReviewLogsTableFilterComposer f) f) {
    final $$ReviewLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reviewLogs,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReviewLogsTableFilterComposer(
              $db: $db,
              $table: $db.reviewLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> attemptsRefs(
      Expression<bool> Function($$AttemptsTableFilterComposer f) f) {
    final $$AttemptsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableFilterComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> mistakesRefs(
      Expression<bool> Function($$MistakesTableFilterComposer f) f) {
    final $$MistakesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableFilterComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardsTableOrderingComposer
    extends Composer<_$JPStudyDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get ease => $composableBuilder(
      column: $table.ease, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lapses => $composableBuilder(
      column: $table.lapses, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastGrade => $composableBuilder(
      column: $table.lastGrade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isLeech => $composableBuilder(
      column: $table.isLeech, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableOrderingComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CardsTableAnnotationComposer
    extends Composer<_$JPStudyDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(
      column: $table.intervalDays, builder: (column) => column);

  GeneratedColumn<double> get ease =>
      $composableBuilder(column: $table.ease, builder: (column) => column);

  GeneratedColumn<int> get lapses =>
      $composableBuilder(column: $table.lapses, builder: (column) => column);

  GeneratedColumn<String> get lastGrade =>
      $composableBuilder(column: $table.lastGrade, builder: (column) => column);

  GeneratedColumn<int> get isLeech =>
      $composableBuilder(column: $table.isLeech, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> reviewLogsRefs<T extends Object>(
      Expression<T> Function($$ReviewLogsTableAnnotationComposer a) f) {
    final $$ReviewLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reviewLogs,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReviewLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.reviewLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> attemptsRefs<T extends Object>(
      Expression<T> Function($$AttemptsTableAnnotationComposer a) f) {
    final $$AttemptsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableAnnotationComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> mistakesRefs<T extends Object>(
      Expression<T> Function($$MistakesTableAnnotationComposer a) f) {
    final $$MistakesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableAnnotationComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardsTableTableManager extends RootTableManager<
    _$JPStudyDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function(
        {bool itemId,
        bool reviewLogsRefs,
        bool attemptsRefs,
        bool mistakesRefs})> {
  $$CardsTableTableManager(_$JPStudyDatabase db, $CardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> itemId = const Value.absent(),
            Value<String> dueDate = const Value.absent(),
            Value<int> intervalDays = const Value.absent(),
            Value<double> ease = const Value.absent(),
            Value<int> lapses = const Value.absent(),
            Value<String?> lastGrade = const Value.absent(),
            Value<int> isLeech = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              CardsCompanion(
            id: id,
            itemId: itemId,
            dueDate: dueDate,
            intervalDays: intervalDays,
            ease: ease,
            lapses: lapses,
            lastGrade: lastGrade,
            isLeech: isLeech,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int itemId,
            required String dueDate,
            Value<int> intervalDays = const Value.absent(),
            Value<double> ease = const Value.absent(),
            Value<int> lapses = const Value.absent(),
            Value<String?> lastGrade = const Value.absent(),
            Value<int> isLeech = const Value.absent(),
            required String createdAt,
            required String updatedAt,
          }) =>
              CardsCompanion.insert(
            id: id,
            itemId: itemId,
            dueDate: dueDate,
            intervalDays: intervalDays,
            ease: ease,
            lapses: lapses,
            lastGrade: lastGrade,
            isLeech: isLeech,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CardsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {itemId = false,
              reviewLogsRefs = false,
              attemptsRefs = false,
              mistakesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reviewLogsRefs) db.reviewLogs,
                if (attemptsRefs) db.attempts,
                if (mistakesRefs) db.mistakes
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (itemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.itemId,
                    referencedTable: $$CardsTableReferences._itemIdTable(db),
                    referencedColumn:
                        $$CardsTableReferences._itemIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reviewLogsRefs)
                    await $_getPrefetchedData<Card, $CardsTable, ReviewLog>(
                        currentTable: table,
                        referencedTable:
                            $$CardsTableReferences._reviewLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CardsTableReferences(db, table, p0)
                                .reviewLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cardId == item.id),
                        typedResults: items),
                  if (attemptsRefs)
                    await $_getPrefetchedData<Card, $CardsTable, Attempt>(
                        currentTable: table,
                        referencedTable:
                            $$CardsTableReferences._attemptsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CardsTableReferences(db, table, p0).attemptsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cardId == item.id),
                        typedResults: items),
                  if (mistakesRefs)
                    await $_getPrefetchedData<Card, $CardsTable, Mistake>(
                        currentTable: table,
                        referencedTable:
                            $$CardsTableReferences._mistakesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CardsTableReferences(db, table, p0).mistakesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cardId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CardsTableProcessedTableManager = ProcessedTableManager<
    _$JPStudyDatabase,
    $CardsTable,
    Card,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (Card, $$CardsTableReferences),
    Card,
    PrefetchHooks Function(
        {bool itemId,
        bool reviewLogsRefs,
        bool attemptsRefs,
        bool mistakesRefs})>;
typedef $$SentencesTableCreateCompanionBuilder = SentencesCompanion Function({
  Value<int> id,
  Value<int?> itemId,
  required String sentence,
  Value<String?> cloze,
  Value<String?> answer,
  Value<String> kind,
  required String createdAt,
});
typedef $$SentencesTableUpdateCompanionBuilder = SentencesCompanion Function({
  Value<int> id,
  Value<int?> itemId,
  Value<String> sentence,
  Value<String?> cloze,
  Value<String?> answer,
  Value<String> kind,
  Value<String> createdAt,
});

final class $$SentencesTableReferences
    extends BaseReferences<_$JPStudyDatabase, $SentencesTable, Sentence> {
  $$SentencesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$JPStudyDatabase db) => db.items
      .createAlias($_aliasNameGenerator(db.sentences.itemId, db.items.id));

  $$ItemsTableProcessedTableManager? get itemId {
    final $_column = $_itemColumn<int>('item_id');
    if ($_column == null) return null;
    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AttemptsTable, List<Attempt>> _attemptsRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.attempts,
          aliasName:
              $_aliasNameGenerator(db.sentences.id, db.attempts.sentenceId));

  $$AttemptsTableProcessedTableManager get attemptsRefs {
    final manager = $$AttemptsTableTableManager($_db, $_db.attempts)
        .filter((f) => f.sentenceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attemptsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SentencesTableFilterComposer
    extends Composer<_$JPStudyDatabase, $SentencesTable> {
  $$SentencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sentence => $composableBuilder(
      column: $table.sentence, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cloze => $composableBuilder(
      column: $table.cloze, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answer => $composableBuilder(
      column: $table.answer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> attemptsRefs(
      Expression<bool> Function($$AttemptsTableFilterComposer f) f) {
    final $$AttemptsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.sentenceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableFilterComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SentencesTableOrderingComposer
    extends Composer<_$JPStudyDatabase, $SentencesTable> {
  $$SentencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sentence => $composableBuilder(
      column: $table.sentence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cloze => $composableBuilder(
      column: $table.cloze, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answer => $composableBuilder(
      column: $table.answer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableOrderingComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SentencesTableAnnotationComposer
    extends Composer<_$JPStudyDatabase, $SentencesTable> {
  $$SentencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sentence =>
      $composableBuilder(column: $table.sentence, builder: (column) => column);

  GeneratedColumn<String> get cloze =>
      $composableBuilder(column: $table.cloze, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> attemptsRefs<T extends Object>(
      Expression<T> Function($$AttemptsTableAnnotationComposer a) f) {
    final $$AttemptsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.sentenceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableAnnotationComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SentencesTableTableManager extends RootTableManager<
    _$JPStudyDatabase,
    $SentencesTable,
    Sentence,
    $$SentencesTableFilterComposer,
    $$SentencesTableOrderingComposer,
    $$SentencesTableAnnotationComposer,
    $$SentencesTableCreateCompanionBuilder,
    $$SentencesTableUpdateCompanionBuilder,
    (Sentence, $$SentencesTableReferences),
    Sentence,
    PrefetchHooks Function({bool itemId, bool attemptsRefs})> {
  $$SentencesTableTableManager(_$JPStudyDatabase db, $SentencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SentencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SentencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SentencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> itemId = const Value.absent(),
            Value<String> sentence = const Value.absent(),
            Value<String?> cloze = const Value.absent(),
            Value<String?> answer = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              SentencesCompanion(
            id: id,
            itemId: itemId,
            sentence: sentence,
            cloze: cloze,
            answer: answer,
            kind: kind,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> itemId = const Value.absent(),
            required String sentence,
            Value<String?> cloze = const Value.absent(),
            Value<String?> answer = const Value.absent(),
            Value<String> kind = const Value.absent(),
            required String createdAt,
          }) =>
              SentencesCompanion.insert(
            id: id,
            itemId: itemId,
            sentence: sentence,
            cloze: cloze,
            answer: answer,
            kind: kind,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SentencesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({itemId = false, attemptsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (attemptsRefs) db.attempts],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (itemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.itemId,
                    referencedTable:
                        $$SentencesTableReferences._itemIdTable(db),
                    referencedColumn:
                        $$SentencesTableReferences._itemIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (attemptsRefs)
                    await $_getPrefetchedData<Sentence, $SentencesTable,
                            Attempt>(
                        currentTable: table,
                        referencedTable:
                            $$SentencesTableReferences._attemptsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SentencesTableReferences(db, table, p0)
                                .attemptsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sentenceId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SentencesTableProcessedTableManager = ProcessedTableManager<
    _$JPStudyDatabase,
    $SentencesTable,
    Sentence,
    $$SentencesTableFilterComposer,
    $$SentencesTableOrderingComposer,
    $$SentencesTableAnnotationComposer,
    $$SentencesTableCreateCompanionBuilder,
    $$SentencesTableUpdateCompanionBuilder,
    (Sentence, $$SentencesTableReferences),
    Sentence,
    PrefetchHooks Function({bool itemId, bool attemptsRefs})>;
typedef $$ErrorsTableCreateCompanionBuilder = ErrorsCompanion Function({
  Value<int> id,
  Value<int?> itemId,
  required String source,
  required String errorType,
  Value<String?> note,
  required String createdAt,
  Value<int> resolved,
});
typedef $$ErrorsTableUpdateCompanionBuilder = ErrorsCompanion Function({
  Value<int> id,
  Value<int?> itemId,
  Value<String> source,
  Value<String> errorType,
  Value<String?> note,
  Value<String> createdAt,
  Value<int> resolved,
});

final class $$ErrorsTableReferences
    extends BaseReferences<_$JPStudyDatabase, $ErrorsTable, Error> {
  $$ErrorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$JPStudyDatabase db) =>
      db.items.createAlias($_aliasNameGenerator(db.errors.itemId, db.items.id));

  $$ItemsTableProcessedTableManager? get itemId {
    final $_column = $_itemColumn<int>('item_id');
    if ($_column == null) return null;
    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ErrorsTableFilterComposer
    extends Composer<_$JPStudyDatabase, $ErrorsTable> {
  $$ErrorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorType => $composableBuilder(
      column: $table.errorType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get resolved => $composableBuilder(
      column: $table.resolved, builder: (column) => ColumnFilters(column));

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ErrorsTableOrderingComposer
    extends Composer<_$JPStudyDatabase, $ErrorsTable> {
  $$ErrorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorType => $composableBuilder(
      column: $table.errorType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get resolved => $composableBuilder(
      column: $table.resolved, builder: (column) => ColumnOrderings(column));

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableOrderingComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ErrorsTableAnnotationComposer
    extends Composer<_$JPStudyDatabase, $ErrorsTable> {
  $$ErrorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get errorType =>
      $composableBuilder(column: $table.errorType, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get resolved =>
      $composableBuilder(column: $table.resolved, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ErrorsTableTableManager extends RootTableManager<
    _$JPStudyDatabase,
    $ErrorsTable,
    Error,
    $$ErrorsTableFilterComposer,
    $$ErrorsTableOrderingComposer,
    $$ErrorsTableAnnotationComposer,
    $$ErrorsTableCreateCompanionBuilder,
    $$ErrorsTableUpdateCompanionBuilder,
    (Error, $$ErrorsTableReferences),
    Error,
    PrefetchHooks Function({bool itemId})> {
  $$ErrorsTableTableManager(_$JPStudyDatabase db, $ErrorsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ErrorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ErrorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ErrorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> itemId = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> errorType = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
            Value<int> resolved = const Value.absent(),
          }) =>
              ErrorsCompanion(
            id: id,
            itemId: itemId,
            source: source,
            errorType: errorType,
            note: note,
            createdAt: createdAt,
            resolved: resolved,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> itemId = const Value.absent(),
            required String source,
            required String errorType,
            Value<String?> note = const Value.absent(),
            required String createdAt,
            Value<int> resolved = const Value.absent(),
          }) =>
              ErrorsCompanion.insert(
            id: id,
            itemId: itemId,
            source: source,
            errorType: errorType,
            note: note,
            createdAt: createdAt,
            resolved: resolved,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ErrorsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({itemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (itemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.itemId,
                    referencedTable: $$ErrorsTableReferences._itemIdTable(db),
                    referencedColumn:
                        $$ErrorsTableReferences._itemIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ErrorsTableProcessedTableManager = ProcessedTableManager<
    _$JPStudyDatabase,
    $ErrorsTable,
    Error,
    $$ErrorsTableFilterComposer,
    $$ErrorsTableOrderingComposer,
    $$ErrorsTableAnnotationComposer,
    $$ErrorsTableCreateCompanionBuilder,
    $$ErrorsTableUpdateCompanionBuilder,
    (Error, $$ErrorsTableReferences),
    Error,
    PrefetchHooks Function({bool itemId})>;
typedef $$TestsTableCreateCompanionBuilder = TestsCompanion Function({
  Value<int> id,
  required String title,
  required String createdAt,
});
typedef $$TestsTableUpdateCompanionBuilder = TestsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> createdAt,
});

final class $$TestsTableReferences
    extends BaseReferences<_$JPStudyDatabase, $TestsTable, Test> {
  $$TestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TestAttemptsTable, List<TestAttempt>>
      _testAttemptsRefsTable(_$JPStudyDatabase db) =>
          MultiTypedResultKey.fromTable(db.testAttempts,
              aliasName:
                  $_aliasNameGenerator(db.tests.id, db.testAttempts.testId));

  $$TestAttemptsTableProcessedTableManager get testAttemptsRefs {
    final manager = $$TestAttemptsTableTableManager($_db, $_db.testAttempts)
        .filter((f) => f.testId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_testAttemptsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AttemptsTable, List<Attempt>> _attemptsRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.attempts,
          aliasName: $_aliasNameGenerator(db.tests.id, db.attempts.testId));

  $$AttemptsTableProcessedTableManager get attemptsRefs {
    final manager = $$AttemptsTableTableManager($_db, $_db.attempts)
        .filter((f) => f.testId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attemptsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TestsTableFilterComposer
    extends Composer<_$JPStudyDatabase, $TestsTable> {
  $$TestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> testAttemptsRefs(
      Expression<bool> Function($$TestAttemptsTableFilterComposer f) f) {
    final $$TestAttemptsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.testAttempts,
        getReferencedColumn: (t) => t.testId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestAttemptsTableFilterComposer(
              $db: $db,
              $table: $db.testAttempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> attemptsRefs(
      Expression<bool> Function($$AttemptsTableFilterComposer f) f) {
    final $$AttemptsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.testId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableFilterComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TestsTableOrderingComposer
    extends Composer<_$JPStudyDatabase, $TestsTable> {
  $$TestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TestsTableAnnotationComposer
    extends Composer<_$JPStudyDatabase, $TestsTable> {
  $$TestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> testAttemptsRefs<T extends Object>(
      Expression<T> Function($$TestAttemptsTableAnnotationComposer a) f) {
    final $$TestAttemptsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.testAttempts,
        getReferencedColumn: (t) => t.testId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestAttemptsTableAnnotationComposer(
              $db: $db,
              $table: $db.testAttempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> attemptsRefs<T extends Object>(
      Expression<T> Function($$AttemptsTableAnnotationComposer a) f) {
    final $$AttemptsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.testId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableAnnotationComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TestsTableTableManager extends RootTableManager<
    _$JPStudyDatabase,
    $TestsTable,
    Test,
    $$TestsTableFilterComposer,
    $$TestsTableOrderingComposer,
    $$TestsTableAnnotationComposer,
    $$TestsTableCreateCompanionBuilder,
    $$TestsTableUpdateCompanionBuilder,
    (Test, $$TestsTableReferences),
    Test,
    PrefetchHooks Function({bool testAttemptsRefs, bool attemptsRefs})> {
  $$TestsTableTableManager(_$JPStudyDatabase db, $TestsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              TestsCompanion(
            id: id,
            title: title,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String createdAt,
          }) =>
              TestsCompanion.insert(
            id: id,
            title: title,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TestsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {testAttemptsRefs = false, attemptsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (testAttemptsRefs) db.testAttempts,
                if (attemptsRefs) db.attempts
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (testAttemptsRefs)
                    await $_getPrefetchedData<Test, $TestsTable, TestAttempt>(
                        currentTable: table,
                        referencedTable:
                            $$TestsTableReferences._testAttemptsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TestsTableReferences(db, table, p0)
                                .testAttemptsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.testId == item.id),
                        typedResults: items),
                  if (attemptsRefs)
                    await $_getPrefetchedData<Test, $TestsTable, Attempt>(
                        currentTable: table,
                        referencedTable:
                            $$TestsTableReferences._attemptsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TestsTableReferences(db, table, p0).attemptsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.testId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TestsTableProcessedTableManager = ProcessedTableManager<
    _$JPStudyDatabase,
    $TestsTable,
    Test,
    $$TestsTableFilterComposer,
    $$TestsTableOrderingComposer,
    $$TestsTableAnnotationComposer,
    $$TestsTableCreateCompanionBuilder,
    $$TestsTableUpdateCompanionBuilder,
    (Test, $$TestsTableReferences),
    Test,
    PrefetchHooks Function({bool testAttemptsRefs, bool attemptsRefs})>;
typedef $$TestAttemptsTableCreateCompanionBuilder = TestAttemptsCompanion
    Function({
  Value<int> id,
  Value<int?> testId,
  Value<double> score,
  Value<String?> detailJson,
  required String createdAt,
});
typedef $$TestAttemptsTableUpdateCompanionBuilder = TestAttemptsCompanion
    Function({
  Value<int> id,
  Value<int?> testId,
  Value<double> score,
  Value<String?> detailJson,
  Value<String> createdAt,
});

final class $$TestAttemptsTableReferences
    extends BaseReferences<_$JPStudyDatabase, $TestAttemptsTable, TestAttempt> {
  $$TestAttemptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TestsTable _testIdTable(_$JPStudyDatabase db) => db.tests
      .createAlias($_aliasNameGenerator(db.testAttempts.testId, db.tests.id));

  $$TestsTableProcessedTableManager? get testId {
    final $_column = $_itemColumn<int>('test_id');
    if ($_column == null) return null;
    final manager = $$TestsTableTableManager($_db, $_db.tests)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_testIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$AttemptsTable, List<Attempt>> _attemptsRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.attempts,
          aliasName: $_aliasNameGenerator(
              db.testAttempts.id, db.attempts.testAttemptId));

  $$AttemptsTableProcessedTableManager get attemptsRefs {
    final manager = $$AttemptsTableTableManager($_db, $_db.attempts)
        .filter((f) => f.testAttemptId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_attemptsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TestAttemptsTableFilterComposer
    extends Composer<_$JPStudyDatabase, $TestAttemptsTable> {
  $$TestAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get detailJson => $composableBuilder(
      column: $table.detailJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$TestsTableFilterComposer get testId {
    final $$TestsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestsTableFilterComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> attemptsRefs(
      Expression<bool> Function($$AttemptsTableFilterComposer f) f) {
    final $$AttemptsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.testAttemptId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableFilterComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TestAttemptsTableOrderingComposer
    extends Composer<_$JPStudyDatabase, $TestAttemptsTable> {
  $$TestAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get detailJson => $composableBuilder(
      column: $table.detailJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$TestsTableOrderingComposer get testId {
    final $$TestsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestsTableOrderingComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TestAttemptsTableAnnotationComposer
    extends Composer<_$JPStudyDatabase, $TestAttemptsTable> {
  $$TestAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get detailJson => $composableBuilder(
      column: $table.detailJson, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TestsTableAnnotationComposer get testId {
    final $$TestsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestsTableAnnotationComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> attemptsRefs<T extends Object>(
      Expression<T> Function($$AttemptsTableAnnotationComposer a) f) {
    final $$AttemptsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.testAttemptId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableAnnotationComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TestAttemptsTableTableManager extends RootTableManager<
    _$JPStudyDatabase,
    $TestAttemptsTable,
    TestAttempt,
    $$TestAttemptsTableFilterComposer,
    $$TestAttemptsTableOrderingComposer,
    $$TestAttemptsTableAnnotationComposer,
    $$TestAttemptsTableCreateCompanionBuilder,
    $$TestAttemptsTableUpdateCompanionBuilder,
    (TestAttempt, $$TestAttemptsTableReferences),
    TestAttempt,
    PrefetchHooks Function({bool testId, bool attemptsRefs})> {
  $$TestAttemptsTableTableManager(
      _$JPStudyDatabase db, $TestAttemptsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TestAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TestAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TestAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> testId = const Value.absent(),
            Value<double> score = const Value.absent(),
            Value<String?> detailJson = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              TestAttemptsCompanion(
            id: id,
            testId: testId,
            score: score,
            detailJson: detailJson,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> testId = const Value.absent(),
            Value<double> score = const Value.absent(),
            Value<String?> detailJson = const Value.absent(),
            required String createdAt,
          }) =>
              TestAttemptsCompanion.insert(
            id: id,
            testId: testId,
            score: score,
            detailJson: detailJson,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TestAttemptsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({testId = false, attemptsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (attemptsRefs) db.attempts],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (testId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.testId,
                    referencedTable:
                        $$TestAttemptsTableReferences._testIdTable(db),
                    referencedColumn:
                        $$TestAttemptsTableReferences._testIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (attemptsRefs)
                    await $_getPrefetchedData<TestAttempt, $TestAttemptsTable,
                            Attempt>(
                        currentTable: table,
                        referencedTable: $$TestAttemptsTableReferences
                            ._attemptsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TestAttemptsTableReferences(db, table, p0)
                                .attemptsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.testAttemptId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TestAttemptsTableProcessedTableManager = ProcessedTableManager<
    _$JPStudyDatabase,
    $TestAttemptsTable,
    TestAttempt,
    $$TestAttemptsTableFilterComposer,
    $$TestAttemptsTableOrderingComposer,
    $$TestAttemptsTableAnnotationComposer,
    $$TestAttemptsTableCreateCompanionBuilder,
    $$TestAttemptsTableUpdateCompanionBuilder,
    (TestAttempt, $$TestAttemptsTableReferences),
    TestAttempt,
    PrefetchHooks Function({bool testId, bool attemptsRefs})>;
typedef $$ReviewLogsTableCreateCompanionBuilder = ReviewLogsCompanion Function({
  Value<int> id,
  required int cardId,
  required String grade,
  required int isCorrect,
  required String createdAt,
});
typedef $$ReviewLogsTableUpdateCompanionBuilder = ReviewLogsCompanion Function({
  Value<int> id,
  Value<int> cardId,
  Value<String> grade,
  Value<int> isCorrect,
  Value<String> createdAt,
});

final class $$ReviewLogsTableReferences
    extends BaseReferences<_$JPStudyDatabase, $ReviewLogsTable, ReviewLog> {
  $$ReviewLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CardsTable _cardIdTable(_$JPStudyDatabase db) => db.cards
      .createAlias($_aliasNameGenerator(db.reviewLogs.cardId, db.cards.id));

  $$CardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<int>('card_id')!;

    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ReviewLogsTableFilterComposer
    extends Composer<_$JPStudyDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewLogsTableOrderingComposer
    extends Composer<_$JPStudyDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableOrderingComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewLogsTableAnnotationComposer
    extends Composer<_$JPStudyDatabase, $ReviewLogsTable> {
  $$ReviewLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<int> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewLogsTableTableManager extends RootTableManager<
    _$JPStudyDatabase,
    $ReviewLogsTable,
    ReviewLog,
    $$ReviewLogsTableFilterComposer,
    $$ReviewLogsTableOrderingComposer,
    $$ReviewLogsTableAnnotationComposer,
    $$ReviewLogsTableCreateCompanionBuilder,
    $$ReviewLogsTableUpdateCompanionBuilder,
    (ReviewLog, $$ReviewLogsTableReferences),
    ReviewLog,
    PrefetchHooks Function({bool cardId})> {
  $$ReviewLogsTableTableManager(_$JPStudyDatabase db, $ReviewLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> cardId = const Value.absent(),
            Value<String> grade = const Value.absent(),
            Value<int> isCorrect = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              ReviewLogsCompanion(
            id: id,
            cardId: cardId,
            grade: grade,
            isCorrect: isCorrect,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int cardId,
            required String grade,
            required int isCorrect,
            required String createdAt,
          }) =>
              ReviewLogsCompanion.insert(
            id: id,
            cardId: cardId,
            grade: grade,
            isCorrect: isCorrect,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ReviewLogsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (cardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cardId,
                    referencedTable:
                        $$ReviewLogsTableReferences._cardIdTable(db),
                    referencedColumn:
                        $$ReviewLogsTableReferences._cardIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ReviewLogsTableProcessedTableManager = ProcessedTableManager<
    _$JPStudyDatabase,
    $ReviewLogsTable,
    ReviewLog,
    $$ReviewLogsTableFilterComposer,
    $$ReviewLogsTableOrderingComposer,
    $$ReviewLogsTableAnnotationComposer,
    $$ReviewLogsTableCreateCompanionBuilder,
    $$ReviewLogsTableUpdateCompanionBuilder,
    (ReviewLog, $$ReviewLogsTableReferences),
    ReviewLog,
    PrefetchHooks Function({bool cardId})>;
typedef $$AttemptsTableCreateCompanionBuilder = AttemptsCompanion Function({
  Value<int> id,
  Value<int?> itemId,
  Value<int?> cardId,
  Value<int?> sentenceId,
  Value<int?> testId,
  Value<int?> testAttemptId,
  required String source,
  Value<String?> prompt,
  Value<String?> response,
  Value<String?> expected,
  Value<int?> isCorrect,
  Value<double?> score,
  Value<int?> durationMs,
  required String createdAt,
});
typedef $$AttemptsTableUpdateCompanionBuilder = AttemptsCompanion Function({
  Value<int> id,
  Value<int?> itemId,
  Value<int?> cardId,
  Value<int?> sentenceId,
  Value<int?> testId,
  Value<int?> testAttemptId,
  Value<String> source,
  Value<String?> prompt,
  Value<String?> response,
  Value<String?> expected,
  Value<int?> isCorrect,
  Value<double?> score,
  Value<int?> durationMs,
  Value<String> createdAt,
});

final class $$AttemptsTableReferences
    extends BaseReferences<_$JPStudyDatabase, $AttemptsTable, Attempt> {
  $$AttemptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$JPStudyDatabase db) => db.items
      .createAlias($_aliasNameGenerator(db.attempts.itemId, db.items.id));

  $$ItemsTableProcessedTableManager? get itemId {
    final $_column = $_itemColumn<int>('item_id');
    if ($_column == null) return null;
    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CardsTable _cardIdTable(_$JPStudyDatabase db) => db.cards
      .createAlias($_aliasNameGenerator(db.attempts.cardId, db.cards.id));

  $$CardsTableProcessedTableManager? get cardId {
    final $_column = $_itemColumn<int>('card_id');
    if ($_column == null) return null;
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SentencesTable _sentenceIdTable(_$JPStudyDatabase db) =>
      db.sentences.createAlias(
          $_aliasNameGenerator(db.attempts.sentenceId, db.sentences.id));

  $$SentencesTableProcessedTableManager? get sentenceId {
    final $_column = $_itemColumn<int>('sentence_id');
    if ($_column == null) return null;
    final manager = $$SentencesTableTableManager($_db, $_db.sentences)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sentenceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TestsTable _testIdTable(_$JPStudyDatabase db) => db.tests
      .createAlias($_aliasNameGenerator(db.attempts.testId, db.tests.id));

  $$TestsTableProcessedTableManager? get testId {
    final $_column = $_itemColumn<int>('test_id');
    if ($_column == null) return null;
    final manager = $$TestsTableTableManager($_db, $_db.tests)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_testIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TestAttemptsTable _testAttemptIdTable(_$JPStudyDatabase db) =>
      db.testAttempts.createAlias(
          $_aliasNameGenerator(db.attempts.testAttemptId, db.testAttempts.id));

  $$TestAttemptsTableProcessedTableManager? get testAttemptId {
    final $_column = $_itemColumn<int>('test_attempt_id');
    if ($_column == null) return null;
    final manager = $$TestAttemptsTableTableManager($_db, $_db.testAttempts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_testAttemptIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MistakesTable, List<Mistake>> _mistakesRefsTable(
          _$JPStudyDatabase db) =>
      MultiTypedResultKey.fromTable(db.mistakes,
          aliasName:
              $_aliasNameGenerator(db.attempts.id, db.mistakes.lastAttemptId));

  $$MistakesTableProcessedTableManager get mistakesRefs {
    final manager = $$MistakesTableTableManager($_db, $_db.mistakes)
        .filter((f) => f.lastAttemptId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mistakesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AttemptsTableFilterComposer
    extends Composer<_$JPStudyDatabase, $AttemptsTable> {
  $$AttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get prompt => $composableBuilder(
      column: $table.prompt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get expected => $composableBuilder(
      column: $table.expected, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SentencesTableFilterComposer get sentenceId {
    final $$SentencesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sentenceId,
        referencedTable: $db.sentences,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SentencesTableFilterComposer(
              $db: $db,
              $table: $db.sentences,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TestsTableFilterComposer get testId {
    final $$TestsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestsTableFilterComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TestAttemptsTableFilterComposer get testAttemptId {
    final $$TestAttemptsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testAttemptId,
        referencedTable: $db.testAttempts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestAttemptsTableFilterComposer(
              $db: $db,
              $table: $db.testAttempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> mistakesRefs(
      Expression<bool> Function($$MistakesTableFilterComposer f) f) {
    final $$MistakesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.lastAttemptId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableFilterComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AttemptsTableOrderingComposer
    extends Composer<_$JPStudyDatabase, $AttemptsTable> {
  $$AttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get prompt => $composableBuilder(
      column: $table.prompt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get response => $composableBuilder(
      column: $table.response, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get expected => $composableBuilder(
      column: $table.expected, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableOrderingComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableOrderingComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SentencesTableOrderingComposer get sentenceId {
    final $$SentencesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sentenceId,
        referencedTable: $db.sentences,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SentencesTableOrderingComposer(
              $db: $db,
              $table: $db.sentences,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TestsTableOrderingComposer get testId {
    final $$TestsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestsTableOrderingComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TestAttemptsTableOrderingComposer get testAttemptId {
    final $$TestAttemptsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testAttemptId,
        referencedTable: $db.testAttempts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestAttemptsTableOrderingComposer(
              $db: $db,
              $table: $db.testAttempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttemptsTableAnnotationComposer
    extends Composer<_$JPStudyDatabase, $AttemptsTable> {
  $$AttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);

  GeneratedColumn<String> get expected =>
      $composableBuilder(column: $table.expected, builder: (column) => column);

  GeneratedColumn<int> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SentencesTableAnnotationComposer get sentenceId {
    final $$SentencesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sentenceId,
        referencedTable: $db.sentences,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SentencesTableAnnotationComposer(
              $db: $db,
              $table: $db.sentences,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TestsTableAnnotationComposer get testId {
    final $$TestsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testId,
        referencedTable: $db.tests,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestsTableAnnotationComposer(
              $db: $db,
              $table: $db.tests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TestAttemptsTableAnnotationComposer get testAttemptId {
    final $$TestAttemptsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.testAttemptId,
        referencedTable: $db.testAttempts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TestAttemptsTableAnnotationComposer(
              $db: $db,
              $table: $db.testAttempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> mistakesRefs<T extends Object>(
      Expression<T> Function($$MistakesTableAnnotationComposer a) f) {
    final $$MistakesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mistakes,
        getReferencedColumn: (t) => t.lastAttemptId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MistakesTableAnnotationComposer(
              $db: $db,
              $table: $db.mistakes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AttemptsTableTableManager extends RootTableManager<
    _$JPStudyDatabase,
    $AttemptsTable,
    Attempt,
    $$AttemptsTableFilterComposer,
    $$AttemptsTableOrderingComposer,
    $$AttemptsTableAnnotationComposer,
    $$AttemptsTableCreateCompanionBuilder,
    $$AttemptsTableUpdateCompanionBuilder,
    (Attempt, $$AttemptsTableReferences),
    Attempt,
    PrefetchHooks Function(
        {bool itemId,
        bool cardId,
        bool sentenceId,
        bool testId,
        bool testAttemptId,
        bool mistakesRefs})> {
  $$AttemptsTableTableManager(_$JPStudyDatabase db, $AttemptsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> itemId = const Value.absent(),
            Value<int?> cardId = const Value.absent(),
            Value<int?> sentenceId = const Value.absent(),
            Value<int?> testId = const Value.absent(),
            Value<int?> testAttemptId = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> prompt = const Value.absent(),
            Value<String?> response = const Value.absent(),
            Value<String?> expected = const Value.absent(),
            Value<int?> isCorrect = const Value.absent(),
            Value<double?> score = const Value.absent(),
            Value<int?> durationMs = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              AttemptsCompanion(
            id: id,
            itemId: itemId,
            cardId: cardId,
            sentenceId: sentenceId,
            testId: testId,
            testAttemptId: testAttemptId,
            source: source,
            prompt: prompt,
            response: response,
            expected: expected,
            isCorrect: isCorrect,
            score: score,
            durationMs: durationMs,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> itemId = const Value.absent(),
            Value<int?> cardId = const Value.absent(),
            Value<int?> sentenceId = const Value.absent(),
            Value<int?> testId = const Value.absent(),
            Value<int?> testAttemptId = const Value.absent(),
            required String source,
            Value<String?> prompt = const Value.absent(),
            Value<String?> response = const Value.absent(),
            Value<String?> expected = const Value.absent(),
            Value<int?> isCorrect = const Value.absent(),
            Value<double?> score = const Value.absent(),
            Value<int?> durationMs = const Value.absent(),
            required String createdAt,
          }) =>
              AttemptsCompanion.insert(
            id: id,
            itemId: itemId,
            cardId: cardId,
            sentenceId: sentenceId,
            testId: testId,
            testAttemptId: testAttemptId,
            source: source,
            prompt: prompt,
            response: response,
            expected: expected,
            isCorrect: isCorrect,
            score: score,
            durationMs: durationMs,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AttemptsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {itemId = false,
              cardId = false,
              sentenceId = false,
              testId = false,
              testAttemptId = false,
              mistakesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (mistakesRefs) db.mistakes],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (itemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.itemId,
                    referencedTable: $$AttemptsTableReferences._itemIdTable(db),
                    referencedColumn:
                        $$AttemptsTableReferences._itemIdTable(db).id,
                  ) as T;
                }
                if (cardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cardId,
                    referencedTable: $$AttemptsTableReferences._cardIdTable(db),
                    referencedColumn:
                        $$AttemptsTableReferences._cardIdTable(db).id,
                  ) as T;
                }
                if (sentenceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sentenceId,
                    referencedTable:
                        $$AttemptsTableReferences._sentenceIdTable(db),
                    referencedColumn:
                        $$AttemptsTableReferences._sentenceIdTable(db).id,
                  ) as T;
                }
                if (testId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.testId,
                    referencedTable: $$AttemptsTableReferences._testIdTable(db),
                    referencedColumn:
                        $$AttemptsTableReferences._testIdTable(db).id,
                  ) as T;
                }
                if (testAttemptId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.testAttemptId,
                    referencedTable:
                        $$AttemptsTableReferences._testAttemptIdTable(db),
                    referencedColumn:
                        $$AttemptsTableReferences._testAttemptIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mistakesRefs)
                    await $_getPrefetchedData<Attempt, $AttemptsTable, Mistake>(
                        currentTable: table,
                        referencedTable:
                            $$AttemptsTableReferences._mistakesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AttemptsTableReferences(db, table, p0)
                                .mistakesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.lastAttemptId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AttemptsTableProcessedTableManager = ProcessedTableManager<
    _$JPStudyDatabase,
    $AttemptsTable,
    Attempt,
    $$AttemptsTableFilterComposer,
    $$AttemptsTableOrderingComposer,
    $$AttemptsTableAnnotationComposer,
    $$AttemptsTableCreateCompanionBuilder,
    $$AttemptsTableUpdateCompanionBuilder,
    (Attempt, $$AttemptsTableReferences),
    Attempt,
    PrefetchHooks Function(
        {bool itemId,
        bool cardId,
        bool sentenceId,
        bool testId,
        bool testAttemptId,
        bool mistakesRefs})>;
typedef $$MistakesTableCreateCompanionBuilder = MistakesCompanion Function({
  Value<int> id,
  required int itemId,
  Value<int?> cardId,
  required String source,
  Value<int> mistakeCount,
  required String lastMistakeAt,
  Value<int?> lastAttemptId,
});
typedef $$MistakesTableUpdateCompanionBuilder = MistakesCompanion Function({
  Value<int> id,
  Value<int> itemId,
  Value<int?> cardId,
  Value<String> source,
  Value<int> mistakeCount,
  Value<String> lastMistakeAt,
  Value<int?> lastAttemptId,
});

final class $$MistakesTableReferences
    extends BaseReferences<_$JPStudyDatabase, $MistakesTable, Mistake> {
  $$MistakesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItemsTable _itemIdTable(_$JPStudyDatabase db) => db.items
      .createAlias($_aliasNameGenerator(db.mistakes.itemId, db.items.id));

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager($_db, $_db.items)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CardsTable _cardIdTable(_$JPStudyDatabase db) => db.cards
      .createAlias($_aliasNameGenerator(db.mistakes.cardId, db.cards.id));

  $$CardsTableProcessedTableManager? get cardId {
    final $_column = $_itemColumn<int>('card_id');
    if ($_column == null) return null;
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AttemptsTable _lastAttemptIdTable(_$JPStudyDatabase db) =>
      db.attempts.createAlias(
          $_aliasNameGenerator(db.mistakes.lastAttemptId, db.attempts.id));

  $$AttemptsTableProcessedTableManager? get lastAttemptId {
    final $_column = $_itemColumn<int>('last_attempt_id');
    if ($_column == null) return null;
    final manager = $$AttemptsTableTableManager($_db, $_db.attempts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lastAttemptIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MistakesTableFilterComposer
    extends Composer<_$JPStudyDatabase, $MistakesTable> {
  $$MistakesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mistakeCount => $composableBuilder(
      column: $table.mistakeCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastMistakeAt => $composableBuilder(
      column: $table.lastMistakeAt, builder: (column) => ColumnFilters(column));

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableFilterComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AttemptsTableFilterComposer get lastAttemptId {
    final $$AttemptsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lastAttemptId,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableFilterComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MistakesTableOrderingComposer
    extends Composer<_$JPStudyDatabase, $MistakesTable> {
  $$MistakesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mistakeCount => $composableBuilder(
      column: $table.mistakeCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastMistakeAt => $composableBuilder(
      column: $table.lastMistakeAt,
      builder: (column) => ColumnOrderings(column));

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableOrderingComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableOrderingComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AttemptsTableOrderingComposer get lastAttemptId {
    final $$AttemptsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lastAttemptId,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableOrderingComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MistakesTableAnnotationComposer
    extends Composer<_$JPStudyDatabase, $MistakesTable> {
  $$MistakesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get mistakeCount => $composableBuilder(
      column: $table.mistakeCount, builder: (column) => column);

  GeneratedColumn<String> get lastMistakeAt => $composableBuilder(
      column: $table.lastMistakeAt, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.itemId,
        referencedTable: $db.items,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.items,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AttemptsTableAnnotationComposer get lastAttemptId {
    final $$AttemptsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.lastAttemptId,
        referencedTable: $db.attempts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttemptsTableAnnotationComposer(
              $db: $db,
              $table: $db.attempts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MistakesTableTableManager extends RootTableManager<
    _$JPStudyDatabase,
    $MistakesTable,
    Mistake,
    $$MistakesTableFilterComposer,
    $$MistakesTableOrderingComposer,
    $$MistakesTableAnnotationComposer,
    $$MistakesTableCreateCompanionBuilder,
    $$MistakesTableUpdateCompanionBuilder,
    (Mistake, $$MistakesTableReferences),
    Mistake,
    PrefetchHooks Function({bool itemId, bool cardId, bool lastAttemptId})> {
  $$MistakesTableTableManager(_$JPStudyDatabase db, $MistakesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MistakesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MistakesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MistakesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> itemId = const Value.absent(),
            Value<int?> cardId = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<int> mistakeCount = const Value.absent(),
            Value<String> lastMistakeAt = const Value.absent(),
            Value<int?> lastAttemptId = const Value.absent(),
          }) =>
              MistakesCompanion(
            id: id,
            itemId: itemId,
            cardId: cardId,
            source: source,
            mistakeCount: mistakeCount,
            lastMistakeAt: lastMistakeAt,
            lastAttemptId: lastAttemptId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int itemId,
            Value<int?> cardId = const Value.absent(),
            required String source,
            Value<int> mistakeCount = const Value.absent(),
            required String lastMistakeAt,
            Value<int?> lastAttemptId = const Value.absent(),
          }) =>
              MistakesCompanion.insert(
            id: id,
            itemId: itemId,
            cardId: cardId,
            source: source,
            mistakeCount: mistakeCount,
            lastMistakeAt: lastMistakeAt,
            lastAttemptId: lastAttemptId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MistakesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {itemId = false, cardId = false, lastAttemptId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (itemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.itemId,
                    referencedTable: $$MistakesTableReferences._itemIdTable(db),
                    referencedColumn:
                        $$MistakesTableReferences._itemIdTable(db).id,
                  ) as T;
                }
                if (cardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cardId,
                    referencedTable: $$MistakesTableReferences._cardIdTable(db),
                    referencedColumn:
                        $$MistakesTableReferences._cardIdTable(db).id,
                  ) as T;
                }
                if (lastAttemptId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.lastAttemptId,
                    referencedTable:
                        $$MistakesTableReferences._lastAttemptIdTable(db),
                    referencedColumn:
                        $$MistakesTableReferences._lastAttemptIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MistakesTableProcessedTableManager = ProcessedTableManager<
    _$JPStudyDatabase,
    $MistakesTable,
    Mistake,
    $$MistakesTableFilterComposer,
    $$MistakesTableOrderingComposer,
    $$MistakesTableAnnotationComposer,
    $$MistakesTableCreateCompanionBuilder,
    $$MistakesTableUpdateCompanionBuilder,
    (Mistake, $$MistakesTableReferences),
    Mistake,
    PrefetchHooks Function({bool itemId, bool cardId, bool lastAttemptId})>;

class $JPStudyDatabaseManager {
  final _$JPStudyDatabase _db;
  $JPStudyDatabaseManager(this._db);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$SentencesTableTableManager get sentences =>
      $$SentencesTableTableManager(_db, _db.sentences);
  $$ErrorsTableTableManager get errors =>
      $$ErrorsTableTableManager(_db, _db.errors);
  $$TestsTableTableManager get tests =>
      $$TestsTableTableManager(_db, _db.tests);
  $$TestAttemptsTableTableManager get testAttempts =>
      $$TestAttemptsTableTableManager(_db, _db.testAttempts);
  $$ReviewLogsTableTableManager get reviewLogs =>
      $$ReviewLogsTableTableManager(_db, _db.reviewLogs);
  $$AttemptsTableTableManager get attempts =>
      $$AttemptsTableTableManager(_db, _db.attempts);
  $$MistakesTableTableManager get mistakes =>
      $$MistakesTableTableManager(_db, _db.mistakes);
}
