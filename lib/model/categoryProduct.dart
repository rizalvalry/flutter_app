// To parse this JSON data, do
//
//     final albums = albumsFromJson(jsonString);

import 'dart:convert';

Albums albumsFromJson(String str) => Albums.fromJson(json.decode(str));

String albumsToJson(Albums data) => json.encode(data.toJson());

class Albums {
    Albums({
        this.status,
        this.message,
        this.products,
        this.totalData,
        this.limit,
        this.totalPages,
        this.page,
        this.pageLink,
        this.pagingCounter,
        this.hasPrevPage,
        this.hasNextPage,
        this.prevPage,
        this.nextPage,
    });

    bool status;
    String message;
    List<Product> products;
    int totalData;
    int limit;
    int totalPages;
    dynamic page;
    PageLink pageLink;
    dynamic pagingCounter;
    bool hasPrevPage;
    bool hasNextPage;
    dynamic prevPage;
    dynamic nextPage;

    factory Albums.fromJson(Map<String, dynamic> json) => Albums(
        status: json["status"],
        message: json["message"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        totalData: json["totalData"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pageLink: PageLink.fromJson(json["pageLink"]),
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "totalData": totalData,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pageLink": pageLink.toJson(),
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
    };
}

class PageLink {
    PageLink({
        this.baseLink,
        this.exampleLink,
        this.method,
    });

    String baseLink;
    String exampleLink;
    String method;

    factory PageLink.fromJson(Map<String, dynamic> json) => PageLink(
        baseLink: json["baseLink"],
        exampleLink: json["exampleLink"],
        method: json["method"],
    );

    Map<String, dynamic> toJson() => {
        "baseLink": baseLink,
        "exampleLink": exampleLink,
        "method": method,
    };
}

class Product {
    Product({
        this.id,
        this.wishlist,
        this.store,
        this.productCode,
        this.name,
        this.nameCurrentLanguage,
        this.price,
        this.subPrice,
        this.discount,
        this.details,
        this.files,
        this.categories,
        this.keyWords,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    bool wishlist;
    Store store;
    String productCode;
    List<PurpleName> name;
    List<NameCurrentLanguageElement> nameCurrentLanguage;
    List<Price> price;
    List<dynamic> subPrice;
    int discount;
    ProductDetails details;
    List<FileElement> files;
    List<Category> categories;
    List<String> keyWords;
    Status status;
    String createdAt;
    String updatedAt;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        wishlist: json["wishlist"],
        store: Store.fromJson(json["store"]),
        productCode: json["productCode"],
        name: List<PurpleName>.from(json["name"].map((x) => PurpleName.fromJson(x))),
        nameCurrentLanguage: List<NameCurrentLanguageElement>.from(json["nameCurrentLanguage"].map((x) => NameCurrentLanguageElement.fromJson(x))),
        price: List<Price>.from(json["price"].map((x) => Price.fromJson(x))),
        subPrice: List<dynamic>.from(json["subPrice"].map((x) => x)),
        discount: json["discount"],
        details: ProductDetails.fromJson(json["details"]),
        files: List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        keyWords: List<String>.from(json["keyWords"].map((x) => x)),
        status: statusValues.map[json["status"]],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "wishlist": wishlist,
        "store": store.toJson(),
        "productCode": productCode,
        "name": List<dynamic>.from(name.map((x) => x.toJson())),
        "nameCurrentLanguage": List<dynamic>.from(nameCurrentLanguage.map((x) => x.toJson())),
        "price": List<dynamic>.from(price.map((x) => x.toJson())),
        "subPrice": List<dynamic>.from(subPrice.map((x) => x)),
        "discount": discount,
        "details": details.toJson(),
        "files": List<dynamic>.from(files.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "keyWords": List<dynamic>.from(keyWords.map((x) => x)),
        "status": statusValues.reverse[status],
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}

class Category {
    Category({
        this.id,
        this.name,
    });

    String id;
    List<NameCurrentLanguageElement> name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: List<NameCurrentLanguageElement>.from(json["name"].map((x) => NameCurrentLanguageElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": List<dynamic>.from(name.map((x) => x.toJson())),
    };
}

class NameCurrentLanguageElement {
    NameCurrentLanguageElement({
        this.languageId,
        this.languageCode,
        this.name,
    });

    LanguageId languageId;
    LanguageCode languageCode;
    String name;

    factory NameCurrentLanguageElement.fromJson(Map<String, dynamic> json) => NameCurrentLanguageElement(
        languageId: languageIdValues.map[json["languageId"]],
        languageCode: languageCodeValues.map[json["languageCode"]],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "languageId": languageIdValues.reverse[languageId],
        "languageCode": languageCodeValues.reverse[languageCode],
        "name": name,
    };
}

enum LanguageCode { ID, EN, IND }

final languageCodeValues = EnumValues({
    "EN": LanguageCode.EN,
    "ID": LanguageCode.ID,
    "IND": LanguageCode.IND
});

enum LanguageId { THE_5_F6589713_EEA8_C4_D606_F2_CB4, THE_5_F72_D22_EB00_D2_D24_A528_B06_E, THE_5_FB7892843438511_D9188_BF7 }

final languageIdValues = EnumValues({
    "5f6589713eea8c4d606f2cb4": LanguageId.THE_5_F6589713_EEA8_C4_D606_F2_CB4,
    "5f72d22eb00d2d24a528b06e": LanguageId.THE_5_F72_D22_EB00_D2_D24_A528_B06_E,
    "5fb7892843438511d9188bf7": LanguageId.THE_5_FB7892843438511_D9188_BF7
});

class ProductDetails {
    ProductDetails({
        this.minPurchase,
        this.lengthId,
        this.lengthCode,
        this.lengthName,
        this.length,
        this.widthId,
        this.widthCode,
        this.widthName,
        this.width,
        this.heightId,
        this.heightCode,
        this.heightName,
        this.height,
        this.weightId,
        this.weightCode,
        this.weightName,
        this.weight,
        this.details,
    });

    int minPurchase;
    LengthId lengthId;
    Code lengthCode;
    Name lengthName;
    dynamic length;
    WidthId widthId;
    WidthCode widthCode;
    WidthName widthName;
    dynamic width;
    HeightId heightId;
    Code heightCode;
    Name heightName;
    dynamic height;
    WeightId weightId;
    WeightCode weightCode;
    WeightName weightName;
    dynamic weight;
    String details;

    factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        minPurchase: json["minPurchase"],
        lengthId: lengthIdValues.map[json["lengthId"]],
        lengthCode: codeValues.map[json["lengthCode"]],
        lengthName: nameValues.map[json["lengthName"]],
        length: json["length"],
        widthId: widthIdValues.map[json["widthId"]],
        widthCode: widthCodeValues.map[json["widthCode"]],
        widthName: widthNameValues.map[json["widthName"]],
        width: json["width"],
        heightId: heightIdValues.map[json["heightId"]],
        heightCode: codeValues.map[json["heightCode"]],
        heightName: nameValues.map[json["heightName"]],
        height: json["height"],
        weightId: weightIdValues.map[json["weightId"]],
        weightCode: weightCodeValues.map[json["weightCode"]],
        weightName: weightNameValues.map[json["weightName"]],
        weight: json["weight"],
        details: json["details"],
    );

    Map<String, dynamic> toJson() => {
        "minPurchase": minPurchase,
        "lengthId": lengthIdValues.reverse[lengthId],
        "lengthCode": codeValues.reverse[lengthCode],
        "lengthName": nameValues.reverse[lengthName],
        "length": length,
        "widthId": widthIdValues.reverse[widthId],
        "widthCode": widthCodeValues.reverse[widthCode],
        "widthName": widthNameValues.reverse[widthName],
        "width": width,
        "heightId": heightIdValues.reverse[heightId],
        "heightCode": codeValues.reverse[heightCode],
        "heightName": nameValues.reverse[heightName],
        "height": height,
        "weightId": weightIdValues.reverse[weightId],
        "weightCode": weightCodeValues.reverse[weightCode],
        "weightName": weightNameValues.reverse[weightName],
        "weight": weight,
        "details": details,
    };
}

enum Code { CM, CMS }

final codeValues = EnumValues({
    "cm": Code.CM,
    "cms": Code.CMS
});

enum HeightId { THE_5_F6589883_EEA8_C4_D606_F2_CB6 }

final heightIdValues = EnumValues({
    "5f6589883eea8c4d606f2cb6": HeightId.THE_5_F6589883_EEA8_C4_D606_F2_CB6
});

enum Name { CENTIMETER, AKSESORIS }

final nameValues = EnumValues({
    "Aksesoris": Name.AKSESORIS,
    "centimeter": Name.CENTIMETER
});

enum LengthId { THE_5_FB78_A5443438511_D9188_BFF, THE_5_F6589903_EEA8_C4_D606_F2_CB7 }

final lengthIdValues = EnumValues({
    "5f6589903eea8c4d606f2cb7": LengthId.THE_5_F6589903_EEA8_C4_D606_F2_CB7,
    "5fb78a5443438511d9188bff": LengthId.THE_5_FB78_A5443438511_D9188_BFF
});

enum WeightCode { KG, LITERS }

final weightCodeValues = EnumValues({
    "kg": WeightCode.KG,
    "Liters": WeightCode.LITERS
});

enum WeightId { THE_5_F6589963_EEA8_C4_D606_F2_CB8, THE_5_FB78_AA243438511_D9188_C03 }

final weightIdValues = EnumValues({
    "5f6589963eea8c4d606f2cb8": WeightId.THE_5_F6589963_EEA8_C4_D606_F2_CB8,
    "5fb78aa243438511d9188c03": WeightId.THE_5_FB78_AA243438511_D9188_C03
});

enum WeightName { KILOGRAM, AIR }

final weightNameValues = EnumValues({
    "Air": WeightName.AIR,
    "kilogram": WeightName.KILOGRAM
});

enum WidthCode { CM, THE_1 }

final widthCodeValues = EnumValues({
    "cm": WidthCode.CM,
    "_)(*&^1": WidthCode.THE_1
});

enum WidthId { THE_5_F65899_E3_EEA8_C4_D606_F2_CBB, THE_5_F81_D4_EA8_EE7473578091325 }

final widthIdValues = EnumValues({
    "5f65899e3eea8c4d606f2cbb": WidthId.THE_5_F65899_E3_EEA8_C4_D606_F2_CBB,
    "5f81d4ea8ee7473578091325": WidthId.THE_5_F81_D4_EA8_EE7473578091325
});

enum WidthName { CENTIMETER, HDASKALH783_R }

final widthNameValues = EnumValues({
    "centimeter": WidthName.CENTIMETER,
    "hdaskalh783r": WidthName.HDASKALH783_R
});

class FileElement {
    FileElement({
        this.id,
        this.original,
        this.small,
        this.thumb,
        this.fileType,
    });

    String id;
    String original;
    String small;
    String thumb;
    FileType fileType;

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["_id"],
        original: json["original"],
        small: json["small"],
        thumb: json["thumb"],
        fileType: fileTypeValues.map[json["fileType"]],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "original": original,
        "small": small,
        "thumb": thumb,
        "fileType": fileTypeValues.reverse[fileType],
    };
}

enum FileType { IMAGE }

final fileTypeValues = EnumValues({
    "image": FileType.IMAGE
});

class PurpleName {
    PurpleName({
        this.id,
        this.languageId,
        this.languageCode,
        this.languageName,
        this.name,
    });

    String id;
    LanguageId languageId;
    LanguageCode languageCode;
    LanguageName languageName;
    String name;

    factory PurpleName.fromJson(Map<String, dynamic> json) => PurpleName(
        id: json["_id"],
        languageId: languageIdValues.map[json["languageId"]],
        languageCode: languageCodeValues.map[json["languageCode"]],
        languageName: languageNameValues.map[json["languageName"]],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "languageId": languageIdValues.reverse[languageId],
        "languageCode": languageCodeValues.reverse[languageCode],
        "languageName": languageNameValues.reverse[languageName],
        "name": name,
    };
}

enum LanguageName { INDONESIA, INDONESIAN }

final languageNameValues = EnumValues({
    "INDONESIA": LanguageName.INDONESIA,
    "Indonesian": LanguageName.INDONESIAN
});

class Price {
    Price({
        this.currencyId,
        this.currencyCode,
        this.price,
    });

    CurrencyId currencyId;
    CurrencyCode currencyCode;
    int price;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        currencyId: currencyIdValues.map[json["currencyId"]],
        currencyCode: currencyCodeValues.map[json["currencyCode"]],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "currencyId": currencyIdValues.reverse[currencyId],
        "currencyCode": currencyCodeValues.reverse[currencyCode],
        "price": price,
    };
}

enum CurrencyCode { IDR }

final currencyCodeValues = EnumValues({
    "IDR": CurrencyCode.IDR
});

enum CurrencyId { THE_5_F6589_FA3_EEA8_C4_D606_F2_CBC }

final currencyIdValues = EnumValues({
    "5f6589fa3eea8c4d606f2cbc": CurrencyId.THE_5_F6589_FA3_EEA8_C4_D606_F2_CBC
});

enum Status { ACTIVE }

final statusValues = EnumValues({
    "active": Status.ACTIVE
});

class Store {
    Store({
        this.id,
        this.accountId,
        this.name,
        this.address,
        this.details,
        this.role,
    });

    String id;
    String accountId;
    String name;
    Address address;
    StoreDetails details;
    Role role;

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        accountId: json["accountId"],
        name: json["name"],
        address: Address.fromJson(json["address"]),
        details: StoreDetails.fromJson(json["details"]),
        role: roleValues.map[json["role"]],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "accountId": accountId,
        "name": name,
        "address": address.toJson(),
        "details": details.toJson(),
        "role": roleValues.reverse[role],
    };
}

class Address {
    Address({
        this.countryCode,
        this.country,
        this.flag,
        this.regionCode,
        this.region,
        this.cityCode,
        this.city,
        this.address,
    });

    CountryCode countryCode;
    Country country;
    String flag;
    String regionCode;
    Region region;
    CityCode cityCode;
    City city;
    String address;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        countryCode: countryCodeValues.map[json["countryCode"]],
        country: countryValues.map[json["country"]],
        flag: json["flag"],
        regionCode: json["regionCode"],
        region: regionValues.map[json["region"]],
        cityCode: cityCodeValues.map[json["cityCode"]],
        city: cityValues.map[json["city"]],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "countryCode": countryCodeValues.reverse[countryCode],
        "country": countryValues.reverse[country],
        "flag": flag,
        "regionCode": regionCode,
        "region": regionValues.reverse[region],
        "cityCode": cityCodeValues.reverse[cityCode],
        "city": cityValues.reverse[city],
        "address": address,
    };
}

enum City { KAB_PACITAN, OTHER, PADEMANGANN }

final cityValues = EnumValues({
    "Kab. Pacitan": City.KAB_PACITAN,
    "Other": City.OTHER,
    "pademangann": City.PADEMANGANN
});

enum CityCode { THE_3501, THE_03, JAKBAR }

final cityCodeValues = EnumValues({
    "jakbar": CityCode.JAKBAR,
    "03": CityCode.THE_03,
    "35.01": CityCode.THE_3501
});

enum Country { INDONESIA, FRANCE }

final countryValues = EnumValues({
    "France": Country.FRANCE,
    "Indonesia": Country.INDONESIA
});

enum CountryCode { ID, FR }

final countryCodeValues = EnumValues({
    "FR": CountryCode.FR,
    "ID": CountryCode.ID
});

enum Region { JAWA_TIMUR, PARIS, JAKARTA }

final regionValues = EnumValues({
    "Jakarta": Region.JAKARTA,
    "Jawa Timur": Region.JAWA_TIMUR,
    "Paris": Region.PARIS
});

class StoreDetails {
    StoreDetails({
        this.employes,
        this.details,
    });

    int employes;
    String details;

    factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
        employes: json["employes"],
        details: json["details"],
    );

    Map<String, dynamic> toJson() => {
        "employes": employes,
        "details": details,
    };
}

enum Role { BEGINNER }

final roleValues = EnumValues({
    "beginner": Role.BEGINNER
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
