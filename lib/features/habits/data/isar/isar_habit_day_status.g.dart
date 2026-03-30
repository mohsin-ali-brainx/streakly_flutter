// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_habit_day_status.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarHabitDayStatusCollection on Isar {
  IsarCollection<IsarHabitDayStatus> get isarHabitDayStatus =>
      this.collection();
}

const IsarHabitDayStatusSchema = CollectionSchema(
  name: r'IsarHabitDayStatus',
  id: 2754069175355815913,
  properties: {
    r'dayKey': PropertySchema(
      id: 0,
      name: r'dayKey',
      type: IsarType.string,
    ),
    r'habitId': PropertySchema(
      id: 1,
      name: r'habitId',
      type: IsarType.long,
    ),
    r'habitIdDayKey': PropertySchema(
      id: 2,
      name: r'habitIdDayKey',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 3,
      name: r'status',
      type: IsarType.byte,
      enumMap: _IsarHabitDayStatusstatusEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 4,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _isarHabitDayStatusEstimateSize,
  serialize: _isarHabitDayStatusSerialize,
  deserialize: _isarHabitDayStatusDeserialize,
  deserializeProp: _isarHabitDayStatusDeserializeProp,
  idName: r'id',
  indexes: {
    r'habitId': IndexSchema(
      id: 1000409552522198739,
      name: r'habitId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'habitId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'dayKey': IndexSchema(
      id: -3264092797330672150,
      name: r'dayKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dayKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'habitIdDayKey': IndexSchema(
      id: 3011703272035939417,
      name: r'habitIdDayKey',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'habitIdDayKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarHabitDayStatusGetId,
  getLinks: _isarHabitDayStatusGetLinks,
  attach: _isarHabitDayStatusAttach,
  version: '3.1.0+1',
);

int _isarHabitDayStatusEstimateSize(
  IsarHabitDayStatus object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.dayKey.length * 3;
  bytesCount += 3 + object.habitIdDayKey.length * 3;
  return bytesCount;
}

void _isarHabitDayStatusSerialize(
  IsarHabitDayStatus object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dayKey);
  writer.writeLong(offsets[1], object.habitId);
  writer.writeString(offsets[2], object.habitIdDayKey);
  writer.writeByte(offsets[3], object.status.index);
  writer.writeDateTime(offsets[4], object.updatedAt);
}

IsarHabitDayStatus _isarHabitDayStatusDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarHabitDayStatus();
  object.dayKey = reader.readString(offsets[0]);
  object.habitId = reader.readLong(offsets[1]);
  object.habitIdDayKey = reader.readString(offsets[2]);
  object.id = id;
  object.status = _IsarHabitDayStatusstatusValueEnumMap[
          reader.readByteOrNull(offsets[3])] ??
      IsarHabitDayCompletionStatus.done;
  object.updatedAt = reader.readDateTime(offsets[4]);
  return object;
}

P _isarHabitDayStatusDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (_IsarHabitDayStatusstatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          IsarHabitDayCompletionStatus.done) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarHabitDayStatusstatusEnumValueMap = {
  'done': 0,
  'missed': 1,
  'insured': 2,
};
const _IsarHabitDayStatusstatusValueEnumMap = {
  0: IsarHabitDayCompletionStatus.done,
  1: IsarHabitDayCompletionStatus.missed,
  2: IsarHabitDayCompletionStatus.insured,
};

Id _isarHabitDayStatusGetId(IsarHabitDayStatus object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarHabitDayStatusGetLinks(
    IsarHabitDayStatus object) {
  return [];
}

void _isarHabitDayStatusAttach(
    IsarCollection<dynamic> col, Id id, IsarHabitDayStatus object) {
  object.id = id;
}

extension IsarHabitDayStatusByIndex on IsarCollection<IsarHabitDayStatus> {
  Future<IsarHabitDayStatus?> getByHabitIdDayKey(String habitIdDayKey) {
    return getByIndex(r'habitIdDayKey', [habitIdDayKey]);
  }

  IsarHabitDayStatus? getByHabitIdDayKeySync(String habitIdDayKey) {
    return getByIndexSync(r'habitIdDayKey', [habitIdDayKey]);
  }

  Future<bool> deleteByHabitIdDayKey(String habitIdDayKey) {
    return deleteByIndex(r'habitIdDayKey', [habitIdDayKey]);
  }

  bool deleteByHabitIdDayKeySync(String habitIdDayKey) {
    return deleteByIndexSync(r'habitIdDayKey', [habitIdDayKey]);
  }

  Future<List<IsarHabitDayStatus?>> getAllByHabitIdDayKey(
      List<String> habitIdDayKeyValues) {
    final values = habitIdDayKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'habitIdDayKey', values);
  }

  List<IsarHabitDayStatus?> getAllByHabitIdDayKeySync(
      List<String> habitIdDayKeyValues) {
    final values = habitIdDayKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'habitIdDayKey', values);
  }

  Future<int> deleteAllByHabitIdDayKey(List<String> habitIdDayKeyValues) {
    final values = habitIdDayKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'habitIdDayKey', values);
  }

  int deleteAllByHabitIdDayKeySync(List<String> habitIdDayKeyValues) {
    final values = habitIdDayKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'habitIdDayKey', values);
  }

  Future<Id> putByHabitIdDayKey(IsarHabitDayStatus object) {
    return putByIndex(r'habitIdDayKey', object);
  }

  Id putByHabitIdDayKeySync(IsarHabitDayStatus object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'habitIdDayKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByHabitIdDayKey(List<IsarHabitDayStatus> objects) {
    return putAllByIndex(r'habitIdDayKey', objects);
  }

  List<Id> putAllByHabitIdDayKeySync(List<IsarHabitDayStatus> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'habitIdDayKey', objects, saveLinks: saveLinks);
  }
}

extension IsarHabitDayStatusQueryWhereSort
    on QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QWhere> {
  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhere>
      anyHabitId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'habitId'),
      );
    });
  }
}

extension IsarHabitDayStatusQueryWhere
    on QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QWhereClause> {
  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      habitIdEqualTo(int habitId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'habitId',
        value: [habitId],
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      habitIdNotEqualTo(int habitId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'habitId',
              lower: [],
              upper: [habitId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'habitId',
              lower: [habitId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'habitId',
              lower: [habitId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'habitId',
              lower: [],
              upper: [habitId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      habitIdGreaterThan(
    int habitId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'habitId',
        lower: [habitId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      habitIdLessThan(
    int habitId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'habitId',
        lower: [],
        upper: [habitId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      habitIdBetween(
    int lowerHabitId,
    int upperHabitId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'habitId',
        lower: [lowerHabitId],
        includeLower: includeLower,
        upper: [upperHabitId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      dayKeyEqualTo(String dayKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dayKey',
        value: [dayKey],
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      dayKeyNotEqualTo(String dayKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayKey',
              lower: [],
              upper: [dayKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayKey',
              lower: [dayKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayKey',
              lower: [dayKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dayKey',
              lower: [],
              upper: [dayKey],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      habitIdDayKeyEqualTo(String habitIdDayKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'habitIdDayKey',
        value: [habitIdDayKey],
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterWhereClause>
      habitIdDayKeyNotEqualTo(String habitIdDayKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'habitIdDayKey',
              lower: [],
              upper: [habitIdDayKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'habitIdDayKey',
              lower: [habitIdDayKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'habitIdDayKey',
              lower: [habitIdDayKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'habitIdDayKey',
              lower: [],
              upper: [habitIdDayKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarHabitDayStatusQueryFilter
    on QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QFilterCondition> {
  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dayKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayKey',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      dayKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dayKey',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'habitId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'habitId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'habitId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'habitId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'habitIdDayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'habitIdDayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'habitIdDayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'habitIdDayKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'habitIdDayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'habitIdDayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'habitIdDayKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'habitIdDayKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'habitIdDayKey',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      habitIdDayKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'habitIdDayKey',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      statusEqualTo(IsarHabitDayCompletionStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      statusGreaterThan(
    IsarHabitDayCompletionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      statusLessThan(
    IsarHabitDayCompletionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      statusBetween(
    IsarHabitDayCompletionStatus lower,
    IsarHabitDayCompletionStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
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

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
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

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterFilterCondition>
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

extension IsarHabitDayStatusQueryObject
    on QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QFilterCondition> {}

extension IsarHabitDayStatusQueryLinks
    on QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QFilterCondition> {}

extension IsarHabitDayStatusQuerySortBy
    on QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QSortBy> {
  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByDayKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayKey', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByDayKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayKey', Sort.desc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByHabitId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitId', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByHabitIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitId', Sort.desc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByHabitIdDayKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitIdDayKey', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByHabitIdDayKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitIdDayKey', Sort.desc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarHabitDayStatusQuerySortThenBy
    on QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QSortThenBy> {
  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByDayKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayKey', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByDayKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayKey', Sort.desc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByHabitId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitId', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByHabitIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitId', Sort.desc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByHabitIdDayKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitIdDayKey', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByHabitIdDayKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habitIdDayKey', Sort.desc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarHabitDayStatusQueryWhereDistinct
    on QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QDistinct> {
  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QDistinct>
      distinctByDayKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QDistinct>
      distinctByHabitId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'habitId');
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QDistinct>
      distinctByHabitIdDayKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'habitIdDayKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QDistinct>
      distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension IsarHabitDayStatusQueryProperty
    on QueryBuilder<IsarHabitDayStatus, IsarHabitDayStatus, QQueryProperty> {
  QueryBuilder<IsarHabitDayStatus, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarHabitDayStatus, String, QQueryOperations> dayKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayKey');
    });
  }

  QueryBuilder<IsarHabitDayStatus, int, QQueryOperations> habitIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'habitId');
    });
  }

  QueryBuilder<IsarHabitDayStatus, String, QQueryOperations>
      habitIdDayKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'habitIdDayKey');
    });
  }

  QueryBuilder<IsarHabitDayStatus, IsarHabitDayCompletionStatus,
      QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<IsarHabitDayStatus, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
