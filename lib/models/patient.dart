class Patient {
  int? id;
  String? name;
  String? sex;
  int? age;
  String? referdate;
  String? township;
  String? address;
  String? referfrom;
  String? referto;
  String? signandsymptom;

  Patient({
    this.id,
    this.name,
    this.sex,
    this.age,
    this.referdate,
    this.township,
    this.address,
    this.referfrom,
    this.referto,
    this.signandsymptom,
  });

  Patient.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        name = result["name"],
        sex = result["sex"],
        age = result["age"],
        referdate = result["referdate"],
        township = result["township"],
        address = result["address"],
        referfrom = result["referfrom"],
        referto = result["referto"],
        signandsymptom = result["signandsymptom"];

  Map<String, Object> toMap() {
    return {
      'name': name!,
      'sex': sex!,
      'age': age!,
      'referdate': referdate!,
      'township': township!,
      'address': address!,
      'referfrom': referfrom!,
      'referto': referto!,
      'signandsymptom': signandsymptom!,
    };
  }
}
