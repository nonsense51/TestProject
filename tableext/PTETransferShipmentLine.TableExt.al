tableextension 50003 "PTETransfer Shipment Line" extends "Transfer Shipment Line"
{
    fields
    {
        field(50000; "Split-from Line No."; Integer)
        {
            Caption = 'Split-from Line No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "Split-up Qty. per UOM"; Decimal)
        {
            Caption = 'Split-up Qty. per UOM';
            DataClassification = ToBeClassified;
        }
    }
}
