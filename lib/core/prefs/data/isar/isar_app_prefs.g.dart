// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_app_prefs.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarAppPrefsCollection on Isar {
  IsarCollection<IsarAppPrefs> get isarAppPrefs => this.collection();
}

const IsarAppPrefsSchema = CollectionSchema(
  name: r'IsarAppPrefs',
  id: 6241086163308878808,
  properties: {
    r'notificationsEnabled': PropertySchema(
      id: 0,
      name: r'notificationsEnabled',
      type: IsarType.bool,
    ),
    r'notificationsPermissionAsked': PropertySchema(
      id: 1,
      name: r'notificationsPermissionAsked',
      type: IsarType.bool,
    ),
    r'onboardingCompleted': PropertySchema(
      id: 2,
      name: r'onboardingCompleted',
      type: IsarType.bool,
    ),
    r'onboardingNotificationsStepCompleted': PropertySchema(
      id: 3,
      name: r'onboardingNotificationsStepCompleted',
      type: IsarType.bool,
    ),
    r'onboardingWelcomeStepCompleted': PropertySchema(
      id: 4,
      name: r'onboardingWelcomeStepCompleted',
      type: IsarType.bool,
    ),
    r'starterHabitsCreated': PropertySchema(
      id: 5,
      name: r'starterHabitsCreated',
      type: IsarType.bool,
    ),
    r'updatedAt': PropertySchema(
      id: 6,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _isarAppPrefsEstimateSize,
  serialize: _isarAppPrefsSerialize,
  deserialize: _isarAppPrefsDeserialize,
  deserializeProp: _isarAppPrefsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarAppPrefsGetId,
  getLinks: _isarAppPrefsGetLinks,
  attach: _isarAppPrefsAttach,
  version: '3.1.0+1',
);

int _isarAppPrefsEstimateSize(
  IsarAppPrefs object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarAppPrefsSerialize(
  IsarAppPrefs object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.notificationsEnabled);
  writer.writeBool(offsets[1], object.notificationsPermissionAsked);
  writer.writeBool(offsets[2], object.onboardingCompleted);
  writer.writeBool(offsets[3], object.onboardingNotificationsStepCompleted);
  writer.writeBool(offsets[4], object.onboardingWelcomeStepCompleted);
  writer.writeBool(offsets[5], object.starterHabitsCreated);
  writer.writeDateTime(offsets[6], object.updatedAt);
}

IsarAppPrefs _isarAppPrefsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarAppPrefs();
  object.id = id;
  object.notificationsEnabled = reader.readBool(offsets[0]);
  object.notificationsPermissionAsked = reader.readBool(offsets[1]);
  object.onboardingCompleted = reader.readBool(offsets[2]);
  object.onboardingNotificationsStepCompleted = reader.readBool(offsets[3]);
  object.onboardingWelcomeStepCompleted = reader.readBool(offsets[4]);
  object.starterHabitsCreated = reader.readBool(offsets[5]);
  object.updatedAt = reader.readDateTime(offsets[6]);
  return object;
}

P _isarAppPrefsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarAppPrefsGetId(IsarAppPrefs object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarAppPrefsGetLinks(IsarAppPrefs object) {
  return [];
}

void _isarAppPrefsAttach(
    IsarCollection<dynamic> col, Id id, IsarAppPrefs object) {
  object.id = id;
}

extension IsarAppPrefsQueryWhereSort
    on QueryBuilder<IsarAppPrefs, IsarAppPrefs, QWhere> {
  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarAppPrefsQueryWhere
    on QueryBuilder<IsarAppPrefs, IsarAppPrefs, QWhereClause> {
  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarAppPrefsQueryFilter
    on QueryBuilder<IsarAppPrefs, IsarAppPrefs, QFilterCondition> {
  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      notificationsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationsEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      notificationsPermissionAskedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationsPermissionAsked',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      onboardingCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboardingCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      onboardingNotificationsStepCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboardingNotificationsStepCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      onboardingWelcomeStepCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboardingWelcomeStepCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      starterHabitsCreatedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'starterHabitsCreated',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarAppPrefsQueryObject
    on QueryBuilder<IsarAppPrefs, IsarAppPrefs, QFilterCondition> {}

extension IsarAppPrefsQueryLinks
    on QueryBuilder<IsarAppPrefs, IsarAppPrefs, QFilterCondition> {}

extension IsarAppPrefsQuerySortBy
    on QueryBuilder<IsarAppPrefs, IsarAppPrefs, QSortBy> {
  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByNotificationsPermissionAsked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsPermissionAsked', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByNotificationsPermissionAskedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsPermissionAsked', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByOnboardingNotificationsStepCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingNotificationsStepCompleted', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByOnboardingNotificationsStepCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'onboardingNotificationsStepCompleted', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByOnboardingWelcomeStepCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingWelcomeStepCompleted', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByOnboardingWelcomeStepCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingWelcomeStepCompleted', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByStarterHabitsCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starterHabitsCreated', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      sortByStarterHabitsCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starterHabitsCreated', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarAppPrefsQuerySortThenBy
    on QueryBuilder<IsarAppPrefs, IsarAppPrefs, QSortThenBy> {
  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByNotificationsPermissionAsked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsPermissionAsked', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByNotificationsPermissionAskedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsPermissionAsked', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByOnboardingNotificationsStepCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingNotificationsStepCompleted', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByOnboardingNotificationsStepCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
          r'onboardingNotificationsStepCompleted', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByOnboardingWelcomeStepCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingWelcomeStepCompleted', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByOnboardingWelcomeStepCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingWelcomeStepCompleted', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByStarterHabitsCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starterHabitsCreated', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy>
      thenByStarterHabitsCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starterHabitsCreated', Sort.desc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarAppPrefsQueryWhereDistinct
    on QueryBuilder<IsarAppPrefs, IsarAppPrefs, QDistinct> {
  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QDistinct>
      distinctByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationsEnabled');
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QDistinct>
      distinctByNotificationsPermissionAsked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationsPermissionAsked');
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QDistinct>
      distinctByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingCompleted');
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QDistinct>
      distinctByOnboardingNotificationsStepCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingNotificationsStepCompleted');
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QDistinct>
      distinctByOnboardingWelcomeStepCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingWelcomeStepCompleted');
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QDistinct>
      distinctByStarterHabitsCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'starterHabitsCreated');
    });
  }

  QueryBuilder<IsarAppPrefs, IsarAppPrefs, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension IsarAppPrefsQueryProperty
    on QueryBuilder<IsarAppPrefs, IsarAppPrefs, QQueryProperty> {
  QueryBuilder<IsarAppPrefs, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarAppPrefs, bool, QQueryOperations>
      notificationsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationsEnabled');
    });
  }

  QueryBuilder<IsarAppPrefs, bool, QQueryOperations>
      notificationsPermissionAskedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationsPermissionAsked');
    });
  }

  QueryBuilder<IsarAppPrefs, bool, QQueryOperations>
      onboardingCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingCompleted');
    });
  }

  QueryBuilder<IsarAppPrefs, bool, QQueryOperations>
      onboardingNotificationsStepCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingNotificationsStepCompleted');
    });
  }

  QueryBuilder<IsarAppPrefs, bool, QQueryOperations>
      onboardingWelcomeStepCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingWelcomeStepCompleted');
    });
  }

  QueryBuilder<IsarAppPrefs, bool, QQueryOperations>
      starterHabitsCreatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'starterHabitsCreated');
    });
  }

  QueryBuilder<IsarAppPrefs, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
