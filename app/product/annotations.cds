using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(
    UI.HeaderInfo                : {
        TypeName      : '{i18n>productTypeName}',
        TypeNamePlural: '{i18n>productTypeNamePlural}',
        ImageUrl      : ImageUrl,
        Title         : {Value: ProductName},
        Description   : {Value: Description}
    },
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>releaseDateLabel}',
                Value: ReleaseDate
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>discontinuedDateLabel}',
                Value: DiscontinuedDate
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>priceLabel}',
                Value: Price
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>heightLabel}',
                Value: Height
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>widthLabel}',
                Value: Width
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>depthLabel}',
                Value: Depth
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>quantityLabel}',
                Value: Quantity
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>uomLabel}',
                Value: ToUnitOfMeasure_ID
            }, // Ajustado internamente por CAP
            {
                $Type: 'UI.DataField',
                Label: '{i18n>currencyLabel}',
                Value: ToCurrency_ID
            }, // Ajustado internamente por CAP
            {
                $Type: 'UI.DataField',
                Label: '{i18n>categoryLabel}',
                Value: ToCategory_ID
            }, // Ajustado internamente por CAP
            {
                $Type: 'UI.DataField',
                Label: '{i18n>categoryLabel}',
                Value: Category
            }, 
            {
                $Type: 'UI.DataField',
                Label: '{i18n>uomLabel}',
                Value: ToDimensionUnit_ID
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>stockAvailabilityLabel}',
                Value: StockAvailability
            },
        ],
    },
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : '{i18n>generalInformationFacetLabel}',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }],

    UI.HeaderFacets              : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.DataPoint#AverageRating'
    }],

    UI.SelectionFields           : [
        ToCategory_ID,
        ToCurrency_ID,
        StockAvailability
    ],

    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: '{i18n>imageUrlLabel}',
            Value: ImageUrl,
        },
        {
            $Type      : 'UI.DataField',
            Label      : '{i18n>stockAvailabilityLabel}',
            Value      : StockAvailability,
            Criticality: StockAvailability,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : '{i18n>supplierLabel}',
            Target: 'Supplier/@Communication.Contact'
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>productTypeName}',
            Value: ProductName,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>generalInformationFacetLabel}',
            Value: Description,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : '{i18n>ratingLabel}',
            Target: '@UI.DataPoint#AverageRating'
        },
    ],
);

annotate service.Products with {
    ToCategory        @title: '{i18n>categoryLabel}';
    ToCurrency        @title: '{i18n>currencyLabel}';
    StockAvailability @title: '{i18n>stockAvailabilityLabel}';
    ImageUrl          @(UI.IsImageURL: true);
};

/*
* Annotations for SH (Value Helps mapeados usando tus alias del servicio)
*/
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
 * Annotations for Value Helps
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

annotate service.VH_Currency with {
    Code @(UI.HiddenFilter: true);
    Text @(UI.HiddenFilter: true);
};

annotate service.StockAvailability with {
    ID @Common.Text: {
        $value                : Description,
        ![@UI.TextArrangement]: #TextLast
    };
};

annotate service.VH_UnitOfMeasure with {
    Code @(UI.HiddenFilter: true);
    Text @(UI.HiddenFilter: true);
};

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

/*
* Data point for Average Rating
*/
annotate service.Products with @(UI.DataPoint #AverageRating: {
    Value        : Raiting, // Usando exactamente el nombre de tu servicio
    Title        : '{i18n>ratingLabel}',
    TargetValue  : 5,
    Visualization: #Rating
});
