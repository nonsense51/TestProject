page 50002 "Transfer Line Split-up"
{
    ApplicationArea = All;
    Caption = 'Transfer Line Split-up';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Split-from Item No."; SplitFromItemNo)
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                    Editable = false;

                }

                field("Split-from UOM Code"; SplitFromUOMCode)
                {
                    ApplicationArea = All;
                    Caption = 'Unit of Measure Code';
                    Editable = false;
                }

                field("Available Quantity"; AvailableQuantity)
                {
                    ApplicationArea = All;
                    Caption = 'Available Quantity';
                    Editable = false;
                }

                field("Split-to Item No."; SplitToItemNo)
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                    LookupPageId = "Item List";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemRec: Record Item;
                        TransferLineRec: Record "Transfer Line";
                        SplitFromItemCategoryCode: Code[20];
                        SplitToItemCategoryCode: Code[20];
                    begin
                        TransferLineRec.Get(TransferLineRec."Document No.", TransferLineRec."Line No.");
                        SplitFromItemCategoryCode := TransferLineRec."Item Category Code";
                        ItemRec.SetRange("No.", Text);
                        if not ItemRec.FindFirst() then
                            SplitToItemCategoryCode := ItemRec."Item Category Code";
                        if SplitFromItemCategoryCode <> SplitToItemCategoryCode then
                            Error('The Item Category Code of the Split-from Line ("%1" = %2) must be the same as the Item Category Code of the Split-to Line ("%3" = %4).', ItemRec."Item Category Code", SplitFromItemCategoryCode, ItemRec."Item Category Code",
                                  SplitToItemCategoryCode);
                    end;

                    trigger OnValidate()
                    var
                        ItemUnitOfMeasureRec: Record "Item Unit of Measure";
                        BaseUnitOfMeasure: Code[10];
                        ItemRec: Record Item;
                    begin
                        if SplitToItemNo = '' then
                            Error('Split-to Item No. must be filled.');
                        ItemUnitOfMeasureRec.SetRange("Item No.", SplitToItemNo);
                        ItemUnitOfMeasureRec.SetRange("Code", SplitFromUOMCode);
                        if not ItemUnitOfMeasureRec.FindSet() then begin
                            ItemRec.Get(SplitToItemNo);
                            BaseUnitOfMeasure := ItemRec."Base Unit of Measure";
                            if BaseUnitOfMeasure = '' then
                                Error('Base Unit of Measure must be filled for the selected item.')
                            else
                                SplitToUOMCode := BaseUnitOfMeasure;
                        end;
                    end;
                }

                field("Split-to UOM Code"; SplitToUOMCode)
                {
                    ApplicationArea = All;
                    Caption = 'Unit of Measure Code';
                }

                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    MinValue = 0;
                    trigger OnValidate()
                    var
                        ErrorMsgLbl: Label 'The Quantity for Splitting-up Transfer Line cannot be more than "Available Quantity" = %1.', Comment = 'Error message for quantity validation';
                    begin
                        if Quantity > AvailableQuantity then
                            Error(ErrorMsgLbl);
                    end;

                }

                field("Qty. per Split-from UOM"; QtyPerSplitFromUOM)
                {
                    ApplicationArea = All;
                    Caption = 'Qty. per Split-from Unit of Measure';
                    Editable = false;
                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                        ItemUOMRecTo: Record "Item Unit of Measure";
                        QtyPerUnitMeasureTo: Decimal;
                        TransferLineRec: Record "Transfer Line";
                    begin
                        if ItemRec.Get(SplittoItemNo) then
                            if ItemRec."Item Category Code" <> TransferLineRec."Item Category Code" then
                                ItemUOMRecTo.Reset();
                        ItemUOMRecTo.SetRange("Item No.", SplittoItemNo);
                        ItemUOMRecTo.SetRange(Code, SplittoUOMCode);
                        if ItemUOMRecTo.FindFirst() then begin
                            QtyPerUnitMeasureTo := ItemUOMRecTo."Qty. per Unit of Measure";
                            if QtyPerUnitMeasureTo = 0 then begin
                                Error('The Qty. per Unit of Measure for the Split-to UOM Code is 0. Cannot proceed with this UOM.');
                                SplittoUOMCode := '';
                                exit;
                            end;
                            Quantity := Quantity * QtyPerUnitMeasureTo;
                        end
                        else begin
                            Error('Cannot find Item Unit of Measure for Split-to Item No. and UOM Code.');
                            SplittoUOMCode := '';
                            exit;
                        end;

                    end;

                }

                field("Quantity (Base)"; QuantityBase)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity (Base)';
                    MinValue = 0;
                    Editable = false;
                    trigger OnValidate()
                    var
                        ItemUnitOfMeasureRecTo: Record "Item Unit of Measure";
                        QtyPerUnitTo: Decimal;
                        InitValue: Decimal;
                        ErrorMsgLbl: Label 'The value of the "%1" cannot be 0.';
                    begin
                        ItemUnitOfMeasureRecTo.SetRange("Item No.", SplitToItemNo);
                        ItemUnitOfMeasureRecTo.SetRange("Code", SplitToUOMCode);

                        if ItemUnitOfMeasureRecTo.FindFirst() then begin
                            QtyPerUnitTo := ItemUnitOfMeasureRecTo."Qty. per Unit of Measure";
                            InitValue := Quantity * QtyPerUnitTo;

                            if InitValue = 0 then
                                Error(ErrorMsgLbl);//"Split-to UOM Code" The name 'Split-to UOM Code' does not exist in the current context
                        end;
                    end;
                }

            }

        }
    }
    var
        SplitfromItemNo: Code[20];
        SplitfromUOMCode: Code[10];
        AvailableQuantity: Decimal;
        SplittoItemNo: Code[20];
        SplitToUOMCode: Code[10];
        Quantity: Decimal;
        QtyPerSplitFromUOM: Decimal;
        QuantityBase: Decimal;

    trigger OnOpenPage()
    var
        TransferLineRec: Record "Transfer Line";
    begin
        if TransferLineRec.Get(TransferLineRec."Document No.", TransferLineRec."Line No.") then
            SplitFromItemNo := TransferLineRec."Item No.";
        SplitFromUOMCode := TransferLineRec."Unit of Measure Code";
        AvailableQuantity := TransferLineRec."Quantity" - TransferLineRec."Quantity Shipped";
    end;

    procedure CreateTransferLine()
    var
        TransferLineRec: Record "Transfer Line";
        SourceTransferLineRec: Record "Transfer Line";
        QuantityToSplit: Decimal;
        DocumentNo: Code[20];
        LineNo: Code[20];
        NextLineNo: Integer;
        CurrentTransferLine: Record "Transfer Line";
    begin
        if SourceTransferLineRec.Get(DocumentNo, LineNo) then begin
            TransferLineRec.Init();
            TransferLineRec."Document No." := SourceTransferLineRec."Document No.";
            TransferLineRec."Line No." := NextLineNo;
            TransferLineRec."Item No." := SplitToItemNo;
            QuantityToSplit := Quantity / QtyPerSplitFromUOM;
            TransferLineRec.Quantity := QuantityToSplit;
            TransferLineRec."Unit of Measure Code" := SplitToUOMCode;
            TransferLineRec."Shipment Date" := SourceTransferLineRec."Shipment Date";
            TransferLineRec."Receipt Date" := SourceTransferLineRec."Receipt Date";
            TransferLineRec."Split-from Line No." := SourceTransferLineRec."Line No.";
            TransferLineRec."Split-up Qty. per UOM" := QtyPerSplitFromUOM;
            TransferLineRec."Dimension Set ID" := SourceTransferLineRec."Dimension Set ID";
            TransferLineRec.Validate("Item No.");
            TransferLineRec.Validate("Quantity");
            TransferLineRec.Validate("Unit of Measure Code");
            TransferLineRec.Insert();

        end;
    end;
}
