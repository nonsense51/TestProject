page 50111 "PTE Gudfood Item List"
{
    PageType = List;
    SourceTable = "PTE Gudfood Item";
    ApplicationArea = All;
    Caption = 'Gudfood Item List';
    UsageCategory = Lists;
    CardPageId = "PTE Gudfood Item Card";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Original Item No."; Rec."Original Item No.")
                {
                    ToolTip = 'Specifies the value of the Original Item No. field.';

                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Price field.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Qty. Ordered"; Rec."Qty. Ordered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. Ordered field.';
                }
                field("Qty. in Order"; Rec."Qty. in Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Qty. in Order field.';
                }
                field("Shelf Life"; Rec."Shelf Life")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shelf Life field.';
                }
            }
        }
    }
}
