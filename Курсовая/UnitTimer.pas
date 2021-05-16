unit UnitTimer;

interface

uses
    System.SysUtils;

const
    DefaultTimeOnTimer = 900;
    DefaultAddingOnTimer = 10;

procedure ShowTimeOnTimer(IsWhite: Boolean);
procedure TimerEvery1Second();
procedure PauseAndStartTimer();
procedure StartTimerAfterPauseIfWasPaused();

implementation

uses UnitMainForm, UnitAfterGameFinished;

procedure TimerEvery1Second();
var
    TimeRemaining: SmallInt;

begin
    with FormMain do
    if not Game.GameEnded then
    begin
        if WhiteIsToMove then
            TimeRemaining := Game.TimeRemainingW
        else
            TimeRemaining := Game.TimeRemainingB;

        if WhiteIsToMove then
            Dec(Game.TimeRemainingW)
        else
            Dec(Game.TimeRemainingB);

        ShowTimeOnTimer(WhiteIsToMove);

        Dec(TimeRemaining);
        if TimeRemaining < 1 then
            if WhiteIsToMove then
                DoAfterGameEnded(Black, ByTime)
            else
                DoAfterGameEnded(White, ByTime);
    end;
end;

procedure PauseAndStartTimer();
begin
    with FormMain do
    begin
        with LabelPause do
            if Parent <> PanelForBoard then
            begin
                Parent := PanelForBoard;
                Top := Round(PanelForBoard.Width / 2 - Height / 2);
                Left := Round(PanelForBoard.Width / 2 - Width / 2);
            end;

        if TimerForTimer.Enabled then
        begin
            ImagePauseAndStartTimer.Picture := ImageGo.Picture;
            LabelPause.Visible := True;
            ImageBoard.Picture := ImageBoardDark.Picture;
            BringToFront();
        end
        else
        begin
            ImagePauseAndStartTimer.Picture := ImagePause.Picture;
            LabelPause.Visible := False;
            ImageBoard.Picture := ImageBoardLight.Picture;
        end;

        TimerForTimer.Enabled := not TimerForTimer.Enabled;
    end;
end;

procedure StartTimerAfterPauseIfWasPaused();
begin
    with FormMain do
        if LabelPause.Visible then
        begin
            PauseAndStartTimer();
        end;
end;

procedure ShowTimeOnTimer(IsWhite: Boolean);
var
    TimeRemaining: SmallInt;
    StrTime: String;

begin
    StrTime := '';

    with FormMain do
    begin
        if IsWhite then
            TimeRemaining := Game.TimeRemainingW
        else
            TimeRemaining := Game.TimeRemainingB;

        // hours
        if TimeRemaining div 3600 > 0 then
        begin
            if TimeRemaining div 3600 < 10 then
                StrTime := '0';

            StrTime := StrTime + IntToStr(TimeRemaining div 3600) + ':';
            TimeRemaining := TimeRemaining mod 3600;
        end;

        // minutes
        if TimeRemaining div 60 < 10 then
            StrTime := StrTime + '0';

        StrTime := StrTime + IntToStr(TimeRemaining div 60) + ':';
        TimeRemaining := TimeRemaining mod 60;

        // seconds
        if TimeRemaining < 10 then
            StrTime := StrTime + '0';

        StrTime := StrTime + IntToStr(TimeRemaining);

        if IsWhite then
            LabelTimeW.Caption := StrTime
        else
            LabelTimeB.Caption := StrTime;
    end;
end;

end.
