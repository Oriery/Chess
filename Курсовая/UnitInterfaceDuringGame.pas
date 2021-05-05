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
        WhoResigns := '�����'
    else
        WhoResigns := '׸����';

    if MyMessageBoxYesNo('�������?', WhoResigns + ' �������?') then
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
        CanExit := GameIsSaved or MyMessageBoxYesNo('����� � ������� ����',
            '�� �������, ��� ������ ����� � ������� ����?' + #10#13 +
            '������������ ������ ����� �������.', True);

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
    if MyMessageBoxYesNo('�����?',
            '��������� ������ � ����������� "�����"?') then
        DoAfterGameEnded(Draw, DrawByAgreement);
end;

end.
