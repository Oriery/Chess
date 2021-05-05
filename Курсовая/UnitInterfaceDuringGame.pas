unit UnitInterfaceDuringGame;

interface

uses
    Vcl.Controls, Vcl.Dialogs;

procedure ResignGame();
procedure ExitToMainMenu();
procedure DrawGame();

implementation

uses UnitMainForm, UnitAfterGameFinished, UnitSetupBoard, UnitMyMessageBoxes;

procedure ResignGame();
var
    WhoResigns: String;

begin
    if WhiteIsToMove then
        WhoResigns := 'Белые'
    else
        WhoResigns := 'Чёрные';

    if MyMessageBoxYesNo('Сдаться?', WhoResigns + ' сдаются?') then
        if WhiteIsToMove then
            DoAfterGameEnded(Black, Resign)
        else
            DoAfterGameEnded(White, Resign);
end;

procedure ExitToMainMenu();
var
    CanExit: Boolean;

begin
    with FormMain do
    begin
        CanExit := GameIsSaved or MyMessageBoxYesNo('Выход в главное меню',
            'Вы уверены, что хотите выйти в главное меню?' + #10#13 +
            'Несохранённая партия будет утеряна.', True);

        if CanExit then
        begin
            TimerForTimer.Enabled := False;
            GameIsSaved := True;

            PageControl1.ActivePageIndex := 0;
            ClearChessboard();
            SetLength(ArrOfFigures, 0);

            PanelGameEnded.Visible := False;
            PanelChoiceOfTransPawnForBlack.Visible := False;
            PanelChoiceOfTransPawnForWhite.Visible := False;
        end;
    end;
end;

procedure DrawGame();
begin
    if MyMessageBoxYesNo('Ничья?',
            'Завершить партию с результатом "Ничья"?') then
        DoAfterGameEnded(Draw, DrawByAgreement);
end;

end.
