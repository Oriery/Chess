unit UnitPawnTransformation;

interface

uses
    System.SysUtils, UnitCreatingFigures;

procedure PawnTransformation(Figure: TFigure);
procedure EndPawnTransformation(NewTypeOfFigure: Char);

implementation

uses UnitMainForm, UnitSetupBoard, UnitMakeAMove, UnitReplayAndNotation;

procedure PawnTransformation(Figure: TFigure);
begin
    with FormMain do
    begin
        ButtonResign.Enabled := False;
        ButtonDraw.Enabled := False;

        with Figure do
            if FIsWhite then
                with PanelChoiceOfTransPawnForWhite do
                begin
                    if Parent <> PanelForBoard then
                    begin
                        Parent := PanelForBoard;
                        Top := Round(PanelForBoard.Height / 2 - Height / 2);
                        Left := Round(PanelForBoard.Width / 2 - Width / 2);
                    end;
                    Visible := True;
                end
            else
                with PanelChoiceOfTransPawnForBlack do
                begin
                    if Parent <> PanelForBoard then
                    begin
                        Parent := PanelForBoard;
                        Top := Round(PanelForBoard.Height / 2 - Height / 2);
                        Left := Round(PanelForBoard.Width / 2 - Width / 2);
                    end;
                    Visible := True;
                end;
    end;
end;

procedure EndPawnTransformation(NewTypeOfFigure: Char);
var
    Figure: TFigure;
    Cell: TCell;

begin
    with FormMain do
    begin
        BoardReal[StrToInt(LastMove[3])][StrToInt(LastMove[4])].CellFigureName :=
          NewTypeOfFigure;
        Cell := BoardReal[StrToInt(LastMove[3])][StrToInt(LastMove[4])];
        Figure := ArrOfFigures[Cell.CellFigureIndex];
        Figure.FFigureType := NewTypeOfFigure;

        with Figure do
            if Figure.FIsWhite then
                case NewTypeOfFigure of
                    'Q': Picture := ImageWQ.Picture;
                    'R': Picture := ImageWR.Picture;
                    'B': Picture := ImageWB.Picture;
                    'N': Picture := ImageWN.Picture;
                end
            else
                case NewTypeOfFigure of
                    'Q': Picture := ImageBQ.Picture;
                    'R': Picture := ImageBR.Picture;
                    'B': Picture := ImageBB.Picture;
                    'N': Picture := ImageBN.Picture;
                end;

        BufferFor1Move := BufferFor1Move + NewTypeOfFigure;

        with Figure do
            if FIsWhite then
                PanelChoiceOfTransPawnForWhite.Visible := False
            else
                PanelChoiceOfTransPawnForBlack.Visible := False;


        ButtonResign.Enabled := True;
        ButtonDraw.Enabled := True;

        AfterPawnTranformedOrNot();
    end;
end;

end.
