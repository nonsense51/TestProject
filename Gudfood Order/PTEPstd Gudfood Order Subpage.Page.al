page 50115 "PTEPstd Gudfood Order Subpage"
{
    PageType = ListPart;
    SourceTable = "PTE Pstd Gudfood Ordr Line";
    ApplicationArea = All;
    Caption = 'PTE Posted Gudfood Order Subpage';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Order No.';
                    ToolTip = 'Specifies the value of the Order No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to Customer No.';
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    Caption = 'Date Created';
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                    Caption = 'Item Type';
                    ToolTip = 'Specifies the value of the Item Type field.';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Quantity"; Rec."Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Price';
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }
}
