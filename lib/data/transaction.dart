import 'package:hive/hive.dart';

// this together with 'flutter packages pub run build_runner build' will create a new file
part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction
    extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String details;
  @HiveField(2)
  double amount;
  @HiveField(3)
  String type;
  @HiveField(4)
  DateTime date;

  Transaction(this.name, this.details, this.amount, this.type, this.date);
}
