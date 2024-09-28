page 50101 "PTE Gudfood Orders"
{
    PageType = List;
    SourceTable = "PTE Gudfood Order Header";
    ApplicationArea = All;
    Caption = 'Gudfood Orders';
    UsageCategory = Lists;
    CardPageId = "PTE Gudfood Order";
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Order Details';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Order Date';
                    ToolTip = 'Specifies the value of the Order Date field.';
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ApplicationArea = All;
                    Caption = 'Posting No.';
                    ToolTip = 'Specifies the value of the Posting No. field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    Caption = 'Date Created';
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
            }
        }
    }
}
