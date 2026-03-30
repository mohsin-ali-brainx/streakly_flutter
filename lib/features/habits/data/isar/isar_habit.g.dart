// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_habit.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarHabitCollection on Isar {
  IsarCollection<IsarHabit> get isarHabits => this.collection();
}

const IsarHabitSchema = CollectionSchema(
  name: r'IsarHabit',
  id: 3986760503176683818,
  properties: {
    r'archived': PropertySchema(
      id: 0,
      name: r'archived',
      type: IsarType.bool,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'iconKey': PropertySchema(
      id: 2,
      name: r'iconKey',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'reminderEnabled': PropertySchema(
      id: 4,
      name: r'reminderEnabled',
      type: IsarType.bool,
    ),
    r'reminderTimeMinutes': PropertySchema(
      id: 5,
      name: r'reminderTimeMinutes',
      type: IsarType.long,
    )
  },
  estimateSize: _isarHabitEstimateSize,
  serialize: _isarHabitSerialize,
  deserialize: _isarHabitDeserialize,
  deserializeProp: _isarHabitDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarHabitGetId,
  getLinks: _isarHabitGetLinks,
  attach: _isarHabitAttach,
  version: '3.1.0+1',
);

int _isarHabitEstimateSize(
  IsarHabit object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.iconKey.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _isarHabitSerialize(
  IsarHabit object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.archived);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.iconKey);
  writer.writeString(offsets[3], object.name);
  writer.writeBool(offsets[4], object.reminderEnabled);
  writer.writeLong(offsets[5], object.reminderTimeMinutes);
}

IsarHabit _isarHabitDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarHabit();
  object.archived = reader.readBool(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.iconKey = reader.readString(offsets[2]);
  object.id = id;
  object.name = reader.readString(offsets[3]);
  object.reminderEnabled = reader.readBool(offsets[4]);
  object.reminderTimeMinutes = reader.readLongOrNull(offsets[5]);
  return object;
}

P _isarHabitDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarHabitGetId(IsarHabit object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarHabitGetLinks(IsarHabit object) {
  return [];
}

void _isarHabitAttach(IsarCollection<dynamic> col, Id id, IsarHabit object) {
  object.id = id;
}

extension IsarHabitQueryWhereSort
    on QueryBuilder<IsarHabit, IsarHabit, QWhere> {
  QueryBuilder<IsarHabit, IsarHabit, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarHabitQueryWhere
    on QueryBuilder<IsarHabit, IsarHabit, QWhereClause> {
  QueryBuilder<IsarHabit, IsarHabit, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<IsarHabit, IsarHabit, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterWhereClause> idBetween(
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

extension IsarHabitQueryFilter
    on QueryBuilder<IsarHabit, IsarHabit, QFilterCondition> {
  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> archivedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'archived',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> iconKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> iconKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> iconKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> iconKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'iconKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> iconKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> iconKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> iconKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'iconKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> iconKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'iconKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> iconKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'iconKey',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition>
      iconKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'iconKey',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition>
      reminderEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition>
      reminderTimeMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reminderTimeMinutes',
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition>
      reminderTimeMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reminderTimeMinutes',
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition>
      reminderTimeMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reminderTimeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition>
      reminderTimeMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reminderTimeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition>
      reminderTimeMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reminderTimeMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterFilterCondition>
      reminderTimeMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reminderTimeMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarHabitQueryObject
    on QueryBuilder<IsarHabit, IsarHabit, QFilterCondition> {}

extension IsarHabitQueryLinks
    on QueryBuilder<IsarHabit, IsarHabit, QFilterCondition> {}

extension IsarHabitQuerySortBy on QueryBuilder<IsarHabit, IsarHabit, QSortBy> {
  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archived', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archived', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByIconKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconKey', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByIconKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconKey', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> sortByReminderTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy>
      sortByReminderTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderTimeMinutes', Sort.desc);
    });
  }
}

extension IsarHabitQuerySortThenBy
    on QueryBuilder<IsarHabit, IsarHabit, QSortThenBy> {
  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archived', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'archived', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByIconKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconKey', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByIconKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'iconKey', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByReminderEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderEnabled', Sort.desc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy> thenByReminderTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QAfterSortBy>
      thenByReminderTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reminderTimeMinutes', Sort.desc);
    });
  }
}

extension IsarHabitQueryWhereDistinct
    on QueryBuilder<IsarHabit, IsarHabit, QDistinct> {
  QueryBuilder<IsarHabit, IsarHabit, QDistinct> distinctByArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'archived');
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QDistinct> distinctByIconKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'iconKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QDistinct> distinctByReminderEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderEnabled');
    });
  }

  QueryBuilder<IsarHabit, IsarHabit, QDistinct>
      distinctByReminderTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reminderTimeMinutes');
    });
  }
}

extension IsarHabitQueryProperty
    on QueryBuilder<IsarHabit, IsarHabit, QQueryProperty> {
  QueryBuilder<IsarHabit, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarHabit, bool, QQueryOperations> archivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'archived');
    });
  }

  QueryBuilder<IsarHabit, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<IsarHabit, String, QQueryOperations> iconKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'iconKey');
    });
  }

  QueryBuilder<IsarHabit, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<IsarHabit, bool, QQueryOperations> reminderEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderEnabled');
    });
  }

  QueryBuilder<IsarHabit, int?, QQueryOperations>
      reminderTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reminderTimeMinutes');
    });
  }
}
