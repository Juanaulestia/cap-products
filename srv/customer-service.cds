using {com.logali as logali} from '../db/schema';

service CustomerService {
    entity CustomerSvr as projection on logali.Customaer;

}
