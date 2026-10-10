using {com.logali as logali} from '../db/schema';

service CatlogService {
    entity Products      as projection on logali.Products;
    entity Supliers      as projection on logali.Supplier;
    entity UnitOfMeasure as projection on logali.UnitOfMeasure;
    entity Currency      as projection on logali.Currencies;
    entity DimensionUnit as projection on logali.DimensionsUnit;
    entity SalesData     as projection on logali.SalesData;
    entity Reviews       as projection on logali.ProductReview;
    entity Category      as projection on logali.Category;
    entity Months        as projection on logali.Months;
    entity Order         as projection on logali.Orders;
    entity OrderItem     as projection on logali.OrderItems;
}
