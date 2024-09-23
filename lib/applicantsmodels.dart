// To parse this JSON data, do
//
//     final applicantsModels = applicantsModelsFromJson(jsonString);

import 'dart:convert';

ApplicantsModels applicantsModelsFromJson(String str) =>
    ApplicantsModels.fromJson(json.decode(str));

String applicantsModelsToJson(ApplicantsModels data) =>
    json.encode(data.toJson());

class ApplicantsModels {
  String? email;
  String? firstName;
  String? jobRole;
  String? lastName;
  String? phone;
  List<SelectedProduct>? selectedProducts;
  num? totalPrice;

  ApplicantsModels({
    this.email,
    this.firstName,
    this.jobRole,
    this.lastName,
    this.phone,
    this.selectedProducts,
    this.totalPrice,
  });

  factory ApplicantsModels.fromJson(Map<String, dynamic> json) =>
      ApplicantsModels(
        email: json["email"],
        firstName: json["first_name"],
        jobRole: json["job_role"],
        lastName: json["last_name"],
        phone: json["phone"],
        selectedProducts: json["selected_products"] == null
            ? []
            : List<SelectedProduct>.from(json["selected_products"]!
                .map((x) => SelectedProduct.fromJson(x))),
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "job_role": jobRole,
        "last_name": lastName,
        "phone": phone,
        "selected_products": selectedProducts == null
            ? []
            : List<dynamic>.from(selectedProducts!.map((x) => x.toJson())),
        "total_price": totalPrice,
      };
}

class SelectedProduct {
  String? image;
  bool? isSelected;
  num? price;
  String? title;
  String? subtitle;

  SelectedProduct(
      {this.image, this.isSelected, this.price, this.title, this.subtitle});

  factory SelectedProduct.fromJson(Map<String, dynamic> json) =>
      SelectedProduct(
        image: json["image"],
        isSelected: json["isSelected"],
        price: json["price"],
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "isSelected": isSelected,
        "price": price,
        "title": title,
        'subtitle': subtitle,
      };
}
