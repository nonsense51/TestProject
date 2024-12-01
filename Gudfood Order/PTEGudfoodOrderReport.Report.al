report 50103 "PTE Gudfood Order Report"
{
    Caption = 'Gudfood Order Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Gudfood Order/layout/GudfoodOrder.rdlc';
    dataset
    {
        dataitem(OrderHeader; "PTE Gudfood Order Header")
        {
            DataItemTableView = WHERE("No." = CONST(''));
            RequestFilterFields = "No.";

            column("OrderNo"; "No.")
            {
                Caption = 'Order No.';
            }
            column("OrderDate"; "Order Date")
            {
                Caption = 'Order Date';
            }
            column("SellToCustomerNo"; "Sell-to Customer No.")
            {
                Caption = 'Customer No.';
            }
            column("SellToCustomerName"; "Sell-to Customer Name")
            {
                Caption = 'Customer Name';
            }
            column("DateCreated"; "Date Created")
            {
                Caption = 'Date Created';
            }

            dataitem(OrderLines; "PTE Gudfood Order Line")
            {
                DataItemLink = "Order No." = FIELD("No.");
                DataItemTableView = SORTING("Line No.") ORDER(Ascending);

                column("ItemNo"; "Item No.")
                {
                    Caption = 'Item No.';
                }
                column("ItemType"; "Item Type")
                {
                    Caption = 'Item Type';
                }
                column("Description"; "Description")
                {
                    Caption = 'Description';
                }
                column("Quantity"; "Quantity")
                {
                    Caption = 'Quantity';
                }
                column("UnitPrice"; "Unit Price")
                {
                    Caption = 'Unit Price';
                }
                column("Amount"; "Amount")
                {
                    Caption = 'Amount';
                }
            }
        }
    }



    requestpage
    {
        layout
        {
            area(content)
            {
                group(FilterGroup)
                {
                    Caption = 'Filters';

                    field("OrderNo"; OrderNoFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Order No.';
                        ToolTip = 'Specify the order number to print.';
                        trigger OnValidate()
                        begin
                            OrderHeader.SetFilter("No.", OrderNoFilter);
                        end;
                    }
                }
            }
        }

        var
            OrderNoFilter: Text;
    }
}
