codeunit 50000 "Lift"
{

    var
        FirstFloor, LastFloor : Integer;

    trigger OnRun()
    begin
        FirstFloor := 1;
        LastFloor := 25;
        FindBestLift(22, 21, 25);
    end;

    local procedure FindBestLift(CurrFloor: Integer; LiftFloor1: Integer; LiftFloor2: Integer) ChoosenLift: Option "1","2";
    var
        distan1: Integer;
        distant2: Integer;
    begin
        distan1 := CurrFloor - LiftFloor1;
        distant2 := CurrFloor - LiftFloor2;
        if distan1 < 0 then
            distan1 := (distan1 * -1);

        if distant2 < 0 then
            distant2 := (distant2 * -1);

        if (distan1 > distant2) then
            ChoosenLift := ChoosenLift::"2"
        else
            ChoosenLift := ChoosenLift::"1"

    end;

    local procedure TwoSums(Nums: List of [Decimal]; Target: Decimal): List of [Decimal]
    var
        CurrNum: Decimal;
    begin
        foreach CurrNum in Nums do begin

        end;
    end;
}
