unit Chess_Game_1_vs_1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Chess_Main_Menu;

procedure TForm2.FormCreate(Sender: TObject);
begin
    with Form2 do
    begin
        ClientHeight := FormMainMenu.ClientStartHeight;
        ClientWidth := FormMainMenu.ClientStartWidth;
    end;
end;

end.
