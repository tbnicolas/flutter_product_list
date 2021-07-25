import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    Product({
        this.name,
        this.description ='',
        this.stock,
        this.price,
        this.id
    });

    String name;
    String description;
    int stock;
    int price;
    String id;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        stock: json["stock"],
        price: json["price"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "stock": stock,
        "price": price,
        "id": id
    };
}
