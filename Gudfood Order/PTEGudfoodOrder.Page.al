page 50102 "PTE Gudfood Order"
{
    PageType = Card;
    SourceTable = "PTE Gudfood Order Header";
    ApplicationArea = All;
    Caption = 'Gudfood Order';
    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Order Details';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to Customer No.';
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to Customer Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field.';
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
                    Editable = false;
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Total Qty"; Rec."Total Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Total Quantity';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Quantity field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
            }
            part("Lines"; "PTE Gudfood Order Subpage")

            {
                SubPageLink = "Order No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Post;
                ToolTip = 'Executes the Post action.';
                trigger OnAction()
                var
                    GudfoodOrderLine: Record "PTE Gudfood Order Line";
                    GudfoodOrderHeader: Record "PTE Gudfood Order Header";
                    SalesReceivablesSetup: Record "Sales & Receivables Setup";
                    PostedOrderHeader: Record "PTE Pstd Gudfood Ordr Header";
                    PostedOrderLine: Record "PTE Pstd Gudfood Ordr Line";
                    NoSeries: Codeunit "No. Series";
                    NewPostedDocNo: Code[20];
                begin
                    GudfoodOrderHeader.Get(Rec."No.");
                    SalesReceivablesSetup.Get();
                    SalesReceivablesSetup.TestField("PTE Posted Gudfood Order Nos.");
                    NewPostedDocNo := NoSeries.GetNextNo(SalesReceivablesSetup."PTE Posted Gudfood Order Nos.");
                    PostedOrderHeader.Init();
                    PostedOrderHeader.TransferFields(GudfoodOrderHeader);
                    PostedOrderHeader."No." := NewPostedDocNo;
                    PostedOrderHeader.Insert();
                    GudfoodOrderLine.SETRANGE("Order No.", Rec."No.");
                    GudfoodOrderLine.SetFilter("Order No.", '*a*');
                    if GudfoodOrderLine.FINDSET() then
                        repeat
                            PostedOrderLine.Init();
                            PostedOrderLine.TransferFields(GudfoodOrderLine);
                            PostedOrderLine."Order No." := PostedOrderHeader."No.";
                            PostedOrderLine.Insert();
                        until GudfoodOrderLine.NEXT() = 0;
                    GudfoodOrderHeader.Delete(true)
                end;

            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;
                ToolTip = 'Executes the Print action.';

                trigger OnAction()
                begin
                    Report.Run(50103, true, false, Rec);
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        Rec."Date Created" := Today;
        SalesReceivablesSetup.Get();
        SalesReceivablesSetup.TestField("PTE Gudfood Order Nos.");
        Rec."No." := NoSeries.GetNextNo(SalesReceivablesSetup."PTE Gudfood Order Nos.");
    end;
}
