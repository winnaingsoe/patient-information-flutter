class HEActivity {
  int? id;
  String? date;
  String? address;
  String? volunteer;
  String? heattendedslist;
  int? male;
  int? female;

  HEActivity({
    this.id,
    this.date,
    this.address,
    this.volunteer,
    this.heattendedslist,
    this.male,
    this.female,
  });

  HEActivity.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        date = result["date"],
        address = result["address"],
        volunteer = result["volunteer"],
        heattendedslist = result["heattendedslist"],
        male = result["male"],
        female = result["female"];

  Map<String, Object> toMap() {
    return {
      'date': date!,
      'address': address!,
      'volunteer': volunteer!,
      'heattendedslist': heattendedslist!,
      'male': male!,
      'female': female!,
    };
  }
}
