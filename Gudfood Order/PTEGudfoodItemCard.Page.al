page 50112 "PTE Gudfood Item Card"
{
    PageType = Card;
    SourceTable = "PTE Gudfood Item";
    ApplicationArea = All;
    Caption = 'Gudfood Item';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No"; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
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
            }

            group(Inventory)
            {
                Caption = 'Inventory';
                field("Qty. Ordered"; Rec."Qty. Ordered")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qty. Ordered field.';
                }
                field("Qty. in Order"; Rec."Qty. in Order")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qty. in Order field.';
                }
            }

            group(Details)
            {
                Caption = 'Details';
                field("Shelf Life"; Rec."Shelf Life")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shelf Life field.';
                }
                field("Picture"; Rec."Picture")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Picture field.';
                }
            }
        }
        area(FactBoxes)
        {
            part(GudfoodPicture; "PTE Gudfood Picture")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }
}
