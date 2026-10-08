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

};

entity Supplier {

    key ID      : UUID;
        Name    : String;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;

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
    key Name    : String;
        Rating  : Integer;
        Comment : String;
};

entity SalesDate {

    key ID           : UUID;
        DeliveryDate : DateTime;
        Revenue      : Decimal(16, 2);

};
