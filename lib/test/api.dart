class restaurant {
  String? title;
  Properties? properties;

  restaurant({this.title, this.properties});

  restaurant.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    return data;
  }
}

class Properties {
  Id? iId;
  Address? address;
  Id? borough;
  Id? cuisine;
  Coord? grades;
  Id? name;
  Id? restaurantId;

  Properties(
      {this.iId,
        this.address,
        this.borough,
        this.cuisine,
        this.grades,
        this.name,
        this.restaurantId});

  Properties.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    borough = json['borough'] != null ? new Id.fromJson(json['borough']) : null;
    cuisine = json['cuisine'] != null ? new Id.fromJson(json['cuisine']) : null;
    grades = json['grades'] != null ? new Coord.fromJson(json['grades']) : null;
    name = json['name'] != null ? new Id.fromJson(json['name']) : null;
    restaurantId = json['restaurant_id'] != null
        ? new Id.fromJson(json['restaurant_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.borough != null) {
      data['borough'] = this.borough!.toJson();
    }
    if (this.cuisine != null) {
      data['cuisine'] = this.cuisine!.toJson();
    }
    if (this.grades != null) {
      data['grades'] = this.grades!.toJson();
    }
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.restaurantId != null) {
      data['restaurant_id'] = this.restaurantId!.toJson();
    }
    return data;
  }
}

class Id {
  String? bsonType;

  Id({this.bsonType});

  Id.fromJson(Map<String, dynamic> json) {
    bsonType = json['bsonType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bsonType'] = this.bsonType;
    return data;
  }
}

class Address {
  String? bsonType;
  Properties? properties;

  Address({this.bsonType, this.properties});

  Address.fromJson(Map<String, dynamic> json) {
    bsonType = json['bsonType'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bsonType'] = this.bsonType;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    return data;
  }
}

class BuildingProperties {
  Id? building;
  Coord? coord;
  Id? street;
  Id? zipcode;

  BuildingProperties({this.building, this.coord, this.street, this.zipcode});

  BuildingProperties.fromJson(Map<String, dynamic> json) {
    building =
    json['building'] != null ? new Id.fromJson(json['building']) : null;
    coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
    street = json['street'] != null ? new Id.fromJson(json['street']) : null;
    zipcode = json['zipcode'] != null ? new Id.fromJson(json['zipcode']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.building != null) {
      data['building'] = this.building!.toJson();
    }
    if (this.coord != null) {
      data['coord'] = this.coord!.toJson();
    }
    if (this.street != null) {
      data['street'] = this.street!.toJson();
    }
    if (this.zipcode != null) {
      data['zipcode'] = this.zipcode!.toJson();
    }
    return data;
  }
}

class Coord {
  String? bsonType;
  Address? items;

  Coord({this.bsonType, this.items});

  Coord.fromJson(Map<String, dynamic> json) {
    bsonType = json['bsonType'];
    items = json['items'] != null ? new Address.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bsonType'] = this.bsonType;
    if (this.items != null) {
      data['items'] = this.items!.toJson();
    }
    return data;
  }
}

class GradeModel {
  Id? date;
  Id? grade;
  Id? score;

  GradeModel({this.date, this.grade, this.score});

  GradeModel.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? new Id.fromJson(json['date']) : null;
    grade = json['grade'] != null ? new Id.fromJson(json['grade']) : null;
    score = json['score'] != null ? new Id.fromJson(json['score']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    if (this.grade != null) {
      data['grade'] = this.grade!.toJson();
    }
    if (this.score != null) {
      data['score'] = this.score!.toJson();
    }
    return data;
  }
}
