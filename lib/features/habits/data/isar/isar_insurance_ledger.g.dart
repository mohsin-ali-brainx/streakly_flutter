// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_insurance_ledger.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarInsuranceLedgerCollection on Isar {
  IsarCollection<IsarInsuranceLedger> get isarInsuranceLedgers =>
      this.collection();
}

const IsarInsuranceLedgerSchema = CollectionSchema(
  name: r'IsarInsuranceLedger',
  id: -1679167064436429727,
  properties: {
    r'monthKey': PropertySchema(
      id: 0,
      name: r'monthKey',
      type: IsarType.string,
    ),
    r'tokensUsed': PropertySchema(
      id: 1,
      name: r'tokensUsed',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 2,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _isarInsuranceLedgerEstimateSize,
  serialize: _isarInsuranceLedgerSerialize,
  deserialize: _isarInsuranceLedgerDeserialize,
  deserializeProp: _isarInsuranceLedgerDeserializeProp,
  idName: r'id',
  indexes: {
    r'monthKey': IndexSchema(
      id: -6349924167704926890,
      name: r'monthKey',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'monthKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarInsuranceLedgerGetId,
  getLinks: _isarInsuranceLedgerGetLinks,
  attach: _isarInsuranceLedgerAttach,
  version: '3.1.0+1',
);

int _isarInsuranceLedgerEstimateSize(
  IsarInsuranceLedger object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.monthKey.length * 3;
  return bytesCount;
}

void _isarInsuranceLedgerSerialize(
  IsarInsuranceLedger object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.monthKey);
  writer.writeLong(offsets[1], object.tokensUsed);
  writer.writeDateTime(offsets[2], object.updatedAt);
}

IsarInsuranceLedger _isarInsuranceLedgerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarInsuranceLedger();
  object.id = id;
  object.monthKey = reader.readString(offsets[0]);
  object.tokensUsed = reader.readLong(offsets[1]);
  object.updatedAt = reader.readDateTime(offsets[2]);
  return object;
}

P _isarInsuranceLedgerDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarInsuranceLedgerGetId(IsarInsuranceLedger object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarInsuranceLedgerGetLinks(
    IsarInsuranceLedger object) {
  return [];
}

void _isarInsuranceLedgerAttach(
    IsarCollection<dynamic> col, Id id, IsarInsuranceLedger object) {
  object.id = id;
}

extension IsarInsuranceLedgerByIndex on IsarCollection<IsarInsuranceLedger> {
  Future<IsarInsuranceLedger?> getByMonthKey(String monthKey) {
    return getByIndex(r'monthKey', [monthKey]);
  }

  IsarInsuranceLedger? getByMonthKeySync(String monthKey) {
    return getByIndexSync(r'monthKey', [monthKey]);
  }

  Future<bool> deleteByMonthKey(String monthKey) {
    return deleteByIndex(r'monthKey', [monthKey]);
  }

  bool deleteByMonthKeySync(String monthKey) {
    return deleteByIndexSync(r'monthKey', [monthKey]);
  }

  Future<List<IsarInsuranceLedger?>> getAllByMonthKey(
      List<String> monthKeyValues) {
    final values = monthKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'monthKey', values);
  }

  List<IsarInsuranceLedger?> getAllByMonthKeySync(List<String> monthKeyValues) {
    final values = monthKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'monthKey', values);
  }

  Future<int> deleteAllByMonthKey(List<String> monthKeyValues) {
    final values = monthKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'monthKey', values);
  }

  int deleteAllByMonthKeySync(List<String> monthKeyValues) {
    final values = monthKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'monthKey', values);
  }

  Future<Id> putByMonthKey(IsarInsuranceLedger object) {
    return putByIndex(r'monthKey', object);
  }

  Id putByMonthKeySync(IsarInsuranceLedger object, {bool saveLinks = true}) {
    return putByIndexSync(r'monthKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMonthKey(List<IsarInsuranceLedger> objects) {
    return putAllByIndex(r'monthKey', objects);
  }

  List<Id> putAllByMonthKeySync(List<IsarInsuranceLedger> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'monthKey', objects, saveLinks: saveLinks);
  }
}

extension IsarInsuranceLedgerQueryWhereSort
    on QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QWhere> {
  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarInsuranceLedgerQueryWhere
    on QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QWhereClause> {
  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterWhereClause>
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

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterWhereClause>
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

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterWhereClause>
      monthKeyEqualTo(String monthKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'monthKey',
        value: [monthKey],
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterWhereClause>
      monthKeyNotEqualTo(String monthKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monthKey',
              lower: [],
              upper: [monthKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monthKey',
              lower: [monthKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monthKey',
              lower: [monthKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'monthKey',
              lower: [],
              upper: [monthKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarInsuranceLedgerQueryFilter on QueryBuilder<IsarInsuranceLedger,
    IsarInsuranceLedger, QFilterCondition> {
  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
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

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
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

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
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

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monthKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monthKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monthKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'monthKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'monthKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'monthKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'monthKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monthKey',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      monthKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'monthKey',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      tokensUsedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tokensUsed',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      tokensUsedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tokensUsed',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      tokensUsedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tokensUsed',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      tokensUsedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tokensUsed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
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

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
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

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterFilterCondition>
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

extension IsarInsuranceLedgerQueryObject on QueryBuilder<IsarInsuranceLedger,
    IsarInsuranceLedger, QFilterCondition> {}

extension IsarInsuranceLedgerQueryLinks on QueryBuilder<IsarInsuranceLedger,
    IsarInsuranceLedger, QFilterCondition> {}

extension IsarInsuranceLedgerQuerySortBy
    on QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QSortBy> {
  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      sortByMonthKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthKey', Sort.asc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      sortByMonthKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthKey', Sort.desc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      sortByTokensUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokensUsed', Sort.asc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      sortByTokensUsedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokensUsed', Sort.desc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarInsuranceLedgerQuerySortThenBy
    on QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QSortThenBy> {
  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      thenByMonthKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthKey', Sort.asc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      thenByMonthKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'monthKey', Sort.desc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      thenByTokensUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokensUsed', Sort.asc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      thenByTokensUsedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tokensUsed', Sort.desc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension IsarInsuranceLedgerQueryWhereDistinct
    on QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QDistinct> {
  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QDistinct>
      distinctByMonthKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monthKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QDistinct>
      distinctByTokensUsed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tokensUsed');
    });
  }

  QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension IsarInsuranceLedgerQueryProperty
    on QueryBuilder<IsarInsuranceLedger, IsarInsuranceLedger, QQueryProperty> {
  QueryBuilder<IsarInsuranceLedger, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarInsuranceLedger, String, QQueryOperations>
      monthKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monthKey');
    });
  }

  QueryBuilder<IsarInsuranceLedger, int, QQueryOperations>
      tokensUsedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tokensUsed');
    });
  }

  QueryBuilder<IsarInsuranceLedger, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
