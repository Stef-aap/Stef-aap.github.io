unit rvhtmlimport;
{

  Copyright (c) 2002 by Carlo Kok <rvhtml@carlo-kok.com>
  Additions by
    - Harry Mulder <hpmulder@wanadoo.nl> (hm)
    - Rudy Ramsey <rudy@ramsisle.com> (rr)
    - Sergey Tkachenko (st)

  You are free to use, modify and redistribute it with the following restrictions:
	 - This header and copyright notice must stay intact
	 - You must have a TRichView license

Supported:
 - <b><i> and <u>
 - <font size, color, face>
 - <body bgcolor,text,link>
 - <title></title>
 - <img> .. Using events to load the image
 - <table bgcolor,width,border,cellspacing,cellpadding,bordercolor,bordercolorlight>
 - <tr>
 - <td bgcolor,width,height>
 - <ul style="disc,circle,square">
 - <ol style="a,i,A,I" start="1">  // Also numbers (style="")

Version 0.0014

What's new in 0.0014

        -  Range check error if line if finished with #13.  (st)
        -  Possible line breaks in checkpoint names and hyperlinks. (st)

What's new in 0.0013

        - <td>s without <tr> in tables are now supported. (hm)
        - Correctly handles text outside <td>-tags in tables.  (hm)

        - Revised UL and OL; fixed various issues, and added support for params.(hm)

        - New property: EnforceListLevels. Exotic usage of HTML's UL/OL tags    (hm)
          can be emulated within RichView, but only by applying ListLevels in
          an undocumented fashion (simply put, the index of a ListLevel no
          longer specifies its depth). This property determines if this
          technique should be used. Settings:

            True  : ListLevels are used in the documented manner, but you will
                    have less HTML compatibility. (Default)
            False : You will have a higher degree of HTML compatibility, but
                    the resulting ListLevels do not behave in the documented
                    manner. Advisable for experts only.

What's new in 0.0012
        - Fix: "Empty" tags made <div>-tags function incorrectly (hm)
        - Support for stretched images (hm)
        - Support for ISO Latin-1 code table (hm)

What's new in 0.0011
        - Added an option if the document (and it's styles) should be cleared (ck)

What's new in 0.0010
        - Fix in <li> when exporting and reimporting it (ck)
        - Specific (wrongly written) HTML could generate an "AV at 00000000" (hm)
        - Support for hypertext pictures (hm)

What's new in 0.0009
Changes by Sergey Tkachenko:
        - procedure LoadFromClipboard loads HTML from the Clipboard.
          After loading, you can use  function GetSelectionBounds to get a range
          of items that was selected in browser
        - BasePath: String property specifies a base path for images and links.
          When loading from file, you should assign it yourself.
          When loading from the Clipboard, this property is assigned automatically
          (probably, to www location)
          Suggestion: processing <BASE> should modify this property.
        - bulleted lists are represented by rvlstBullet, not by rvlstImageList.
        - list indents are changed

What's new in 0.0008
        - CharCount property provides running character count for use in events (rr)
        - LineCount property provides running line count for use in events (rr)
        - SeparateLines property causes separate text lines to be loaded into
                RichView as separate items, rather than being accumulated (rr)
        - OnComment event makes comment text available for external use (rr)
        - OnNewLine event notifies user at start of each new line of HTML
                In my simple implementation, ignores newlines within tags and in <pre>...</pre> (rr)


What's new in 0.0007
	- Added support for TH (ck)
	- Small changes (ck)

What's new in 0.0006
	- Fixed bug in Table colspan (ck)
	- Fixed bug in Table border colors (ck)
	- Added support for Table/TR/TD valign (ck)

What's new in 0.0005
        - Alignment support (table align; center; div) (hm)
	- A lot of fixes (font styles don't leak to other cells anymore) (hm)
	- <title></title> fix (hm)
	- Support for <body background>; new event "OnBackgroundRequired" for supplying the bitmap. (hm)
	- The name-property of an image now contains the URL (hm)
	- <tr bgcolor> (hm)
	- Support for named colors (hm)
	- <script>; <noembed> tags (contents will be ignored) (hm)


What's new in 0.0004
        - CR, LF and Tab now also supported in tags (hm)
        - New event: TOnImageRequired2, this event has width and height passed from the html. (hm)


What's new in 0.0003
        - Updated to support <div></div> (hm)

What's new in 0.0002
        - <table cellspacing,cellpadding,bordercolor,bordercolorlight> (hm)
        - <ul style="disc,circle,square"> and <ol style="a,i,A,I" start="1"> (hm)

}

{$I RV_Defs.inc}


interface

uses
  SysUtils, Windows, Classes, RichView, RVStyle, CRVData, Graphics, Controls,
  RVTable;

type
  TOnComment = procedure(Sender: TObject; const sComment: string) of
  object;  //hrr OnComment
  TOnImageRequired = procedure(Sender: TObject; const src: string; var Img: TGraphic) of
  object;

  TOnImageRequired2 = procedure(Sender: TObject; const src: string;
    Width, Height: integer; var Img: TGraphic) of object;

  TOnBackgroundRequired = procedure(Sender: TObject; const src: string; var Img: TBitmap) of
  object;

  TListType = (ltNone, ltDisc, ltCircle, ltSquare, ltNumber, ltLowerAlpha,
    ltUpperAlpha, ltLowerRoman, ltUpperRoman);



  TRvHtmlImporter = class(TComponent)
  private
//SM added, to suppress styles creation
    Ffixed_css_styles :boolean;
//SM end added
    FCharCount: integer;            //hrr	CharCount
    FLineCount: integer;            //hrr LineCount
    FSeparateLines: boolean;          //hrr SeparateLines
    FViewer: TCustomRichView;
    FOnImageRequired: TOnImageRequired;
    FDefaultFontSize: integer;
    FDefaultCFontSize: integer;
    FDefaultFontName: TFontName;
    FDefaultCFontName: TFontName;
    FDefaultColor: TColor;
    FDefaultLinkCol: TColor;
    FDefaultLinkStyle: TFontStyles;
    FDefaultBGColor: TColor;
    FTitle: string;
    FOnComment: TOnComment;          //hrr OnComment
    FOnNewLine: TNotifyEvent;          //hrr OnNewLine
    FOnImageRequired2: TOnImageRequired2;
    FOnBackgroundRequired: TOnBackgroundRequired;
    FStartSelection, FEndSelection, FStartSelNo, FEndSelNo: integer;
    FNextTimeCloseSelection: boolean;
    FSelRVData: TCustomRVData;
    FBasePath: string;
    FClearDocument: boolean;

    FClrListStyle : integer;
    FEnforceListLevels: boolean;


//SM added, to suppress styles creation
    procedure Set_fixed_css_styles(value:boolean);
//SM end added

    procedure LoadHtmlSelection(const Data: string;
      StartSelection, EndSelection: integer);
    procedure CheckSelection(Parser: TObject; RVData: TCustomRVData;
      RVT: TRVTableItemInfo);
    procedure LoadClipboardHtml(const Data: string);

    procedure InitListLevel(ALevel: TRVListLevel; AType: TListType; ADepth: integer);

  public
    procedure LoadFromClipboard;
    procedure LoadHtml(const Data: string);
    constructor Create(AOwner: TComponent); override;
    function GetSelectionBounds(var RVData: TCustomRVData;
      var StartNo, EndNo: integer): boolean;
    property CharCount: integer read FCharCount;    //hrr CharCount
    property LineCount: integer read FLineCount;    //hrr LineCount
    property Title: string read FTitle;
    property BasePath: string read FBasePath write FBasePath;
  published
//SM added, to suppress styles creation
    property fixed_css_styles :boolean read Ffixed_css_styles write Set_fixed_css_styles;
//SM end added
    property ClearDocument: boolean read FClearDocument write FClearDocument
      default True;
    property SeparateLines: boolean read FSeparateLines write FSeparateLines;
    //hrr SeparateLines
    property RichView: TCustomRichView read FViewer write FViewer;
    property OnImageRequired: TOnImageRequired read FOnImageRequired write FOnImageRequired;
    property DefaultFontName: TFontName read FDefaultFontName write FDefaultFontName;
    property DefaultCFontName: TFontName read FDefaultCFontName write FDefaultCFontName;
    property DefaultFontSize: integer read FDefaultFontSize write FDefaultFontSize;
    property DefaultCFontSize: integer read FDefaultCFontSize write FDefaultCFontSize;
    property DefaultColor: TColor read FDefaultColor write FDefaultColor;
    property DefaultLinkCol: TColor read FDefaultLinkCol write FDefaultLinkCol;
    property DefaultLinkStyle: TFontStyles read FDefaultLinkStyle write FDefaultLinkStyle;
    property DefaultBGColor: TColor read FDefaultBGColor write FDefaultBGColor;

    property EnforceListLevels : boolean read FEnforceListLevels write FEnforceListLevels;


    property OnComment: TOnComment read FOnComment write FOnComment;    //hrr OnComment
    property OnNewLine: TNotifyEvent read FOnNewLine write FOnNewLine;  //hrr OnNewLine
    property OnImageRequired2: TOnImageRequired2
      read FOnImageRequired2 write FOnImageRequired2;

    property OnBackgroundRequired: TOnBackgroundRequired 
      read FOnBackgroundRequired write FOnBackgroundRequired;
  end;

procedure Register;

implementation

uses
  RVItem, CRVFData, RVRVData, RVScroll
  ;

const
  DefMarkerIndent = 24;
  DefLeftIndent = 24;

procedure Register;
begin
  RegisterComponents('RichView', [TRVHtmlImporter]);
end;

type
  TCurrBlock = (cbComment, cbText, cbTag);
  THtmlParser = class
  private
    OrgText: string;
    FLastWasSpace: boolean;
    P: PChar;

    FTagName: string;
    FTagParams: TStringList;
    FCurrBlock: TCurrBlock;
    FRemoveSpaces: boolean;
    FCurrLine: integer;
    function GetBytesParsed: integer;                  //hrr LineCount
  public
    property LastWasSpace: boolean read FLastWasSpace write FLastWasSpace;
    property RemoveSpaces: boolean read FRemoveSpaces write FRemoveSpaces;

    constructor Create(const Text: string);
    destructor Destroy; override;

    procedure Next;
    function Done: boolean;

    property TagName: string read FTagName;
    property TagParams: TStringList read FTagParams;
    property CurrBlock: TCurrBlock read FCurrBlock;
    property CurrLine: integer read FCurrLine;      //hrr LineCount
    property BytesParsed: integer read GetBytesParsed;
  end;

//SM added, to suppress styles creation
    procedure TRvHtmlImporter.Set_fixed_css_styles(value:boolean);
    begin
      Ffixed_css_styles:=value;
      if Ffixed_css_styles then FEnforceListLevels:=false;
    end;
//SM end added


  { THtmlLoader }

function gv(c: TStrings; const Name: string): string;
begin
  if c.IndexOfName(Name) <> -1 then Result := c.Values[Name]
  else
    Result := '';
end;




const 
  FontSize: array[1..7] of integer = (8,10,12, 14, 18, 24, 36);

function HFtoF(FSize: integer): integer;
var
  I: integer;
begin
  for i := 1 to 6 do
  begin
    if FSize <= FontSize[i] then 
    begin
      Result := i;
      exit; 
    end;
  end;
  Result := 7;
end;

function FtoHF(HSize: integer): integer;
begin
  if HSize < Low(FontSize) then HSize := Low(FontSize) 
  else if HSize > High(FontSize) then HSize := High(FontSize);
  Result := FontSize[HSize];
end;


type
  TRVTableRowsH = class(TRVTableRows)
  end;
  TRVTableItemInfoH = class(TRVTableItemInfo)
  public
    CurrRow, CurrCol: longint;
  end;

function GetHtmlColor(s: string): TColor;
var
  Col: TColor;
begin
  if (CompareText(s, 'white') = 0) then Result := clWhite
  else if (CompareText(s, 'black') = 0) then Result := clBlack     
  else if (CompareText(s, 'red') = 0) then Result := clRed       
  else if (CompareText(s, 'green') = 0) then Result := clGreen
  else if (CompareText(s, 'blue') = 0) then Result := clBlue      
  else if (CompareText(s, 'aqua') = 0) then Result := clAqua
  else if (CompareText(s, 'fuchsia') = 0) then Result := clFuchsia
  else if (CompareText(s, 'gray') = 0) then Result := clDkGray    
  else if (CompareText(s, 'lime') = 0) then Result := clLime
  else if (CompareText(s, 'maroon') = 0) then Result := clMaroon    
  else if (CompareText(s, 'navy') = 0) then Result := clNavy      
  else if (CompareText(s, 'olive') = 0) then Result := clOlive
  else if (CompareText(s, 'purple') = 0) then Result := clPurple
  else if (CompareText(s, 'silver') = 0) then Result := clGray
  else if (CompareText(s, 'teal') = 0) then Result := clTeal      
  else if (CompareText(s, 'yellow') = 0) then Result := clYellow
  else
  begin
    if s[1] = '#' then
    begin
      Delete(s, 1, 1);
    end;
    Col := StrToIntDef('$' + s, - 1);
    if Col <> -1 then
      Result := ((Col and $FF) shl 16) or (Col and $FF00) or ((Col and $FF0000) shr 16)
    else
      Result := 0;
  end;
end;


function GetListType( AData : string; ADef : TListType ): TListType;
begin
  if SameText( AData, 'disc')        then Result := ltdisc
  else if SameText( AData, 'circle') then Result := ltcircle
  else if SameText( AData, 'square') then Result := ltSquare
  else if (AData = 'a')              then Result := ltLowerAlpha
  else if (AData = 'A')              then Result := ltUpperAlpha
  else if (AData = 'i')              then Result := ltLowerRoman
  else if (AData = 'I')              then Result := ltUpperRoman
  else if (AData = '1')              then Result := ltNumber
  else Result := ADef;
end;


function GetAlignParam(c: TStrings; ADefault: TRVAlignment): TRVAlignment;
  (* converts text alignments to TRVAligment;
     returns default if align-param not found/incorrect *)
var
  s: string;
begin
  s := LowerCase(gv(c, 'align'));

  if (s = 'left') then Result := rvaLeft
  else if (s = 'right') then Result := rvaRight
  else if (s = 'center') then Result := rvaCenter
  else
    Result := ADefault;
end;


type
  TContainerLevel = (clMain, clTable, clRow, clCol);
  TIndentType = (llUL, llOL);

  TContainerIndentType = class
  public
    IndentType  : TIndentType;
    ListType    : TListType;
    ListValue   : integer;
  end;


  TContainerDataType = class(TCollectionItem)
    (* contains settings and local stacks for a container *)
    (* container is: main doc, table, tr or td.           *)
  private
    AlignmentStack: TList;
    PrevFont: TList;
    IndentStack : TList;


    function FindAlignment(AAlignment: TRVAlignment): integer;
    function GetCurAlignment: TRVAlignment;


  public
    Importer : TRvHtmlImporter;

    Level: TContainerLevel;
    TextStyle: integer;
    ParaStyle: integer;

    IndentListStyle : integer;

    VAlign: TRVCellVAlign;

    BgColor: TColor;

    CurLIType  : TListType; // current Listype, applied by LI
    CurLIValue : integer;   // current value, applied by LI
    CurHadLI   : boolean;

    RVT : TRVTableItemInfoH; // contains current RV Table-instance
    RVData : TCustomRVData;  // contains default RVData (for unbalanced tables)


    property CurAlignment: TRVAlignment read GetCurAlignment;

    procedure EnterAlignment(AAlignment: TRVAlignment);
    procedure LeaveAlignment;

    procedure EnterIndent( AIndentType : TIndentType; AType: TListType; AStartAt: longint );
    procedure LeaveIndent( AIndentType : TIndentType );

    function ListCount : integer; // returns no of Ul/OL's in IndentStack

    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  end;



{ TContainerDataType }

constructor TContainerDataType.Create(Collection: TCollection);
begin
  inherited;
  AlignmentStack := TList.Create;
  PrevFont := TList.Create;
  IndentStack := TList.Create;

  IndentListStyle := -1;
end;

destructor TContainerDataType.Destroy;
begin
  IndentStack.Free;
  PrevFont.Free;

  AlignmentStack.Free;
  inherited;
end;


function TContainerDataType.FindAlignment(AAlignment: TRVAlignment): integer;
begin
  (* make sure RichView has an applicable style *)
  with Importer.FViewer.Style.ParaStyles do
  begin
    Result := FindStyleWithAlignment(0, AAlignment);

//if not(fixed_css_styles) then
    if (Result < 0) then
      with Add do
      begin
        Result := Index;

        (* init style *)
        Items[Result] := Items[0];
        Alignment := AAlignment;
      end;
  end;
end;


procedure TContainerDataType.EnterAlignment(AAlignment: TRVAlignment);
begin
  (* add alignment to stack *)
  AlignmentStack.Add(pointer(AAlignment));

  (* get richview style *)
  ParaStyle := FindAlignment(AAlignment);
end;


procedure TContainerDataType.LeaveAlignment;
begin
  with AlignmentStack do
  begin
    (* remove current from stack *)
    if (Count > 1) then Delete(Count - 1);

    (* get richview style *)
    ParaStyle := FindAlignment(TRVAlignment(Items[Count - 1]));
  end;
end;

function TContainerDataType.GetCurAlignment: TRVAlignment;
begin
  with AlignmentStack do
    Result := TRVAlignment(Items[Count - 1]);
end;


procedure TContainerDataType.EnterIndent(AIndentType: TIndentType; AType: TListType; AStartAt: Integer);
var
  Indent : TContainerIndentType;
  Level  : TRVListLevel;
begin
  (* add new list to stack *)
  Indent := TContainerIndentType.Create;
  IndentStack.Add( Indent );

  (* init list *)
  Indent.IndentType := AIndentType;
  Indent.ListType   := AType;
  Indent.ListValue  := AStartAt;

  (* always create a ListLevel when enforcing them *)
  if Importer.EnforceListLevels then
  begin
    with Importer.FViewer.Style do
    begin
      if IndentListStyle = -1 then
        IndentListStyle := ListStyles.Add.Index;

      Level := ListStyles[IndentListStyle].Levels.Add;
      Importer.InitListLevel( Level, AType, Level.Index+1 );
    end;
  end
//SM added, to suppress listlevel creation
  else
  begin
    with Importer.FViewer.Style do
    begin
      IndentListStyle:=0;
      Level:=ListStyles[IndentListStyle].Levels[0];
    end;
  end;
//SM end added
end;


procedure TContainerDataType.LeaveIndent(AIndentType: TIndentType);
var
  i,j : integer;
begin
  (* search for parent tag, and remove all others if found *)
  for i := IndentStack.Count-1 downto 0 do
    with TContainerIndentType(IndentStack[i]) do
      if (IndentType = AIndentType) then
      begin
        for j := IndentStack.Count-1 downto i do
        begin
          TContainerIndentType(IndentStack[j]).Free;
          IndentStack.Delete(j);
        end;

        if IndentStack.Count = 0 then
          IndentListStyle := -1;

        CurLIType := ltNone;
        Exit;
      end;
end;

function TContainerDataType.ListCount: integer;
var i : integer;
begin
  Result := 0;
  for i := 0 to IndentStack.Count-1 do
    if (TContainerIndentType(IndentStack[i]).IndentType in [llUL, llOL]) then
      inc(Result);
end;




{$IFNDEF RICHVIEWDEF6}
function Utf8ToUnicode(Dest: PWideChar; MaxDestChars: cardinal;
  Source: PChar; SourceBytes: cardinal): cardinal;
var
  i, Count: cardinal;
  c: byte;
  wc: cardinal;
begin
  if Source = nil then
  begin
    Result := 0;
    Exit;
  end;
  Result := cardinal(-1);
  Count := 0;
  i := 0;
  if Dest <> nil then
  begin
    while (i < SourceBytes) and (Count < MaxDestChars) do
    begin
      wc := cardinal(Source[i]);
      Inc(i);
      if (wc and $80) <> 0 then
      begin
        if i >= SourceBytes then Exit;          // incomplete multibyte char
        wc := wc and $3F;
        if (wc and $20) <> 0 then
        begin
          c := byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then Exit;
          // malformed trail byte or out of range char
          if i >= SourceBytes then Exit;        // incomplete multibyte char
          wc := (wc shl 6) or (c and $3F);
        end;
        c := byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte

        Dest[Count] := widechar((wc shl 6) or (c and $3F));
      end
      else
        Dest[Count] := widechar(wc);
      Inc(Count);
    end;
    if Count >= MaxDestChars then Count := MaxDestChars - 1;
    Dest[Count] := #0;
  end
  else
  begin
    while (i < SourceBytes) do
    begin
      c := byte(Source[i]);
      Inc(i);
      if (c and $80) <> 0 then
      begin
        if i >= SourceBytes then Exit;          // incomplete multibyte char
        c := c and $3F;
        if (c and $20) <> 0 then
        begin
          c := byte(Source[i]);
          Inc(i);
          if (c and $C0) <> $80 then Exit;
          // malformed trail byte or out of range char
          if i >= SourceBytes then Exit;        // incomplete multibyte char
        end;
        c := byte(Source[i]);
        Inc(i);
        if (c and $C0) <> $80 then Exit;       // malformed trail byte
      end;
      Inc(Count);
    end;
  end;
  Result := Count + 1;
end;

function Utf8Decode(const S: string): WideString;
var
  L: integer;
  Temp: widestring;
begin
  Result := '';
  if S = '' then Exit;
  SetLength(Temp, Length(S));

  L := Utf8ToUnicode(PWideChar(Temp), Length(Temp) + 1, PChar(S), Length(S));
  if L > 0 then
    SetLength(Temp, L - 1)
  else
    Temp := '';
  Result := Temp;
end;
{$ENDIF}





{ THtmlImporter }

constructor TRvHtmlImporter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDefaultFontSize := 12;
  FDefaultCFontSize := 10;
  FDefaultFontName := 'Times New Roman';
  FDefaultCFontName := 'Courier New';
  FDefaultColor := clBlack;
  FDefaultLinkCol := clBlue;
  FDefaultLinkStyle := [fsUnderline];
  FDefaultBGColor := clWhite;
  FStartSelection := -1;
  FEndSelection := -1;
  FClearDocument := True;
  FEnforceListLevels := True;
end;







procedure TRvHtmlImporter.LoadClipboardHtml(const Data: string);
const
  StrSignature = 'Version:';
  StrStartHTML = 'StartHTML:';
  StrEndHTML = 'EndHTML:';
  StrStartFragment = 'StartFragment:';
  StrEndFragment = 'EndFragment:';
  StrSourceURL = 'SourceURL:';
  //StrStartSelection = 'StartSelection:';
  //StrEndSelection = 'EndSelection';
var
  p1, p2: integer;
  s1, s2, s3: string;

  function ReadString(const Key: string): string;
  var
    p: integer;
  begin
    Result := '';
    p := Pos(Key, Data);
    if p = 0 then
      exit;
    inc(p, Length(Key));
    Result := '';
    while not (Data[p] in [#10, #13]) do
    begin
      Result := Result + Data[p];
      inc(p);
    end;
  end;

  function ReadInteger(const Key: string): integer;
  var 
    p: integer;
    val: string;
  begin
    p := Pos(Key, Data);
    if p = 0 then
      abort;
    inc(p, Length(Key));
    val := '';
    while Data[p] in ['0'..'9'] do
    begin
      val := val + Data[p];
      inc(p);
    end;
    Result := StrToInt(Val);
  end;
begin
  if Copy(Data, 1, Length(StrSignature)) <> StrSignature then
    abort;
  p1 := ReadInteger(StrStartHTML);
  if p1 < 0 then
    p1 := ReadInteger(StrStartFragment);
  p2 := ReadInteger(StrEndHTML);
  if p2 < 0 then
    p2 := ReadInteger(StrEndFragment);
  BasePath := ReadString(StrSourceURL);
  if Pos('file://', BasePath) = 1 then
    BasePath := Copy(BasePath, 8,Length(BasePath));
  BasePath := ExtractFilePath(BasePath);


  FStartSelection := ReadInteger(StrStartFragment) - p1;
  FEndSelection := ReadInteger(StrEndFragment) - p1;
  s3 := Copy(Data, p1, p2 - p1);
  s1 := Copy(s3, 1, FStartSelection + 1);
  s2 := Copy(s3, FStartSelection + 2, FEndSelection - FStartSelection);
  s3 := Copy(s3, FEndSelection + 2, Length(s3));
  s1 := UTF8Decode(s1);
  s2 := UTF8Decode(s2);
  s3 := UTF8Decode(s3);
  FStartSelection := Length(s1) - 1;
  FEndSelection := Length(s1) + Length(s2) - 1;
  LoadHtmlSelection(s1 + s2 + s3, FStartSelection, FEndSelection);
end;

procedure TRvHtmlImporter.LoadFromClipboard;
var 
  cf: cardinal;
  Data: string;
  mem: cardinal;
  ptr: Pointer;
begin
  cf := RegisterClipboardFormat('HTML Format');
  if not IsClipboardFormatAvailable(cf) then
    exit;
  OpenClipboard(0);
  try
    mem := GetClipboardData(cf);
    SetLength(Data, GlobalSize(mem));
    ptr := GlobalLock(mem);
    Move(ptr^, PChar(Data)^, Length(Data));
    GlobalUnlock(mem);
  finally
    CloseClipboard;
  end;
  LoadClipboardHtml(Data);
end;

procedure TRvHtmlImporter.LoadHtmlSelection(const Data: string;
  StartSelection, EndSelection: integer);
begin
  FStartSelection := StartSelection;
  FEndSelection := EndSelection;
  try
    LoadHtml(Data);
  finally
    FStartSelection := -1;
    FEndSelection := -1;
  end;
end;

procedure TRvHtmlImporter.CheckSelection(Parser: TObject; RVData: TCustomRVData;
  RVT: TRVTableItemInfo);
begin
  if (FStartSelection >= 0) then 
  begin
    if (FStartSelNo < 0) and (THtmlParser(Parser).BytesParsed >= FStartSelection) then
    begin
      FNextTimeCloseSelection := False;
      FSelRVData := RVData;
      if FSelRVData = nil then
      begin
        FSelRVData := TRVTableRowsH(RVT.Rows).FMainRVData;
        FStartSelNo := FSelRVData.Items.Count - 1;
        FEndSelNo := FSelRVData.Items.Count - 1;
      end
      else
        FStartSelNo := RVData.Items.Count;
    end;
    if (FEndSelNo < 0) then
    begin
      if FNextTimeCloseSelection and (RVData <> nil) then 
      begin
        FEndSelNo := RVData.Items.Count - 1;
        FNextTimeCloseSelection := False;
      end
      else if (THtmlParser(Parser).BytesParsed > FEndSelection) then
        FNextTimeCloseSelection := True;
    end;
  end;
end;

function TRvHtmlImporter.GetSelectionBounds(var RVData: TCustomRVData;
  var StartNo, EndNo: integer): boolean;
begin
  RVData := FSelRVData;
  Result := RVData <> nil;
  if RVData = nil then
    exit;
  StartNo := FStartSelNo;
  if (FEndSelNo < 0) or (FEndSelNo >= RVData.Items.Count) then
    FEndSelNo := RVData.Items.Count - 1;
  EndNo := FEndSelNo;
end;




procedure TRvHtmlImporter.InitListLevel(ALevel: TRVListLevel; AType: TListType; ADepth: integer);
begin
  with ALevel do
  begin
    FirstIndent := 0;
    MarkerIndent := DefMarkerIndent * ADepth;
    LeftIndent := MarkerIndent + DefLeftIndent;
    FormatString := '%' + IntToStr(Index) + ':s.';
    Font.Size := FDefaultFontSize;
    case AType of
      ltNumber:
        begin
          ListType := rvlstDecimal;
        end;
      ltDisc:
        begin
          ListType := rvlstBullet;
          Font.Name := 'Symbol';
          Font.Charset := SYMBOL_CHARSET;
          FormatString := #$B7;
        end;
      ltCircle:
        begin
          ListType := rvlstBullet;
          Font.Name := 'Courier New';
          Font.Charset := ANSI_CHARSET;
          FormatString := 'o';
        end;
      ltSquare:
        begin
          ListType := rvlstBullet;
          Font.Name := 'Wingdings';
          Font.Charset := SYMBOL_CHARSET;
          FormatString := #$A7;
        end;
      ltLowerAlpha:
        begin
          ListType := rvlstLowerAlpha;
        end;
      ltUpperAlpha:
        begin
          ListType := rvlstUpperAlpha;
        end;
      ltLowerRoman:
        begin
          ListType := rvlstLowerRoman;
        end;
      ltUpperRoman:
        begin
          ListType := rvlstUpperRoman;
        end;
      ltNone:
        begin
          FormatString := '';
        end;
    end;
  end;
end;





procedure TRvHtmlImporter.LoadHtml(const Data: string);
var
  RVData: TCustomRVData;
  FLinkCol: TColor;
  Parser: THtmlParser;
  CurrLink: string;
  BeforeLinkFont: longint;
  CurrListStyle, ListLevel, ListStartAt: longint;
  CurrStyle, DefStyle: longint;
  lt: TListType;
  ts: string;
  s: string;
  CF: TFont;
  Gr: TGraphic;
  I: longint;
  RVT: TRVTableItemInfoH;

  ContainerStack: TCollection;
  CurContainer: TContainerDataType;

  CurParaStyle: integer;  // keeps track of last used ParaStyle


  procedure RemoveLineBreaks(var s: String);
  var i: Integer;
  begin
    for i := Length(s) downto 1 do
      if s[i] in [#10, #13] then
        Delete(s, i, 1);
  end;


  procedure writets;
  var
    Link : longint;
    Para : integer;

    function GetList(AType: TListType; ADepth: integer): integer;
    var
      Level: TRVListLevel;
      i : integer;
      dpth : integer;

      function IsSame( lvl : TRVListLevel ): boolean;
      begin
        Result := False;
        if lvl.MarkerIndent = dpth then
          case AType of
            ltNumber     : Result := (lvl.ListType = rvlstDecimal);
            ltLowerAlpha : Result := (lvl.ListType = rvlstLowerAlpha);
            ltUpperAlpha : Result := (lvl.ListType = rvlstUpperAlpha);
            ltLowerRoman : Result := (lvl.ListType = rvlstLowerRoman);
            ltUpperRoman : Result := (lvl.ListType = rvlstUpperRoman);
            ltDisc       : Result := (lvl.ListType = rvlstBullet) and (lvl.FormatString=#$B7);
            ltCircle     : Result := (lvl.ListType = rvlstBullet) and (lvl.FormatString='o');
            ltSquare     : Result := (lvl.ListType = rvlstBullet) and (lvl.FormatString=#$A7);
            ltNone       : Result := (lvl.FormatString = '');
          end
      end;

    begin
      dpth := DefMarkerIndent * ADepth;

      if EnforceListLevels then
      begin
        (* Level already created; just retrieve it here *)
        Result := ADepth-1;
      end
      else
      begin
        (* find applicable level *)
        with FViewer.Style.ListStyles[CurContainer.IndentListStyle] do
         for i := 0 to Levels.Count-1 do
           if IsSame( Levels[i] ) then
           begin
             Result := Levels[i].Index;
             Exit; //LEAVE NOW
           end;

        (* still here ? then create new *)
//SM added, to suppress liststyle creation
        if fixed_css_styles then
        begin
          with FViewer.Style.ListStyles[CurContainer.IndentListStyle] do
            result:=levels[0].index;
        end
        else
//SM end added
        begin
          Level := FViewer.Style.ListStyles[CurContainer.IndentListStyle].Levels.Add;
          InitListLevel( Level, AType, ADepth );
          Result := Level.Index;
        end;
      end;
    end;


    procedure SetListMarker;
    var i : integer;
    begin
      if CurContainer.IndentListStyle = -1 then
        with FViewer.Style.ListStyles.Add do
          CurContainer.IndentListStyle := Index;

      i := GetList( CurContainer.CurLIType, CurContainer.IndentStack.Count );
      if i >= 0 then
        CurContainer.RVData.SetListMarkerInfo( -1, CurContainer.IndentListStyle,
                                               i,  CurContainer.CurLIValue,
                                               CurContainer.ParaStyle, True);
    end;

var line:string;
  begin
    (* Make sure even empty <LI> tags generate an indentation *)
    if CurContainer.CurHadLI then
    begin
      SetListMarker;

      CurContainer.CurLIType := ltNone;
      CurParaStyle := CurContainer.ParaStyle;
      CurContainer.CurHadLI := False;
    end;


    (* is there any text ? *)
    if ts <> '' then
    begin

      (* do we need to switch parastyles ? *)
      if (CurParaStyle <> CurContainer.ParaStyle) then
      begin
        CurParaStyle := CurContainer.ParaStyle;


        if (CurContainer.IndentStack.Count > 0) then
        begin
          (* Apply indentation *)
          SetListMarker;

          Para := -1;   // ListMarker already causes para-change
        end
        else
        begin
          (* no indentation *)
          Para := CurContainer.ParaStyle;
        end
      end
      else
        Para := -1;

      (* setup hyperlink *)
      if CurrLink <> '' then
      begin
        RemoveLineBreaks(CurrLink);
        Link := integer(StrNew(PChar(CurrLink)))
      end
      else
        Link := 0;

      (* write data *)
//SM, no
//xxxx
{if ts=' ' then
begin
line:=parser.tagname;
end; }
if ts<>' ' then
//if ts<>'' then
//if not(in_paragraph) then
//if not(lowercase(parser.tagname)='p') then
      CurContainer.RVData.AddNLTag(ts, CurrStyle, Para, Link);

      Inc(FCharCount, Length(ts));      //hrr CharCount
      ts := '';
    end;
  end;

  procedure writeCR;
  begin
    (* write a forced break *)
    if Assigned(RVData) then
      RVData.AddNLTag('', CurrStyle, CurContainer.ParaStyle, 0);
  end;

  procedure WriteTSCR;
    { Added for PRE }
  var
    s: string;
    i1: integer;
  begin
    s := ts;
    i1 := 1;
    while i1 <= Length(s) do
    begin
      if (s[i1] = #13) then
      begin
        ts := copy(s, 1, i1 - 1);
        if (i1+1<=Length(s)) and (s[i1 + 1] = #10) then
          Delete(s, 1, i1 + 1)
        else
          Delete(s, 1, i1);
        WriteTS;
        WriteCR;
        i1 := 0;
      end
      else if s[i1] = #10 then
      begin
        ts := copy(s, 1, i1 + 1);
        Delete(s, 1, i1);
        WriteTS;
        WriteCR;
        i1 := 0;
      end;
      inc(i1);
    end;
    ts := s;
    WriteTS;
  end;

  procedure FindFont(b, alink: boolean);
  var
    I: longint;
  begin
    if RVData = nil then Exit;
    if b then CurContainer.PrevFont.Add(Pointer(CurrStyle))
    else
    begin
      if CurContainer.PrevFont.Count > 0 then
        CurContainer.PrevFont.Delete(CurContainer.PrevFont.Count - 1);
    end;
    with FViewer.Style.TextStyles do
    begin
      for i := 0 to Count - 1 do
      begin
        with Items[i] do
        begin
          if (Size = cf.size) and
            (Color = cf.Color) and
            (jump = alink) and
            (FontName = CF.Name) and
            (Style = CF.Style) then
          begin
            CurrStyle := I;
            Exit;
          end;
        end;
      end; // for
{      with Add do
      begin
        FontName := CF.Name;
        Size := CF.Size;
        Color := CF.Color;
        Style := CF.Style;
        Jump := alink;
        CurrStyle := Index;
stylename:=fontname+'='+inttostr(size);
      end;
      }
    end;
  end;

  procedure EnterContainer(ADefTextStyle: integer; ALevel: TContainerLevel;
    ADefAlignment: TRVAlignment);
  var
    BgClr: TColor;
    VAlign: TRVCellVAlign;
    RVData: TCustomRVData;
  begin
    VAlign := rvcMiddle;
    RVData := nil;
    if Assigned(CurContainer) then
    begin
      (* Sync current container with CurrStyle *)
      CurContainer.TextStyle := CurrStyle;

      (* new container wil get current BgColor as default *)
      BgClr := CurContainer.BgColor;

      if CurContainer.Level in [clTable, clRow] then
        VAlign := CurContainer.VALign;

      RVData := CurContainer.RVData;
    end
    else
      BgClr := DefaultBGColor;


    (* place a new container on the stack, and make this one the current *)
    CurContainer := TContainerDataType(ContainerStack.Add);
    CurContainer.Importer := Self;
    CurContainer.Level := ALevel;
    CurContainer.TextStyle := ADefTextStyle;
    CurContainer.BgColor := BgClr;
    CurContainer.VAlign := VAlign;
    CurContainer.RVData := RVData;


    (* reset current parastyle *)
    CurParaStyle := -1;
    CurrListStyle := -1;
    ListLevel := 0;

    (* sync CurrStyle with new container settings *)
    CurrStyle := CurContainer.TextStyle;
    FViewer.Style.TextStyles[CurrStyle].AssignTo(CF);
    (* make sure we have a default alignment *)
    CurContainer.EnterAlignment(ADefAlignment);
  end;





  procedure LeaveContainer(ALevel: TContainerLevel);
  begin
    (* remove un-balanced levels *)
    while (ContainerStack.Count > 1) and (ALevel < CurContainer.Level) do
    begin
      ContainerStack.Items[ContainerStack.Count - 1].Free;
      CurContainer := TContainerDataType(ContainerStack.Items[ContainerStack.Count - 1]);
    end;

    (* remove container from stack *)
    if (ContainerStack.Count > 1) and (ALevel = CurContainer.Level) then
    begin
      ContainerStack.Items[ContainerStack.Count - 1].Free;
      CurContainer := TContainerDataType(ContainerStack.Items[ContainerStack.Count - 1]);
    end;

    (* reset current parastyle *)
    CurParaStyle := -1;

    (* sync CurrStyle with new container settings *)
    CurrStyle := CurContainer.TextStyle;
    FViewer.Style.TextStyles[CurrStyle].AssignTo(CF);
  end;


  procedure DoTable;
  var
    i: integer;
    s: string;
  begin
    if RVData = nil then Exit;
    RVT := TRVTableItemInfoH.Create(RVData);
    CurContainer.RVT := RVT;

    RVT.BorderWidth := StrToIntDef(gv(Parser.TagParams, 'border'), 0);
    if RVT.BorderWidth > 0 then RVT.CellBorderWidth := 1;
    i := strToIntDef(gv(Parser.TagParams, 'cellspacing'), 2);
    rvt.BorderVSpacing := i;
    rvt.BorderHSpacing := i;
    rvt.CellVSpacing := i;
    rvt.CellHSpacing := i;
    rvt.BorderStyle := rvtbRaisedColor;
    rvt.CellBorderStyle := rvtbLoweredColor;
    RVT.CellPadding := StrToIntDef(gv(Parser.TagParams, 'cellpadding'), 1);
    s := gv(Parser.TagParams, 'bordercolor');
    if s <> '' then
    begin
      RVT.BorderColor := GetHtmlColor(s);
      rvt.BorderStyle := rvtbColor;
      rvt.CellBorderStyle := rvtbColor;
    end
    else
    begin
      RVT.BorderColor := clBtnShadow;
      rvt.BorderStyle := rvtbRaisedColor;
      rvt.CellBorderStyle := rvtbLoweredColor;
    end;
    RVT.CellBorderColor := RVT.BorderColor;
    s := gv(Parser.TagParams, 'bordercolorlight');
    if s <> '' then
      RVT.BorderLightColor := GetHtmlColor(s)
    else
    begin
      if ColorToRGB(rvt.Color) = ColorToRGB(clBtnHighlight) then
        RVT.BorderLightColor := clBtnFace
      else
        RVT.BorderLightColor := clBtnHighlight
    end;
    RVT.CellBorderLightColor := RVT.BorderLightColor;

    s := gv(Parser.TagParams, 'width');
    if s <> '' then
    begin
      if pos('%', s) > 0 then
      begin
        Delete(s, pos('%', s), 1);
        i := -(abs(StrToIntDef(s, 0)) mod 100);
      end
      else
        i := abs(StrToIntDef(s, 0));
      RVT.BestWidth := i;
    end
    else
      RVT.BestWidth := 0;

    (* set table alignment *)
    RVT.ParaNo := CurContainer.FindAlignment(GetAlignParam(Parser.TagParams,
      CurContainer.CurAlignment));

    (* new table -> new container, with default TextStyle and alignment *)
    EnterContainer(DefStyle, clTable, rvaLeft);

    s := lowercase(gv(Parser.TagParams, 'valign'));
    if s = 'top' then CurContainer.VAlign := rvcTop
    else if s = 'bottom' then CurContainer.VAlign := rvcBottom
    else if s = 'middle' then CurContainer.VAlign := rvcMiddle;

    s := gv(Parser.TagParams, 'bgcolor');
    if s <> '' then
      CurContainer.BgColor := GetHtmlColor(s)
    else
      CurContainer.bgColor := clNone;

    RVT.Color := CurContainer.BgColor;

    RVData := nil;
    RVT.CurrRow := -1;
    RVT.CurrCol := -1;
  end;


  procedure DoMerge(ColSpan, RowSpan: integer);
  var
    i, colc, j: longint;
  begin
    if ColSpan < 1 then ColSpan := 1;
    if RowSpan < 1 then RowSpan := 1;
    if (ColSpan > 1) or (RowSpan > 1) then
    begin
      while rvt.CurrRow + RowSpan > RVt.Rows.Count do
      begin
        RVt.Rows.Add(Rvt.Rows[0].Count);
      end;
      colc := RVT.CurrCol + ColSpan - RVT.Rows[0].Count;
      for i := 0 to RVT.Rows.Count - 1 do
      begin
        for j := 0 to ColC - 1 do
        begin
          RVT.Rows[i].Add;
        end;
      end;
      RVT.MergeCells(RVT.CurrRow, RVT.CurrCol, ColSpan, rowSpan, True);
    end;
  end;




  procedure CheckForNewLine;            //hrr LineCount, OnNewLine...
  begin
    if FLineCount = Parser.CurrLine then exit;
    FLineCount := Parser.CurrLine;
    if Assigned(FOnNewLine) then
      FOnNewLine(Self);
  end;                          //...hrr LineCount, OnNewLine


var
  idx : integer;
  w,h : integer;
  x: TRVAlignment;

  line :string;
  posi :integer;
begin
  FStartSelNo := -1;
  FEndSelNo := -1;
  FSelRVData := nil;
  if FClearDocument then
    FViewer.Clear;
  RVT := nil;
  CurrListStyle := -1;
  ListLevel := 0;

  FClrListStyle := -1;

  BeforeLinkFont := 0;
  //  PrevFont := TList.Create;
  FViewer.Style.Color := FDefaultBGColor;
  FViewer.BackgroundBitmap := nil;

  FLinkCol := DefaultLinkCol;
  CF := TFont.Create;


  ContainerStack := TCollection.Create(TContainerDataType);
  CurContainer := nil;


  try
//SM added
    if not(fixed_css_styles) then
    begin
//SM end added
      if FClearDocument then
      begin
        FViewer.Style.TextStyles.Clear;
        FViewer.Style.ListStyles.Clear;
        FViewer.Style.ParaStyles.Clear;
        with FViewer.Style.ParaStyles.Add do
        begin
        end;
      end;
      with FViewer.Style.TextStyles.Add do
      begin
        FontName := DefaultFontName;
        Size := DefaultFontSize;
        Color := DefaultColor;
        AssignTo(CF);
        DefStyle := 0;
      end;
    end;

    (* create container for main document *)
    EnterContainer(DefStyle, clMain, rvaLeft);


    Parser := THtmlParser.Create(Data);
    Parser.LastWasSpace := True;
    {<dt>}
    CurrStyle := DefStyle;
    try
      RVData := FViewer.RVData;
      CurContainer.RVData := RVData;

      while not Parser.Done do
      begin
        Parser.Next;
        if FNextTimeCloseSelection then
          WriteTSCR;
        CheckSelection(Parser, RVData, RVT);
        CheckForNewLine;                    //hrr OnNewLine
        case Parser.CurrBlock of
          cbComment:                        //hrr OnComment...
            begin
              if Assigned(FOnComment) then
                FOnComment(Self, Parser.TagName);
            end;                          //...hrr OnComment
          cbTag:
            begin

              s := LowerCase(Parser.TagName);
              if (s = 'title') then
              begin
                FTitle := '';
                Parser.Next;
                CheckForNewLine;                //hrr OnNewLine

                // support for <title></title>
                while ((Parser.CurrBlock <> cbTag) or
                  (lowercase(Parser.tagName) <> '/title')) and not (Parser.Done) do
                begin
                  FTitle := FTitle + Parser.TagName;
                  Parser.Next;
                end;
{
                repeat
                  FTitle := FTitle + Parser.TagName;
						Parser.Next;
                until ((Parser.CurrBlock = cbTag) and (lowercase(Parser.tagName) = '/title')) or (Parser.Done);
}
                Parser.LastWasSpace := True;
              end
              else if (S = 'body') then
              begin
                s := gv(Parser.TagParams, 'bgcolor');
                if s <> '' then 
                begin
                  CurContainer.BgColor := GetHtmlColor(s);
                  FViewer.Style.Color := CurContainer.BgColor;
                end;

                s := gv(Parser.TagParams, 'text');
                if s <> '' then
                begin
                  Fviewer.Style.TextStyles[DefStyle].Color := GetHtmlColor(s);
                end;
                s := gv(Parser.TagParams, 'link');
                if s <> '' then
                begin
                  FLinkCol := GetHtmlColor(s);
                end;

                s := gv(Parser.TagParams, 'background');
                if s <> '' then
                begin
                  if Assigned(FOnBackgroundRequired) then
                  begin
                    Gr := Fviewer.BackgroundBitmap;
                    FOnBackgroundRequired(self, s, TBitmap(Gr));
                    Fviewer.BackgroundBitmap := TBitmap(Gr);
                    Fviewer.BackgroundStyle := bsTiled;
                  end;
                end;
              end
              else if (s = '/tr') then
              begin
                (* make sure data is written in case of unbalanced td-tags *)
                WriteTSCR;
                if RVData is TRVTableCellData then
                begin
                  RVT := TRVTableItemInfoH(TRVTableCellData(RVData).GetTable);
                  RVData := nil;
                end;

                (* leaving row -> leave container *)
                LeaveContainer(clRow);
              end
              else if (s = 'tr') then
              begin
                WriteTSCR;
                if RVData is TRVTableCellData then
                begin
                  RVT := TRVTableItemInfoH(TRVTableCellData(RVData).GetTable);
                  RVData := nil;
                end;

                (* close any unbalanced tags *)
                LeaveContainer(clRow);

                if RvData = nil then
                begin
                  inc(RVT.CurrRow);
                  if RVT.CurrRow >= RVT.Rows.Count then
                  begin
                    RVT.Rows.Add(RVT.Rows[0].Count);
                  end;
                  RVT.CurrCol := -1;
                end;

                (* new row -> new container, with default TextStyle and optional align-param *)
                EnterContainer(DefStyle, clRow, GetAlignParam(Parser.TagParams, rvaLeft));

                s := lowercase(gv(Parser.TagParams, 'valign'));
                if s = 'top' then CurContainer.VAlign := rvcTop
                else if s = 'bottom' then CurContainer.VAlign := rvcBottom
                else if s = 'middle' then CurContainer.VAlign := rvcMiddle;

                s := gv(Parser.TagParams, 'bgcolor');
                if s <> '' then
                  CurContainer.BgColor := GetHtmlColor(s);
              end
              else if (s = '/td') or (s = '/th') then
              begin
                WriteTSCR;
                if RVData is TRVTableCellData then
                begin
                  RVT := TRVTableItemInfoH(TRVTableCellData(RVData).GetTable);
                  RVData := nil;

                  (* leaving cell -> leave container *)
                  LeaveContainer(clCol);

                  Parser.LastWasSpace := True;
                  if s = '/th' then
                  begin
                    if CurContainer.PrevFont.Count > 0 then
                    begin
                      CurrStyle := longint(CurContainer.PrevFont[CurContainer.PrevFont.Count
                        - 1]);
                      CurContainer.PrevFont.Delete(CurContainer.PrevFont.Count - 1);
                      FViewer.Style.TextStyles[CurrStyle].AssignTo(CF);
                    end;
                  end;
                end;
              end
              else if (s = 'td') or (s = 'th') then
              begin
                WriteTSCR;
                if RVData is TRVTableCellData then
                begin
                  RVT := TRVTableItemInfoH(TRVTableCellData(RVData).GetTable);
                  RVData := nil;
                end;

                (* close any unbalanced tags *)
                LeaveContainer(clCol);

                Parser.LastWasSpace := True;
                ts := '';
                if (RVData = nil) then
                begin

                  (* support for TD without TR tag *)
                  if (RVT.CurrRow < 0) then
                  begin
                    EnterContainer( DefStyle, clRow, rvaLeft );
                    RVT.CurrRow := 0;
                  end;

                  while RVData = nil do
                  begin
                    Inc(RVT.CurrCol);
                    if RVT.CurrCol >= RVT.Rows[RVT.CurrRow].Count then
                    begin
                      for i := 0 to RVT.Rows.Count - 1 do
                      begin
                        RVT.Rows[i].Add;
                      end;
                    end;
                    RVData := RVT.Cells[RVT.CurrRow, RVT.CurrCol];
                  end;
                  RVData := RVT.Cells[RVT.CurrRow, RVT.CurrCol];

                  RVData.Clear; // remove default item added by RichView

                  (* new cell -> new container, with default TextStyle and optional align-param *)
                  (* CurAlignment is default handles <tr align= <x>> behaviour                  *)
                  EnterContainer(DefStyle, clCol,
                    GetAlignParam(Parser.TagParams, CurContainer.CurAlignment));

                  CurContainer.RVData := RVData; // new default RVData

                  if s = 'th' then
                  begin
                    CF.Style := Cf.Style + [fsBold];
                    FindFont(True, CurrLink <> '');
                  end;
                  s := lowercase(gv(Parser.TagParams, 'valign'));
                  if s = 'top' then CurContainer.VAlign := rvcTop
                  else if s = 'bottom' then CurContainer.VAlign := rvcBottom
                  else if s = 'middle' then CurContainer.VAlign := rvcMiddle;

                  TRVTableCellData(RVData).VAlign := CurContainer.VAlign;

                  DoMerge(StrToIntDef(gv(Parser.TagParams, 'colspan'), 1),
                    StrToIntDef(gv(Parser.TagParams, 'rowspan'), 1));

                  s := gv(Parser.TagParams, 'bordercolor');
                  if s <> '' then
                  begin
                    TRVTableCellData(RVData).BorderColor := GetHtmlColor(s);
                  end;

                  s := gv(Parser.TagParams, 'bgcolor');
                  if s <> '' then
                    CurContainer.BgColor := GetHtmlColor(s);
                  TRVTableCellData(RVData).Color := CurContainer.BgColor;

                  s := gv(Parser.TagParams, 'width');
                  if s <> '' then
                  begin
                    if pos('%', s) > 0 then
                    begin
                      Delete(s, pos('%', s), 1);
                      i := -(abs(StrToIntDef(s, 0)) mod 101);
                    end
                    else
                      i := abs(StrToIntDef(s, 0));

                    TRVTableCellData(RVData).BestWidth := i;
                  end;
                  s := gv(Parser.TagParams, 'height');
                  if s <> '' then
                  begin
                    TRVTableCellData(RVData).BestHeight := StrToIntDef(s, 0);
                  end;
                end;
              end
              else if (S = '/table') then
              begin
                WriteTSCR;
                LeaveContainer(clTable);

                RVData := CurContainer.RVData;

                (* actually add table to RV *)
                if Assigned(CurContainer.RVT) then
                begin
                  RVData.AddItem('', CurContainer.RVT);
                  CurContainer.RVT := nil;
                end;

                RVT := nil;
                CurParaStyle := -1;
              end
              else if (s = 'table') then
              begin
                WriteTSCR;

                (* add new table *)
                DoTable;
              end
              else if s = 'ol' then
              begin
                WriteTSCR;

                lt := GetListType( gv(Parser.TagParams, 'type'), ltNumber );
                CurContainer.EnterIndent( llOL, lt, StrToIntDef(gv(Parser.TagParams, 'start'), 1) );

                (* insert extra LF on main level *)
//                if (not (RVData is TRVTableCellData)) and (CurContainer.ListCount = 1) then writeCR;

                CurParaStyle := -1;
              end
              else if (s = '/ol') then
              begin
                WriteTSCR;

                (* insert extra LF on main level *)
//                if (not (RVData is TRVTableCellData)) and (CurContainer.ListCount = 1) then writeCR;

                CurContainer.LeaveIndent( llOL );

                (* next paragraph *)
                CurParaStyle := -1;
              end
              else if s = 'ul' then
              begin
                WriteTSCR;

                case CurContainer.ListCount of
                  0  : lt := ltDisc;
                  1  : lt := ltCircle;
                  else lt := ltSquare;
                end;
                lt := GetListType( gv(Parser.TagParams, 'type'), lt );
                CurContainer.EnterIndent( llUL, lt, StrToIntDef(gv(Parser.TagParams, 'start'), 1) );

                (* insert extra LF on main level *)
//                if (not (RVData is TRVTableCellData)) and (CurContainer.ListCount = 1) then writeCR;

                CurParaStyle := -1;
              end
              else if (s = '/ul') then
              begin
                WriteTSCR;

                (* insert extra LF on main level *)
//                if (not (RVData is TRVTableCellData)) and (CurContainer.ListCount = 1) then writeCR;

                CurContainer.LeaveIndent( llUL );

                (* next paragraph *)
                CurParaStyle := -1;
              end
              else if (s = 'li') then
              begin
                WriteTSCR;

                with CurContainer do
                begin
                  lt := ltDisc;
                  i  := StrToIntDef( gv(Parser.TagParams, 'value'), 0 );

                  if IndentStack.Count > 0 then
                    with TContainerIndentType(IndentStack[IndentStack.Count-1]) do
                    begin
                      lt := ListType;

                      if (i > 0) then
                        ListValue := i
                      else
                        i := ListValue;

                      inc(ListValue);
                    end;

                  CurLIType  := GetListType( gv(Parser.TagParams, 'type'), lt );
                  CurLIValue := i;
                  CurHadLI   := True;
                end;

                CurParaStyle := -1;
              end

              else if s = 'pre' then
              begin
                WriteTSCR;
                Parser.RemoveSpaces := False;
                CF.Name := DefaultCFontName;
                CF.Size := DefaultCFontSize;
                FindFont(True, CurrLink <> '');
              end
              else if s = '/pre' then
              begin
                Parser.RemoveSpaces := True;
                WriteTSCR;
                if CurContainer.PrevFont.Count > 0 then
                begin
                  CurrStyle := longint(CurContainer.PrevFont[CurContainer.PrevFont.Count - 1]);
                  CurContainer.PrevFont.Delete(CurContainer.PrevFont.Count - 1);
                  FViewer.Style.TextStyles[CurrStyle].AssignTo(CF);
                end;
              end
              else if (length(s) = 3) and (s[1] = '/') and (s[2] = 'h') and (s[3] in ['1'..'6']) then
              begin
                WriteTSCR;
                writeCR;
                if CurContainer.PrevFont.Count > 0 then
                begin
                  CurrStyle := longint(CurContainer.PrevFont[CurContainer.PrevFont.Count - 1]);
                  CurContainer.PrevFont.Delete(CurContainer.PrevFont.Count - 1);
                  FViewer.Style.TextStyles[CurrStyle].AssignTo(CF);
                end;
              end
              else if (length(s) = 2) and (s[1] = 'h') and (s[2] in ['1'..'6']) then
              begin
                {
                if (ts <> '') and (ts[length(ts)] <> #13) then ts := ts + #13;
                WriteTSCR;
                }

                WriteTSCR;
                WriteCR;
                if (ts <> '') and (ts[length(ts)] <> #13) then writeCR;


                CF.Size := FontSize[1 + (abs(7 - (Ord(s[2]) - Ord('0'))) mod 7)];
                CF.Style := [fsbold];
                FindFont(True, CurrLink <> '');
              end
              else if s = 'hr' then
              begin
                WriteTSCR;
                if RVData <> nil then
                  RVData.AddBreak;
              end
              else if s = 'img' then
              begin
//SM if an image is on the first place after a paragraph change
//  set parastyle here !!
(* do we need to switch parastyles ? * YES ;-) *)
if fixed_css_styles and (CurParaStyle <> CurContainer.ParaStyle) then
begin
  CurParaStyle := CurContainer.ParaStyle;
  writeCR;
end;
//SM end
                WriteTSCR;

                gr := nil;
                if @FOnImageRequired <> nil then
                begin
                  FOnImageRequired(Self, gv(Parser.TagParams, 'src'), Gr);
                end;

                if Assigned(OnImageRequired2) then
                begin
                  OnImageRequired2(Self,
                    gv(Parser.TagParams, 'src'),
                    StrToIntDef(gv(Parser.TagParams, 'width'), 0),
                    StrToIntDef(gv(Parser.TagParams, 'height'), 0), Gr);
                end;

                
                if gr <> nil then
                begin
                  w := -1;
                  h := -1;

                  try

                    s := gv(Parser.TagParams, 'width');
                    if s <> '' then
                    begin
                      gr.Width := StrtoIntDef(s, gr.Width);
                      w := gr.Width;  // img-tag specifically stated width
                    end;

                    s := gv(Parser.TagParams, 'height');
                    if s <> '' then
                    begin
                      gr.Height := StrtoIntDef(s, gr.Height);
                      h := gr.Height; // img-tag specifically stated height
                    end;
                  except
                  end;
                  if (RVData <> nil) then
                  begin
                   //TODO: <li> behaviour ? add marker ?
                    if (CurrLink <> '') then
                    begin
                      RemoveLineBreaks(CurrLink);
                      RVData.AddHotPictureTag(gv(Parser.TagParams, 'src'),
                        gr, - 1, rvvaBaseline, integer(StrNew(PChar(CurrLink))))
                    end
                    else
                      RVData.AddPictureEx(gv(Parser.TagParams, 'src'),
                        gr, - 1, rvvaBaseline);

                    (* set sizes as specified in img-tag *)
                    if (w > 0) then RVData.SetItemExtraIntProperty( rvData.ItemCount-1, rvepImageWidth, w );
                    if (h > 0) then RVData.SetItemExtraIntProperty( rvData.ItemCount-1, rvepImageHeight, h );
                    RVData.SetItemExtraIntProperty( rvData.ItemCount-1, rvepSpacing, 0 );
                  end
                  else
                    gr.Free;
                end;
              end
              else if s = 'a' then
              begin
                WriteTSCR;
                s := gv(Parser.TagParams, 'href');
                if s <> '' then
                begin
                  if CurrLink <> '' then Continue;
                  CurrLink := s;
                  BeforeLinkFont := CurContainer.PrevFont.Count;
                  CF.Color := FLinkCol;
                  CF.Style := DefaultLinkStyle;
//sm search the first font with jump=true
//                  FindFont(True, CurrLink <> '');
    if (RVData <> nil) then
    begin
      CurContainer.PrevFont.Add(Pointer(CurrStyle));
      with FViewer.Style.TextStyles do
        for i := 0 to Count - 1 do
          if Items[i].Jump then
          begin
            CurrStyle := I;
            break;
          end;
    end;
//end sm
                end
                else
                begin
                  s := gv(Parser.TagParams, 'name');
                  RemoveLineBreaks(s);
                  if RVData <> nil then
                    FViewer.AddNamedCheckpoint(s);
                end;
              end
              else if s = '/a' then
              begin
                if CurrLink <> '' then
                begin
                  WriteTSCR;
                  CurrLink := '';
                  if BeforeLinkFont < CurContainer.PrevFont.Count then
                    CurrStyle := longint(CurContainer.PrevFont[BeforeLinkFont])
                  else
                    CurrStyle := DefStyle;
                  while CurContainer.PrevFont.Count > BeforeLinkFont do
                  begin
                    CurContainer.PrevFont.Delete(CurContainer.PrevFont.Count - 1);
                  end;
                  BeforeLinkFont := DefStyle;
                  FViewer.Style.TextStyles[CurrStyle].AssignTo(CF);
                end;
              end

              else if (s = 'div') then
              begin
                WriteTSCR;

                (* Enter new alignment *)
//SM added
if not(fixed_css_styles) then
//SM end added
                CurContainer.EnterAlignment(GetAlignParam(Parser.TagParams,
                  CurContainer.CurAlignment));

                CurParaStyle := -1;  // reset current parastyle
              end
              else if (s = 'center') then
              begin
                WriteTSCR;

                (* treat as <div align=center> *)
//SM added
if not(fixed_css_styles) then
//SM end added
                CurContainer.EnterAlignment(rvaCenter);
              end
              else if (s = '/div') or (s = '/center') then
              begin
                Parser.LastWasSpace := True;
                WriteTSCR;

                (* Leave alignment *)
                CurContainer.LeaveAlignment;
                CurParaStyle := -1;  // reset current parastyle
              end
              else if (s = 'br') then
              begin
                Parser.LastWasSpace := True;

                WriteTSCR;
                if (CurParaStyle = -1) then
                  WriteCR;
                CurParaStyle := -1;
              end
              else if s = '/p' then
              begin
                WriteTSCR;
                CurContainer.LeaveAlignment;
                CurParaStyle := -1;  // reset current parastyle
              end
              else if s = 'p' then
              begin
                Parser.LastWasSpace := True;
                WriteTSCR;
//SM added
s := gv(Parser.TagParams, 'class');
if fixed_css_styles and (pos('RVPS',s)=1) then
begin
  s:=copy(s,5,length(s)-4);
  i:=strtointdef(s,0);
  if i>Fviewer.Style.ParaStyles.Count-1 then i:=0;
  CurContainer.Parastyle:=i;
end
else
begin
if not(fixed_css_styles) then
//SM end added
  writeCR;
                CurContainer.EnterAlignment(GetAlignParam(Parser.TagParams,
                  CurContainer.CurAlignment));
end;

                CurParaStyle := -1;  // reset current parastyle

                //                ts := ts + #13#13;
              end
              else if (s = 'b') or (S = 'strong') then
              begin
                WriteTSCR;
                CF.Style := Cf.Style + [fsBold];
                FindFont(True, CurrLink <> '');
              end
              else if (s = '/b') or (s = '/strong') then
              begin
                WriteTSCR;
                CF.Style := Cf.Style - [fsBold];
                FindFont(False, CurrLink <> '');
              end
              else if (s = 'i') or (s = 'em') then
              begin
                WriteTSCR;
                CF.Style := Cf.Style + [fsItalic];
                FindFont(True, CurrLink <> '');
              end
              else if (s = '/i') or (s = '/em') then
              begin
                WriteTSCR;
                CF.Style := Cf.Style - [fsItalic];
                FindFont(False, CurrLink <> '');
              end
              else if s = 'u' then
              begin
                WriteTSCR;
                CF.Style := Cf.Style + [fsUnderline];
                FindFont(True, CurrLink <> '');
              end
              else if s = '/u' then
              begin
                WriteTSCR;
                CF.Style := Cf.Style - [fsUnderline];
                FindFont(False, CurrLink <> '');
              end
              else if s = 'strike' then
              begin
                WriteTSCR;
                CF.Style := Cf.Style + [fsStrikeout];
                FindFont(True, CurrLink <> '');
              end
              else if s = '/strike' then
              begin
                WriteTSCR;
                CF.Style := Cf.Style - [fsStrikeOut];
                FindFont(True, CurrLink <> '');
              end
              else if s = '/font' then
              begin
                WriteTSCR;
                if CurContainer.PrevFont.Count > 0 then
                begin
                  CurrStyle := longint(CurContainer.PrevFont[CurContainer.PrevFont.Count - 1]);
                  CurContainer.PrevFont.Delete(CurContainer.PrevFont.Count - 1);
                  FViewer.Style.TextStyles[CurrStyle].AssignTo(CF);
                end;
              end
              else if s = 'font' then
              begin
                WriteTSCR;
                s := gv(Parser.TagParams, 'face');
                if s <> '' then CF.Name := s;
                s := gv(Parser.TagParams, 'size');
                if s <> '' then
                begin
                  if s[1] = '+' then CF.Size := FtoHF(HFtoF(CF.Size) +
                      StrToIntDef(Copy(S, 2, MaxInt), 0))
                  else if s[1] = '-' then CF.Size := FtoHF(HFtoF(CF.Size) - StrToIntDef(Copy(S, 2, MaxInt),
                      0))
                  else
                    CF.Size := FtoHF(StrToIntDef(s, 3));
                end;
                s := gv(Parser.TagParams, 'color');
                if s <> '' then CF.Color := GetHtmlColor(s);
                FindFont(True, CurrLink <> '');
              end

//SM added
              else if s = '/span' then
              begin
                WriteTSCR;
                if CurContainer.PrevFont.Count > 0 then
                begin
                  CurrStyle := longint(CurContainer.PrevFont[CurContainer.PrevFont.Count - 1]);
                  CurContainer.PrevFont.Delete(CurContainer.PrevFont.Count - 1);
                  FViewer.Style.TextStyles[CurrStyle].AssignTo(CF);
                end;
              end
              else if s = 'span' then
              begin
                WriteTSCR;
                s := gv(Parser.TagParams, 'class');
                s:=copy(s,5,length(s)-4);
                i:=strtointdef(s,0);
                if i>Fviewer.Style.TextStyles.Count-1 then i:=0;
                CF.assign(FViewer.Style.TextStyles[i]);
                if RVData <> nil then
                begin
                  CurContainer.PrevFont.Add(Pointer(CurrStyle));
                  with FViewer.Style.TextStyles do
                  begin
                    CurrStyle := I;
                  end;
                end;
              end
//SM end added




              else if (s = 'script') then
              begin
                (* no support for scripts; filter all data within this tag *)
                Parser.Next;
                while ((Parser.CurrBlock <> cbTag) or
                  (lowercase(Parser.tagName) <> '/script')) and not (Parser.Done) do
                  Parser.Next;
              end 
              else if (s = 'style') then
              begin
                (* no support for style; filter all data within this tag *)
                Parser.Next;
                while ((Parser.CurrBlock <> cbTag) or
                  (lowercase(Parser.tagName) <> '/style')) and not (Parser.Done) do
                begin
//SM added, detection of background color
                  line:=lowercase(parser.tagname);
                  posi:=pos('background-color:',line);
                  if posi>0 then
                  begin
                    posi:=posi+16;
                    line:=trim(copy(line,posi+1,length(line)-posi));
                    posi:=pos(';',line);
                    line:=copy(line,1,posi-1);
                    if line<>'' then richview.color:=GetHtmlColor(line);
                  end;
//SM end added
                  Parser.Next;
                end;
              end
              else if (s = 'noembed') then
              begin
                (* no support for scripts; filter all data within this tag *)
                Parser.Next;
                while ((Parser.CurrBlock <> cbTag) or
                  (lowercase(Parser.tagName) <> '/noembed')) and not (Parser.Done) do
                  Parser.Next;
              end;
            end;
          cbText:
            begin
              ts := ts + Parser.TagName;
              if FSeparateLines then
                WriteTS;    //hrr SeparateLines
            end;
        end;
      end;
    finally
      Parser.Free;
    end;
    WriteTSCR;

    (* support for unbalanced TABLE tag *)
    LeaveContainer(clTable);
    RVData := CurContainer.RVData;
    if Assigned(CurContainer.RVT) then
    begin
      RVData.AddItem('', CurContainer.RVT);
      CurContainer.RVT := nil;
    end;


    FViewer.Format;


  finally
    ContainerStack.Free;

    //    PrevFont.Free;
    CF.Free;
  end;
end;








{ THtmlParser }

constructor THtmlParser.Create(const Text: string);
begin
  FTagParams := TStringList.Create;
  FRemoveSpaces := True;
  OrgText := Text;
  P := PChar(OrgText);
  FCurrLine := 1;                  //hrr LineCount
  inherited Create;
end;

destructor THtmlParser.Destroy;
begin
  FTagParams.Free;
  inherited Destroy;
end;

const
  Spaces = [' ', #9, #13, #10];

function THtmlParser.Done: boolean;
begin
  Result := p^ = #0;
end;

function THtmlParser.GetBytesParsed: integer;
begin
  Result := p - PChar(OrgText);
end;

procedure THtmlParser.Next;
var
  c, s: string;
  PCurr, PEnd: PChar;
  I, Pos: longint;


  function ConvertCData( CData : string ): char;
  type
    TCTableEntry = record
      CData : string;
      CChar : byte;
    end;

  const
    CTableCnt = 5 + 95;
    CTable : array[0..CTableCnt-1] of TCTableEntry =
    (
      (* Markup Controls (cnt=5) *)
      (CData:'nbsp'; CChar: 32),(CData:'quot'; CChar: 34),(CData:'amp'; CChar: 38),
      (CData:'lt'; CChar:   60),(CData:'gt'; CChar:   62),

      (* ISO Latin-1 (cnt=95) *)
      (CData:'iexcl'; CChar:  161),(CData:'cent'; CChar:   162),
      (CData:'pound'; CChar:  163),(CData:'curren'; CChar: 164),(CData:'yen'; CChar:    165),
      (CData:'brvbar'; CChar: 166),(CData:'sect'; CChar:   167),(CData:'uml'; CChar:    168),
      (CData:'copy'; CChar:   169),(CData:'ordf'; CChar:   170),(CData:'laquo'; CChar:  171),
      (CData:'not'; CChar:    172),(CData:'shy'; CChar:    173),(CData:'reg'; CChar:    174),
      (CData:'macr'; CChar:   175),(CData:'deg'; CChar:    176),(CData:'plusmn'; CChar: 177),
      (CData:'sup2'; CChar:   178),(CData:'sup3'; CChar:   179),(CData:'acute'; CChar:  180),
      (CData:'micro'; CChar:  181),(CData:'para'; CChar:   182),(CData:'middot'; CChar: 183),
      (CData:'cedil'; CChar:  184),(CData:'sup1'; CChar:   185),(CData:'ordm'; CChar:   186),
      (CData:'raquo'; CChar:  187),(CData:'frac14'; CChar: 188),(CData:'frac12'; CChar: 189),
      (CData:'frac34'; CChar: 190),(CData:'iquest'; CChar: 191),(CData:'Agrave'; CChar: 192),
      (CData:'Aacute'; CChar: 193),(CData:'Acirc'; CChar:  194),(CData:'Atilde'; CChar: 195),
      (CData:'Auml'; CChar:   196),(CData:'Aring'; CChar:  197),(CData:'AElig'; CChar:  198),
      (CData:'Ccedil'; CChar: 199),(CData:'Egrave'; CChar: 200),(CData:'Eacute'; CChar: 201),
      (CData:'Ecirc'; CChar:  202),(CData:'Euml'; CChar:   203),(CData:'Igrave'; CChar: 204),
      (CData:'Iacute'; CChar: 205),(CData:'Icirc'; CChar:  206),(CData:'Iuml'; CChar:   207),
      (CData:'ETH'; CChar:    208),(CData:'Ntilde'; CChar: 209),(CData:'Ograve'; CChar: 210),
      (CData:'Oacute'; CChar: 211),(CData:'Ocirc'; CChar:  212),(CData:'Otilde'; CChar: 213),
      (CData:'Ouml'; CChar:   214),(CData:'times'; CChar:  215),(CData:'Oslash'; CChar: 216),
      (CData:'Ugrave'; CChar: 217),(CData:'Uacute'; CChar: 218),(CData:'Ucircv'; CChar: 219),
      (CData:'Uuml'; CChar:   220),(CData:'Yacute'; CChar: 221),(CData:'THORN'; CChar:  222),
      (CData:'szlig'; CChar:  223),(CData:'agrave'; CChar: 224),(CData:'aacute'; CChar: 225),
      (CData:'acirc'; CChar:  226),(CData:'atilde'; CChar: 227),(CData:'auml'; CChar:   228),
      (CData:'aring'; CChar:  229),(CData:'aelig'; CChar:  230),(CData:'ccedil'; CChar: 231),
      (CData:'egrave'; CChar: 232),(CData:'eacute'; CChar: 233),(CData:'ecirc'; CChar:  234),
      (CData:'euml'; CChar:   235),(CData:'igrave'; CChar: 236),(CData:'iacute'; CChar: 237),
      (CData:'icirc'; CChar:  238),(CData:'iuml'; CChar:   239),(CData:'eth'; CChar:    240),
      (CData:'ntilde'; CChar: 241),(CData:'ograve'; CChar: 242),(CData:'oacute'; CChar: 243),
      (CData:'ocirc'; CChar:  244),(CData:'otilde'; CChar: 245),(CData:'ouml'; CChar:   246),
      (CData:'divide'; CChar: 247),(CData:'oslash'; CChar: 248),(CData:'ugrave'; CChar: 249),
      (CData:'uacute'; CChar: 250),(CData:'ucirc'; CChar:  251),(CData:'uuml'; CChar:   252),
      (CData:'yacute'; CChar: 253),(CData:'thorn'; CChar:  254),(CData:'yuml'; CChar:   255)
    );
  var i : integer;
  begin
    (* try character entities *)
    for i :=0 to CTableCnt-1 do
      if (CTable[i].CData = CData) then
      begin
        Result := chr(CTable[i].CChar);
        Exit;
      end;

    (* still here ? try number *)
    Result := chr(StrToIntDef( CData, ord(' ') ));
  end;



begin
  PEnd := P;
  if PEnd^ = '<' then
  begin
    Inc(PEnd);
    if (PEnd[0] = '!') and (PEnd[1] = '-') and (PEnd[2] = '-') then
    begin
      Inc(PEnd, 3);
//      while PEnd <> #0 do
      while (PEnd[0] <> #0) and (PEnd[1] <> #0) and (PEnd[2] <> #0) do
      begin
        if (PEnd[0] = '-') and (PEnd[1] = '-') and (PEnd[2] = '>') then
        begin
          Inc(PEnd, 3);
          SetLength(FTagName, longint(PEnd) - longint(P));
          Move(P^, FTagName[1], Length(FTagName));
          FTagParams.Clear;
          Break;
        end;
        Inc(PEnd);
      end; // while
      FCurrBlock := cbComment;
    end {if} 
    else 
    begin
      FTagParams.Clear;
      PCurr := PEnd;
      Inc(PEnd);

      while not (PEnd^ in (['/', #0, '>'] + Spaces)) do Inc(PEnd);

      SetString(FTagName, PCurr, longint(PEnd) - longint(PCurr));

      if PEnd^ in Spaces then
      begin
        Inc(PEnd);
        while (PEnd^ <> '>') and (pend^ <> #0) do
        begin
          while PEnd^ in Spaces do Inc(PEnd);

          PCurr := PEnd;

          while not (PEnd^ in ([#0, '>', '='] + Spaces)) do Inc(PEnd);

          SetString(c, PCurr, longint(PEnd) - longint(PCurr));

          (* filter optional spaces before = *)
          while (PEnd^ in Spaces) do Inc(PEnd);

          if PEnd^ = '=' then
          begin
            Inc(PEnd);

            (* filter optional spaces after = *)
            while (PEnd^ in Spaces) do Inc(PEnd);

            if PEnd^ = '"' then
            begin
              Inc(PEnd);
              PCurr := PEnd;
              while not (PEnd^ in [#0, '"']) do Inc(PEnd);
              SetString(s, PCurr, longint(PEnd) - longint(PCurr));
              if PEnd^ = '"' then Inc(PEnd);
              if PEnd^ = ' ' then Inc(PEnd);
              FTagParams.Add(c + '=' + s);
            end 
            else
            begin
              PCurr := PEnd;

              while not (PEnd^ in ([#0, '>'] + Spaces)) do Inc(PEnd);

              SetString(s, PCurr, longint(PEnd) - longint(PCurr));
              if PEnd^ = ' ' then Inc(PEnd);
              FTagParams.Add(c + '=' + s);
            end;
          end
          else 
          begin
            FTagParams.Add(c);
          end;
        end;
      end; //if
      if PEnd^ = '/' then Inc(PEnd);
      if PEnd^ = '>' then Inc(PEnd);
      FCurrBlock := cbTag;
    end; // else if
  end 
  else 
  begin
    //	 while not (PEnd^ in [#0, '<']) do Inc(PEnd);			//hrr out
    while not (PEnd^ in [#0, '<', #10]) do Inc(PEnd);    //hrr LineCount...
    if PEnd^ = #10 then
    begin
      Inc(FCurrLine);
      Inc(PEnd);
    end;                                  //...hrr LineCount

    SetLength(s, Longint(PEnd) - Longint(P));
    Move(P^, s[1], Length(s));
    SetLength(FTagName, Length(S));
    Pos := 0;
    I := 1;
    while I <= Length(S) do
    begin
      Inc(Pos);
      if (s[i] in Spaces) and (FRemoveSpaces) then
      begin
        Inc(I);
        while (I <= Length(s)) and(s[i] in Spaces) do
          Inc(I);
        FTagName[Pos] := ' ';
      end
      else if s[i] = '&' then
      begin
        Inc(i);
        c := '';
        while (I<= Length(s)) and (s[i] <> ';') do
        begin
          c := c + s[i];
          Inc(I);
        end;
        if s[i] = ';' then inc(i);

        FTagName[Pos] := ConvertCData( c );

      end else
      begin
        FTagName[Pos] :=s[i];
        Inc(I);
      end;
    end;

    SetLength(FTagName, Pos);
    if (Pos > 0) and ((s[1] in Spaces) and FLastWasSpace) and (FRemoveSpaces) then
      Delete(FTagName, 1, 1);
    if fTagName <> '' then
      FLastWasSpace := FTagName[Length(FTagName)] = ' ';
    if not FRemoveSpaces then
      FTagName := StringReplace(FTagName, #13#10, #13, [rfReplaceAll]);
    FTagParams.Clear;
    FCurrBlock := cbText;
  end;
  P := PEnd;
end;


end.
