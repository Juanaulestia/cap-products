using {com.logali as logali} from '../db/schema';

service CatlogService {
    entity Products      as projection on logali.materials.Products;
    entity Supliers      as projection on logali.sales.Supplier;
    entity UnitOfMeasure as projection on logali.materials.UnitOfMeasure;
    entity Currency      as projection on logali.materials.Currencies;
    entity DimensionUnit as projection on logali.materials.DimensionsUnit;
    entity SalesData     as projection on logali.sales.SalesData;
    entity Reviews       as projection on logali.sales.ProductReview;
    entity Category      as projection on logali.materials.Category;
    entity Months        as projection on logali.sales.Months;
    entity Order         as projection on logali.sales.Orders;
    entity OrderItem     as projection on logali.sales.OrderItems;
}
