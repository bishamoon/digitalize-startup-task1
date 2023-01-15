class House {
  int? id;
  String? cityName;
  String? stateName;
  String? cost;
  int? beds;
  
  String? imageURL;
  
//construtor
  House(
      {this.cityName,
     
      this.beds,
      this.cost,
      this.id,
      this.stateName,
      this.imageURL});

//mapping data from json file
  House.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    cityName = json["cityName"];
    stateName = json["stateName"];
    cost = json["cost"];
    beds = json["beds"];
    
    imageURL = json["imageURL"];
  }
}
