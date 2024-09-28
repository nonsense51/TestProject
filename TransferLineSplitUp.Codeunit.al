codeunit 50100 "TransferLineSplitUp"
{
    trigger OnRun()
    var
        UserGroupRec: Record "User Group Member";
        InventorySetupRec: Record "Inventory Setup";
        TransferHeaderRec: Record "Transfer Header";
        TransferLineRec: Record "Transfer Line";
        ReservationEntryRec: Record "Reservation Entry";
        ErrorMsg: Label 'Your user does not have permission to use the Split-up Transfer Line functionality.';
        StatusErrorMsg: Label 'Document is not open.';
        TrackingErrorMsg: Label 'Splitting-up is only possible for a line that has no associated tracking lines.';
        ItemNoErrorMsg: Label 'Item No. must be filled.';
        ItemCategoryCodeErrorMsg: Label 'Item Category Code must be filled.';
        QuantityErrorMsg: Label 'Quantity must be filled.';
        UnitOfMeasureCodeErrorMsg: Label 'Unit of Measure Code must be filled.';
        CurrentTransferLine: Record "Transfer Line";
    begin
        InventorySetupRec.Get();
        if not IsUserInGroup(InventorySetupRec."Allw Splitup Trans Line UsrGrp") then
            Error(ErrorMsg);
        TransferHeaderRec.Get();
        if TransferHeaderRec.Status <> TransferHeaderRec.Status::Open then
            Error(StatusErrorMsg);
        ReservationEntryRec.SetRange("Source Type", 5741);
        ReservationEntryRec.SetRange("Item No.", TransferLineRec."Item No.");
        ReservationEntryRec.SetRange("Location Code", TransferLineRec."Transfer-from Code");
        ReservationEntryRec.SetRange("Source ID", TransferLineRec."Document No.");
        ReservationEntryRec.SetRange("Source Ref. No.", TransferLineRec."Line No.");
        if ReservationEntryRec.FindFirst() then
            Error(TrackingErrorMsg);
        if TransferLineRec."Item No." = '' then
            Error(ItemNoErrorMsg);
        if TransferLineRec."Item Category Code" = '' then
            Error(ItemCategoryCodeErrorMsg);
        if TransferLineRec.Quantity = 0 then
            Error(QuantityErrorMsg);
        if TransferLineRec."Unit of Measure Code" = '' then
            Error(UnitOfMeasureCodeErrorMsg);

    end;

    local procedure UpdateCurrentLine(var CurrentLine: Record "Transfer Line"; CurrentQuantity: Decimal; NewQuantity: Decimal; QtyPerSplitFromUOM: Decimal)
    begin
        CurrentLine."Quantity" := CurrentQuantity - (NewQuantity / QtyPerSplitFromUOM);
        CurrentLine.Modify();
    end;

    local procedure IsUserInGroup(UserGroupCode: Code[20]): Boolean
    var
        UserGroupRec: Record "User Group Member";
        UserID: Code[20];
    begin
        UserID := USERID;
        UserGroupRec.SetRange("User Group Code", UserGroupCode);
        UserGroupRec.SetRange("User Security ID", UserID);
        UserGroupRec.SetRange("Company Name", CompanyName());
        exit(UserGroupRec.FindFirst());
    end;

    procedure ValidateSplitUpVariables(SplitToItemNo: Code[20]; SplitToUOMCode: Code[10]; Quantity: Decimal)
    var
        ErrorMsgLbl: Label 'To perform the action the variable "%1" must be filled in.';
    begin
        if SplitToItemNo = '' then
            Error(ErrorMsgLbl, 'Split-to Item No.');

        if SplitToUOMCode = '' then
            Error(ErrorMsgLbl, 'Split-to UOM Code');

        if Quantity <= 0 then
            Error(ErrorMsgLbl, 'Quantity');
    end;
}
