import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

@DataClassName("Credential")
class Credentials extends Table {
  TextColumn get id => text().withLength(max: 36)();

  TextColumn get title => text().withLength(max: 256)();
  TextColumn get titleIv => text().withLength(max: 32)();

  TextColumn get account => text().withLength(max: 512)();
  TextColumn get accountIv => text().withLength(max: 32)();

  TextColumn get password => text().withLength(max: 512)();
  TextColumn get passwordIv => text().withLength(max: 32)();

  TextColumn get note => text().withLength(max: 1024).nullable()();
  TextColumn get noteIv => text().withLength(max: 32).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName("MasterPassword")
class MasterPasswords extends Table {
  TextColumn get hashedPassword => text().withLength(max: 256)();
  TextColumn get salt => text().withLength(max: 32)();

  @override
  Set<Column> get primaryKey => {hashedPassword};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbDirectory = await getApplicationSupportDirectory();
    final file = File(p.join(dbDirectory.path, "passman.sqlite"));
    return VmDatabase(file, logStatements: true);
  });
}

@UseMoor(tables: [Credentials, MasterPasswords])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Credential>> getAllCredentials() => select(credentials).get();
  Stream<List<Credential>> watchAllCredentials() => select(credentials).watch();
  Future insertCredential(Credential credential) =>
      into(credentials).insert(credential);
  Future updateCredential(Credential credential) =>
      update(credentials).replace(credential);
  Future deleteCredential(Credential credential) =>
      delete(credentials).delete(credential);

  Future<MasterPassword> getMasterPassword() =>
      select(masterPasswords).getSingle();
  Future insertMasterPassword(MasterPassword masterPassword) =>
      into(masterPasswords).insert(masterPassword);
}
