using com.training from '../db/training';

define service ManageOrders {

    type CancelOrderReturn {
        status : String enum {
            Succeeded;
            Failed
        };
        mesage : String
    };

    //  function getClientTaxRate(clientemail: String(65)) returns Decimal(4, 2);
    //   action   cancelOrder(clientemail: String(65))      returns CancelOrderReturn;

    entity Orders as projection on training.Orders
        actions {
            function getClientTaxRate(clientemail: String(65)) returns Decimal(4, 2);
            action   cancelOrder(clientemail: String(65))      returns CancelOrderReturn;
        }

}
