table 50112 "PTE Gudfood Order Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "PTE Gudfood Order Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Sell-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer';
            TableRelation = Customer."No.";
            Editable = false;
        }
        field(4; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Created';
            Editable = false;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = "PTE Gudfood Item"."No.";
            trigger OnValidate()
            var
                GudfoodItem: Record "PTE Gudfood Item";
            begin
                GudfoodItem.GET(Rec."Item No.");
                if TODAY >= GudfoodItem."Shelf Life" then
                    Error('Item expired!');
                Rec.Description := GudfoodItem.Description;
                Rec."Item Type" := GudfoodItem.Type;
                Rec."Unit Price" := GudfoodItem."Unit Price";
                CalcAmount();
            end;
        }
        field(6; "Item Type"; Option)
        {
            FieldClass = FlowField;
            OptionMembers = ,Salat,Burger,Capcake,Drink;
            Caption = 'Item Type';
            CalcFormula = Lookup("PTE Gudfood Item"."Type" WHERE("No." = FIELD("Item No.")));
        }
        field(7; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            MinValue = 0;
            trigger OnValidate();
            begin
                CalcAmount();
            end;
        }
        field(9; "Unit Price"; Decimal)
        {
            Caption = 'Cost';
        }
        field(10; "Amount"; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        SetLineNo();
    end;

    local procedure SetLineNo()
    var
        GudfoodOrderLine: Record "PTE Gudfood Order Line";
    begin
        GudfoodOrderLine.SETRANGE("Order No.", Rec."Order No.");
        if GudfoodOrderLine.FINDLAST() then
            Rec."Line No." := GudfoodOrderLine."Line No." + 10000
        else
            Rec."Line No." := 10000;
    end;

    local procedure CalcAmount()
    begin
        Rec."Amount" := Rec."Quantity" * Rec."Unit Price";
    end;
}
