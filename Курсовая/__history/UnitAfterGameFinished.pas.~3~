unit UnitAfterGameFinished;

interface

uses
    Vcl.Forms;

type
    TWhoWon = (White, Black, Draw);
    THowGameEnded = (Mate, Resign, ByTime, Stalemate, DrawByAgreement,
      DrawByNotEnoughFigures, DrawBy3SamePosition,
      DrawBy50MovesWithoutPawnMovedOrFigureCaptured, DrawOnTime);

procedure DoAfterGameEnded(WhoWon: TWhoWon; HowGameEnded: THowGameEnded);

implementation

uses UnitMainForm, UnitReplayAndNotation;

procedure ShowWhoWon(WhoWon: TWhoWon; HowGameEnded: THowGameEnded); forward;

procedure DoAfterGameEnded(WhoWon: TWhoWon; HowGameEnded: THowGameEnded);
begin
    with FormMain do
    begin
        Screen.Cursor := 3;
        Game.GameEnded := True;
        ButtonResign.Enabled := False;
        ButtonDraw.Enabled := False;
        TimerForTimer.Enabled := False;
    end;

    ShowWhoWon(WhoWon, HowGameEnded);
end;

procedure ShowWhoWon(WhoWon: TWhoWon; HowGameEnded: THowGameEnded);
begin
    with FormMain do
    begin
        case WhoWon of
            Draw:
                begin
                    ImageWhoWon.Picture := ImageDraw.Picture;
                    LabelWhoWon.Caption := 'НИЧЬЯ';

                    // Notation
                    BufferFor1Move := BufferFor1Move + ' 0.5-0.5';
                end;
            White:
                begin
                    ImageWhoWon.Picture := ImageWhite.Picture;
                    LabelWhoWon.Caption := 'БЕЛЫЕ ПОБЕДИЛИ';

                    // Notation
                    BufferFor1Move := BufferFor1Move + ' 1-0';
                end;
            Black:
                begin
                    ImageWhoWon.Picture := ImageBlack.Picture;
                    LabelWhoWon.Caption := 'ЧЁРНЫЕ ПОБЕДИЛИ';

                    // Notation
                    BufferFor1Move := BufferFor1Move + ' 0-1';
                end;
        end;
        case HowGameEnded of
            Mate:
                LabelHowGameEnded.Caption := 'Объявлен мат';
            Stalemate:
                LabelHowGameEnded.Caption := 'Объявлен пат';
            ByTime:
                LabelHowGameEnded.Caption := 'по времени';
            Resign:
                if WhoWon = White then
                    LabelHowGameEnded.Caption := 'Чёрные сдались'
                else
                    LabelHowGameEnded.Caption := 'Белые сдались';
            DrawByAgreement:
                LabelHowGameEnded.Caption := 'Стороны договорились';
            DrawByNotEnoughFigures:
                LabelHowGameEnded.Caption := 'Невозможно объявить мат';
            DrawBy3SamePosition:
                LabelHowGameEnded.Caption := 'по повторению позиции';
            DrawBy50MovesWithoutPawnMovedOrFigureCaptured:
                LabelHowGameEnded.Caption := 'по правилу 50-ти ходов';
            DrawOnTime:
                LabelHowGameEnded.Caption := 'по времени';
        end;

        with PanelGameEnded do
        begin
            if Parent <> PanelForBoard then
            begin
                Parent := PanelForBoard;
                Top := Round(PanelForBoard.Height / 2 - Height / 2);
                Left := Round(PanelForBoard.Width / 2 - Width / 2);
            end;
            Visible := True;
        end;

        // Notation
        if (HowGameEnded <> Mate) and (HowGameEnded <> StaleMate) then
            if WhiteIsToMove then
            begin
                ListBoxNotationB.Items.Delete(ListBoxNotationB.Count - 1);
                ListBoxNotationB.Items.Add(BufferFor1Move);
            end
            else
            begin
                ListBoxNotationW.Items.Delete(ListBoxNotationW.Count - 1);
                ListBoxNotationW.Items.Add(BufferFor1Move);
                CorrectLengthOfScrollboxForNotation();
            end;
    end;
end;

end.
