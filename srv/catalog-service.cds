using {com.logali as logali} from '../db/schema';

service CatlogService {
    entity Products as projection on logali.Products ;
    entity Supliers as projection on logali.Supplier;
}
