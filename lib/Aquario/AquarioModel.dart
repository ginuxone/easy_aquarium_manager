
class AquarioModel {

  String key;
  String name;
  AquarioModel({
    this.key,
    this.name
  });
  fromMap(Map aq){
    return AquarioModel(key:aq["key"],name:aq["name"]);
  }
}