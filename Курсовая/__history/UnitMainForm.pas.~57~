unit UnitMainForm;

interface

uses
    Winapi.Windows, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
    Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus,
    UnitWorkWithFiles, UnitCreatingFigures, UnitReplayAndNotation, UnitSetupBoard,
    UnitTimer, UnitGrabbingFigures, UnitMakeAMove, UnitPawnTransformation,
    UnitInterfaceDuringGame, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, UnitMyMessageBoxes;

type

    TCellForReplay = Record
        CellFigureName: Char;
        CellFigureColorIsWhite, CellFigureHasMoved: Boolean;
    End;


    TGame = Record
        AllBoards: Array of Array [0 .. 1] of Array [1 .. 8, 1 .. 8]
            of TCellForReplay; // move - w/b - row - file
        GameEnded: Boolean;
        TimeRemainingW, TimeRemainingB: SmallInt;
    End;

    TFormMain = class(TForm)
        LabelMenuHead: TLabel;
        ButtonMenuNewGame: TButton;
        ImageBackGround: TImage;
        ButtonMenuOpenGame: TButton;
        PageControl1: TPageControl;
        TabSheet1: TTabSheet;
        TabSheet2: TTabSheet;
        MainMenu1: TMainMenu;
        NFile: TMenuItem;
        NOpen: TMenuItem;
        NSaveAs: TMenuItem;
        NAbout: TMenuItem;
        NAuthor: TMenuItem;
        ImageBoard: TImage;
        LabelToMeasureScreenOfUser: TLabel;
        PanelForBoard: TPanel;
        ButtonExit: TButton;
        PanelChoiceOfTransPawnForBlack: TPanel;
        ImageBN: TImage;
        ImageBB: TImage;
        ImageBR: TImage;
        ImageBQ: TImage;
        PanelChoiceOfTransPawnForWhite: TPanel;
        ImageWN: TImage;
        ImageWB: TImage;
        ImageWR: TImage;
        ImageWQ: TImage;
        TimerForAnimation: TTimer;
        TabSheet3: TTabSheet;
        PanelGameEnded: TPanel;
        LabelWhoWon: TLabel;
        ImageWhoWon: TImage;
        LabelHowGameEnded: TLabel;
        ListBoxNotationW: TListBox;
        ListBoxNotationB: TListBox;
        ListBoxNotationNum: TListBox;
        PanelForNotation: TPanel;
        ButtonReplay: TButton;
        PanelForReplay: TPanel;
        ImageReplayStart: TImage;
        ImageReplayPrev: TImage;
        ImageReplayNext: TImage;
        ImageReplayEnd: TImage;
        ButtonResign: TButton;
        PanelTimer: TPanel;
        ButtonDraw: TButton;
        ImageBP: TImage;
        ImageWP: TImage;
        ImageWK: TImage;
        ImageBK: TImage;
        ImageBlack: TImage;
        ImageWhite: TImage;
        ImageDraw: TImage;
        ImageTimer: TImage;
        ScrollBox1: TScrollBox;
        LabelTimeW: TLabel;
        LabelTimeB: TLabel;
        TimerForTimer: TTimer;
        ImagePauseAndStartTimer: TImage;
        LabelPause: TLabel;
        ImagePause: TImage;
        BalloonHint1: TBalloonHint;
        SaveDialog1: TSaveDialog;
        OpenDialog1: TOpenDialog;
        ButtonSaveGame: TButton;
        ButtonStartNewGame: TButton;
        procedure FormCreate(Sender: TObject);
        procedure ButtonMenuNewGameClick(Sender: TObject);
        procedure FormKeyPress(Sender: TObject; var Key: Char);
        procedure ButtonExitClick(Sender: TObject);
        procedure NAuthorClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure ImageWNClick(Sender: TObject);
        procedure ImageWBClick(Sender: TObject);
        procedure ImageWRClick(Sender: TObject);
        procedure ImageWQClick(Sender: TObject);
        procedure ImageBNClick(Sender: TObject);
        procedure ImageBBClick(Sender: TObject);
        procedure ImageBRClick(Sender: TObject);
        procedure ImageBQClick(Sender: TObject);
        procedure FigureMouseEnter(Sender: TObject);
        procedure FigureMouseLeave(Sender: TObject);
        procedure TimerForAnimationTimer(Sender: TObject);
        procedure ButtonReplayClick(Sender: TObject);
        procedure ListBoxNotationExit(Sender: TObject);
        procedure ListBoxNotationEnter(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
        procedure ImageReplayNextClick(Sender: TObject);
        procedure ImageReplayStartClick(Sender: TObject);
        procedure ImageReplayPrevClick(Sender: TObject);
        procedure ImageReplayEndClick(Sender: TObject);
        procedure ButtonDrawClick(Sender: TObject);
        procedure ButtonResignClick(Sender: TObject);
        procedure TimerForTimerTimer(Sender: TObject);
        procedure ImagePauseAndStartTimerClick(Sender: TObject);
        procedure ImageBoardClick(Sender: TObject);
        procedure LabelPauseClick(Sender: TObject);
        procedure NSaveAsClick(Sender: TObject);
        procedure NOpenClick(Sender: TObject);
        procedure ButtonMenuOpenGameClick(Sender: TObject);
        procedure ButtonSaveGameClick(Sender: TObject);
        procedure ButtonStartNewGameClick(Sender: TObject);

    public
        procedure FigureMouseDown(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        procedure FigureMouseMove(Sender: TObject; Shift: TShiftState;
          X, Y: Integer);
        procedure FigureMouseUp(Sender: TObject; Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
        function MultPixels(PixQuant: Integer): Integer;
    end;

const
    TopOfBoard = 50;
    LeftOFBoard = 30;
    WidthOfBoard = 546;
    WidthOfEdgePlusAdjust = 6 + 3;
    SizeOfCell = 66;
    // Оригинальное изображение 800*800 имеет бортики шириной в 10 и ширину
    // клетки вместе с перегородкой 110 (перегородка 10).
    // То есть по краям есть и перегородка (10), и бортик (10) - итого 20.
    // Изображение в программе имеет размер 3/5 от оригинала (480x480).
    SizeOfFigureComparedToCell = 0.8;
    ScaleWhileFigureOnDrag = 1.08;
    DefaultTimeOnTimer = 900;
    DefaultAddingOnTimer = 10;

var
    FormMain: TFormMain;
    SizeOfFigure, ShiftOfFigure: Byte;
    DragShiftX, DragShiftY, ItemIndexW, ItemIndexB: SmallInt;
    ArrOfFigures: Array Of TFigure;
    BoardReal: TBoard;
    GameIsSaved, NowIsTakingOnAisle, NowIsCastling, NowCheck, WhiteIsToMove: Boolean;
    LastMove: String[4];
    MultPix: Single;
    Game: TGame;

    BufferFor1Move: String;  //Notation

    NowAnimating: Boolean;
    ImgToMoveWithAnimationGlobal: TImage;
    XPS_AnimationOfImg, YPS_AnimationOfImg, NeedTop_AnimationOfImg,
      NeedLeft_AnimationOfImg: SmallInt;

implementation

{$R *.dfm}

// *******************************
// Chess Timer

procedure TFormMain.TimerForTimerTimer(Sender: TObject);
begin
    TimerEvery1Second();
end;

procedure TFormMain.ImagePauseAndStartTimerClick(Sender: TObject);
begin
    PauseAndStartTimer();
end;

// *******************************
// Replay and Notation

procedure TFormMain.ButtonReplayClick(Sender: TObject);
begin
    StartReplayAfterGameFinished();
end;

procedure TFormMain.LabelPauseClick(Sender: TObject);
begin
    StartTimerAfterPauseIfWasPaused();
end;

procedure TFormMain.ListBoxNotationEnter(Sender: TObject);
begin
    (Sender as TListBox).Enabled := False;
end;

procedure TFormMain.ListBoxNotationExit(Sender: TObject);
begin
    (Sender as TListBox).Enabled := True;
end;

procedure TFormMain.ImageReplayEndClick(Sender: TObject);
begin
    ReplayGoToEnd();
end;

procedure TFormMain.ImageReplayStartClick(Sender: TObject);
begin
    ReplayGoToStart()
end;

procedure TFormMain.ImageReplayNextClick(Sender: TObject);
begin
    ReplayGoToNext();
end;

procedure TFormMain.ImageReplayPrevClick(Sender: TObject);
begin
    ReplayGoToPrev();
end;

// *******************************
// Game Save, Load

procedure TFormMain.NOpenClick(Sender: TObject);
begin
    OpenFileChess();
end;

procedure TFormMain.NSaveAsClick(Sender: TObject);
begin
    SaveToFileAs();
end;

// *******************************
// Moving Figures With Mouse

procedure TFormMain.FigureMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    MouseStartsToGrabFigure(Sender, Button, Shift, X, Y);
end;

procedure TFormMain.FigureMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    MouseMovesOverFigure(Sender, Shift, X, Y);
end;

procedure TFormMain.FigureMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    MouseFinishesToGrabFigure(Sender, Button, Shift, X, Y);
end;

procedure TFormMain.FigureMouseEnter(Sender: TObject);
begin
    if not Game.GameEnded then
        Screen.Cursor := 1;
end;

procedure TFormMain.FigureMouseLeave(Sender: TObject);
begin
    if not Game.GameEnded then
        Screen.Cursor := 3;
end;

// *******************************
// Moving Figures

procedure TFormMain.TimerForAnimationTimer(Sender: TObject);
begin
    DoOneFrameOfAnimation();
end;

// *******************************
// Pawn Transformation

procedure TFormMain.ImageBBClick(Sender: TObject);
begin
    EndPawnTransformation('B');
end;

procedure TFormMain.ImageBNClick(Sender: TObject);
begin
    EndPawnTransformation('N');
end;

procedure TFormMain.ImageBoardClick(Sender: TObject);
begin
    StartTimerAfterPauseIfWasPaused();
end;

procedure TFormMain.ImageBQClick(Sender: TObject);
begin
    EndPawnTransformation('Q');
end;

procedure TFormMain.ImageBRClick(Sender: TObject);
begin
    EndPawnTransformation('R');
end;

procedure TFormMain.ImageWBClick(Sender: TObject);
begin
    EndPawnTransformation('B');
end;

procedure TFormMain.ImageWNClick(Sender: TObject);
begin
    EndPawnTransformation('N');
end;

procedure TFormMain.ImageWQClick(Sender: TObject);
begin
    EndPawnTransformation('Q');
end;

procedure TFormMain.ImageWRClick(Sender: TObject);
begin
    EndPawnTransformation('R');
end;

// *******************************
// OnFormCreate

procedure TFormMain.FormCreate(Sender: TObject);
begin
    SetupBoardOnStartOfForm();
end;

// *******************************
// Interface during Chess Play

procedure TFormMain.ButtonDrawClick(Sender: TObject);
begin
    DrawGame();
end;

procedure TFormMain.ButtonResignClick(Sender: TObject);
begin
    ResignGame();
end;

procedure TFormMain.ButtonSaveGameClick(Sender: TObject);
begin
    NSaveAsClick(Self);
end;

procedure TFormMain.ButtonStartNewGameClick(Sender: TObject);
begin
    StartNewGameAfterPrevFinished();
end;

procedure TFormMain.ButtonExitClick(Sender: TObject);
begin
    ExitToMainMenu();
end;

// *******************************
// Menu

procedure TFormMain.ButtonMenuOpenGameClick(Sender: TObject);
begin
    NOpenClick(Self);
end;

procedure TFormMain.ButtonMenuNewGameClick(Sender: TObject);
begin
    ResetChessboardToStandart();
    PageControl1.ActivePageIndex := 1;
end;

procedure TFormMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
    Arrows = [VK_DOWN, VK_UP, VK_LEFT, VK_RIGHT];

begin
    if (Key in Arrows) then
    begin
        if Game.GameEnded and PanelForReplay.Visible then
            case Key of
                VK_RIGHT:
                    ImageReplayNextClick(Self);
                VK_LEFT:
                    ImageReplayPrevClick(Self);
                VK_UP:
                    ImageReplayStartClick(Self);
                VK_DOWN:
                    ImageReplayEndClick(Self);
            end;
        Key := 0;
    end;
end;

procedure TFormMain.FormKeyPress(Sender: TObject; var Key: Char);
const
    KeysForBack = [#8, #27];

begin
    if (PageControl1.ActivePageIndex = 1) and (Key in KeysForBack) and
      ButtonExit.Visible then
        ButtonExitClick(Self);
end;

// *******************************
// Other

procedure TFormMain.NAuthorClick(Sender: TObject);
begin
    MyMessageBoxInfo('Автор',
    'Курсовая работа по дисциплине "Основы алгоритмизации и программирования".'
      + #10#13 + 'Курс 1' + #10#13 + 'Панев Александр, гр. 051007' + #10#13 +
      'Минск, 2021');
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    CanClose := GameIsSaved or MyMessageBoxYesNo('Выход из программы',
    'Вы уверены, что хотите выйти из программы?' + #10#13 +
    'Несохранённая партия будет утеряна.', True);
end;

function TFormMain.MultPixels(PixQuant: Integer): Integer;
begin
    Result := Round(PixQuant * MultPix);
end;

end.
