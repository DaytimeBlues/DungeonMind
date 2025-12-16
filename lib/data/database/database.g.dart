// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class Campaigns extends Table with TableInfo<Campaigns, Campaign> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Campaigns(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _calendarSystemMeta =
      const VerificationMeta('calendarSystem');
  late final GeneratedColumn<String> calendarSystem = GeneratedColumn<String>(
      'calendar_system', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT \'gregorian\'',
      defaultValue: const CustomExpression('\'gregorian\''));
  static const VerificationMeta _currentInGameDateMeta =
      const VerificationMeta('currentInGameDate');
  late final GeneratedColumn<String> currentInGameDate =
      GeneratedColumn<String>('current_in_game_date', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        calendarSystem,
        currentInGameDate,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'campaigns';
  @override
  VerificationContext validateIntegrity(Insertable<Campaign> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('calendar_system')) {
      context.handle(
          _calendarSystemMeta,
          calendarSystem.isAcceptableOrUnknown(
              data['calendar_system']!, _calendarSystemMeta));
    }
    if (data.containsKey('current_in_game_date')) {
      context.handle(
          _currentInGameDateMeta,
          currentInGameDate.isAcceptableOrUnknown(
              data['current_in_game_date']!, _currentInGameDateMeta));
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
  Campaign map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Campaign(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      calendarSystem: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}calendar_system'])!,
      currentInGameDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_in_game_date']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  Campaigns createAlias(String alias) {
    return Campaigns(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Campaign extends DataClass implements Insertable<Campaign> {
  final String id;
  final String title;
  final String? description;
  final String calendarSystem;
  final String? currentInGameDate;
  final int createdAt;
  final int updatedAt;
  const Campaign(
      {required this.id,
      required this.title,
      this.description,
      required this.calendarSystem,
      this.currentInGameDate,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['calendar_system'] = Variable<String>(calendarSystem);
    if (!nullToAbsent || currentInGameDate != null) {
      map['current_in_game_date'] = Variable<String>(currentInGameDate);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  CampaignsCompanion toCompanion(bool nullToAbsent) {
    return CampaignsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      calendarSystem: Value(calendarSystem),
      currentInGameDate: currentInGameDate == null && nullToAbsent
          ? const Value.absent()
          : Value(currentInGameDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Campaign.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Campaign(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      calendarSystem: serializer.fromJson<String>(json['calendar_system']),
      currentInGameDate:
          serializer.fromJson<String?>(json['current_in_game_date']),
      createdAt: serializer.fromJson<int>(json['created_at']),
      updatedAt: serializer.fromJson<int>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'calendar_system': serializer.toJson<String>(calendarSystem),
      'current_in_game_date': serializer.toJson<String?>(currentInGameDate),
      'created_at': serializer.toJson<int>(createdAt),
      'updated_at': serializer.toJson<int>(updatedAt),
    };
  }

  Campaign copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          String? calendarSystem,
          Value<String?> currentInGameDate = const Value.absent(),
          int? createdAt,
          int? updatedAt}) =>
      Campaign(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        calendarSystem: calendarSystem ?? this.calendarSystem,
        currentInGameDate: currentInGameDate.present
            ? currentInGameDate.value
            : this.currentInGameDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Campaign copyWithCompanion(CampaignsCompanion data) {
    return Campaign(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      calendarSystem: data.calendarSystem.present
          ? data.calendarSystem.value
          : this.calendarSystem,
      currentInGameDate: data.currentInGameDate.present
          ? data.currentInGameDate.value
          : this.currentInGameDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Campaign(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('calendarSystem: $calendarSystem, ')
          ..write('currentInGameDate: $currentInGameDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, calendarSystem,
      currentInGameDate, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Campaign &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.calendarSystem == this.calendarSystem &&
          other.currentInGameDate == this.currentInGameDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CampaignsCompanion extends UpdateCompanion<Campaign> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> calendarSystem;
  final Value<String?> currentInGameDate;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const CampaignsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.calendarSystem = const Value.absent(),
    this.currentInGameDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CampaignsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.calendarSystem = const Value.absent(),
    this.currentInGameDate = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Campaign> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? calendarSystem,
    Expression<String>? currentInGameDate,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (calendarSystem != null) 'calendar_system': calendarSystem,
      if (currentInGameDate != null) 'current_in_game_date': currentInGameDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CampaignsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String>? calendarSystem,
      Value<String?>? currentInGameDate,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return CampaignsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      calendarSystem: calendarSystem ?? this.calendarSystem,
      currentInGameDate: currentInGameDate ?? this.currentInGameDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (calendarSystem.present) {
      map['calendar_system'] = Variable<String>(calendarSystem.value);
    }
    if (currentInGameDate.present) {
      map['current_in_game_date'] = Variable<String>(currentInGameDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampaignsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('calendarSystem: $calendarSystem, ')
          ..write('currentInGameDate: $currentInGameDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Entities extends Table with TableInfo<Entities, Entity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Entities(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _campaignIdMeta =
      const VerificationMeta('campaignId');
  late final GeneratedColumn<String> campaignId = GeneratedColumn<String>(
      'campaign_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES campaigns(id)ON DELETE CASCADE');
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
      'slug', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _bodyContentMeta =
      const VerificationMeta('bodyContent');
  late final GeneratedColumn<String> bodyContent = GeneratedColumn<String>(
      'body_content', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _publicDescriptionMeta =
      const VerificationMeta('publicDescription');
  late final GeneratedColumn<String> publicDescription =
      GeneratedColumn<String>('public_description', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _completenessScoreMeta =
      const VerificationMeta('completenessScore');
  late final GeneratedColumn<double> completenessScore =
      GeneratedColumn<double>('completeness_score', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          $customConstraints: 'NOT NULL DEFAULT 0.0',
          defaultValue: const CustomExpression('0.0'));
  static const VerificationMeta _isRevealedMeta =
      const VerificationMeta('isRevealed');
  late final GeneratedColumn<bool> isRevealed = GeneratedColumn<bool>(
      'is_revealed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT FALSE',
      defaultValue: const CustomExpression('FALSE'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        campaignId,
        type,
        title,
        slug,
        bodyContent,
        publicDescription,
        metadata,
        tags,
        completenessScore,
        isRevealed,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entities';
  @override
  VerificationContext validateIntegrity(Insertable<Entity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('campaign_id')) {
      context.handle(
          _campaignIdMeta,
          campaignId.isAcceptableOrUnknown(
              data['campaign_id']!, _campaignIdMeta));
    } else if (isInserting) {
      context.missing(_campaignIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
          _slugMeta, slug.isAcceptableOrUnknown(data['slug']!, _slugMeta));
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('body_content')) {
      context.handle(
          _bodyContentMeta,
          bodyContent.isAcceptableOrUnknown(
              data['body_content']!, _bodyContentMeta));
    }
    if (data.containsKey('public_description')) {
      context.handle(
          _publicDescriptionMeta,
          publicDescription.isAcceptableOrUnknown(
              data['public_description']!, _publicDescriptionMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('completeness_score')) {
      context.handle(
          _completenessScoreMeta,
          completenessScore.isAcceptableOrUnknown(
              data['completeness_score']!, _completenessScoreMeta));
    }
    if (data.containsKey('is_revealed')) {
      context.handle(
          _isRevealedMeta,
          isRevealed.isAcceptableOrUnknown(
              data['is_revealed']!, _isRevealedMeta));
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
  Entity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      campaignId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}campaign_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      slug: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slug'])!,
      bodyContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body_content']),
      publicDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}public_description']),
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
      completenessScore: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}completeness_score'])!,
      isRevealed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_revealed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  Entities createAlias(String alias) {
    return Entities(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Entity extends DataClass implements Insertable<Entity> {
  final String id;
  final String campaignId;
  final String type;
  final String title;
  final String slug;
  final String? bodyContent;
  final String? publicDescription;
  final String? metadata;
  final String? tags;
  final double completenessScore;
  final bool isRevealed;
  final int createdAt;
  final int updatedAt;
  const Entity(
      {required this.id,
      required this.campaignId,
      required this.type,
      required this.title,
      required this.slug,
      this.bodyContent,
      this.publicDescription,
      this.metadata,
      this.tags,
      required this.completenessScore,
      required this.isRevealed,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['campaign_id'] = Variable<String>(campaignId);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || bodyContent != null) {
      map['body_content'] = Variable<String>(bodyContent);
    }
    if (!nullToAbsent || publicDescription != null) {
      map['public_description'] = Variable<String>(publicDescription);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['completeness_score'] = Variable<double>(completenessScore);
    map['is_revealed'] = Variable<bool>(isRevealed);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  EntitiesCompanion toCompanion(bool nullToAbsent) {
    return EntitiesCompanion(
      id: Value(id),
      campaignId: Value(campaignId),
      type: Value(type),
      title: Value(title),
      slug: Value(slug),
      bodyContent: bodyContent == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyContent),
      publicDescription: publicDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(publicDescription),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      completenessScore: Value(completenessScore),
      isRevealed: Value(isRevealed),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Entity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entity(
      id: serializer.fromJson<String>(json['id']),
      campaignId: serializer.fromJson<String>(json['campaign_id']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      slug: serializer.fromJson<String>(json['slug']),
      bodyContent: serializer.fromJson<String?>(json['body_content']),
      publicDescription:
          serializer.fromJson<String?>(json['public_description']),
      metadata: serializer.fromJson<String?>(json['metadata']),
      tags: serializer.fromJson<String?>(json['tags']),
      completenessScore:
          serializer.fromJson<double>(json['completeness_score']),
      isRevealed: serializer.fromJson<bool>(json['is_revealed']),
      createdAt: serializer.fromJson<int>(json['created_at']),
      updatedAt: serializer.fromJson<int>(json['updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'campaign_id': serializer.toJson<String>(campaignId),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'slug': serializer.toJson<String>(slug),
      'body_content': serializer.toJson<String?>(bodyContent),
      'public_description': serializer.toJson<String?>(publicDescription),
      'metadata': serializer.toJson<String?>(metadata),
      'tags': serializer.toJson<String?>(tags),
      'completeness_score': serializer.toJson<double>(completenessScore),
      'is_revealed': serializer.toJson<bool>(isRevealed),
      'created_at': serializer.toJson<int>(createdAt),
      'updated_at': serializer.toJson<int>(updatedAt),
    };
  }

  Entity copyWith(
          {String? id,
          String? campaignId,
          String? type,
          String? title,
          String? slug,
          Value<String?> bodyContent = const Value.absent(),
          Value<String?> publicDescription = const Value.absent(),
          Value<String?> metadata = const Value.absent(),
          Value<String?> tags = const Value.absent(),
          double? completenessScore,
          bool? isRevealed,
          int? createdAt,
          int? updatedAt}) =>
      Entity(
        id: id ?? this.id,
        campaignId: campaignId ?? this.campaignId,
        type: type ?? this.type,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        bodyContent: bodyContent.present ? bodyContent.value : this.bodyContent,
        publicDescription: publicDescription.present
            ? publicDescription.value
            : this.publicDescription,
        metadata: metadata.present ? metadata.value : this.metadata,
        tags: tags.present ? tags.value : this.tags,
        completenessScore: completenessScore ?? this.completenessScore,
        isRevealed: isRevealed ?? this.isRevealed,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Entity copyWithCompanion(EntitiesCompanion data) {
    return Entity(
      id: data.id.present ? data.id.value : this.id,
      campaignId:
          data.campaignId.present ? data.campaignId.value : this.campaignId,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      slug: data.slug.present ? data.slug.value : this.slug,
      bodyContent:
          data.bodyContent.present ? data.bodyContent.value : this.bodyContent,
      publicDescription: data.publicDescription.present
          ? data.publicDescription.value
          : this.publicDescription,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      tags: data.tags.present ? data.tags.value : this.tags,
      completenessScore: data.completenessScore.present
          ? data.completenessScore.value
          : this.completenessScore,
      isRevealed:
          data.isRevealed.present ? data.isRevealed.value : this.isRevealed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entity(')
          ..write('id: $id, ')
          ..write('campaignId: $campaignId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('slug: $slug, ')
          ..write('bodyContent: $bodyContent, ')
          ..write('publicDescription: $publicDescription, ')
          ..write('metadata: $metadata, ')
          ..write('tags: $tags, ')
          ..write('completenessScore: $completenessScore, ')
          ..write('isRevealed: $isRevealed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      campaignId,
      type,
      title,
      slug,
      bodyContent,
      publicDescription,
      metadata,
      tags,
      completenessScore,
      isRevealed,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entity &&
          other.id == this.id &&
          other.campaignId == this.campaignId &&
          other.type == this.type &&
          other.title == this.title &&
          other.slug == this.slug &&
          other.bodyContent == this.bodyContent &&
          other.publicDescription == this.publicDescription &&
          other.metadata == this.metadata &&
          other.tags == this.tags &&
          other.completenessScore == this.completenessScore &&
          other.isRevealed == this.isRevealed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EntitiesCompanion extends UpdateCompanion<Entity> {
  final Value<String> id;
  final Value<String> campaignId;
  final Value<String> type;
  final Value<String> title;
  final Value<String> slug;
  final Value<String?> bodyContent;
  final Value<String?> publicDescription;
  final Value<String?> metadata;
  final Value<String?> tags;
  final Value<double> completenessScore;
  final Value<bool> isRevealed;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const EntitiesCompanion({
    this.id = const Value.absent(),
    this.campaignId = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.slug = const Value.absent(),
    this.bodyContent = const Value.absent(),
    this.publicDescription = const Value.absent(),
    this.metadata = const Value.absent(),
    this.tags = const Value.absent(),
    this.completenessScore = const Value.absent(),
    this.isRevealed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntitiesCompanion.insert({
    required String id,
    required String campaignId,
    required String type,
    required String title,
    required String slug,
    this.bodyContent = const Value.absent(),
    this.publicDescription = const Value.absent(),
    this.metadata = const Value.absent(),
    this.tags = const Value.absent(),
    this.completenessScore = const Value.absent(),
    this.isRevealed = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        campaignId = Value(campaignId),
        type = Value(type),
        title = Value(title),
        slug = Value(slug),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Entity> custom({
    Expression<String>? id,
    Expression<String>? campaignId,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? slug,
    Expression<String>? bodyContent,
    Expression<String>? publicDescription,
    Expression<String>? metadata,
    Expression<String>? tags,
    Expression<double>? completenessScore,
    Expression<bool>? isRevealed,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (campaignId != null) 'campaign_id': campaignId,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (slug != null) 'slug': slug,
      if (bodyContent != null) 'body_content': bodyContent,
      if (publicDescription != null) 'public_description': publicDescription,
      if (metadata != null) 'metadata': metadata,
      if (tags != null) 'tags': tags,
      if (completenessScore != null) 'completeness_score': completenessScore,
      if (isRevealed != null) 'is_revealed': isRevealed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntitiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? campaignId,
      Value<String>? type,
      Value<String>? title,
      Value<String>? slug,
      Value<String?>? bodyContent,
      Value<String?>? publicDescription,
      Value<String?>? metadata,
      Value<String?>? tags,
      Value<double>? completenessScore,
      Value<bool>? isRevealed,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<int>? rowid}) {
    return EntitiesCompanion(
      id: id ?? this.id,
      campaignId: campaignId ?? this.campaignId,
      type: type ?? this.type,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      bodyContent: bodyContent ?? this.bodyContent,
      publicDescription: publicDescription ?? this.publicDescription,
      metadata: metadata ?? this.metadata,
      tags: tags ?? this.tags,
      completenessScore: completenessScore ?? this.completenessScore,
      isRevealed: isRevealed ?? this.isRevealed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (campaignId.present) {
      map['campaign_id'] = Variable<String>(campaignId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (bodyContent.present) {
      map['body_content'] = Variable<String>(bodyContent.value);
    }
    if (publicDescription.present) {
      map['public_description'] = Variable<String>(publicDescription.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (completenessScore.present) {
      map['completeness_score'] = Variable<double>(completenessScore.value);
    }
    if (isRevealed.present) {
      map['is_revealed'] = Variable<bool>(isRevealed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntitiesCompanion(')
          ..write('id: $id, ')
          ..write('campaignId: $campaignId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('slug: $slug, ')
          ..write('bodyContent: $bodyContent, ')
          ..write('publicDescription: $publicDescription, ')
          ..write('metadata: $metadata, ')
          ..write('tags: $tags, ')
          ..write('completenessScore: $completenessScore, ')
          ..write('isRevealed: $isRevealed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class Edges extends Table with TableInfo<Edges, Edge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Edges(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES entities(id)ON DELETE CASCADE');
  static const VerificationMeta _targetIdMeta =
      const VerificationMeta('targetId');
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
      'target_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES entities(id)ON DELETE CASCADE');
  static const VerificationMeta _edgeTypeMeta =
      const VerificationMeta('edgeType');
  late final GeneratedColumn<String> edgeType = GeneratedColumn<String>(
      'edge_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, sourceId, targetId, edgeType, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'edges';
  @override
  VerificationContext validateIntegrity(Insertable<Edge> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(_targetIdMeta,
          targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta));
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('edge_type')) {
      context.handle(_edgeTypeMeta,
          edgeType.isAcceptableOrUnknown(data['edge_type']!, _edgeTypeMeta));
    } else if (isInserting) {
      context.missing(_edgeTypeMeta);
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
  Edge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Edge(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_id'])!,
      targetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_id'])!,
      edgeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}edge_type'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  Edges createAlias(String alias) {
    return Edges(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Edge extends DataClass implements Insertable<Edge> {
  final String id;
  final String sourceId;
  final String targetId;
  final String edgeType;
  final int createdAt;
  const Edge(
      {required this.id,
      required this.sourceId,
      required this.targetId,
      required this.edgeType,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_id'] = Variable<String>(sourceId);
    map['target_id'] = Variable<String>(targetId);
    map['edge_type'] = Variable<String>(edgeType);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  EdgesCompanion toCompanion(bool nullToAbsent) {
    return EdgesCompanion(
      id: Value(id),
      sourceId: Value(sourceId),
      targetId: Value(targetId),
      edgeType: Value(edgeType),
      createdAt: Value(createdAt),
    );
  }

  factory Edge.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Edge(
      id: serializer.fromJson<String>(json['id']),
      sourceId: serializer.fromJson<String>(json['source_id']),
      targetId: serializer.fromJson<String>(json['target_id']),
      edgeType: serializer.fromJson<String>(json['edge_type']),
      createdAt: serializer.fromJson<int>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'source_id': serializer.toJson<String>(sourceId),
      'target_id': serializer.toJson<String>(targetId),
      'edge_type': serializer.toJson<String>(edgeType),
      'created_at': serializer.toJson<int>(createdAt),
    };
  }

  Edge copyWith(
          {String? id,
          String? sourceId,
          String? targetId,
          String? edgeType,
          int? createdAt}) =>
      Edge(
        id: id ?? this.id,
        sourceId: sourceId ?? this.sourceId,
        targetId: targetId ?? this.targetId,
        edgeType: edgeType ?? this.edgeType,
        createdAt: createdAt ?? this.createdAt,
      );
  Edge copyWithCompanion(EdgesCompanion data) {
    return Edge(
      id: data.id.present ? data.id.value : this.id,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      edgeType: data.edgeType.present ? data.edgeType.value : this.edgeType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Edge(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('targetId: $targetId, ')
          ..write('edgeType: $edgeType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sourceId, targetId, edgeType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Edge &&
          other.id == this.id &&
          other.sourceId == this.sourceId &&
          other.targetId == this.targetId &&
          other.edgeType == this.edgeType &&
          other.createdAt == this.createdAt);
}

class EdgesCompanion extends UpdateCompanion<Edge> {
  final Value<String> id;
  final Value<String> sourceId;
  final Value<String> targetId;
  final Value<String> edgeType;
  final Value<int> createdAt;
  final Value<int> rowid;
  const EdgesCompanion({
    this.id = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.targetId = const Value.absent(),
    this.edgeType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EdgesCompanion.insert({
    required String id,
    required String sourceId,
    required String targetId,
    required String edgeType,
    required int createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        sourceId = Value(sourceId),
        targetId = Value(targetId),
        edgeType = Value(edgeType),
        createdAt = Value(createdAt);
  static Insertable<Edge> custom({
    Expression<String>? id,
    Expression<String>? sourceId,
    Expression<String>? targetId,
    Expression<String>? edgeType,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceId != null) 'source_id': sourceId,
      if (targetId != null) 'target_id': targetId,
      if (edgeType != null) 'edge_type': edgeType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EdgesCompanion copyWith(
      {Value<String>? id,
      Value<String>? sourceId,
      Value<String>? targetId,
      Value<String>? edgeType,
      Value<int>? createdAt,
      Value<int>? rowid}) {
    return EdgesCompanion(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      targetId: targetId ?? this.targetId,
      edgeType: edgeType ?? this.edgeType,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (edgeType.present) {
      map['edge_type'] = Variable<String>(edgeType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EdgesCompanion(')
          ..write('id: $id, ')
          ..write('sourceId: $sourceId, ')
          ..write('targetId: $targetId, ')
          ..write('edgeType: $edgeType, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class GameMaps extends Table with TableInfo<GameMaps, GameMap> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  GameMaps(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _campaignIdMeta =
      const VerificationMeta('campaignId');
  late final GeneratedColumn<String> campaignId = GeneratedColumn<String>(
      'campaign_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES campaigns(id)ON DELETE CASCADE');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
      'width', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _fogMaskMeta =
      const VerificationMeta('fogMask');
  late final GeneratedColumn<String> fogMask = GeneratedColumn<String>(
      'fog_mask', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, campaignId, title, imagePath, width, height, fogMask, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_maps';
  @override
  VerificationContext validateIntegrity(Insertable<GameMap> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('campaign_id')) {
      context.handle(
          _campaignIdMeta,
          campaignId.isAcceptableOrUnknown(
              data['campaign_id']!, _campaignIdMeta));
    } else if (isInserting) {
      context.missing(_campaignIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('fog_mask')) {
      context.handle(_fogMaskMeta,
          fogMask.isAcceptableOrUnknown(data['fog_mask']!, _fogMaskMeta));
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
  GameMap map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameMap(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      campaignId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}campaign_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}width'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height'])!,
      fogMask: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fog_mask']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  GameMaps createAlias(String alias) {
    return GameMaps(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class GameMap extends DataClass implements Insertable<GameMap> {
  final String id;
  final String campaignId;
  final String title;
  final String imagePath;
  final int width;
  final int height;
  final String? fogMask;
  final int createdAt;
  const GameMap(
      {required this.id,
      required this.campaignId,
      required this.title,
      required this.imagePath,
      required this.width,
      required this.height,
      this.fogMask,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['campaign_id'] = Variable<String>(campaignId);
    map['title'] = Variable<String>(title);
    map['image_path'] = Variable<String>(imagePath);
    map['width'] = Variable<int>(width);
    map['height'] = Variable<int>(height);
    if (!nullToAbsent || fogMask != null) {
      map['fog_mask'] = Variable<String>(fogMask);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  GameMapsCompanion toCompanion(bool nullToAbsent) {
    return GameMapsCompanion(
      id: Value(id),
      campaignId: Value(campaignId),
      title: Value(title),
      imagePath: Value(imagePath),
      width: Value(width),
      height: Value(height),
      fogMask: fogMask == null && nullToAbsent
          ? const Value.absent()
          : Value(fogMask),
      createdAt: Value(createdAt),
    );
  }

  factory GameMap.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameMap(
      id: serializer.fromJson<String>(json['id']),
      campaignId: serializer.fromJson<String>(json['campaign_id']),
      title: serializer.fromJson<String>(json['title']),
      imagePath: serializer.fromJson<String>(json['image_path']),
      width: serializer.fromJson<int>(json['width']),
      height: serializer.fromJson<int>(json['height']),
      fogMask: serializer.fromJson<String?>(json['fog_mask']),
      createdAt: serializer.fromJson<int>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'campaign_id': serializer.toJson<String>(campaignId),
      'title': serializer.toJson<String>(title),
      'image_path': serializer.toJson<String>(imagePath),
      'width': serializer.toJson<int>(width),
      'height': serializer.toJson<int>(height),
      'fog_mask': serializer.toJson<String?>(fogMask),
      'created_at': serializer.toJson<int>(createdAt),
    };
  }

  GameMap copyWith(
          {String? id,
          String? campaignId,
          String? title,
          String? imagePath,
          int? width,
          int? height,
          Value<String?> fogMask = const Value.absent(),
          int? createdAt}) =>
      GameMap(
        id: id ?? this.id,
        campaignId: campaignId ?? this.campaignId,
        title: title ?? this.title,
        imagePath: imagePath ?? this.imagePath,
        width: width ?? this.width,
        height: height ?? this.height,
        fogMask: fogMask.present ? fogMask.value : this.fogMask,
        createdAt: createdAt ?? this.createdAt,
      );
  GameMap copyWithCompanion(GameMapsCompanion data) {
    return GameMap(
      id: data.id.present ? data.id.value : this.id,
      campaignId:
          data.campaignId.present ? data.campaignId.value : this.campaignId,
      title: data.title.present ? data.title.value : this.title,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      fogMask: data.fogMask.present ? data.fogMask.value : this.fogMask,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameMap(')
          ..write('id: $id, ')
          ..write('campaignId: $campaignId, ')
          ..write('title: $title, ')
          ..write('imagePath: $imagePath, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('fogMask: $fogMask, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, campaignId, title, imagePath, width, height, fogMask, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameMap &&
          other.id == this.id &&
          other.campaignId == this.campaignId &&
          other.title == this.title &&
          other.imagePath == this.imagePath &&
          other.width == this.width &&
          other.height == this.height &&
          other.fogMask == this.fogMask &&
          other.createdAt == this.createdAt);
}

class GameMapsCompanion extends UpdateCompanion<GameMap> {
  final Value<String> id;
  final Value<String> campaignId;
  final Value<String> title;
  final Value<String> imagePath;
  final Value<int> width;
  final Value<int> height;
  final Value<String?> fogMask;
  final Value<int> createdAt;
  final Value<int> rowid;
  const GameMapsCompanion({
    this.id = const Value.absent(),
    this.campaignId = const Value.absent(),
    this.title = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.fogMask = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameMapsCompanion.insert({
    required String id,
    required String campaignId,
    required String title,
    required String imagePath,
    required int width,
    required int height,
    this.fogMask = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        campaignId = Value(campaignId),
        title = Value(title),
        imagePath = Value(imagePath),
        width = Value(width),
        height = Value(height),
        createdAt = Value(createdAt);
  static Insertable<GameMap> custom({
    Expression<String>? id,
    Expression<String>? campaignId,
    Expression<String>? title,
    Expression<String>? imagePath,
    Expression<int>? width,
    Expression<int>? height,
    Expression<String>? fogMask,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (campaignId != null) 'campaign_id': campaignId,
      if (title != null) 'title': title,
      if (imagePath != null) 'image_path': imagePath,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (fogMask != null) 'fog_mask': fogMask,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameMapsCompanion copyWith(
      {Value<String>? id,
      Value<String>? campaignId,
      Value<String>? title,
      Value<String>? imagePath,
      Value<int>? width,
      Value<int>? height,
      Value<String?>? fogMask,
      Value<int>? createdAt,
      Value<int>? rowid}) {
    return GameMapsCompanion(
      id: id ?? this.id,
      campaignId: campaignId ?? this.campaignId,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      width: width ?? this.width,
      height: height ?? this.height,
      fogMask: fogMask ?? this.fogMask,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (campaignId.present) {
      map['campaign_id'] = Variable<String>(campaignId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (fogMask.present) {
      map['fog_mask'] = Variable<String>(fogMask.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameMapsCompanion(')
          ..write('id: $id, ')
          ..write('campaignId: $campaignId, ')
          ..write('title: $title, ')
          ..write('imagePath: $imagePath, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('fogMask: $fogMask, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class MapPins extends Table with TableInfo<MapPins, MapPin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  MapPins(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _mapIdMeta = const VerificationMeta('mapId');
  late final GeneratedColumn<String> mapId = GeneratedColumn<String>(
      'map_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES game_maps(id)ON DELETE CASCADE');
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES entities(id)ON DELETE SET NULL');
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
      'x', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
      'y', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT \'default\'',
      defaultValue: const CustomExpression('\'default\''));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns =>
      [id, mapId, entityId, x, y, icon, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'map_pins';
  @override
  VerificationContext validateIntegrity(Insertable<MapPin> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('map_id')) {
      context.handle(
          _mapIdMeta, mapId.isAcceptableOrUnknown(data['map_id']!, _mapIdMeta));
    } else if (isInserting) {
      context.missing(_mapIdMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
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
  MapPin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MapPin(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      mapId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}map_id'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id']),
      x: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}x'])!,
      y: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}y'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  MapPins createAlias(String alias) {
    return MapPins(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class MapPin extends DataClass implements Insertable<MapPin> {
  final String id;
  final String mapId;
  final String? entityId;
  final double x;
  final double y;
  final String icon;
  final int createdAt;
  const MapPin(
      {required this.id,
      required this.mapId,
      this.entityId,
      required this.x,
      required this.y,
      required this.icon,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['map_id'] = Variable<String>(mapId);
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<String>(entityId);
    }
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    map['icon'] = Variable<String>(icon);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  MapPinsCompanion toCompanion(bool nullToAbsent) {
    return MapPinsCompanion(
      id: Value(id),
      mapId: Value(mapId),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      x: Value(x),
      y: Value(y),
      icon: Value(icon),
      createdAt: Value(createdAt),
    );
  }

  factory MapPin.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MapPin(
      id: serializer.fromJson<String>(json['id']),
      mapId: serializer.fromJson<String>(json['map_id']),
      entityId: serializer.fromJson<String?>(json['entity_id']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
      icon: serializer.fromJson<String>(json['icon']),
      createdAt: serializer.fromJson<int>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'map_id': serializer.toJson<String>(mapId),
      'entity_id': serializer.toJson<String?>(entityId),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
      'icon': serializer.toJson<String>(icon),
      'created_at': serializer.toJson<int>(createdAt),
    };
  }

  MapPin copyWith(
          {String? id,
          String? mapId,
          Value<String?> entityId = const Value.absent(),
          double? x,
          double? y,
          String? icon,
          int? createdAt}) =>
      MapPin(
        id: id ?? this.id,
        mapId: mapId ?? this.mapId,
        entityId: entityId.present ? entityId.value : this.entityId,
        x: x ?? this.x,
        y: y ?? this.y,
        icon: icon ?? this.icon,
        createdAt: createdAt ?? this.createdAt,
      );
  MapPin copyWithCompanion(MapPinsCompanion data) {
    return MapPin(
      id: data.id.present ? data.id.value : this.id,
      mapId: data.mapId.present ? data.mapId.value : this.mapId,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      icon: data.icon.present ? data.icon.value : this.icon,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MapPin(')
          ..write('id: $id, ')
          ..write('mapId: $mapId, ')
          ..write('entityId: $entityId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mapId, entityId, x, y, icon, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MapPin &&
          other.id == this.id &&
          other.mapId == this.mapId &&
          other.entityId == this.entityId &&
          other.x == this.x &&
          other.y == this.y &&
          other.icon == this.icon &&
          other.createdAt == this.createdAt);
}

class MapPinsCompanion extends UpdateCompanion<MapPin> {
  final Value<String> id;
  final Value<String> mapId;
  final Value<String?> entityId;
  final Value<double> x;
  final Value<double> y;
  final Value<String> icon;
  final Value<int> createdAt;
  final Value<int> rowid;
  const MapPinsCompanion({
    this.id = const Value.absent(),
    this.mapId = const Value.absent(),
    this.entityId = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.icon = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MapPinsCompanion.insert({
    required String id,
    required String mapId,
    this.entityId = const Value.absent(),
    required double x,
    required double y,
    this.icon = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        mapId = Value(mapId),
        x = Value(x),
        y = Value(y),
        createdAt = Value(createdAt);
  static Insertable<MapPin> custom({
    Expression<String>? id,
    Expression<String>? mapId,
    Expression<String>? entityId,
    Expression<double>? x,
    Expression<double>? y,
    Expression<String>? icon,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mapId != null) 'map_id': mapId,
      if (entityId != null) 'entity_id': entityId,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (icon != null) 'icon': icon,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MapPinsCompanion copyWith(
      {Value<String>? id,
      Value<String>? mapId,
      Value<String?>? entityId,
      Value<double>? x,
      Value<double>? y,
      Value<String>? icon,
      Value<int>? createdAt,
      Value<int>? rowid}) {
    return MapPinsCompanion(
      id: id ?? this.id,
      mapId: mapId ?? this.mapId,
      entityId: entityId ?? this.entityId,
      x: x ?? this.x,
      y: y ?? this.y,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mapId.present) {
      map['map_id'] = Variable<String>(mapId.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MapPinsCompanion(')
          ..write('id: $id, ')
          ..write('mapId: $mapId, ')
          ..write('entityId: $entityId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('icon: $icon, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class SessionLogs extends Table with TableInfo<SessionLogs, SessionLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SessionLogs(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _campaignIdMeta =
      const VerificationMeta('campaignId');
  late final GeneratedColumn<String> campaignId = GeneratedColumn<String>(
      'campaign_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES campaigns(id)ON DELETE CASCADE');
  static const VerificationMeta _sessionNumberMeta =
      const VerificationMeta('sessionNumber');
  late final GeneratedColumn<int> sessionNumber = GeneratedColumn<int>(
      'session_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _inGameDateMeta =
      const VerificationMeta('inGameDate');
  late final GeneratedColumn<String> inGameDate = GeneratedColumn<String>(
      'in_game_date', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _rawNotesMeta =
      const VerificationMeta('rawNotes');
  late final GeneratedColumn<String> rawNotes = GeneratedColumn<String>(
      'raw_notes', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _formattedSummaryMeta =
      const VerificationMeta('formattedSummary');
  late final GeneratedColumn<String> formattedSummary = GeneratedColumn<String>(
      'formatted_summary', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        campaignId,
        sessionNumber,
        inGameDate,
        rawNotes,
        formattedSummary,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_logs';
  @override
  VerificationContext validateIntegrity(Insertable<SessionLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('campaign_id')) {
      context.handle(
          _campaignIdMeta,
          campaignId.isAcceptableOrUnknown(
              data['campaign_id']!, _campaignIdMeta));
    } else if (isInserting) {
      context.missing(_campaignIdMeta);
    }
    if (data.containsKey('session_number')) {
      context.handle(
          _sessionNumberMeta,
          sessionNumber.isAcceptableOrUnknown(
              data['session_number']!, _sessionNumberMeta));
    } else if (isInserting) {
      context.missing(_sessionNumberMeta);
    }
    if (data.containsKey('in_game_date')) {
      context.handle(
          _inGameDateMeta,
          inGameDate.isAcceptableOrUnknown(
              data['in_game_date']!, _inGameDateMeta));
    }
    if (data.containsKey('raw_notes')) {
      context.handle(_rawNotesMeta,
          rawNotes.isAcceptableOrUnknown(data['raw_notes']!, _rawNotesMeta));
    }
    if (data.containsKey('formatted_summary')) {
      context.handle(
          _formattedSummaryMeta,
          formattedSummary.isAcceptableOrUnknown(
              data['formatted_summary']!, _formattedSummaryMeta));
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
  SessionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      campaignId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}campaign_id'])!,
      sessionNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_number'])!,
      inGameDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}in_game_date']),
      rawNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}raw_notes']),
      formattedSummary: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}formatted_summary']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  SessionLogs createAlias(String alias) {
    return SessionLogs(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class SessionLog extends DataClass implements Insertable<SessionLog> {
  final String id;
  final String campaignId;
  final int sessionNumber;
  final String? inGameDate;
  final String? rawNotes;
  final String? formattedSummary;
  final int createdAt;
  const SessionLog(
      {required this.id,
      required this.campaignId,
      required this.sessionNumber,
      this.inGameDate,
      this.rawNotes,
      this.formattedSummary,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['campaign_id'] = Variable<String>(campaignId);
    map['session_number'] = Variable<int>(sessionNumber);
    if (!nullToAbsent || inGameDate != null) {
      map['in_game_date'] = Variable<String>(inGameDate);
    }
    if (!nullToAbsent || rawNotes != null) {
      map['raw_notes'] = Variable<String>(rawNotes);
    }
    if (!nullToAbsent || formattedSummary != null) {
      map['formatted_summary'] = Variable<String>(formattedSummary);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  SessionLogsCompanion toCompanion(bool nullToAbsent) {
    return SessionLogsCompanion(
      id: Value(id),
      campaignId: Value(campaignId),
      sessionNumber: Value(sessionNumber),
      inGameDate: inGameDate == null && nullToAbsent
          ? const Value.absent()
          : Value(inGameDate),
      rawNotes: rawNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(rawNotes),
      formattedSummary: formattedSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(formattedSummary),
      createdAt: Value(createdAt),
    );
  }

  factory SessionLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionLog(
      id: serializer.fromJson<String>(json['id']),
      campaignId: serializer.fromJson<String>(json['campaign_id']),
      sessionNumber: serializer.fromJson<int>(json['session_number']),
      inGameDate: serializer.fromJson<String?>(json['in_game_date']),
      rawNotes: serializer.fromJson<String?>(json['raw_notes']),
      formattedSummary: serializer.fromJson<String?>(json['formatted_summary']),
      createdAt: serializer.fromJson<int>(json['created_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'campaign_id': serializer.toJson<String>(campaignId),
      'session_number': serializer.toJson<int>(sessionNumber),
      'in_game_date': serializer.toJson<String?>(inGameDate),
      'raw_notes': serializer.toJson<String?>(rawNotes),
      'formatted_summary': serializer.toJson<String?>(formattedSummary),
      'created_at': serializer.toJson<int>(createdAt),
    };
  }

  SessionLog copyWith(
          {String? id,
          String? campaignId,
          int? sessionNumber,
          Value<String?> inGameDate = const Value.absent(),
          Value<String?> rawNotes = const Value.absent(),
          Value<String?> formattedSummary = const Value.absent(),
          int? createdAt}) =>
      SessionLog(
        id: id ?? this.id,
        campaignId: campaignId ?? this.campaignId,
        sessionNumber: sessionNumber ?? this.sessionNumber,
        inGameDate: inGameDate.present ? inGameDate.value : this.inGameDate,
        rawNotes: rawNotes.present ? rawNotes.value : this.rawNotes,
        formattedSummary: formattedSummary.present
            ? formattedSummary.value
            : this.formattedSummary,
        createdAt: createdAt ?? this.createdAt,
      );
  SessionLog copyWithCompanion(SessionLogsCompanion data) {
    return SessionLog(
      id: data.id.present ? data.id.value : this.id,
      campaignId:
          data.campaignId.present ? data.campaignId.value : this.campaignId,
      sessionNumber: data.sessionNumber.present
          ? data.sessionNumber.value
          : this.sessionNumber,
      inGameDate:
          data.inGameDate.present ? data.inGameDate.value : this.inGameDate,
      rawNotes: data.rawNotes.present ? data.rawNotes.value : this.rawNotes,
      formattedSummary: data.formattedSummary.present
          ? data.formattedSummary.value
          : this.formattedSummary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionLog(')
          ..write('id: $id, ')
          ..write('campaignId: $campaignId, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('inGameDate: $inGameDate, ')
          ..write('rawNotes: $rawNotes, ')
          ..write('formattedSummary: $formattedSummary, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, campaignId, sessionNumber, inGameDate,
      rawNotes, formattedSummary, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionLog &&
          other.id == this.id &&
          other.campaignId == this.campaignId &&
          other.sessionNumber == this.sessionNumber &&
          other.inGameDate == this.inGameDate &&
          other.rawNotes == this.rawNotes &&
          other.formattedSummary == this.formattedSummary &&
          other.createdAt == this.createdAt);
}

class SessionLogsCompanion extends UpdateCompanion<SessionLog> {
  final Value<String> id;
  final Value<String> campaignId;
  final Value<int> sessionNumber;
  final Value<String?> inGameDate;
  final Value<String?> rawNotes;
  final Value<String?> formattedSummary;
  final Value<int> createdAt;
  final Value<int> rowid;
  const SessionLogsCompanion({
    this.id = const Value.absent(),
    this.campaignId = const Value.absent(),
    this.sessionNumber = const Value.absent(),
    this.inGameDate = const Value.absent(),
    this.rawNotes = const Value.absent(),
    this.formattedSummary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionLogsCompanion.insert({
    required String id,
    required String campaignId,
    required int sessionNumber,
    this.inGameDate = const Value.absent(),
    this.rawNotes = const Value.absent(),
    this.formattedSummary = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        campaignId = Value(campaignId),
        sessionNumber = Value(sessionNumber),
        createdAt = Value(createdAt);
  static Insertable<SessionLog> custom({
    Expression<String>? id,
    Expression<String>? campaignId,
    Expression<int>? sessionNumber,
    Expression<String>? inGameDate,
    Expression<String>? rawNotes,
    Expression<String>? formattedSummary,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (campaignId != null) 'campaign_id': campaignId,
      if (sessionNumber != null) 'session_number': sessionNumber,
      if (inGameDate != null) 'in_game_date': inGameDate,
      if (rawNotes != null) 'raw_notes': rawNotes,
      if (formattedSummary != null) 'formatted_summary': formattedSummary,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? campaignId,
      Value<int>? sessionNumber,
      Value<String?>? inGameDate,
      Value<String?>? rawNotes,
      Value<String?>? formattedSummary,
      Value<int>? createdAt,
      Value<int>? rowid}) {
    return SessionLogsCompanion(
      id: id ?? this.id,
      campaignId: campaignId ?? this.campaignId,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      inGameDate: inGameDate ?? this.inGameDate,
      rawNotes: rawNotes ?? this.rawNotes,
      formattedSummary: formattedSummary ?? this.formattedSummary,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (campaignId.present) {
      map['campaign_id'] = Variable<String>(campaignId.value);
    }
    if (sessionNumber.present) {
      map['session_number'] = Variable<int>(sessionNumber.value);
    }
    if (inGameDate.present) {
      map['in_game_date'] = Variable<String>(inGameDate.value);
    }
    if (rawNotes.present) {
      map['raw_notes'] = Variable<String>(rawNotes.value);
    }
    if (formattedSummary.present) {
      map['formatted_summary'] = Variable<String>(formattedSummary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionLogsCompanion(')
          ..write('id: $id, ')
          ..write('campaignId: $campaignId, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('inGameDate: $inGameDate, ')
          ..write('rawNotes: $rawNotes, ')
          ..write('formattedSummary: $formattedSummary, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final Campaigns campaigns = Campaigns(this);
  late final Entities entities = Entities(this);
  late final Index idxEntitiesCampaign = Index('idx_entities_campaign',
      'CREATE INDEX idx_entities_campaign ON entities (campaign_id)');
  late final Index idxEntitiesSlug = Index(
      'idx_entities_slug', 'CREATE INDEX idx_entities_slug ON entities (slug)');
  late final Index idxEntitiesType = Index(
      'idx_entities_type', 'CREATE INDEX idx_entities_type ON entities (type)');
  late final Edges edges = Edges(this);
  late final Index idxEdgesSource = Index(
      'idx_edges_source', 'CREATE INDEX idx_edges_source ON edges (source_id)');
  late final Index idxEdgesTarget = Index(
      'idx_edges_target', 'CREATE INDEX idx_edges_target ON edges (target_id)');
  late final GameMaps gameMaps = GameMaps(this);
  late final MapPins mapPins = MapPins(this);
  late final SessionLogs sessionLogs = SessionLogs(this);
  Selectable<Campaign> allCampaigns() {
    return customSelect('SELECT * FROM campaigns ORDER BY updated_at DESC',
        variables: [],
        readsFrom: {
          campaigns,
        }).asyncMap(campaigns.mapFromRow);
  }

  Selectable<Campaign> campaignById(String id) {
    return customSelect('SELECT * FROM campaigns WHERE id = ?1', variables: [
      Variable<String>(id)
    ], readsFrom: {
      campaigns,
    }).asyncMap(campaigns.mapFromRow);
  }

  Selectable<Entity> entitiesByCampaign(String campaignId) {
    return customSelect(
        'SELECT * FROM entities WHERE campaign_id = ?1 ORDER BY title',
        variables: [
          Variable<String>(campaignId)
        ],
        readsFrom: {
          entities,
        }).asyncMap(entities.mapFromRow);
  }

  Selectable<Entity> entitiesByCampaignAndType(String campaignId, String type) {
    return customSelect(
        'SELECT * FROM entities WHERE campaign_id = ?1 AND type = ?2 ORDER BY title',
        variables: [
          Variable<String>(campaignId),
          Variable<String>(type)
        ],
        readsFrom: {
          entities,
        }).asyncMap(entities.mapFromRow);
  }

  Selectable<Entity> entityById(String id) {
    return customSelect('SELECT * FROM entities WHERE id = ?1', variables: [
      Variable<String>(id)
    ], readsFrom: {
      entities,
    }).asyncMap(entities.mapFromRow);
  }

  Selectable<Entity> entityBySlug(String campaignId, String slug) {
    return customSelect(
        'SELECT * FROM entities WHERE campaign_id = ?1 AND slug = ?2',
        variables: [
          Variable<String>(campaignId),
          Variable<String>(slug)
        ],
        readsFrom: {
          entities,
        }).asyncMap(entities.mapFromRow);
  }

  Selectable<Entity> searchEntities(String campaignId, String query) {
    return customSelect(
        'SELECT * FROM entities WHERE campaign_id = ?1 AND(title LIKE \'%\' || ?2 || \'%\' OR body_content LIKE \'%\' || ?2 || \'%\')ORDER BY title',
        variables: [
          Variable<String>(campaignId),
          Variable<String>(query)
        ],
        readsFrom: {
          entities,
        }).asyncMap(entities.mapFromRow);
  }

  Selectable<Edge> edgesBySource(String sourceId) {
    return customSelect('SELECT * FROM edges WHERE source_id = ?1', variables: [
      Variable<String>(sourceId)
    ], readsFrom: {
      edges,
    }).asyncMap(edges.mapFromRow);
  }

  Selectable<Edge> edgesByTarget(String targetId) {
    return customSelect('SELECT * FROM edges WHERE target_id = ?1', variables: [
      Variable<String>(targetId)
    ], readsFrom: {
      edges,
    }).asyncMap(edges.mapFromRow);
  }

  Selectable<Edge> edgesBetween(String id1, String id2) {
    return customSelect(
        'SELECT * FROM edges WHERE(source_id = ?1 AND target_id = ?2)OR(source_id = ?2 AND target_id = ?1)',
        variables: [
          Variable<String>(id1),
          Variable<String>(id2)
        ],
        readsFrom: {
          edges,
        }).asyncMap(edges.mapFromRow);
  }

  Selectable<GameMap> mapsByCampaign(String campaignId) {
    return customSelect(
        'SELECT * FROM game_maps WHERE campaign_id = ?1 ORDER BY title',
        variables: [
          Variable<String>(campaignId)
        ],
        readsFrom: {
          gameMaps,
        }).asyncMap(gameMaps.mapFromRow);
  }

  Selectable<GameMap> mapById(String id) {
    return customSelect('SELECT * FROM game_maps WHERE id = ?1', variables: [
      Variable<String>(id)
    ], readsFrom: {
      gameMaps,
    }).asyncMap(gameMaps.mapFromRow);
  }

  Selectable<MapPin> pinsByMap(String mapId) {
    return customSelect('SELECT * FROM map_pins WHERE map_id = ?1', variables: [
      Variable<String>(mapId)
    ], readsFrom: {
      mapPins,
    }).asyncMap(mapPins.mapFromRow);
  }

  Selectable<MapPin> pinsByEntity(String? entityId) {
    return customSelect('SELECT * FROM map_pins WHERE entity_id = ?1',
        variables: [
          Variable<String>(entityId)
        ],
        readsFrom: {
          mapPins,
        }).asyncMap(mapPins.mapFromRow);
  }

  Selectable<SessionLog> sessionLogsByCampaign(String campaignId) {
    return customSelect(
        'SELECT * FROM session_logs WHERE campaign_id = ?1 ORDER BY session_number DESC',
        variables: [
          Variable<String>(campaignId)
        ],
        readsFrom: {
          sessionLogs,
        }).asyncMap(sessionLogs.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        campaigns,
        entities,
        idxEntitiesCampaign,
        idxEntitiesSlug,
        idxEntitiesType,
        edges,
        idxEdgesSource,
        idxEdgesTarget,
        gameMaps,
        mapPins,
        sessionLogs
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('campaigns',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('entities', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('edges', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('edges', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('campaigns',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('game_maps', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('game_maps',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('map_pins', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('entities',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('map_pins', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('campaigns',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('session_logs', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $CampaignsCreateCompanionBuilder = CampaignsCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<String> calendarSystem,
  Value<String?> currentInGameDate,
  required int createdAt,
  required int updatedAt,
  Value<int> rowid,
});
typedef $CampaignsUpdateCompanionBuilder = CampaignsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<String> calendarSystem,
  Value<String?> currentInGameDate,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> rowid,
});

final class $CampaignsReferences
    extends BaseReferences<_$AppDatabase, Campaigns, Campaign> {
  $CampaignsReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<Entities, List<Entity>> _entitiesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.entities,
          aliasName:
              $_aliasNameGenerator(db.campaigns.id, db.entities.campaignId));

  $EntitiesProcessedTableManager get entitiesRefs {
    final manager = $EntitiesTableManager($_db, $_db.entities)
        .filter((f) => f.campaignId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entitiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<GameMaps, List<GameMap>> _gameMapsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.gameMaps,
          aliasName:
              $_aliasNameGenerator(db.campaigns.id, db.gameMaps.campaignId));

  $GameMapsProcessedTableManager get gameMapsRefs {
    final manager = $GameMapsTableManager($_db, $_db.gameMaps)
        .filter((f) => f.campaignId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gameMapsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<SessionLogs, List<SessionLog>>
      _sessionLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.sessionLogs,
          aliasName:
              $_aliasNameGenerator(db.campaigns.id, db.sessionLogs.campaignId));

  $SessionLogsProcessedTableManager get sessionLogsRefs {
    final manager = $SessionLogsTableManager($_db, $_db.sessionLogs)
        .filter((f) => f.campaignId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $CampaignsFilterComposer extends Composer<_$AppDatabase, Campaigns> {
  $CampaignsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get calendarSystem => $composableBuilder(
      column: $table.calendarSystem,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentInGameDate => $composableBuilder(
      column: $table.currentInGameDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> entitiesRefs(
      Expression<bool> Function($EntitiesFilterComposer f) f) {
    final $EntitiesFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.campaignId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> gameMapsRefs(
      Expression<bool> Function($GameMapsFilterComposer f) f) {
    final $GameMapsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gameMaps,
        getReferencedColumn: (t) => t.campaignId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $GameMapsFilterComposer(
              $db: $db,
              $table: $db.gameMaps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> sessionLogsRefs(
      Expression<bool> Function($SessionLogsFilterComposer f) f) {
    final $SessionLogsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sessionLogs,
        getReferencedColumn: (t) => t.campaignId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $SessionLogsFilterComposer(
              $db: $db,
              $table: $db.sessionLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $CampaignsOrderingComposer extends Composer<_$AppDatabase, Campaigns> {
  $CampaignsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get calendarSystem => $composableBuilder(
      column: $table.calendarSystem,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentInGameDate => $composableBuilder(
      column: $table.currentInGameDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $CampaignsAnnotationComposer extends Composer<_$AppDatabase, Campaigns> {
  $CampaignsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get calendarSystem => $composableBuilder(
      column: $table.calendarSystem, builder: (column) => column);

  GeneratedColumn<String> get currentInGameDate => $composableBuilder(
      column: $table.currentInGameDate, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> entitiesRefs<T extends Object>(
      Expression<T> Function($EntitiesAnnotationComposer a) f) {
    final $EntitiesAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.campaignId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> gameMapsRefs<T extends Object>(
      Expression<T> Function($GameMapsAnnotationComposer a) f) {
    final $GameMapsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gameMaps,
        getReferencedColumn: (t) => t.campaignId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $GameMapsAnnotationComposer(
              $db: $db,
              $table: $db.gameMaps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> sessionLogsRefs<T extends Object>(
      Expression<T> Function($SessionLogsAnnotationComposer a) f) {
    final $SessionLogsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sessionLogs,
        getReferencedColumn: (t) => t.campaignId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $SessionLogsAnnotationComposer(
              $db: $db,
              $table: $db.sessionLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $CampaignsTableManager extends RootTableManager<
    _$AppDatabase,
    Campaigns,
    Campaign,
    $CampaignsFilterComposer,
    $CampaignsOrderingComposer,
    $CampaignsAnnotationComposer,
    $CampaignsCreateCompanionBuilder,
    $CampaignsUpdateCompanionBuilder,
    (Campaign, $CampaignsReferences),
    Campaign,
    PrefetchHooks Function(
        {bool entitiesRefs, bool gameMapsRefs, bool sessionLogsRefs})> {
  $CampaignsTableManager(_$AppDatabase db, Campaigns table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $CampaignsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $CampaignsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $CampaignsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> calendarSystem = const Value.absent(),
            Value<String?> currentInGameDate = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CampaignsCompanion(
            id: id,
            title: title,
            description: description,
            calendarSystem: calendarSystem,
            currentInGameDate: currentInGameDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String> calendarSystem = const Value.absent(),
            Value<String?> currentInGameDate = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CampaignsCompanion.insert(
            id: id,
            title: title,
            description: description,
            calendarSystem: calendarSystem,
            currentInGameDate: currentInGameDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $CampaignsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {entitiesRefs = false,
              gameMapsRefs = false,
              sessionLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (entitiesRefs) db.entities,
                if (gameMapsRefs) db.gameMaps,
                if (sessionLogsRefs) db.sessionLogs
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (entitiesRefs)
                    await $_getPrefetchedData<Campaign, Campaigns, Entity>(
                        currentTable: table,
                        referencedTable:
                            $CampaignsReferences._entitiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $CampaignsReferences(db, table, p0).entitiesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.campaignId == item.id),
                        typedResults: items),
                  if (gameMapsRefs)
                    await $_getPrefetchedData<Campaign, Campaigns, GameMap>(
                        currentTable: table,
                        referencedTable:
                            $CampaignsReferences._gameMapsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $CampaignsReferences(db, table, p0).gameMapsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.campaignId == item.id),
                        typedResults: items),
                  if (sessionLogsRefs)
                    await $_getPrefetchedData<Campaign, Campaigns, SessionLog>(
                        currentTable: table,
                        referencedTable:
                            $CampaignsReferences._sessionLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $CampaignsReferences(db, table, p0).sessionLogsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.campaignId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $CampaignsProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    Campaigns,
    Campaign,
    $CampaignsFilterComposer,
    $CampaignsOrderingComposer,
    $CampaignsAnnotationComposer,
    $CampaignsCreateCompanionBuilder,
    $CampaignsUpdateCompanionBuilder,
    (Campaign, $CampaignsReferences),
    Campaign,
    PrefetchHooks Function(
        {bool entitiesRefs, bool gameMapsRefs, bool sessionLogsRefs})>;
typedef $EntitiesCreateCompanionBuilder = EntitiesCompanion Function({
  required String id,
  required String campaignId,
  required String type,
  required String title,
  required String slug,
  Value<String?> bodyContent,
  Value<String?> publicDescription,
  Value<String?> metadata,
  Value<String?> tags,
  Value<double> completenessScore,
  Value<bool> isRevealed,
  required int createdAt,
  required int updatedAt,
  Value<int> rowid,
});
typedef $EntitiesUpdateCompanionBuilder = EntitiesCompanion Function({
  Value<String> id,
  Value<String> campaignId,
  Value<String> type,
  Value<String> title,
  Value<String> slug,
  Value<String?> bodyContent,
  Value<String?> publicDescription,
  Value<String?> metadata,
  Value<String?> tags,
  Value<double> completenessScore,
  Value<bool> isRevealed,
  Value<int> createdAt,
  Value<int> updatedAt,
  Value<int> rowid,
});

final class $EntitiesReferences
    extends BaseReferences<_$AppDatabase, Entities, Entity> {
  $EntitiesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Campaigns _campaignIdTable(_$AppDatabase db) =>
      db.campaigns.createAlias(
          $_aliasNameGenerator(db.entities.campaignId, db.campaigns.id));

  $CampaignsProcessedTableManager get campaignId {
    final $_column = $_itemColumn<String>('campaign_id')!;

    final manager = $CampaignsTableManager($_db, $_db.campaigns)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_campaignIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<MapPins, List<MapPin>> _mapPinsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.mapPins,
          aliasName: $_aliasNameGenerator(db.entities.id, db.mapPins.entityId));

  $MapPinsProcessedTableManager get mapPinsRefs {
    final manager = $MapPinsTableManager($_db, $_db.mapPins)
        .filter((f) => f.entityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mapPinsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $EntitiesFilterComposer extends Composer<_$AppDatabase, Entities> {
  $EntitiesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bodyContent => $composableBuilder(
      column: $table.bodyContent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get publicDescription => $composableBuilder(
      column: $table.publicDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get completenessScore => $composableBuilder(
      column: $table.completenessScore,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRevealed => $composableBuilder(
      column: $table.isRevealed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $CampaignsFilterComposer get campaignId {
    final $CampaignsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.campaignId,
        referencedTable: $db.campaigns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CampaignsFilterComposer(
              $db: $db,
              $table: $db.campaigns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> mapPinsRefs(
      Expression<bool> Function($MapPinsFilterComposer f) f) {
    final $MapPinsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mapPins,
        getReferencedColumn: (t) => t.entityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $MapPinsFilterComposer(
              $db: $db,
              $table: $db.mapPins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $EntitiesOrderingComposer extends Composer<_$AppDatabase, Entities> {
  $EntitiesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slug => $composableBuilder(
      column: $table.slug, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bodyContent => $composableBuilder(
      column: $table.bodyContent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get publicDescription => $composableBuilder(
      column: $table.publicDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get completenessScore => $composableBuilder(
      column: $table.completenessScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRevealed => $composableBuilder(
      column: $table.isRevealed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $CampaignsOrderingComposer get campaignId {
    final $CampaignsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.campaignId,
        referencedTable: $db.campaigns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CampaignsOrderingComposer(
              $db: $db,
              $table: $db.campaigns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $EntitiesAnnotationComposer extends Composer<_$AppDatabase, Entities> {
  $EntitiesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get bodyContent => $composableBuilder(
      column: $table.bodyContent, builder: (column) => column);

  GeneratedColumn<String> get publicDescription => $composableBuilder(
      column: $table.publicDescription, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<double> get completenessScore => $composableBuilder(
      column: $table.completenessScore, builder: (column) => column);

  GeneratedColumn<bool> get isRevealed => $composableBuilder(
      column: $table.isRevealed, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $CampaignsAnnotationComposer get campaignId {
    final $CampaignsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.campaignId,
        referencedTable: $db.campaigns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CampaignsAnnotationComposer(
              $db: $db,
              $table: $db.campaigns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> mapPinsRefs<T extends Object>(
      Expression<T> Function($MapPinsAnnotationComposer a) f) {
    final $MapPinsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mapPins,
        getReferencedColumn: (t) => t.entityId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $MapPinsAnnotationComposer(
              $db: $db,
              $table: $db.mapPins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $EntitiesTableManager extends RootTableManager<
    _$AppDatabase,
    Entities,
    Entity,
    $EntitiesFilterComposer,
    $EntitiesOrderingComposer,
    $EntitiesAnnotationComposer,
    $EntitiesCreateCompanionBuilder,
    $EntitiesUpdateCompanionBuilder,
    (Entity, $EntitiesReferences),
    Entity,
    PrefetchHooks Function({bool campaignId, bool mapPinsRefs})> {
  $EntitiesTableManager(_$AppDatabase db, Entities table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $EntitiesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $EntitiesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $EntitiesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> campaignId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> slug = const Value.absent(),
            Value<String?> bodyContent = const Value.absent(),
            Value<String?> publicDescription = const Value.absent(),
            Value<String?> metadata = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<double> completenessScore = const Value.absent(),
            Value<bool> isRevealed = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EntitiesCompanion(
            id: id,
            campaignId: campaignId,
            type: type,
            title: title,
            slug: slug,
            bodyContent: bodyContent,
            publicDescription: publicDescription,
            metadata: metadata,
            tags: tags,
            completenessScore: completenessScore,
            isRevealed: isRevealed,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String campaignId,
            required String type,
            required String title,
            required String slug,
            Value<String?> bodyContent = const Value.absent(),
            Value<String?> publicDescription = const Value.absent(),
            Value<String?> metadata = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<double> completenessScore = const Value.absent(),
            Value<bool> isRevealed = const Value.absent(),
            required int createdAt,
            required int updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              EntitiesCompanion.insert(
            id: id,
            campaignId: campaignId,
            type: type,
            title: title,
            slug: slug,
            bodyContent: bodyContent,
            publicDescription: publicDescription,
            metadata: metadata,
            tags: tags,
            completenessScore: completenessScore,
            isRevealed: isRevealed,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $EntitiesReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({campaignId = false, mapPinsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (mapPinsRefs) db.mapPins],
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
                if (campaignId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.campaignId,
                    referencedTable: $EntitiesReferences._campaignIdTable(db),
                    referencedColumn:
                        $EntitiesReferences._campaignIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mapPinsRefs)
                    await $_getPrefetchedData<Entity, Entities, MapPin>(
                        currentTable: table,
                        referencedTable:
                            $EntitiesReferences._mapPinsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $EntitiesReferences(db, table, p0).mapPinsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.entityId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $EntitiesProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    Entities,
    Entity,
    $EntitiesFilterComposer,
    $EntitiesOrderingComposer,
    $EntitiesAnnotationComposer,
    $EntitiesCreateCompanionBuilder,
    $EntitiesUpdateCompanionBuilder,
    (Entity, $EntitiesReferences),
    Entity,
    PrefetchHooks Function({bool campaignId, bool mapPinsRefs})>;
typedef $EdgesCreateCompanionBuilder = EdgesCompanion Function({
  required String id,
  required String sourceId,
  required String targetId,
  required String edgeType,
  required int createdAt,
  Value<int> rowid,
});
typedef $EdgesUpdateCompanionBuilder = EdgesCompanion Function({
  Value<String> id,
  Value<String> sourceId,
  Value<String> targetId,
  Value<String> edgeType,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $EdgesReferences
    extends BaseReferences<_$AppDatabase, Edges, Edge> {
  $EdgesReferences(super.$_db, super.$_table, super.$_typedResult);

  static Entities _sourceIdTable(_$AppDatabase db) => db.entities
      .createAlias($_aliasNameGenerator(db.edges.sourceId, db.entities.id));

  $EntitiesProcessedTableManager get sourceId {
    final $_column = $_itemColumn<String>('source_id')!;

    final manager = $EntitiesTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static Entities _targetIdTable(_$AppDatabase db) => db.entities
      .createAlias($_aliasNameGenerator(db.edges.targetId, db.entities.id));

  $EntitiesProcessedTableManager get targetId {
    final $_column = $_itemColumn<String>('target_id')!;

    final manager = $EntitiesTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $EdgesFilterComposer extends Composer<_$AppDatabase, Edges> {
  $EdgesFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get edgeType => $composableBuilder(
      column: $table.edgeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $EntitiesFilterComposer get sourceId {
    final $EntitiesFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $EntitiesFilterComposer get targetId {
    final $EntitiesFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.targetId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $EdgesOrderingComposer extends Composer<_$AppDatabase, Edges> {
  $EdgesOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get edgeType => $composableBuilder(
      column: $table.edgeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $EntitiesOrderingComposer get sourceId {
    final $EntitiesOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $EntitiesOrderingComposer get targetId {
    final $EntitiesOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.targetId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $EdgesAnnotationComposer extends Composer<_$AppDatabase, Edges> {
  $EdgesAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get edgeType =>
      $composableBuilder(column: $table.edgeType, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $EntitiesAnnotationComposer get sourceId {
    final $EntitiesAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sourceId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $EntitiesAnnotationComposer get targetId {
    final $EntitiesAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.targetId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $EdgesTableManager extends RootTableManager<
    _$AppDatabase,
    Edges,
    Edge,
    $EdgesFilterComposer,
    $EdgesOrderingComposer,
    $EdgesAnnotationComposer,
    $EdgesCreateCompanionBuilder,
    $EdgesUpdateCompanionBuilder,
    (Edge, $EdgesReferences),
    Edge,
    PrefetchHooks Function({bool sourceId, bool targetId})> {
  $EdgesTableManager(_$AppDatabase db, Edges table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $EdgesFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $EdgesOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $EdgesAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> sourceId = const Value.absent(),
            Value<String> targetId = const Value.absent(),
            Value<String> edgeType = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EdgesCompanion(
            id: id,
            sourceId: sourceId,
            targetId: targetId,
            edgeType: edgeType,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String sourceId,
            required String targetId,
            required String edgeType,
            required int createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              EdgesCompanion.insert(
            id: id,
            sourceId: sourceId,
            targetId: targetId,
            edgeType: edgeType,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), $EdgesReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({sourceId = false, targetId = false}) {
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
                if (sourceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sourceId,
                    referencedTable: $EdgesReferences._sourceIdTable(db),
                    referencedColumn: $EdgesReferences._sourceIdTable(db).id,
                  ) as T;
                }
                if (targetId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.targetId,
                    referencedTable: $EdgesReferences._targetIdTable(db),
                    referencedColumn: $EdgesReferences._targetIdTable(db).id,
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

typedef $EdgesProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    Edges,
    Edge,
    $EdgesFilterComposer,
    $EdgesOrderingComposer,
    $EdgesAnnotationComposer,
    $EdgesCreateCompanionBuilder,
    $EdgesUpdateCompanionBuilder,
    (Edge, $EdgesReferences),
    Edge,
    PrefetchHooks Function({bool sourceId, bool targetId})>;
typedef $GameMapsCreateCompanionBuilder = GameMapsCompanion Function({
  required String id,
  required String campaignId,
  required String title,
  required String imagePath,
  required int width,
  required int height,
  Value<String?> fogMask,
  required int createdAt,
  Value<int> rowid,
});
typedef $GameMapsUpdateCompanionBuilder = GameMapsCompanion Function({
  Value<String> id,
  Value<String> campaignId,
  Value<String> title,
  Value<String> imagePath,
  Value<int> width,
  Value<int> height,
  Value<String?> fogMask,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $GameMapsReferences
    extends BaseReferences<_$AppDatabase, GameMaps, GameMap> {
  $GameMapsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Campaigns _campaignIdTable(_$AppDatabase db) =>
      db.campaigns.createAlias(
          $_aliasNameGenerator(db.gameMaps.campaignId, db.campaigns.id));

  $CampaignsProcessedTableManager get campaignId {
    final $_column = $_itemColumn<String>('campaign_id')!;

    final manager = $CampaignsTableManager($_db, $_db.campaigns)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_campaignIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<MapPins, List<MapPin>> _mapPinsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.mapPins,
          aliasName: $_aliasNameGenerator(db.gameMaps.id, db.mapPins.mapId));

  $MapPinsProcessedTableManager get mapPinsRefs {
    final manager = $MapPinsTableManager($_db, $_db.mapPins)
        .filter((f) => f.mapId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_mapPinsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $GameMapsFilterComposer extends Composer<_$AppDatabase, GameMaps> {
  $GameMapsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fogMask => $composableBuilder(
      column: $table.fogMask, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $CampaignsFilterComposer get campaignId {
    final $CampaignsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.campaignId,
        referencedTable: $db.campaigns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CampaignsFilterComposer(
              $db: $db,
              $table: $db.campaigns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> mapPinsRefs(
      Expression<bool> Function($MapPinsFilterComposer f) f) {
    final $MapPinsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mapPins,
        getReferencedColumn: (t) => t.mapId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $MapPinsFilterComposer(
              $db: $db,
              $table: $db.mapPins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $GameMapsOrderingComposer extends Composer<_$AppDatabase, GameMaps> {
  $GameMapsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fogMask => $composableBuilder(
      column: $table.fogMask, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $CampaignsOrderingComposer get campaignId {
    final $CampaignsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.campaignId,
        referencedTable: $db.campaigns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CampaignsOrderingComposer(
              $db: $db,
              $table: $db.campaigns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $GameMapsAnnotationComposer extends Composer<_$AppDatabase, GameMaps> {
  $GameMapsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get fogMask =>
      $composableBuilder(column: $table.fogMask, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $CampaignsAnnotationComposer get campaignId {
    final $CampaignsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.campaignId,
        referencedTable: $db.campaigns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CampaignsAnnotationComposer(
              $db: $db,
              $table: $db.campaigns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> mapPinsRefs<T extends Object>(
      Expression<T> Function($MapPinsAnnotationComposer a) f) {
    final $MapPinsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.mapPins,
        getReferencedColumn: (t) => t.mapId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $MapPinsAnnotationComposer(
              $db: $db,
              $table: $db.mapPins,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $GameMapsTableManager extends RootTableManager<
    _$AppDatabase,
    GameMaps,
    GameMap,
    $GameMapsFilterComposer,
    $GameMapsOrderingComposer,
    $GameMapsAnnotationComposer,
    $GameMapsCreateCompanionBuilder,
    $GameMapsUpdateCompanionBuilder,
    (GameMap, $GameMapsReferences),
    GameMap,
    PrefetchHooks Function({bool campaignId, bool mapPinsRefs})> {
  $GameMapsTableManager(_$AppDatabase db, GameMaps table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $GameMapsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $GameMapsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $GameMapsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> campaignId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<int> width = const Value.absent(),
            Value<int> height = const Value.absent(),
            Value<String?> fogMask = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GameMapsCompanion(
            id: id,
            campaignId: campaignId,
            title: title,
            imagePath: imagePath,
            width: width,
            height: height,
            fogMask: fogMask,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String campaignId,
            required String title,
            required String imagePath,
            required int width,
            required int height,
            Value<String?> fogMask = const Value.absent(),
            required int createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              GameMapsCompanion.insert(
            id: id,
            campaignId: campaignId,
            title: title,
            imagePath: imagePath,
            width: width,
            height: height,
            fogMask: fogMask,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $GameMapsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({campaignId = false, mapPinsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (mapPinsRefs) db.mapPins],
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
                if (campaignId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.campaignId,
                    referencedTable: $GameMapsReferences._campaignIdTable(db),
                    referencedColumn:
                        $GameMapsReferences._campaignIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mapPinsRefs)
                    await $_getPrefetchedData<GameMap, GameMaps, MapPin>(
                        currentTable: table,
                        referencedTable:
                            $GameMapsReferences._mapPinsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $GameMapsReferences(db, table, p0).mapPinsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.mapId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $GameMapsProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    GameMaps,
    GameMap,
    $GameMapsFilterComposer,
    $GameMapsOrderingComposer,
    $GameMapsAnnotationComposer,
    $GameMapsCreateCompanionBuilder,
    $GameMapsUpdateCompanionBuilder,
    (GameMap, $GameMapsReferences),
    GameMap,
    PrefetchHooks Function({bool campaignId, bool mapPinsRefs})>;
typedef $MapPinsCreateCompanionBuilder = MapPinsCompanion Function({
  required String id,
  required String mapId,
  Value<String?> entityId,
  required double x,
  required double y,
  Value<String> icon,
  required int createdAt,
  Value<int> rowid,
});
typedef $MapPinsUpdateCompanionBuilder = MapPinsCompanion Function({
  Value<String> id,
  Value<String> mapId,
  Value<String?> entityId,
  Value<double> x,
  Value<double> y,
  Value<String> icon,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $MapPinsReferences
    extends BaseReferences<_$AppDatabase, MapPins, MapPin> {
  $MapPinsReferences(super.$_db, super.$_table, super.$_typedResult);

  static GameMaps _mapIdTable(_$AppDatabase db) => db.gameMaps
      .createAlias($_aliasNameGenerator(db.mapPins.mapId, db.gameMaps.id));

  $GameMapsProcessedTableManager get mapId {
    final $_column = $_itemColumn<String>('map_id')!;

    final manager = $GameMapsTableManager($_db, $_db.gameMaps)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mapIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static Entities _entityIdTable(_$AppDatabase db) => db.entities
      .createAlias($_aliasNameGenerator(db.mapPins.entityId, db.entities.id));

  $EntitiesProcessedTableManager? get entityId {
    final $_column = $_itemColumn<String>('entity_id');
    if ($_column == null) return null;
    final manager = $EntitiesTableManager($_db, $_db.entities)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $MapPinsFilterComposer extends Composer<_$AppDatabase, MapPins> {
  $MapPinsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $GameMapsFilterComposer get mapId {
    final $GameMapsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.mapId,
        referencedTable: $db.gameMaps,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $GameMapsFilterComposer(
              $db: $db,
              $table: $db.gameMaps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $EntitiesFilterComposer get entityId {
    final $EntitiesFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesFilterComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $MapPinsOrderingComposer extends Composer<_$AppDatabase, MapPins> {
  $MapPinsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get x => $composableBuilder(
      column: $table.x, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get y => $composableBuilder(
      column: $table.y, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $GameMapsOrderingComposer get mapId {
    final $GameMapsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.mapId,
        referencedTable: $db.gameMaps,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $GameMapsOrderingComposer(
              $db: $db,
              $table: $db.gameMaps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $EntitiesOrderingComposer get entityId {
    final $EntitiesOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesOrderingComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $MapPinsAnnotationComposer extends Composer<_$AppDatabase, MapPins> {
  $MapPinsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $GameMapsAnnotationComposer get mapId {
    final $GameMapsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.mapId,
        referencedTable: $db.gameMaps,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $GameMapsAnnotationComposer(
              $db: $db,
              $table: $db.gameMaps,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $EntitiesAnnotationComposer get entityId {
    final $EntitiesAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.entityId,
        referencedTable: $db.entities,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $EntitiesAnnotationComposer(
              $db: $db,
              $table: $db.entities,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $MapPinsTableManager extends RootTableManager<
    _$AppDatabase,
    MapPins,
    MapPin,
    $MapPinsFilterComposer,
    $MapPinsOrderingComposer,
    $MapPinsAnnotationComposer,
    $MapPinsCreateCompanionBuilder,
    $MapPinsUpdateCompanionBuilder,
    (MapPin, $MapPinsReferences),
    MapPin,
    PrefetchHooks Function({bool mapId, bool entityId})> {
  $MapPinsTableManager(_$AppDatabase db, MapPins table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $MapPinsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $MapPinsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $MapPinsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> mapId = const Value.absent(),
            Value<String?> entityId = const Value.absent(),
            Value<double> x = const Value.absent(),
            Value<double> y = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MapPinsCompanion(
            id: id,
            mapId: mapId,
            entityId: entityId,
            x: x,
            y: y,
            icon: icon,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String mapId,
            Value<String?> entityId = const Value.absent(),
            required double x,
            required double y,
            Value<String> icon = const Value.absent(),
            required int createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              MapPinsCompanion.insert(
            id: id,
            mapId: mapId,
            entityId: entityId,
            x: x,
            y: y,
            icon: icon,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map(
                  (e) => (e.readTable(table), $MapPinsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({mapId = false, entityId = false}) {
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
                if (mapId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.mapId,
                    referencedTable: $MapPinsReferences._mapIdTable(db),
                    referencedColumn: $MapPinsReferences._mapIdTable(db).id,
                  ) as T;
                }
                if (entityId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.entityId,
                    referencedTable: $MapPinsReferences._entityIdTable(db),
                    referencedColumn: $MapPinsReferences._entityIdTable(db).id,
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

typedef $MapPinsProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    MapPins,
    MapPin,
    $MapPinsFilterComposer,
    $MapPinsOrderingComposer,
    $MapPinsAnnotationComposer,
    $MapPinsCreateCompanionBuilder,
    $MapPinsUpdateCompanionBuilder,
    (MapPin, $MapPinsReferences),
    MapPin,
    PrefetchHooks Function({bool mapId, bool entityId})>;
typedef $SessionLogsCreateCompanionBuilder = SessionLogsCompanion Function({
  required String id,
  required String campaignId,
  required int sessionNumber,
  Value<String?> inGameDate,
  Value<String?> rawNotes,
  Value<String?> formattedSummary,
  required int createdAt,
  Value<int> rowid,
});
typedef $SessionLogsUpdateCompanionBuilder = SessionLogsCompanion Function({
  Value<String> id,
  Value<String> campaignId,
  Value<int> sessionNumber,
  Value<String?> inGameDate,
  Value<String?> rawNotes,
  Value<String?> formattedSummary,
  Value<int> createdAt,
  Value<int> rowid,
});

final class $SessionLogsReferences
    extends BaseReferences<_$AppDatabase, SessionLogs, SessionLog> {
  $SessionLogsReferences(super.$_db, super.$_table, super.$_typedResult);

  static Campaigns _campaignIdTable(_$AppDatabase db) =>
      db.campaigns.createAlias(
          $_aliasNameGenerator(db.sessionLogs.campaignId, db.campaigns.id));

  $CampaignsProcessedTableManager get campaignId {
    final $_column = $_itemColumn<String>('campaign_id')!;

    final manager = $CampaignsTableManager($_db, $_db.campaigns)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_campaignIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $SessionLogsFilterComposer extends Composer<_$AppDatabase, SessionLogs> {
  $SessionLogsFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sessionNumber => $composableBuilder(
      column: $table.sessionNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inGameDate => $composableBuilder(
      column: $table.inGameDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rawNotes => $composableBuilder(
      column: $table.rawNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formattedSummary => $composableBuilder(
      column: $table.formattedSummary,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $CampaignsFilterComposer get campaignId {
    final $CampaignsFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.campaignId,
        referencedTable: $db.campaigns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CampaignsFilterComposer(
              $db: $db,
              $table: $db.campaigns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $SessionLogsOrderingComposer
    extends Composer<_$AppDatabase, SessionLogs> {
  $SessionLogsOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionNumber => $composableBuilder(
      column: $table.sessionNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inGameDate => $composableBuilder(
      column: $table.inGameDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rawNotes => $composableBuilder(
      column: $table.rawNotes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formattedSummary => $composableBuilder(
      column: $table.formattedSummary,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $CampaignsOrderingComposer get campaignId {
    final $CampaignsOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.campaignId,
        referencedTable: $db.campaigns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CampaignsOrderingComposer(
              $db: $db,
              $table: $db.campaigns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $SessionLogsAnnotationComposer
    extends Composer<_$AppDatabase, SessionLogs> {
  $SessionLogsAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sessionNumber => $composableBuilder(
      column: $table.sessionNumber, builder: (column) => column);

  GeneratedColumn<String> get inGameDate => $composableBuilder(
      column: $table.inGameDate, builder: (column) => column);

  GeneratedColumn<String> get rawNotes =>
      $composableBuilder(column: $table.rawNotes, builder: (column) => column);

  GeneratedColumn<String> get formattedSummary => $composableBuilder(
      column: $table.formattedSummary, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $CampaignsAnnotationComposer get campaignId {
    final $CampaignsAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.campaignId,
        referencedTable: $db.campaigns,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $CampaignsAnnotationComposer(
              $db: $db,
              $table: $db.campaigns,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $SessionLogsTableManager extends RootTableManager<
    _$AppDatabase,
    SessionLogs,
    SessionLog,
    $SessionLogsFilterComposer,
    $SessionLogsOrderingComposer,
    $SessionLogsAnnotationComposer,
    $SessionLogsCreateCompanionBuilder,
    $SessionLogsUpdateCompanionBuilder,
    (SessionLog, $SessionLogsReferences),
    SessionLog,
    PrefetchHooks Function({bool campaignId})> {
  $SessionLogsTableManager(_$AppDatabase db, SessionLogs table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $SessionLogsFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $SessionLogsOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $SessionLogsAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> campaignId = const Value.absent(),
            Value<int> sessionNumber = const Value.absent(),
            Value<String?> inGameDate = const Value.absent(),
            Value<String?> rawNotes = const Value.absent(),
            Value<String?> formattedSummary = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionLogsCompanion(
            id: id,
            campaignId: campaignId,
            sessionNumber: sessionNumber,
            inGameDate: inGameDate,
            rawNotes: rawNotes,
            formattedSummary: formattedSummary,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String campaignId,
            required int sessionNumber,
            Value<String?> inGameDate = const Value.absent(),
            Value<String?> rawNotes = const Value.absent(),
            Value<String?> formattedSummary = const Value.absent(),
            required int createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SessionLogsCompanion.insert(
            id: id,
            campaignId: campaignId,
            sessionNumber: sessionNumber,
            inGameDate: inGameDate,
            rawNotes: rawNotes,
            formattedSummary: formattedSummary,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $SessionLogsReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({campaignId = false}) {
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
                if (campaignId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.campaignId,
                    referencedTable:
                        $SessionLogsReferences._campaignIdTable(db),
                    referencedColumn:
                        $SessionLogsReferences._campaignIdTable(db).id,
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

typedef $SessionLogsProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    SessionLogs,
    SessionLog,
    $SessionLogsFilterComposer,
    $SessionLogsOrderingComposer,
    $SessionLogsAnnotationComposer,
    $SessionLogsCreateCompanionBuilder,
    $SessionLogsUpdateCompanionBuilder,
    (SessionLog, $SessionLogsReferences),
    SessionLog,
    PrefetchHooks Function({bool campaignId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $CampaignsTableManager get campaigns =>
      $CampaignsTableManager(_db, _db.campaigns);
  $EntitiesTableManager get entities =>
      $EntitiesTableManager(_db, _db.entities);
  $EdgesTableManager get edges => $EdgesTableManager(_db, _db.edges);
  $GameMapsTableManager get gameMaps =>
      $GameMapsTableManager(_db, _db.gameMaps);
  $MapPinsTableManager get mapPins => $MapPinsTableManager(_db, _db.mapPins);
  $SessionLogsTableManager get sessionLogs =>
      $SessionLogsTableManager(_db, _db.sessionLogs);
}
