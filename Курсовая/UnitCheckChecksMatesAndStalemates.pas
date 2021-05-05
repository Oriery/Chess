unit UnitCheckChecksMatesAndStalemates;

interface

uses
    UnitCreatingFigures, UnitSetupBoard;

function FindKing(KingIsWhite: Boolean): TFigure;
function CheckIfCellIsNotAttacked(Board: TBoard;
    CoorX, CoorY: Byte; AttackedByWhiteFigures: Boolean): Boolean;
procedure CheckIfCheckOrMateOrStaleMate();

implementation

uses UnitMainForm, UnitAfterGameFinished, UnitCheckMoveIsLegal;

function CheckIfThereAreAvailableMoves(): Boolean; forward;

procedure CheckIfCheck();
var
    King: TFigure;

begin
    King := FindKing(WhiteIsToMove);
    with King do
        NowCheck := not CheckIfCellIsNotAttacked(BoardReal, FPosOnBoardX,
          FPosOnBoardY, not FIsWhite);
end;

function FindKing(KingIsWhite: Boolean): TFigure;
var
    King: TFigure;
    i: Byte;

begin
    i := 0;
    King := nil;

    while (i < Length(ArrOfFigures)) and (King = nil) do
    begin
        if (ArrOfFigures[i] <> nil) and (ArrOfFigures[i].FFigureType = 'K') and
          (ArrOfFigures[i].FIsWhite = KingIsWhite) then
            King := ArrOfFigures[i];
        Inc(i);
    end;

    Result := King;
end;

procedure CheckIfCheckOrMateOrStaleMate();
var
    ThereAreAvailableMoves: Boolean;
    WhoWon: TWhoWon;
    HowGameEnded: THowGameEnded;

begin
    CheckIfCheck();

    ThereAreAvailableMoves := CheckIfThereAreAvailableMoves();
    if not ThereAreAvailableMoves then
    begin
        if NowCheck then
        begin
            HowGameEnded := Mate;
            if WhiteIsToMove then
                WhoWon := Black
            else
                WhoWon := White;

            // Notation
            BufferFor1Move := BufferFor1Move + '#';
        end
        else
        begin
            HowGameEnded := Stalemate;
            WhoWon := Draw;

            // Notation
            BufferFor1Move := BufferFor1Move + '=';
        end;

        DoAfterGameEnded(WhoWon, HowGameEnded);
    end
    else if NowCheck then
        // Notation
        BufferFor1Move := BufferFor1Move + '+';
end;

function CheckIfThereAreAvailableMoves(): Boolean;
var
    ThereIsNoLegalMoves: Boolean;
    i, PosX, PosY: Byte;

begin
    ThereIsNoLegalMoves := True;
    i := 0;
    while (i < Length(ArrOfFigures)) and ThereIsNoLegalMoves do
    begin
        if (ArrOfFigures[i] <> nil) and
          (ArrOfFigures[i].FIsWhite = WhiteIsToMove) then
        begin
            PosX := 1;
            while (PosX < 9) and ThereIsNoLegalMoves do
            begin
                PosY := 1;
                while (PosY < 9) and ThereIsNoLegalMoves do
                begin
                    ThereIsNoLegalMoves := not CheckMoveLegal(ArrOfFigures[i],
                      PosX, PosY);
                    Inc(PosY);
                end;
                Inc(PosX);
            end;
        end;
        Inc(i);
    end;

    Result := not ThereIsNoLegalMoves;
end;

function CheckIfCellIsNotAttacked(Board: TBoard;
  CoorX, CoorY: Byte; AttackedByWhiteFigures: Boolean): Boolean;
var
    Figure: TFigure;
    i: Byte;
    IsNotAttacked: Boolean;

begin
    IsNotAttacked := True;
    i := 0;
    while (i < Length(ArrOfFigures)) and IsNotAttacked do
    begin
        if (ArrOfFigures[i] <> nil) and
          (ArrOfFigures[i].FIsWhite = AttackedByWhiteFigures) then
        begin
            Figure := ArrOfFigures[i];
            IsNotAttacked := not CheckMoveLegalPhysically(Board, Figure,
              CoorX, CoorY);
        end;
        Inc(i);
    end;
    Result := IsNotAttacked;
end;

end.
