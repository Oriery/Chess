unit UnitSetupBoard;

interface

uses
    Winapi.Windows, Vcl.Forms, Vcl.Dialogs, System.UITypes;

type
    TCell = Record
        CellFigureName: Char; // '0'(������), K, Q, R, N, B, P
        CellFigureColorIsWhite: Boolean;
        CellFigureIndex: Byte;
    End;

    TBoard = Array [1 .. 8, 1 .. 8] of TCell;

const
    TopOfBoard = 50;
    LeftOFBoard = 30;
    WidthOfBoard = 546;
    WidthOfEdgePlusAdjust = 6 + 3;
    SizeOfCell = 66;
    // ������������ ����������� 800*800 ����� ������� ������� � 10 � ������
    // ������ ������ � ������������ 110 (����������� 10).
    // �� ���� �� ����� ���� � ����������� (10), � ������ (10) - ����� 20.
    // ����������� � ��������� ����� ������ 3/5 �� ��������� (480x480).
    SizeOfFigureComparedToCell = 0.8;

procedure StartNewGameAfterPrevFinished();
procedure SetupBoardOnStartOfForm();
procedure ResetChessboardToStandart();
procedure ClearChessboard();

implementation

uses UnitMainForm, UnitCreatingFigures, UnitTimer, UnitMyMessageBoxes, UnitReplayAndNotation,
    UnitGrabbingFigures, UnitMakeAMove;


procedure ResetChessboardToStandart();
begin
    with FormMain do
    begin
        ClearChessboard();

        ImageBoard.Picture := ImageBoardLight.Picture;

        PlaceFiguresOnStandartPlace();

        GameIsSaved := True;
        WhiteIsToMove := True;
        NowIsTakingOnAisle := False;
        NowIsCastling := False;
        NowCheck := False;

        SetLength(Game.AllBoards, 0);
        Game.GameEnded := False;

        Game.TimeRemainingW := DefaultTimeOnTimer;
        Game.TimeRemainingB := DefaultTimeOnTimer;
        ShowTimeOnTimer(True);
        ShowTimeOnTimer(False);
        ImagePauseAndStartTimer.Picture := ImagePause.Picture;
        ImagePauseAndStartTimer.Visible := False;
        LabelPause.Visible := False;


        ListBoxNotationW.Clear();
        ListBoxNotationB.Clear();
        ListBoxNotationNum.Clear();

        TimerForTimer.Enabled := False;

        PanelForReplay.Visible := False;
        PanelChoiceOfTransPawnForBlack.Visible := False;
        PanelChoiceOfTransPawnForWhite.Visible := False;
        PanelGameEnded.Visible := False;

        LastMove := '    ';

        ItemIndexW := -1;
        ItemIndexB := -1;

        NowAnimating := False;
        ButtonResign.Enabled := False;
        ButtonDraw.Enabled := False;

        NSaveAs.Enabled := False;
    end;
end;

procedure ClearChessboard();
var
    i, j: Integer;

begin
    for i := 0 to High(ArrOfFigures) do
        if ArrOfFigures[i] <> nil then
            ArrOfFigures[i].Destroy;
    SetLength(ArrOfFigures, 0);

    for i := 1 to 8 do
        for j := 1 to 8 do
            BoardReal[i][j].CellFigureName := '0';
end;

procedure SetupBoardOnStartOfForm();
begin
    with FormMain do
    begin
        PageControl1.ActivePageIndex := 0;

        GameIsSaved := True;

        SizeOfFigure := Round(SizeOfCell * SizeOfFigureComparedToCell);
        ShiftOfFigure := Round(SizeOfCell * (1 - SizeOfFigureComparedToCell) / 2);

        MultPix := LabelToMeasureScreenOfUser.Width / 100;

        ImageBoard.Picture := ImageBoardLight.Picture;

        Screen.Cursors[1] :=
          HCursor(LoadCursorFromFile('Wii Pointer Open Hand.cur'));
        Screen.Cursors[2] := HCursor(LoadCursorFromFile('Wii Pointer Grab.cur'));
        Screen.Cursors[3] := HCursor(LoadCursorFromFile('Wii Pointer.cur'));
        Screen.Cursor := 3;

        with ImageBackGround do
        begin
            Left := 0;
            Top := -Round(FormMain.ClientHeight / 4);
            Width := FormMain.ClientWidth;
            Height := Round(FormMain.ClientHeight * 16 / 9);
        end;

        With PanelForBoard do
        begin
            Top := MultPixels(TopOfBoard);
            Left := MultPixels(LeftOFBoard);
            Width := MultPixels(WidthOfBoard);
            Height := MultPixels(WidthOfBoard);
        end;

        With ImageBoard do
        begin
            Top := 0;
            Left := 0;
            Width := MultPixels(WidthOfBoard);
            Height := MultPixels(WidthOfBoard);
        end;

        ResetChessboardToStandart();
    end;
end;

procedure StartNewGameAfterPrevFinished();
var
    SaidNoSaving: Boolean;

begin
    SaidNoSaving := False;

    with FormMain do
    begin
        if not GameIsSaved then
            if MyMessageBoxYesNo('��������� ������?', '�� ������ ��������� ������� ������?' +
            #10#13 + '����� ������� ������ ����� �������.', True) then
                NSaveAsClick(FormMain)
            else
                SaidNoSaving := True;

        if GameIsSaved or SaidNoSaving or MyMessageBoxYesNo('������ ����� ������?', '�� �������, ��� ������ ������ ����� ������?' + #10#13 +
            '������� ������ ����� �������.', True) then
        begin
            ResetChessboardToStandart();
            PanelGameEnded.Visible := False;
        end;
    end;
end;

end.
