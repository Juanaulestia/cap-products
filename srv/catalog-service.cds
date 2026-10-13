using {com.logali as logali} from '../db/schema';

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

            key ID,
                Name,
                Email,
                Phone,
                Fax,
                Product as ToProduct
        };

    entity Reviews           as
        select from logali.materials.ProductReview {
            key ID,
                Rating,
                Comment,
                createdAt,
                Product as ToProduct,

        };

    @readonly
    entity SalesData         as
        select from logali.sales.SalesData {
            key ID,
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

            key ID,
                Description,
                Product as ToProduct,
        };

    @readonly
    entity VH_Category       as
        select from logali.materials.Category {
            key ID   as Code,
                Name as Text,
        };

    @readonly
    entity VH_Currency       as
        select from logali.materials.Currencies {
            key ID          as Code,
                Description as Text,
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from logali.materials.UnitOfMeasure {
            key ID          as Code,
                Description as Text,
        };

    @readonly
    entity VH_DimensionUnits as
        select
            key ID          as Code,
                Description as Text
        from logali.materials.DimensionsUnit;

};

define service Reports {

    entity AverageRaiting as
        projection on logali.reports.AverageRaiting {
            key ProductId,
                AverageRaiting,
        };

}
