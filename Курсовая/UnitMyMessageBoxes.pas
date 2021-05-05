unit UnitMyMessageBoxes;

interface

uses
    Winapi.Windows;

function MyMessageBoxYesNo(CaptionWindow, TextMessage: String; IsWarning: Boolean = False) : Boolean;
procedure MyMessageBoxInfo(CaptionWindow, TextMessage: String; IsWarning: Boolean = False);

implementation

uses UnitMainForm;

function MyMessageBoxYesNo(CaptionWindow, TextMessage: String; IsWarning: Boolean = False) : Boolean;
var
   Tip: Integer;
   Answer: Boolean;

begin
    Tip:=MB_YESNO;
    if IsWarning then
        Tip := Tip + MB_ICONWARNING
    else
        Tip := Tip + MB_ICONQUESTION;
    Answer := MessageBox(FormMain.Handle,Pchar(TextMessage),Pchar(CaptionWindow),Tip) = IDYES;
    Result := Answer;
end;

procedure MyMessageBoxInfo(CaptionWindow, TextMessage: String; IsWarning: Boolean = False);
var
   Tip: Integer;
   Answer: Boolean;

begin
    Tip:=MB_OK + MB_DEFBUTTON1;
    if IsWarning then
        Tip := Tip + MB_ICONWARNING
    else
        Tip := Tip + MB_ICONINFORMATION;
    MessageBox(FormMain.Handle,Pchar(TextMessage),Pchar(CaptionWindow),Tip);
end;

end.
