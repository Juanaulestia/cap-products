using com.training from '../db/training';

define service ManageOrders {
    entity Orders   as projection on training.Orders;
}
