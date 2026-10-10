using {com.logali as logali} from '../db/schema';

// service CatlogService {
//     entity Products      as projection on logali.materials.Products;
//     entity Supliers      as projection on logali.sales.Supplier;
//     entity UnitOfMeasure as projection on logali.materials.UnitOfMeasure;
//     entity Currency      as projection on logali.materials.Currencies;
//     entity DimensionUnit as projection on logali.materials.DimensionsUnit;
//     entity SalesData     as projection on logali.sales.SalesData;
//     entity Reviews       as projection on logali.sales.ProductReview;
//     entity Category      as projection on logali.materials.Category;
//     entity Months        as projection on logali.sales.Months;
//     entity Order         as projection on logali.sales.Orders;
//     entity OrderItem     as projection on logali.sales.OrderItems;
// }

define service CatalogService {

    entity Products          as
        select from logali.reports.Products {

            ID,
            Name          as ProductName @mandatory,
            Description                  @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                        @mandatory,
            Height,
            Width,
            Depth,
            Quantity                     @(
                mandatory,
                assert.range: [
                    0.00,
                    20.00
                ]
            ),
            UnitOfMeasure as ToUnitOfMeasure,
            Currency      as ToCurrency  @mandatory,
            Category      as ToCategory  @mandatory,
            Category.Name as Category    @readonly,
            DimensionUnit as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews,
            Raiting,
            StockAvailability,
            ToStockAvailability,

        };

    @readonly
    entity Supplier          as
        select from logali.sales.Supplier {

            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    entity Reviews           as
        select from logali.materials.ProductReview {
            ID,
            Rating,
            Comment,
            createdAt,
            Product as ToProduct,

        };

    @readonly
    entity SalesData         as
        select from logali.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct,
        };

    @readonly
    entity StockAvailability as
        select from logali.materials.StockAvailability {

            ID,
            Description,
            Product as ToProduct,
        };

    @readonly
    entity VH_Category       as
        select from logali.materials.Category {
            ID   as Code,
            Name as Text,
        };

    @readonly
    entity VH_Currency       as
        select from logali.materials.Currencies {
            ID          as Code,
            Description as Text,
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from logali.materials.UnitOfMeasure {
            ID          as Code,
            Description as Text,
        };

    @readonly
    entity VH_DimensionUnits as
        select
            ID          as Code,
            Description as Text
        from logali.materials.DimensionsUnit;

};

define service Reports {

    entity AverageRaiting as projection on logali.reports.AverageRaiting;

    entity EntityCasting   as
        select
            cast(
                Price as Integer
            )     as Price,
            Price as Price2 : Integer
        from logali.materials.Products;

        entity EntityExists as select from logali.materials.Products{
            Name
        } where exists Supplier[Name = 'Office World'];
}
