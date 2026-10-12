using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'ProductName',
                Value: ProductName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Description',
                Value: Description,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ImageUrl',
                Value: ImageUrl,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ReleaseDate',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'DiscontinuedDate',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Price',
                Value: Price,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Height',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Width',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Depth',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Quantity',
                Value: Quantity,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToUnitOfMeasure_ID',
                Value: ToUnitOfMeasure_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToCurrency_ID',
                Value: ToCurrency_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToCategory_ID',
                Value: ToCategory_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Category',
                Value: Category,
            },
            {
                $Type: 'UI.DataField',
                Label: 'ToDimensionUnit_ID',
                Value: ToDimensionUnit_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Raiting',
                Value: Raiting,
            },
            {
                $Type: 'UI.DataField',
                Label: 'StockAvailability',
                Value: StockAvailability,
            },
        ],
    },
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, ],

    UI.SelectionFields           : [
        ToCategory_ID,
        ToCurrency_ID,
        StockAvailability
    ],

    UI.LineItem                  : [

        {
            $Type: 'UI.DataField',
            Label: 'ImageUrl',
            Value: ImageUrl,
        },
        {
            $Type      : 'UI.DataField',
            Label      : 'Stock',
            Value      : StockAvailability,
            Criticality: StockAvailability,
        },

        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : 'Supplier',
            Target: 'Supplier/@Communication.Contact'
        },

        {
            $Type: 'UI.DataField',
            Label: 'ProductName',
            Value: ProductName,
        },

        {
            $Type: 'UI.DataField',
            Label: 'Description',
            Value: Description,
        },


    ],
);


annotate service.Products with {
    ImageUrl @(UI.IsImageURL: true)
};


/*
* Annotations fo SH
*/
// Category
annotate service.Products with {
    ToCategory        @(Common: {
        Text                    : {
            $value                : Category,
            ![@UI.TextArrangement]: #TextOnly
        },
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Category',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Category,
                    ValueListProperty: 'Text'
                }
            ]
        }
    });

    // Currency (diálogo con tabla: sin ValueListWithFixedValues)
    ToCurrency        @(Common: {ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'VH_Currency',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: ToCurrency_ID,
                ValueListProperty: 'Code'
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Text'
            }
        ]
    }});

    // Stock availability (desplegable de valores fijos)
    StockAvailability @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'StockAvailability',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: StockAvailability,
                ValueListProperty: 'ID'
            }]
        }
    });
};

/**
 * Annotations for VH_Category
 */
annotate service.VH_Category with {
    Code @(
        UI.Hidden  : true,
        Common.Text: {
            $value                : Text,
            ![@UI.TextArrangement]: #TextOnly
        }
    );
    Text @(UI.HiddenFilter: true);
};

/**
 * Annotations for VH_Currency
 */
annotate service.VH_Currency with {
    Code @(UI.HiddenFilter: true);
    Text @(UI.HiddenFilter: true);
};

/**
 * Annotations for StockAvailability
 */
annotate service.StockAvailability with {
    ID @Common.Text: {
        $value                : Description,
        ![@UI.TextArrangement]: #TextLast
    };
};

/**
 * Annotations for VH_UnitOfMeasure
 */
annotate service.VH_UnitOfMeasure with {
    Code @(UI.HiddenFilter: true);
    Text @(UI.HiddenFilter: true);
};

/**
 * Annotations for VH_DimensionUnits
 */
annotate service.VH_DimensionUnits with {
    Code @(UI.HiddenFilter: true);
    Text @(UI.HiddenFilter: true);
};


annotate service.Supplier with @(Communication: {Contact: {
    $Type: 'Communication.ContactType',
    fn   : Name,
    role : 'Supplier',
    photo: 'sap-icon://supplier',
    email: [{
        type   : #work,
        address: Email
    }],
    tel  : [
        {
            type: #work,
            uri : Phone
        },
        {
            type: #fax,
            uri : Fax
        }
    ]
}});
