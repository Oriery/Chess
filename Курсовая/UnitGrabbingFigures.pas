unit UnitGrabbingFigures;

interface

uses
    System.Classes, Vcl.Controls, Vcl.Forms, Math, UnitCreatingFigures;

type
    TCoord = Record
        Top, Left: SmallInt;
    End;

procedure MouseStartsToGrabFigure(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
procedure MouseMovesOverFigure(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
procedure MouseFinishesToGrabFigure(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
function CountCoordinatesOfFigure(PosX, PosY: Byte): TCoord;
procedure ScaleFigure(Figure: TFigure; Scale: Single);

var
    ShiftOfFigure: Byte;

implementation

uses UnitMainForm, UnitTimer, UnitCheckMoveIsLegal, UnitMakeAMove, UnitSetupBoard;

const
    ScaleWhileFigureOnDrag = 1.08;

var
    DragShiftX, DragShiftY: SmallInt;

procedure MouseStartsToGrabFigure(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    StartTimerAfterPauseIfWasPaused();

    if not Game.GameEnded and not NowAnimating and ((Sender as TFigure).FIsWhite = WhiteIsToMove) then
    begin
        With Sender as TFigure do
            if not FIsOnDrag then
            begin
                FIsOnDrag := True;
                ScaleFigure(Sender as TFigure, ScaleWhileFigureOnDrag);
                DragShiftX :=
                  X + Round(FormMain.MultPixels(SizeOfFigure) *
                  ((ScaleWhileFigureOnDrag - 1) / 2));
                DragShiftY :=
                  Y + Round(FormMain.MultPixels(SizeOfFigure) *
                  ((ScaleWhileFigureOnDrag - 1) / 2));
                BringToFront;
            end;

        Screen.Cursor := 2;
    end;
end;


procedure MouseMovesOverFigure(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
    ShiftState: TShiftState;
    MouseButton: TMouseButton;

begin
    with FormMain do
    if not Game.GameEnded then
        With Sender as TFigure do
        begin
            if FIsOnDrag then
            begin
                // Moving Centre Of Figure To Cursor
                DragShiftX := Round(DragShiftX - Power(0.3 * Abs(DragShiftX - Width / 2), 0.5) * (2 * Ord(DragShiftX > Width / 2) - 1));
                DragShiftY := Round(DragShiftY - Power(0.3 * Abs(DragShiftY - Width / 2), 0.5) * (2 * Ord(DragShiftY > Height / 2) - 1));

                Left := Left + X - DragShiftX;
                Top := Top + Y - DragShiftY;

                MouseButton := mbLeft;

                // Moving figure back if it is not above board
                if (Left < -MultPixels(SizeOfFigure)) or
                  (Top < -MultPixels(SizeOfFigure)) or
                  (Left > PanelForBoard.Width + MultPixels(SizeOfFigure)) or
                  (Top > PanelForBoard.Height + MultPixels(SizeOfFigure)) then
                    FigureMouseUp(Sender, MouseButton, ShiftState, 0, 0);
            end;
        end;
end;

procedure MouseFinishesToGrabFigure(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    PosX, PosY: Byte;
    Figure: TFigure;

begin
    if not Game.GameEnded then
    begin
        (Sender as TFigure).FIsOnDrag := False;

        With Sender as TFigure do
        begin
            PosX := Round((Left / MultPix - WidthOfEdgePlusAdjust -
              ShiftOfFigure) / SizeOfCell + 1);
            PosY := Round((WidthOfBoard + ShiftOfFigure - WidthOfEdgePlusAdjust
              - Round(Top / MultPix)) / SizeOfCell);
        end;

        Figure := Sender as TFigure;
        if CheckMoveLegal(Figure, PosX, PosY) then
            MakeAMove(Figure, PosX, PosY)
        else
        begin
            with Figure do
                MoveFigureToCell(BoardReal, Figure, FPosOnBoardX, FPosOnBoardY);
        end;

        NowIsTakingOnAisle := False;
        NowIsCastling := False;

        if not FormMain.TimerForAnimation.Enabled then
            if CheckIfFigureOfColorIsUnderCursor(WhiteIsToMove) then
                Screen.Cursor := 1
            else
                Screen.Cursor := 3;
    end;
end;

procedure ScaleFigure(Figure: TFigure; Scale: Single);
var
    CoordTemp: TCoord;

begin
    with FormMain do
        With Figure do
        begin
            CoordTemp := CountCoordinatesOfFigure(FPosOnBoardX, FPosOnBoardY);
            Left := CoordTemp.Left - Round(MultPixels(SizeOfFigure) *
              ((Scale - 1) / 2));
            Top := CoordTemp.Top - Round(MultPixels(SizeOfFigure) *
              ((Scale - 1) / 2));
            Width := Round(MultPixels(SizeOfFigure) * Scale);
            Height := Round(MultPixels(SizeOfFigure) * Scale);
        end;
end;

function CountCoordinatesOfFigure(PosX, PosY: Byte): TCoord;
var
    Output: TCoord;

begin
    with FormMain do
    begin
        Output.Top := MultPixels(WidthOfBoard + ShiftOfFigure -
          WidthOfEdgePlusAdjust - PosY * SizeOfCell);
        Output.Left := MultPixels(WidthOfEdgePlusAdjust + ShiftOfFigure + (PosX - 1)
          * SizeOfCell);
    end;

    Result := Output;
end;

end.
