table 50121 "PTE Pstd Gudfood Ordr Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "PTE Pstd Gudfood Ordr Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = "PTE Gudfood Item"."No.";
        }
        field(4; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
        }
        field(6; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(7; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; "Date Created"; Date)
        {
            Caption = 'Date Created';
        }
        field(9; "Sell-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer';
            Editable = false;
        }
        field(11; "Item Type"; Option)
        {
            OptionMembers = ,Salat,Burger,Capcake,Drink;
            Caption = 'Item Type';
        }
    }
    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
