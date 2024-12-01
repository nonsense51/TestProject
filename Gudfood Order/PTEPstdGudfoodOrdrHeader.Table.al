table 50120 "PTE Pstd Gudfood Ordr Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Customer No';
        }
        field(3; "Sell-to Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(4; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(5; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(6; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Created';
            Editable = false;
        }
        field(7; "Total Qty"; Decimal)
        {
            Caption = 'Total Qty';
        }
        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
