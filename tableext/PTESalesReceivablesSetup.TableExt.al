tableextension 50000 "PTE Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "PTE Gudfood Order Nos."; Code[20])
        {
            Caption = 'Gudfood Order Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "PTE Posted Gudfood Order Nos."; Code[20])
        {
            Caption = 'Posted Gudfood Order Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}