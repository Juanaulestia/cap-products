namespace com.logali;

using {
    cuid,
    managed
} from '@sap/cds/common';


type Address {
    Street     : String;
    City       : String;
    State      : String;
    PostalCode : String;
    Country    : String;

}


entity Products : cuid, managed {

    Name             : localized String not null;
    Description      : localized String;
    ImageUrl         : String;
    ReleaseDate      : DateTime default $now;
    DiscontinuedDate : DateTime;
    Price            : Decimal(16, 2);
    Height           : Decimal(16, 2);
    Width            : Decimal(16, 2);
    Depth            : Decimal(16, 2);
    Quantity         : Decimal(16, 2);
    Supplier         : Association to one Supplier;
    UnitOfMeasure    : Association to one UnitOfMeasure;
    Currency         : Association to one Currencies;
    DimensionUnit    : Association to one DimensionsUnit;
    Category         : Association to one Category;
    SalesData        : Association to many SalesData
                           on SalesData.Product = $self;
    Reviews          : Association to many ProductReview
                           on Reviews.Product = $self;
};

entity Orders : cuid {
    Date     : Date;
    Customer : String;
    Item     : Composition of many OrderItems
                   on Item.Order = $self;
};

entity OrderItems : cuid {

    Order    : Association to one Orders;
    Product  : Association to one Products;
    Quantity : Integer;
};

entity Supplier : cuid, managed {

    Name    : String;
    Address : Address;
    Email   : String;
    Phone   : String;
    Fax     : String;
    Product : Association to many Products
                  on Product.Supplier = $self;

};


entity Category {
    key ID   : String(1);
        Name : localized String;
};

entity StockAvailability {

    key ID          : Integer;
        Description : localized String;
        Product     : Association to one Products;
};

entity Currencies {

    key ID          : String(3);
        Description : localized String;
};

entity UnitOfMeasure {

    key ID          : String(2);
        Description : localized String;

};

entity DimensionsUnit {

    key ID          : String(2);
        Description : localized String;

};

entity Months {

    key ID               : String(2);
        Description      : localized String;
        ShortDescription : localized String(3);

}

entity ProductReview : cuid, managed {

    Name    : String;
    Rating  : Integer;
    Comment : String;
    Product : Association to one Products;
};

entity SalesData : cuid {

    DeliveryDate  : DateTime;
    Revenue       : Decimal(16, 2);
    Product       : Association to one Products;
    Currency      : Association to one Currencies;
    DeliveryMonth : Association to one Months;
};


extend Products with {

    PriceCondition     : String(2);
    PriceDetermination : String(3);
};
