table 50100 "PTE Gudfood Item"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = "",Salat,Burger,Capcake,Drink;
        }
        field(5; "Qty. Ordered"; Decimal)
        {

            Caption = 'Qty. Ordered';
            FieldClass = FlowField;
            CalcFormula = Sum("PTE Pstd Gudfood Ordr Line"."Quantity" where("Item No." = field("No.")));

        }
        field(6; "Qty. in Order"; Decimal)
        {
            Caption = 'Qty. in Order';
            FieldClass = FlowField;
            CalcFormula = Sum("PTE Gudfood Order Line"."Quantity" where("Item No." = field("No.")));

        }
        field(7; "Shelf Life"; Date)
        {
            Caption = 'Shelf Life';
        }
        field(8; Picture; MediaSet)
        {
            Caption = 'Picture';
        }
        field(9; "Original Item No."; Code[20])
        {
            Caption = 'Original Item No.';
            TableRelation = Item."No.";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "Shelf Life")
        {

        }
    }
}
