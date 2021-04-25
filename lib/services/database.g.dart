// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Credential extends DataClass implements Insertable<Credential> {
  final String id;
  final String title;
  final String titleIv;
  final String account;
  final String accountIv;
  final String password;
  final String passwordIv;
  final String note;
  final String noteIv;
  Credential(
      {@required this.id,
      @required this.title,
      @required this.titleIv,
      @required this.account,
      @required this.accountIv,
      @required this.password,
      @required this.passwordIv,
      this.note,
      this.noteIv});
  factory Credential.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Credential(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      titleIv: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}title_iv']),
      account:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}account']),
      accountIv: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}account_iv']),
      password: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      passwordIv: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}password_iv']),
      note: stringType.mapFromDatabaseResponse(data['${effectivePrefix}note']),
      noteIv:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}note_iv']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || titleIv != null) {
      map['title_iv'] = Variable<String>(titleIv);
    }
    if (!nullToAbsent || account != null) {
      map['account'] = Variable<String>(account);
    }
    if (!nullToAbsent || accountIv != null) {
      map['account_iv'] = Variable<String>(accountIv);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || passwordIv != null) {
      map['password_iv'] = Variable<String>(passwordIv);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || noteIv != null) {
      map['note_iv'] = Variable<String>(noteIv);
    }
    return map;
  }

  CredentialsCompanion toCompanion(bool nullToAbsent) {
    return CredentialsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      titleIv: titleIv == null && nullToAbsent
          ? const Value.absent()
          : Value(titleIv),
      account: account == null && nullToAbsent
          ? const Value.absent()
          : Value(account),
      accountIv: accountIv == null && nullToAbsent
          ? const Value.absent()
          : Value(accountIv),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      passwordIv: passwordIv == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordIv),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      noteIv:
          noteIv == null && nullToAbsent ? const Value.absent() : Value(noteIv),
    );
  }

  factory Credential.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Credential(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      titleIv: serializer.fromJson<String>(json['titleIv']),
      account: serializer.fromJson<String>(json['account']),
      accountIv: serializer.fromJson<String>(json['accountIv']),
      password: serializer.fromJson<String>(json['password']),
      passwordIv: serializer.fromJson<String>(json['passwordIv']),
      note: serializer.fromJson<String>(json['note']),
      noteIv: serializer.fromJson<String>(json['noteIv']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'titleIv': serializer.toJson<String>(titleIv),
      'account': serializer.toJson<String>(account),
      'accountIv': serializer.toJson<String>(accountIv),
      'password': serializer.toJson<String>(password),
      'passwordIv': serializer.toJson<String>(passwordIv),
      'note': serializer.toJson<String>(note),
      'noteIv': serializer.toJson<String>(noteIv),
    };
  }

  Credential copyWith(
          {String id,
          String title,
          String titleIv,
          String account,
          String accountIv,
          String password,
          String passwordIv,
          String note,
          String noteIv}) =>
      Credential(
        id: id ?? this.id,
        title: title ?? this.title,
        titleIv: titleIv ?? this.titleIv,
        account: account ?? this.account,
        accountIv: accountIv ?? this.accountIv,
        password: password ?? this.password,
        passwordIv: passwordIv ?? this.passwordIv,
        note: note ?? this.note,
        noteIv: noteIv ?? this.noteIv,
      );
  @override
  String toString() {
    return (StringBuffer('Credential(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleIv: $titleIv, ')
          ..write('account: $account, ')
          ..write('accountIv: $accountIv, ')
          ..write('password: $password, ')
          ..write('passwordIv: $passwordIv, ')
          ..write('note: $note, ')
          ..write('noteIv: $noteIv')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              titleIv.hashCode,
              $mrjc(
                  account.hashCode,
                  $mrjc(
                      accountIv.hashCode,
                      $mrjc(
                          password.hashCode,
                          $mrjc(passwordIv.hashCode,
                              $mrjc(note.hashCode, noteIv.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Credential &&
          other.id == this.id &&
          other.title == this.title &&
          other.titleIv == this.titleIv &&
          other.account == this.account &&
          other.accountIv == this.accountIv &&
          other.password == this.password &&
          other.passwordIv == this.passwordIv &&
          other.note == this.note &&
          other.noteIv == this.noteIv);
}

class CredentialsCompanion extends UpdateCompanion<Credential> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> titleIv;
  final Value<String> account;
  final Value<String> accountIv;
  final Value<String> password;
  final Value<String> passwordIv;
  final Value<String> note;
  final Value<String> noteIv;
  const CredentialsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.titleIv = const Value.absent(),
    this.account = const Value.absent(),
    this.accountIv = const Value.absent(),
    this.password = const Value.absent(),
    this.passwordIv = const Value.absent(),
    this.note = const Value.absent(),
    this.noteIv = const Value.absent(),
  });
  CredentialsCompanion.insert({
    @required String id,
    @required String title,
    @required String titleIv,
    @required String account,
    @required String accountIv,
    @required String password,
    @required String passwordIv,
    this.note = const Value.absent(),
    this.noteIv = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        titleIv = Value(titleIv),
        account = Value(account),
        accountIv = Value(accountIv),
        password = Value(password),
        passwordIv = Value(passwordIv);
  static Insertable<Credential> custom({
    Expression<String> id,
    Expression<String> title,
    Expression<String> titleIv,
    Expression<String> account,
    Expression<String> accountIv,
    Expression<String> password,
    Expression<String> passwordIv,
    Expression<String> note,
    Expression<String> noteIv,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (titleIv != null) 'title_iv': titleIv,
      if (account != null) 'account': account,
      if (accountIv != null) 'account_iv': accountIv,
      if (password != null) 'password': password,
      if (passwordIv != null) 'password_iv': passwordIv,
      if (note != null) 'note': note,
      if (noteIv != null) 'note_iv': noteIv,
    });
  }

  CredentialsCompanion copyWith(
      {Value<String> id,
      Value<String> title,
      Value<String> titleIv,
      Value<String> account,
      Value<String> accountIv,
      Value<String> password,
      Value<String> passwordIv,
      Value<String> note,
      Value<String> noteIv}) {
    return CredentialsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      titleIv: titleIv ?? this.titleIv,
      account: account ?? this.account,
      accountIv: accountIv ?? this.accountIv,
      password: password ?? this.password,
      passwordIv: passwordIv ?? this.passwordIv,
      note: note ?? this.note,
      noteIv: noteIv ?? this.noteIv,
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
    if (titleIv.present) {
      map['title_iv'] = Variable<String>(titleIv.value);
    }
    if (account.present) {
      map['account'] = Variable<String>(account.value);
    }
    if (accountIv.present) {
      map['account_iv'] = Variable<String>(accountIv.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (passwordIv.present) {
      map['password_iv'] = Variable<String>(passwordIv.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (noteIv.present) {
      map['note_iv'] = Variable<String>(noteIv.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CredentialsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('titleIv: $titleIv, ')
          ..write('account: $account, ')
          ..write('accountIv: $accountIv, ')
          ..write('password: $password, ')
          ..write('passwordIv: $passwordIv, ')
          ..write('note: $note, ')
          ..write('noteIv: $noteIv')
          ..write(')'))
        .toString();
  }
}

class $CredentialsTable extends Credentials
    with TableInfo<$CredentialsTable, Credential> {
  final GeneratedDatabase _db;
  final String _alias;
  $CredentialsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn('id', $tableName, false, maxTextLength: 36);
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false, maxTextLength: 256);
  }

  final VerificationMeta _titleIvMeta = const VerificationMeta('titleIv');
  GeneratedTextColumn _titleIv;
  @override
  GeneratedTextColumn get titleIv => _titleIv ??= _constructTitleIv();
  GeneratedTextColumn _constructTitleIv() {
    return GeneratedTextColumn('title_iv', $tableName, false,
        maxTextLength: 32);
  }

  final VerificationMeta _accountMeta = const VerificationMeta('account');
  GeneratedTextColumn _account;
  @override
  GeneratedTextColumn get account => _account ??= _constructAccount();
  GeneratedTextColumn _constructAccount() {
    return GeneratedTextColumn('account', $tableName, false,
        maxTextLength: 512);
  }

  final VerificationMeta _accountIvMeta = const VerificationMeta('accountIv');
  GeneratedTextColumn _accountIv;
  @override
  GeneratedTextColumn get accountIv => _accountIv ??= _constructAccountIv();
  GeneratedTextColumn _constructAccountIv() {
    return GeneratedTextColumn('account_iv', $tableName, false,
        maxTextLength: 32);
  }

  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  GeneratedTextColumn _password;
  @override
  GeneratedTextColumn get password => _password ??= _constructPassword();
  GeneratedTextColumn _constructPassword() {
    return GeneratedTextColumn('password', $tableName, false,
        maxTextLength: 512);
  }

  final VerificationMeta _passwordIvMeta = const VerificationMeta('passwordIv');
  GeneratedTextColumn _passwordIv;
  @override
  GeneratedTextColumn get passwordIv => _passwordIv ??= _constructPasswordIv();
  GeneratedTextColumn _constructPasswordIv() {
    return GeneratedTextColumn('password_iv', $tableName, false,
        maxTextLength: 32);
  }

  final VerificationMeta _noteMeta = const VerificationMeta('note');
  GeneratedTextColumn _note;
  @override
  GeneratedTextColumn get note => _note ??= _constructNote();
  GeneratedTextColumn _constructNote() {
    return GeneratedTextColumn('note', $tableName, true, maxTextLength: 1024);
  }

  final VerificationMeta _noteIvMeta = const VerificationMeta('noteIv');
  GeneratedTextColumn _noteIv;
  @override
  GeneratedTextColumn get noteIv => _noteIv ??= _constructNoteIv();
  GeneratedTextColumn _constructNoteIv() {
    return GeneratedTextColumn('note_iv', $tableName, true, maxTextLength: 32);
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        titleIv,
        account,
        accountIv,
        password,
        passwordIv,
        note,
        noteIv
      ];
  @override
  $CredentialsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'credentials';
  @override
  final String actualTableName = 'credentials';
  @override
  VerificationContext validateIntegrity(Insertable<Credential> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('title_iv')) {
      context.handle(_titleIvMeta,
          titleIv.isAcceptableOrUnknown(data['title_iv'], _titleIvMeta));
    } else if (isInserting) {
      context.missing(_titleIvMeta);
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account'], _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('account_iv')) {
      context.handle(_accountIvMeta,
          accountIv.isAcceptableOrUnknown(data['account_iv'], _accountIvMeta));
    } else if (isInserting) {
      context.missing(_accountIvMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password'], _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('password_iv')) {
      context.handle(
          _passwordIvMeta,
          passwordIv.isAcceptableOrUnknown(
              data['password_iv'], _passwordIvMeta));
    } else if (isInserting) {
      context.missing(_passwordIvMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note'], _noteMeta));
    }
    if (data.containsKey('note_iv')) {
      context.handle(_noteIvMeta,
          noteIv.isAcceptableOrUnknown(data['note_iv'], _noteIvMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Credential map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Credential.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CredentialsTable createAlias(String alias) {
    return $CredentialsTable(_db, alias);
  }
}

class MasterPassword extends DataClass implements Insertable<MasterPassword> {
  final String hashedPassword;
  final String salt;
  MasterPassword({@required this.hashedPassword, @required this.salt});
  factory MasterPassword.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return MasterPassword(
      hashedPassword: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}hashed_password']),
      salt: stringType.mapFromDatabaseResponse(data['${effectivePrefix}salt']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || hashedPassword != null) {
      map['hashed_password'] = Variable<String>(hashedPassword);
    }
    if (!nullToAbsent || salt != null) {
      map['salt'] = Variable<String>(salt);
    }
    return map;
  }

  MasterPasswordsCompanion toCompanion(bool nullToAbsent) {
    return MasterPasswordsCompanion(
      hashedPassword: hashedPassword == null && nullToAbsent
          ? const Value.absent()
          : Value(hashedPassword),
      salt: salt == null && nullToAbsent ? const Value.absent() : Value(salt),
    );
  }

  factory MasterPassword.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MasterPassword(
      hashedPassword: serializer.fromJson<String>(json['hashedPassword']),
      salt: serializer.fromJson<String>(json['salt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'hashedPassword': serializer.toJson<String>(hashedPassword),
      'salt': serializer.toJson<String>(salt),
    };
  }

  MasterPassword copyWith({String hashedPassword, String salt}) =>
      MasterPassword(
        hashedPassword: hashedPassword ?? this.hashedPassword,
        salt: salt ?? this.salt,
      );
  @override
  String toString() {
    return (StringBuffer('MasterPassword(')
          ..write('hashedPassword: $hashedPassword, ')
          ..write('salt: $salt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(hashedPassword.hashCode, salt.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MasterPassword &&
          other.hashedPassword == this.hashedPassword &&
          other.salt == this.salt);
}

class MasterPasswordsCompanion extends UpdateCompanion<MasterPassword> {
  final Value<String> hashedPassword;
  final Value<String> salt;
  const MasterPasswordsCompanion({
    this.hashedPassword = const Value.absent(),
    this.salt = const Value.absent(),
  });
  MasterPasswordsCompanion.insert({
    @required String hashedPassword,
    @required String salt,
  })  : hashedPassword = Value(hashedPassword),
        salt = Value(salt);
  static Insertable<MasterPassword> custom({
    Expression<String> hashedPassword,
    Expression<String> salt,
  }) {
    return RawValuesInsertable({
      if (hashedPassword != null) 'hashed_password': hashedPassword,
      if (salt != null) 'salt': salt,
    });
  }

  MasterPasswordsCompanion copyWith(
      {Value<String> hashedPassword, Value<String> salt}) {
    return MasterPasswordsCompanion(
      hashedPassword: hashedPassword ?? this.hashedPassword,
      salt: salt ?? this.salt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (hashedPassword.present) {
      map['hashed_password'] = Variable<String>(hashedPassword.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MasterPasswordsCompanion(')
          ..write('hashedPassword: $hashedPassword, ')
          ..write('salt: $salt')
          ..write(')'))
        .toString();
  }
}

class $MasterPasswordsTable extends MasterPasswords
    with TableInfo<$MasterPasswordsTable, MasterPassword> {
  final GeneratedDatabase _db;
  final String _alias;
  $MasterPasswordsTable(this._db, [this._alias]);
  final VerificationMeta _hashedPasswordMeta =
      const VerificationMeta('hashedPassword');
  GeneratedTextColumn _hashedPassword;
  @override
  GeneratedTextColumn get hashedPassword =>
      _hashedPassword ??= _constructHashedPassword();
  GeneratedTextColumn _constructHashedPassword() {
    return GeneratedTextColumn('hashed_password', $tableName, false,
        maxTextLength: 256);
  }

  final VerificationMeta _saltMeta = const VerificationMeta('salt');
  GeneratedTextColumn _salt;
  @override
  GeneratedTextColumn get salt => _salt ??= _constructSalt();
  GeneratedTextColumn _constructSalt() {
    return GeneratedTextColumn('salt', $tableName, false, maxTextLength: 32);
  }

  @override
  List<GeneratedColumn> get $columns => [hashedPassword, salt];
  @override
  $MasterPasswordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'master_passwords';
  @override
  final String actualTableName = 'master_passwords';
  @override
  VerificationContext validateIntegrity(Insertable<MasterPassword> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('hashed_password')) {
      context.handle(
          _hashedPasswordMeta,
          hashedPassword.isAcceptableOrUnknown(
              data['hashed_password'], _hashedPasswordMeta));
    } else if (isInserting) {
      context.missing(_hashedPasswordMeta);
    }
    if (data.containsKey('salt')) {
      context.handle(
          _saltMeta, salt.isAcceptableOrUnknown(data['salt'], _saltMeta));
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {hashedPassword};
  @override
  MasterPassword map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MasterPassword.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MasterPasswordsTable createAlias(String alias) {
    return $MasterPasswordsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CredentialsTable _credentials;
  $CredentialsTable get credentials => _credentials ??= $CredentialsTable(this);
  $MasterPasswordsTable _masterPasswords;
  $MasterPasswordsTable get masterPasswords =>
      _masterPasswords ??= $MasterPasswordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [credentials, masterPasswords];
}
