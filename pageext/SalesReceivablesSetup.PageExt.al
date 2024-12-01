pageextension 50000 "PTE Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("PTE Gudfood Order Nos."; Rec."PTE Gudfood Order Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gudfood Order Nos. field.';
            }
            field("PTE Posted Gudfood Order Nos."; Rec."PTE Posted Gudfood Order Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posted Gudfood Order Nos. field.';
            }
        }
    }
}
