pageextension 50002 "Transfer Order Subform Ext" extends "Transfer Order Subform"
{
    actions
    {
        addlast("F&unctions")
        {
            action(SplitUpTransferLine)
            {
                Caption = 'Split-up Transfer Line';
                Image = SplitLines;
                Ellipsis = true;
                trigger OnAction()
                var
                    SplitUpCodeunit: Codeunit "PTE Transfer Line SplitUp";
                begin
                    SplitUpCodeunit.Run();
                end;

                // trigger OnClosePage(CloseAction: Action)

                // begin
                //     if CloseAction = Action::OK then
                //         ValidateSplitUpVariables(SplitToItemNo, SplitToUOMCode, Quantity);
                // end;

            }

        }
    }
}
