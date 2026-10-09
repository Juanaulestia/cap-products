namespace com.logali;

type Address {
    Street     : String;
    City       : String;
    State      : String;
    PostalCode : String;
    Country    : String;

}


entity Products {

    key ID               : UUID;
        Name             : String;
        Description      : String;
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

entity Supplier {

    key ID      : UUID;
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
        Name : String;
};

entity StockAvailability {

    key ID          : Integer;
        Description : String;
};

entity Currencies {
    key ID          : String(3);
        Description : String;
};

entity UnitOfMeasure {
    key ID          : String(2);
        Description : String;

};

entity DimensionsUnit {
    key ID          : String(2);
        Description : String;

};

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);

}

entity ProductReview {
    key ID      : UUID;
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to one Products;
};

entity SalesData {

    key ID            : UUID;
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to one Products;
        Currency      : Association to one Currencies;
        DeliveryMonth : Association to one Months;
};


extend Products with {
    PriceCondition     : String(2);
    PriceDetermination : String(3);
}
