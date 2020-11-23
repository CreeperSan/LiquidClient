
class CurrencyModel{
  int id;
  String region;
  String name;
  String shortName;

  CurrencyModel({
    this.id = 0,
    this.region = '',
    this.name = '',
    this.shortName = '',
  });

  @override
  String toString() {
    return '$name[id=$id, region=$region, name=$name, shortName=$shortName]';
  }

}

