using { API_BUSINESS_PARTNER as external } from './external/API_BUSINESS_PARTNER';
service SAPBackendPartner {
    entity Partner as projection on external.A_Customer {
        key Customer,
        CustomerName,
        CustomerFullName,
        County,
    };
}

