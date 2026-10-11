namespace com.training;

using { cuid } from '@sap/cds/common';


entity Orders {
    key ClientEmail : String(65);
        FirstName   : String(30);
        LastName    : String(30);
        CreateOn    : Date;
        Reviewed    : Boolean;
        Approved    : Boolean;

}
