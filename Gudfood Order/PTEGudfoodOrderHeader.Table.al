table 50111 "PTE Gudfood Order Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                Customer: Record "Customer";
                GudfoodOrderLine: Record "PTE Gudfood Order Line";
            begin
                if Rec."Sell-to Customer No." = '' then
                    exit;

                Customer.Get("Sell-to Customer No.");
                Rec."Sell-to Customer Name" := Customer.Name;

                if Rec."Sell-to Customer No." <> xRec."Sell-to Customer No." then begin
                    GudfoodOrderLine.SetRange("Order No.", Rec."No.");
                    GudfoodOrderLine.ModifyAll("Sell-to Customer No.", Rec."Sell-to Customer No.");
                end;
            end;

        }
        field(3; "Sell-to Customer Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Sell-to Customer Name';
            Editable = false;
        }
        field(4; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order Date';
        }
        field(5; "Posting No."; Code[20])
        {
            DataClassification = ToBeClassified;
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
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("PTE Gudfood Order Line"."Quantity");
        }
        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("PTE Gudfood Order Line"."Amount");
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        GudfoodOrderLine: Record "PTE Gudfood Order Line";
    begin
        GudfoodOrderLine.SetRange("Order No.", Rec."No.");
        GudfoodOrderLine.DeleteAll(true);
    end;
}
