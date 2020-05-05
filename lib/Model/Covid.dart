
class Covid {
  String Confirmed;
  String Recovered;
  String Hospitalized;
  String Deaths;
  String NewConfirmed;
  String newRecovered;
  String newHospitalized;
  String newDeaths;
  String UpdateDate;
  String Source;
  String DevBy;
  String SeverBy;

  Covid({
    this.Confirmed,
    this.Recovered,
    this.Hospitalized,
    this.Deaths,
    this.NewConfirmed,
    this.newRecovered,
    this.newHospitalized,
    this.newDeaths,
    this.UpdateDate,
    this.Source,
    this.DevBy,
    this.SeverBy,
  });


  factory Covid.fromJson(Map<String, dynamic> parsedJson) {
    return Covid(
      Confirmed: parsedJson['Confirmed'].toString(),
      Recovered: parsedJson['Recovered'].toString(),
      Hospitalized: parsedJson['Hospitalized'].toString(),
      Deaths: parsedJson['Deaths'].toString(),
      NewConfirmed: parsedJson['NewConfirmed'].toString(),
      newRecovered: parsedJson['NewRecovered'].toString(),
      newHospitalized: parsedJson['NewHospitalized'].toString(),
      newDeaths: parsedJson['NewDeaths'].toString(),
      UpdateDate: parsedJson['UpdateDate'].toString(),
      Source: parsedJson['Source'].toString(),
      DevBy: parsedJson['DevBy'].toString(),
      SeverBy: parsedJson['SeverBy'].toString(),

    );
  }

}