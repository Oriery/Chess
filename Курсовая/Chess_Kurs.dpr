program Chess_Kurs;

uses
  Vcl.Forms,
  UnitMainForm in 'UnitMainForm.pas' {FormMain},
  Vcl.Themes,
  Vcl.Styles,
  UnitWorkWithFiles in 'UnitWorkWithFiles.pas',
  UnitCreatingFigures in 'UnitCreatingFigures.pas',
  UnitReplayAndNotation in 'UnitReplayAndNotation.pas',
  UnitSetupBoard in 'UnitSetupBoard.pas',
  UnitTimer in 'UnitTimer.pas',
  UnitAfterGameFinished in 'UnitAfterGameFinished.pas',
  UnitCheckChecksMatesAndStalemates in 'UnitCheckChecksMatesAndStalemates.pas',
  UnitCheckMoveIsLegal in 'UnitCheckMoveIsLegal.pas',
  UnitGrabbingFigures in 'UnitGrabbingFigures.pas',
  UnitMakeAMove in 'UnitMakeAMove.pas',
  UnitPawnTransformation in 'UnitPawnTransformation.pas',
  UnitInterfaceDuringGame in 'UnitInterfaceDuringGame.pas',
  UnitMyMessageBoxes in 'UnitMyMessageBoxes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
