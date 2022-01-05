{*************************************************************************}
{ TMS ToolBars component                                                  }
{ for Delphi & C++Builder                                                 }
{ version 1.3                                                             }
{                                                                         }
{ written by TMS Software                                                 }
{           copyright © 2005                                              }
{           Email : info@tmssoftware.com                                  }
{           Web : http://www.tmssoftware.com                              }
{                                                                         }
{ The source code is given as is. The author is not responsible           }
{ for any possible damage done due to the use of this code.               }
{ The component can be freely used in any application. The complete       }
{ source code remains property of the author and may not be distributed,  }
{ published, given or sold in any form as such. No parts of the source    }
{ code can be included in any other component or application without      }
{ written authorization of the author.                                    }
{*************************************************************************}

unit AdvToolBar;

{$R ADVTOOLBAR.RES}
{$R ADVTOOLBARDB.RES}

{$I TMSDEFS.INC}
{$T-}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Math, Registry,
  Menus, AdvMenus, Dialogs, Forms, ImgList, CommCtrl, ExtCtrls, ActnList,
  IniFiles, DB;

const
  CN_DROPDOWNCLOSED = WM_USER + $1000;

  DEFAULT_TOOLBARHEIGHT = 26;
  DEFAULT_MINLENGTH = 60;
  MINDOCKPANELHEIGHT = 3;
  DEFAULT_CAPTIONHEIGHT = 16;
  DEFAULT_ITEMHEIGHT = 20;
  DEFAULT_SEPARATORWIDTH = 10;
  IMG_SPACE = 2;
  MIN_BUTTONSIZE = 15;
  DEFAULT_POPUPINDICATORWIDTH = 14;
  MIN_POPUPWINDOWSIZE = 70;
  TOOLBAR_SECTION = 'UnDockedAdvToolBars';

  MDIBTNSIZE = 18; // 20

  MAJ_VER = 1; // Major version nr.
  MIN_VER = 3; // Minor version nr.
  REL_VER = 6; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // 1.0.0.0 : first release
  // 1.0.1.0 : Added properties TextAutoOptionMenu, TextOptionMenu to TAdvToolBar
  //         : Fix for autosizing rootitems in Delphi 5 / C++Builder 5
  // 1.0.1.1 : Fix with menustyler for TAdvDockPanel popupmenu
  // 1.0.2.0 : Extension to better handle shortcuts
  //         : Improved menu handling on multimonitor machines
  //         : Improved handling of tasCheck button type with Down property set in Object Inspector
  // 1.1.0.0 : Property AutoArrangeButtons property added to control auto-arrange of hidden buttons
  //         : TDBAdvToolbarButton added
  //         : Support to add a DB navigator to a toolbar added
  // 1.1.0.1 : Fix for appearance of auto option menu in Delphi 2005
  // 1.1.1.0 : Fix for resizing of toolbar
  //         : Fix for color issue with stylers
  //         : New bsCustom style in OfficeStyler & bsUser in FantasyStyler available
  //         : Fix for ParentStyler property setting
  // 1.2.0.0 : New Whidbey appearance
  //         : Stylers .LoadFromFile, SaveToFile support added
  //         : Improved styler setup & support to use stylers in datamodules
  // 1.2.0.1 : Improved AdvToolBarMenuButton with ShowCaption property
  //         : RichFormat action support enhanced
  // 1.2.0.2 : Fixed issue with visible parent window
  //         : Fixed issue with toolbar button shortcuts
  //         : Fixed issue with custom & user stylers
  // 1.3.0.0 : Dockpanel height lock capability added
  //         : DisabledImages support added
  //         : Fix for destroy of toolbarbutton for use in frames
  //         : New methods: MoveToolBarControl, InsertToolBarControl, AddToolBarControl, IndexOfToolbarControl
  //         : New public property ToolBarControls[index]: TControl
  //         : New public property ToolBarControlCount: integer;
  //         : New property TAdvDockPanel.UseRunTimeHeight
  //         : Support for MDI menu merging with MergeMenu, UnMergeMenu methods
  // 1.3.0.1 : Messages & hints for DB navigator toolbar based on VDBConsts
  //         : Improvements in Office 2003 style appearance
  //         : Fix in ToolBarControls[] access
  // 1.3.0.2 : Fix for caption position for not autosizing toolbar buttons
  // 1.3.5.0 : MDI button display in fullsize toolbar menu capability added
  // 1.3.6.0 : Persistence of toolbar visibility states

type
  TAdvCustomToolBar = class;
  TAdvDockPanel = class;
  TFloatingWindow = class;
  TOptionSelectorPanel = class;
  TOptionSelectorWindow = class;
  TControlSelectorPanel = class;
  TATBPopupWindow = class;
  TATBCustomPopupPanel = class;
  TATBPopupPanel = class;
  TATBMenuItem = class;

  TGradientDirection = (gdHorizontal, gdVertical);
  TDockAlign = (daLeft, daTop, daRight, daBottom);
  TBackGroundDisplay = (bdTile, bdCenter, bdStretch);
  TDragGripStyle = (dsDots, dsSingleLine, dsDoubleLine, dsFlatDots, dsNone);

  TToolBarState = (tsDocked, tsFloating, tsFixed);
  TItemChangeAction = (icRefresh, isResize);
  TButtomItemStyle = (bisButton, bisCheck);
  TGlyphPosition = (gpLeft, gpTop, gpRight, gpBottom);

  TDockableTo = set of TDockAlign;

  TAdvCustomToolBarButton = class;

  TProForm = class(TCustomForm);

  TDbgList = class(TList)
  private
    function GetItemsEx(Index: Integer): Pointer;
    procedure SetItemsEx(Index: Integer; const Value: Pointer);
  public
    property Items[Index: Integer]: Pointer read GetItemsEx write SetItemsEx; default;
  end;

  TButtonAppearance = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FColorHot: TColor;
    FColorTo: TColor;
    FColor: TColor;
    FColorHotTo: TColor;
    FColorDownTo: TColor;
    FColorDown: TColor;
    FBorderDownColor: TColor;
    FBorderColor: TColor;
    FBorderHotColor: TColor;
    FGradientDirection: TGradientDirection;
    FColorChecked: TColor;
    FColorCheckedTo: TColor;
    FCaptionTextColorChecked: TColor;
    FCaptionTextColor: TColor;
    FCaptionTextColorHot: TColor;
    FCaptionTextColorDown: TColor;
    FBorderCheckedColor: TColor;
    FCaptionFont: TFont;
    FGlyphPosition: TGlyphPosition;
    FGradientDirectionDown: TGradientDirection;
    FGradientDirectionHot: TGradientDirection;
    FGradientDirectionChecked: TGradientDirection;
    procedure Change;
    procedure SetBorderColor(const Value: TColor);
    procedure SetColor(const Value: TColor);
    procedure SetColorDown(const Value: TColor);
    procedure SetColorDownTo(const Value: TColor);
    procedure SetColorHot(const Value: TColor);
    procedure SetColorHotTo(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure SetColorChecked(const Value: TColor);
    procedure SetColorCheckedTo(const Value: TColor);
    procedure SetCaptionTextColor(const Value: TColor);
    procedure SetCaptionTextColorDown(const Value: TColor);
    procedure SetCaptionTextColorHot(const Value: TColor);
    procedure SetCaptionTextColorChecked(const Value: TColor);
    procedure SetBorderCheckedColor(const Value: TColor);
    procedure SetCaptionFont(const Value: TFont);
    procedure SetGlyphPosition(const Value: TGlyphPosition);
    procedure SetGradientDirectionChecked(const Value: TGradientDirection);
    procedure SetGradientDirectionDown(const Value: TGradientDirection);
    procedure SetGradientDirectionHot(const Value: TGradientDirection);
  protected
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property GlyphPosition: TGlyphPosition read FGlyphPosition write SetGlyphPosition default gpLeft;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Color: TColor read FColor write SetColor default clNone;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property ColorChecked: TColor read FColorChecked write SetColorChecked default $00D8D5D4;
    property ColorCheckedTo: TColor read FColorCheckedTo write SetColorCheckedTo default clNone;
    property ColorDown: TColor read FColorDown write SetColorDown default $00B59285;
    property ColorDownTo: TColor read FColorDownTo write SetColorDownTo default clNone;
    property ColorHot: TColor read FColorHot write SetColorHot default $00D2BDB6;
    property ColorHotTo: TColor read FColorHotTo write SetColorHotTo default clNone;
    property CaptionTextColor: TColor read FCaptionTextColor write SetCaptionTextColor default clBlack;
    property CaptionTextColorHot: TColor read FCaptionTextColorHot write SetCaptionTextColorHot default clBlack;
    property CaptionTextColorDown: TColor read FCaptionTextColorDown write SetCaptionTextColorDown default clBlack;
    property CaptionTextColorChecked: TColor read FCaptionTextColorChecked write SetCaptionTextColorChecked default clBlack;
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection default gdVertical;
    property GradientDirectionHot: TGradientDirection read FGradientDirectionHot write SetGradientDirectionHot default gdVertical;
    property GradientDirectionDown: TGradientDirection read FGradientDirectionDown write SetGradientDirectionDown default gdVertical;
    property GradientDirectionChecked: TGradientDirection read FGradientDirectionChecked write SetGradientDirectionChecked default gdVertical;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clNone;
    property BorderDownColor: TColor read FBorderDownColor write FBorderDownColor default $006A240A;
    property BorderHotColor: TColor read FBorderHotColor write FBorderHotColor default $006A240A;
    property BorderCheckedColor: TColor read FBorderCheckedColor write SetBorderCheckedColor default $006A240A;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
    //property GlyphPosition: TGlyphPosition read FGlyphPosition write SetGlyphPosition default gpLeft;
  end;

  TGradientBackground = class(TPersistent)
  private
    FSteps: Integer;
    FColor: TColor;
    FColorTo: TColor;
    FDirection: TGradientDirection;
    FOnChange: TNotifyEvent;
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetDirection(const Value: TGradientDirection);
    procedure SetSteps(const Value: Integer);
    procedure Changed;
  protected
  public
    constructor Create; 
    procedure Assign(Source: TPersistent); override;  
  published
    property Color: TColor read FColor write SetColor;
    property ColorTo: TColor read FColorTo write SetColorTo;
    property Direction: TGradientDirection read FDirection write SetDirection default gdHorizontal;
    property Steps: Integer read FSteps write SetSteps default 64;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  //PropID: 5 for update Positioning
  //PropID: 6 for AdvMenuStyler Change
  TCustomAdvToolBarStyler = class(TComponent)
  private
    FBackGroundTransparent: Boolean;
    FBackGroundDisplay: TBackGroundDisplay;
    FBackGround: TBitMap;
    FColor: TGradientBackground;
    FDockColor: TGradientBackground;
    FInternalAdvMenuStyler: TCustomAdvMenuStyler;
    FAdvMenuStyler: TCustomAdvMenuStyler;
    FCurrentAdvMenuStyler: TCustomAdvMenuStyler;
    FDragGripStyle: TDragGripStyle;
    FDragGripImage: TBitMap;
    //FPopupIndicatorStyle: TPopupIndicatorStyle;
    FRightHandleImage: TBitmap;
    FFont: TFont;
    FTransparent: Boolean;
    FControlList: TDbgList;
    FRoundEdges: boolean;
    FRightHandleColor: TColor;
    FRightHandleColorHot: TColor;
    FRightHandleColorTo: TColor;
    FRightHandleColorHotTo: TColor;
    FFloatingWindowBorderWidth: integer;
    FCaptionColorTo: TColor;
    FCaptionBorderColor: TColor;
    FCaptionColor: TColor;
    FFloatingWindowBorderColor: TColor;
    FCaptionTextColor: TColor;
    FButtonAppearance: TButtonAppearance;
    FAutoThemeAdapt: boolean;
    FRightHandleColorDownTo: TColor;
    FRightHandleColorDown: TColor;
    FBevel: TPanelBevel;
    FUseBevel: Boolean;
    procedure SetBackGround(const Value: TBitMap);
    procedure SetBackGroundDisplay(const Value: TBackGroundDisplay);
    procedure SetBackGroundTransparent(const Value: Boolean);
    procedure SetColor(const Value: TGradientBackground);
    procedure SetAdvMenuStyler(const Value: TCustomAdvMenuStyler);
    procedure SetDragGripStyle(const Value: TDragGripStyle);
    procedure SetDragGripImage(const Value: TBitMap);
    //procedure SetPopupIndicatorStyle(const Value: TPopupIndicatorStyle);
    procedure SetRightHandleImage(const Value: TBitmap);
    procedure SetFont(const Value: TFont);
    procedure SetTransparent(const Value: Boolean);
    procedure SetRoundEdges(const Value: boolean);
    procedure SetRightHandleColor(const Value: TColor);
    procedure SetRightHandleColorHot(const Value: TColor);
    procedure SetCaptionBorderColor(const Value: TColor);
    procedure SetCaptionColor(const Value: TColor);
    procedure SetCaptionColorTo(const Value: TColor);
    procedure SetCaptionTextColor(const Value: TColor);
    procedure SetFloatingWindowBorderColor(const Value: TColor);
    procedure SetFloatingWindowBorderWidth(const Value: integer);
    procedure SetTButtonAppearance(const Value: TButtonAppearance);
    procedure SetDockColor(const Value: TGradientBackground);
    procedure SetRightHandleColorTo(const Value: TColor);
    procedure SetRightHandleColorHotTo(const Value: TColor);
    procedure SetRightHandleColorDown(const Value: TColor);
    procedure SetRightHandleColorDownTo(const Value: TColor);
    procedure SetBevel(const Value: TPanelBevel);
    procedure SetUseBevel(const Value: Boolean);
  protected
    procedure AddControl(AControl: TCustomControl);
    procedure RemoveControl(AControl: TCustomControl);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure BackgroundChanged(Sender: TObject);

    property CurrentAdvMenuStyler: TCustomAdvMenuStyler read FCurrentAdvMenuStyler;

    property AutoThemeAdapt: boolean read FAutoThemeAdapt write FAutoThemeAdapt default False;

    property AdvMenuStyler: TCustomAdvMenuStyler read FAdvMenuStyler write SetAdvMenuStyler; // PropID: 0
    property ButtonAppearance: TButtonAppearance read FButtonAppearance write SetTButtonAppearance; // PropID 3

    property Color: TGradientBackground read FColor write SetColor;
    property DockColor: TGradientBackground read FDockColor write SetDockColor;

    property BackGround: TBitMap read FBackGround write SetBackGround;
    property BackGroundTransparent: Boolean read FBackGroundTransparent write SetBackGroundTransparent default true;
    property BackGroundDisplay: TBackGroundDisplay read FBackGroundDisplay write SetBackGroundDisplay default bdTile;

    property Font: TFont read FFont write SetFont;

    {===== AdvToolBar Properties -PropID: 2- =====}
    property DragGripStyle: TDragGripStyle read FDragGripStyle write SetDragGripStyle default dsDots;
    property DragGripImage: TBitMap read FDragGripImage write SetDragGripImage;

    //property PopupIndicatorStyle: TPopupIndicatorStyle read FPopupIndicatorStyle write SetPopupIndicatorStyle default psOffice2003;
    property RightHandleImage: TBitmap read FRightHandleImage write SetRightHandleImage;
    property RightHandleColor: TColor read FRightHandleColor write SetRightHandleColor default clGray;
    property RightHandleColorHot: TColor read FRightHandleColorHot write SetRightHandleColorHot;
    property RightHandleColorTo: TColor read FRightHandleColorTo write SetRightHandleColorTo default clGray;
    property RightHandleColorHotTo: TColor read FRightHandleColorHotTo write SetRightHandleColorHotTo;
    property RightHandleColorDown: TColor read FRightHandleColorDown write SetRightHandleColorDown;
    property RightHandleColorDownTo: TColor read FRightHandleColorDownTo write SetRightHandleColorDownTo;

    property FloatingWindowBorderColor: TColor read FFloatingWindowBorderColor write SetFloatingWindowBorderColor;
    property FloatingWindowBorderWidth: integer read FFloatingWindowBorderWidth write SetFloatingWindowBorderWidth default 2;
    property CaptionColor: TColor read FCaptionColor write SetCaptionColor default clGray;
    property CaptionColorTo: TColor read FCaptionColorTo write SetCaptionColorTo default clNone;
    property CaptionTextColor: TColor read FCaptionTextColor write SetCaptionTextColor default clWhite;
    property CaptionBorderColor: TColor read FCaptionBorderColor write SetCaptionBorderColor default clNone;

    property Bevel: TPanelBevel read FBevel write SetBevel default bvNone;
    property RoundEdges: boolean read FRoundEdges write SetRoundEdges default True;
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property UseBevel: Boolean read FUseBevel write SetUseBevel default False;
  protected
    procedure Change(PropID: integer);
    procedure LoadPropFromFile(var F: TextFile);
    procedure SavePropToFile(var F: TextFile);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Assign(Source: TPersistent); override;
  end;

  TOnDeleteItemEvent = procedure(Sender: TObject; Index: integer) of object;

  TRowCollectionItem = class(TCollectionItem)
  private
    //FHeight: integer;
    FToolBarList: TDbgList;
    FRowRect: TRect;
    function GetHeight: integer;
    function GetRowRect: TRect;
  protected
    function GetSpace(FirstAdvToolBar, SecondAdvToolBar: TAdvCustomToolBar): integer; // return space other than offset
    procedure SetRowRect(R: TRect);
    property ToolBarList: TDbgList read FToolBarList;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure ArrangeToolBars;

    function IsAllowed(aAdvToolBar: TAdvCustomToolBar): Boolean;
    function AddToolBar(aAdvToolBar: TAdvCustomToolBar): integer;
    procedure RemoveToolBar(aAdvToolBar: TAdvCustomToolBar; DeleteIfEmpty: Boolean = True);
    procedure SetToolBarLeftAndWidth(aAdvToolBar: TAdvCustomToolBar; var ALeft, AWidth: integer);
    procedure SetToolBarTopAndHeight(aAdvToolBar: TAdvCustomToolBar; var ATop, AHeight: integer);
    property Height: integer read GetHeight;
    property RowRect: TRect read GetRowRect;
  end;

  TRowCollection = class(TCollection)
  private
    FOwner: TAdvDockPanel;
    {$IFNDEF DELPHI6_LVL}
    FMyOwner: TPersistent;
    {$ENDIF}
    FOnChange: TNotifyEvent;
    FOnDeleteItem: TOnDeleteItemEvent;
    FOffSetY: Integer;
    FOffSetX: Integer;
    procedure SetParentSize;
    function GetItem(Index: Integer): TRowCollectionItem;
    procedure SetItem(Index: Integer; const Value: TRowCollectionItem);
  protected
    procedure DeleteMeIfEmpty(AItem: TRowCollectionItem);
    procedure SetRowsPosition;
    procedure SetToolBarFullSize(aAdvToolBar: TAdvCustomToolBar);
    procedure UpdateToolBarVisibility(aAdvToolBar: TAdvCustomToolBar);
    property OffSetX: integer read FOffSetX default 2;
    property OffSetY: integer read FOffSetY default 1;
  public
    constructor Create(AOwner: TAdvDockPanel);
    property Items[Index: Integer]: TRowCollectionItem read GetItem write SetItem; default;
    function Add: TRowCollectionItem;
    function Insert(Index: Integer): TRowCollectionItem;
    function GetOwner: TPersistent; override;
    {$IFNDEF DELPHI6_LVL}
    property Owner: TPersistent read FMyOwner;
    {$ENDIF}
    function IsToolBarAlreadyAdded(aAdvToolBar: TAdvCustomToolBar): Integer;
    procedure SetToolBarTopAndHeight(aAdvToolBar: TAdvCustomToolBar; var ATop, AHeight: integer);
    procedure SetToolBarLeftAndWidth(aAdvToolBar: TAdvCustomToolBar; var ALeft, AWidth: integer);
    procedure MoveToolBarToRow(aAdvToolBar: TAdvCustomToolBar; ARowIndex: integer);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDeleteItem: TOnDeleteItemEvent read FOnDeleteItem write FOnDeleteItem;
  end;

  TPersistenceLocation = (plRegistry, plIniFile);
  
  TPersistence = class(TPersistent)
  private
    FOwner: TComponent;
    FKey : string;
    FSection : string;
    FLocation: TPersistenceLocation;
    FEnabled: Boolean;
    FOnChange: TNotifyEvent;
    procedure SetEnabled(const Value: Boolean);
    procedure SetKey(const Value: string);
    procedure SetLocation(const Value: TPersistenceLocation);
    procedure SetSection(const Value: string);
  protected
    procedure Change;  
  public
    constructor Create(AOwner:TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Location: TPersistenceLocation read FLocation write SetLocation;
    property Key: string read FKey write SetKey;
    property Section: string read FSection write SetSection;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvDockPanel = class(TCustomControl)
  private
    FInternalToolBarStyler: {TAdvToolBarStyler;//} TCustomAdvToolBarStyler;
    FToolBarStyler: TCustomAdvToolBarStyler;
    FCurrentToolBarStyler: TCustomAdvToolBarStyler;
    FDockAlign: TDockAlign;
    FRows: TRowCollection;
    FOffSetY: integer;
    FOffSetX: integer;
    FToolBars: TDbgList;
    FHiddenToolBars: TDbgList;
    FMyImage: TBitMap;
    FPersistence: TPersistence;
    FMinimumSize: Integer;
    FLockHeight: Boolean;
    FPropertiesLoaded: Boolean;
    FUseRunTimeHeight: Boolean;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure OnPersistenceChange(Sender: TObject);
    procedure SetToolBarStyler(const Value: TCustomAdvToolBarStyler);
    function GetAlign: TDockAlign;
    procedure SetAlign(const Value: TDockAlign);
    function GetAdvToolBarCount: integer;
    function GetAdvToolBars(index: integer): TAdvCustomToolBar;
    function GetRowCount: integer;
    procedure SetPersistence(const Value: TPersistence);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetMinimumSize(const Value: Integer);
    function GetPopupMenuEx: TPopupMenu;
    procedure SetPopupMenuEx(const Value: TPopupMenu);
    procedure SetLockHeight(const Value: Boolean);
    procedure SetUseRunTimeHeight(const Value: Boolean);
  protected
    procedure UpdateMe(PropID: integer);
    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    procedure CreateWnd; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure Paint; override;
    function GetMyImage: TBitMap;

    function IsAllowedInAnyRow(aAdvToolBar: TAdvCustomToolBar): Integer;

    function AddToolBar(aAdvToolBar: TAdvCustomToolBar): integer;
    procedure RemoveToolBar(aAdvToolBar: TAdvCustomToolBar);
    procedure UpdateToolBarVisibility(aAdvToolBar: TAdvCustomToolBar);
    procedure SetToolBarFullSize(aAdvToolBar: TAdvCustomToolBar);
    procedure SetToolBarBounds(aAdvToolBar: TAdvCustomToolBar; var ALeft, ATop, AWidth, AHeight: Integer);

    property Rows: TRowCollection read FRows;
    property OffSetX: integer read FOffSetX default 1;
    property OffSetY: integer read FOffSetY default 0;

    property ToolBars: TDbgList read FToolBars;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure SaveToolBarsPosition;
    procedure LoadToolBarsPosition;

    function GetVersionNr: integer;

    property RowCount: integer read GetRowCount;
    property AdvToolBarCount: integer read GetAdvToolBarCount;
    property AdvToolBars[index: integer]: TAdvCustomToolBar read GetAdvToolBars;
  published
    property Align: TDockAlign read GetAlign write SetAlign default daTop;
    property MinimumSize: Integer read FMinimumSize write SetMinimumSize;
    property LockHeight: Boolean read FLockHeight write SetLockHeight;
    property Persistence: TPersistence read FPersistence write SetPersistence;
    //property PopupMenu;
    property PopupMenu: TPopupMenu read GetPopupMenuEx write SetPopupMenuEx;
    property ToolBarStyler: TCustomAdvToolBarStyler read FToolBarStyler write SetToolBarStyler;
    property UseRunTimeHeight: Boolean read FUseRunTimeHeight write SetUseRunTimeHeight;
    property Version: string read GetVersion write SetVersion;
  end;

  TAdvCustomToolBarControl = class(TGraphicControl)
  private
    FAdvToolBar: TAdvCustomToolBar;
    FPosition: TDockAlign;
    procedure SetPosition(const Value: TDockAlign);
  protected
    procedure ReadState(Reader: TReader); override;
    procedure SetAdvToolBar(const Value: TAdvCustomToolBar); virtual;

    property Position: TDockAlign read FPosition write SetPosition;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property AdvToolBar: TAdvCustomToolBar read FAdvToolBar write SetAdvToolBar;
  end;

  TAdvToolButtonStyle = (tasButton, tasCheck);
  TAdvButtonState = (absUp, absDisabled, absDown, absDropDown, absExclusive);

{$IFDEF DELPHI6_LVL}
  TAdvToolBarButtonActionLink = class(TControlActionLink)
  protected
    FClient: TAdvCustomToolBarButton;
    procedure AssignClient(AClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    function IsGroupIndexLinked: Boolean; override;
    procedure SetGroupIndex(Value: Integer); override;
    procedure SetChecked(Value: Boolean); override;
  end;
{$ENDIF}

  TAdvToolBarButtonDrawPosition = class(TPersistent)
  private
    FEnabled: Boolean;
    FTextX: Integer;
    FTextY: Integer;
    FImageX: Integer;
    FImageY: Integer;
    FOnChange: TNotifyEvent;
    procedure SetEnabled(const Value: Boolean);
    procedure SetImageX(const Value: integer);
    procedure SetImageY(const Value: Integer);
    procedure SetTextX(const Value: integer);
    procedure SetTextY(const Value: integer);
  protected
    procedure Changed;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property TextX: integer read FTextX write SetTextX default 0;
    property TextY: integer read FTextY write SetTextY default 0;
    property ImageX: integer read FImageX write SetImageX default 0;
    property ImageY: Integer read FImageY write SetImageY default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;


  TAdvCustomToolBarButton = class(TAdvCustomToolBarControl)
  private
    FGroupIndex: Integer;
    FGlyph: TBitmap;
    FDown: Boolean;
    //FDragging: Boolean;
    FAllowAllUp: Boolean;
    //FLayout: TButtonLayout;
    FSpacing: Integer;
    FTransparent: Boolean;
    //FMargin: Integer;
    FOffSet: integer;
    FFlat: Boolean;
    FMouseInControl: Boolean;
    FHot: Boolean;
    FMenuSel: Boolean;
    FGlyphDisabled: TBitmap;
    FGlyphHot: TBitmap;
    FGlyphDown: TBitmap;
    FGlyphChecked: TBitmap;
    FGlyphShade: TBitmap;
    FShaded: Boolean;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FStyle: TAdvToolButtonStyle;
    //FLook: Integer;
    //FRounded: Boolean;
    FDropDownButton: Boolean;
    FAutoThemeAdapt: Boolean;
    FOnDropDown: TNotifyEvent;
    FDropDownMenu: TAdvPopupMenu;
    FRounded: Boolean;
    FParentStyler: Boolean;
    FState: TAdvButtonState;
    FGlyphPosition: TGlyphPosition;
    FMouseDownInControl: Boolean;
    FDropDownSectWidth: integer;
    FGrouped: Boolean;
    FMenuItem: TMenuItem;
    FImageIndex: integer;
    FShadedForGlyph: Boolean;
    FDragging: Boolean;
    FAppearance: TButtonAppearance;
    FShowCaption: Boolean;
    FPropHot: Boolean;
    FPicture: TPicture;
    FPictureDisabled: TPicture;
    FUnHotTimer: TTimer;
    FDrawPosition: TAdvToolBarButtonDrawPosition;
    FInitialDown: Boolean;
    FInternalTag: Integer;   // 1: MergedMenu
{$IFNDEF DELPHI6_LVL}
    FAutoSize: Boolean;
{$ENDIF}

    procedure UnHotTimerOnTime(Sender: TObject);
    procedure GlyphChanged(Sender: TObject);
    procedure UpdateExclusive;
    //procedure SetLayout(Value: TButtonLayout);
    procedure SetSpacing(Value: Integer);
    //procedure SetMargin(Value: Integer);
    procedure UpdateTracking;

    procedure DoDropDown; // State Change to DropDown
    procedure PopupBtnDown;
    procedure ButtonDown;

    procedure WMLButtonDblClk(var Message: TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
{$IFNDEF TMSDOTNET}
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
{$ENDIF}
    procedure SetGlyph(Value: TBitmap);
    procedure SetGlyphDisabled(const Value: TBitmap);
    procedure SetGlyphDown(const Value: TBitmap);
    procedure SetGlyphHot(const Value: TBitmap);
    procedure GenerateShade;
    procedure SetShaded(const Value: Boolean);
    procedure SetFlat(Value: Boolean);
    procedure SetDown(Value: Boolean);
    procedure SetAllowAllUp(Value: Boolean);
    procedure SetGroupIndex(Value: Integer);
    procedure SetStyle(const Value: TAdvToolButtonStyle);
    procedure SetDropDownButton(const Value: Boolean);
    procedure SetGlyphPosition(const Value: TGlyphPosition);
    procedure SetParentStyler(const Value: Boolean);
    //procedure SetRounded(const Value: Boolean);
    procedure SetState(const Value: TAdvButtonState);
    procedure SetTransparent(const Value: Boolean);
    procedure SetRounded(const Value: Boolean);
    //procedure SetAdvToolBar(aAdvToolBar: TAdvCustomToolBar);
    procedure SetGlyphChecked(const Value: TBitmap);
    function GetIndex: Integer;
    procedure SetGrouped(const Value: Boolean);
    procedure SetMenuItem(const Value: TMenuItem);
    procedure SetImageIndex(const Value: integer);
    procedure SetAppearance(const Value: TButtonAppearance);
    procedure SetShowCaption(const Value: Boolean);
    function GetAutoSize: Boolean;
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    function GetHot: Boolean;
    procedure SetHot(const Value: Boolean);
    procedure SetPicture(const Value: TPicture);
    procedure SetPictureDisabled(const Value: TPicture);
    procedure SetDrawPosition(const Value: TAdvToolBarButtonDrawPosition);
    procedure PositionChanged(Sender: TObject);
    //procedure SetLook(const Value: Integer);
  protected
    FToolBarCreated: Boolean;
{$IFDEF DELPHI6_LVL}
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
{$ENDIF}
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DrawGlyphAndCaption(ACanvas: TCanvas; R: TRect; TxtClr: TColor; aGlyph: TBitMap); virtual;
    procedure DrawButton(ACanvas: TCanvas); virtual;
    procedure Paint; override;
    property MouseInControl: Boolean read FMouseInControl;
    procedure WndProc(var Message: TMessage); override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
{$IFNDEF DELPHI6_LVL}
    procedure SetAutoSize(Value: Boolean); 
{$ELSE}
    procedure SetAutoSize(Value: Boolean); override;
{$ENDIF}
    procedure AdjustSize; override;
    procedure OnAppearanceChange(Sender: TObject);
    procedure ThemeAdapt;
    procedure SetAutoThemeAdapt(const Value: Boolean);

    procedure InvalidateMe;
    procedure OnDropDownHide;
    function IsMenuButton: Boolean; virtual;
    //procedure SetAdvToolBar(aAdvToolBar: TAdvCustomToolBar);
    property State: TAdvButtonState read FState write SetState;
    //property AdvToolBar: TAdvCustomToolBar read FAdvToolBar write SetAdvToolBar;

    // published
    property Action;
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property Anchors;
    property AutoSize: Boolean read GetAutoSize write SetAutoSize default True;
    property AutoThemeAdapt: Boolean read FAutoThemeAdapt write SetAutoThemeAdapt;
    property BiDiMode;

    property Appearance: TButtonAppearance read FAppearance write SetAppearance;
    property GlyphPosition: TGlyphPosition read FGlyphPosition write SetGlyphPosition default gpLeft;

    property Constraints;
    property DrawPosition: TAdvToolBarButtonDrawPosition read FDrawPosition write SetDrawPosition;
    property Grouped: Boolean read FGrouped write SetGrouped default False;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Down: Boolean read FDown write SetDown default False;
    property DropDownButton: Boolean read FDropDownButton write SetDropDownButton default False;
    property DropDownMenu: TAdvPopupMenu read FDropDownMenu write FDropDownMenu;
    property Caption;
    property Enabled;
    property Flat: Boolean read FFlat write SetFlat default True;
    property Font;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property GlyphHot: TBitmap read FGlyphHot write SetGlyphHot;
    property GlyphDown: TBitmap read FGlyphDown write SetGlyphDown;
    property GlyphDisabled: TBitmap read FGlyphDisabled write SetGlyphDisabled;
    property GlyphChecked: TBitmap read FGlyphChecked write SetGlyphChecked;
    property Hot: Boolean read GetHot write SetHot default false;

    property ImageIndex: integer read FImageIndex write SetImageIndex default -1;
    //property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    //property Margin: Integer read FMargin write SetMargin default -1;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
    property Picture: TPicture read FPicture write SetPicture;
    property PictureDisabled: TPicture read FPictureDisabled write SetPictureDisabled;

    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;
    property ParentStyler: Boolean read FParentStyler write SetParentStyler default True;
    property Rounded: Boolean read FRounded write SetRounded default False;
    property Shaded: Boolean read FShaded write SetShaded default True;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default False;
    property ShowHint;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Style: TAdvToolButtonStyle read FStyle write SetStyle default tasButton;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property Version: string read GetVersion write SetVersion;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
{$IFDEF TMSDOTNET}
    procedure ButtonPressed(Group: Integer; Button: TAdvCustomToolBarButton);
{$ENDIF}
    function CheckMenuDropdown: Boolean; dynamic;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property Index: Integer read GetIndex;
    function GetVersionNr: Integer; virtual;
  published
  end;

  TAdvToolBarButton = class(TAdvCustomToolBarButton)
  public
  published
    property Action;
    property AllowAllUp;
    //property Anchors;
    property AutoSize;
    //property BiDiMode;
    property Appearance;
    property GlyphPosition;

    property Constraints;
    property GroupIndex;
    property Down;
    property DropDownButton;
    property DropDownMenu;
    property Caption;
    property Enabled;
    property DrawPosition;
    //property Flat: Boolean read FFlat write SetFlat default True;
    property Font;
    property Glyph;
    property GlyphHot;
    property GlyphDown;
    property GlyphDisabled;
    property GlyphChecked;
    property ImageIndex;
    property Picture;
    property PictureDisabled;
    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;
    property ParentStyler;
    property Position;
    //property Rounded: Boolean read FRounded write SetRounded default False;
    property Shaded;
    property ShowCaption;
    property ShowHint;
    //property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Style;
    //property Transparent: Boolean read FTransparent write SetTransparent;
    property Version;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnDropDown;
  end;

  TAdvToolBarMenuButton = class(TAdvCustomToolBarButton)
  private
  protected
    function IsMenuButton: Boolean; override;
    procedure DrawButton(aCanvas: TCanvas); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Hot;
  published
    //property Action;
    //property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    //property Anchors;
    //property BiDiMode;
    property Appearance;
    property GlyphPosition;

    property Constraints;
    //property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    //property Down: Boolean read FDown write SetDown default False;
    property DropDownMenu;
    property Caption;
    property Enabled;
    //property Flat: Boolean read FFlat write SetFlat default True;
    property Font;
    property Glyph;
    property GlyphHot;
    property GlyphDown;
    property GlyphDisabled;
    property GlyphChecked;
    property ImageIndex;
    property Picture;
    //property ParentFont;
    //property ParentShowHint;
    //property ParentBiDiMode;
    //property PopupMenu;
    property ParentStyler;
    property Position;
    //property Rounded: Boolean read FRounded write SetRounded default False;
    property Shaded;
    property ShowHint;
    property ShowCaption;    
    //property Spacing: Integer read FSpacing write SetSpacing default 4;
    //property Transparent: Boolean read FTransparent write SetTransparent;
    property Version;
    property Visible;
    property OnClick;
    //property OnDblClick;
    //property OnMouseDown;
    //property OnMouseMove;
    //property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnDropDown;
  end;

  TAdvSeparatorStyle = (ssOffice2003, ssBlank);
  TAdvToolBarSeparator = class(TAdvCustomToolBarControl)
  private
    FSeparatorStyle: TAdvSeparatorStyle;
    FLineColor: TColor;
    procedure SetSeparatorStyle(const Value: TAdvSeparatorStyle);
    procedure SetLineColor(const Value: TColor);
  protected
    procedure Paint; override;
    procedure AdjustSize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property SeparatorStyle: TAdvSeparatorStyle read FSeparatorStyle write SetSeparatorStyle default ssOffice2003;
    property LineColor: TColor read FLineColor write SetLineColor;
  end;

  //---- DB aware version
  TDBButtonType = (dbtCustom, dbtFirst, dbtPrior, dbtNext, dbtLast, dbtInsert, dbtAppend,
                   dbtDelete, dbtEdit, dbtPost, dbtCancel, dbtRefresh);

  TDBBDisableControl = (drBOF, drEOF, drReadonly, drNotEditing, drEditing, drEmpty, drEvent);
  TDBBDisableControls = set of TDBBDisableControl;

  TBeforeActionEvent = procedure (Sender: TObject; var DoAction: Boolean) of object;
  TAfterActionEvent = procedure (Sender: TObject; var ShowException: Boolean) of object;
  TGetConfirmEvent = procedure (Sender: TObject; var Question: string; var Buttons: TMsgDlgButtons; var HelpCtx: Longint) of object;
  TGetEnabledEvent = procedure (Sender: TObject; var Enabled: Boolean) of object;

  TDBATBButtonDataLink = class(TDataLink)
  private
    FOnEditingChanged: TNotifyEvent;
    FOnDataSetChanged: TNotifyEvent;
    FOnActiveChanged: TNotifyEvent;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
  public
    constructor Create;
    property OnEditingChanged: TNotifyEvent
      read FOnEditingChanged write FOnEditingChanged;
    property OnDataSetChanged: TNotifyEvent
      read FOnDataSetChanged write FOnDataSetChanged;
    property OnActiveChanged: TNotifyEvent
      read FOnActiveChanged write FOnActiveChanged;
  end;

  TDBAdvToolBarButton = class(TAdvCustomToolBarButton)
  private
    FDataLink: TDBATBButtonDataLink;
    FAutoDisable: Boolean;
    FDisableControls: TDBBDisableControls;
    FOnAfterAction: TAfterActionEvent;
    FOnBeforeAction: TBeforeActionEvent;
    FDBButtonType: TDBButtonType;
    FOnGetConfirm: TGetConfirmEvent;
    FOnGetEnabled: TGetEnabledEvent;
    FOnEnabledChanged: TNotifyEvent;
    FConfirmAction: Boolean;
    FConfirmActionString: String;
    FInProcUpdateEnabled: Boolean;

    procedure CMEnabledChanged(var Message: TMessage);  message CM_ENABLEDCHANGED;
    procedure OnDataSetEvents(Sender: TObject);

    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetDBButtonType(const Value: TDBButtonType);
    procedure SetConfirmActionString(const Value: String);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure Loaded; override;
    procedure CalcDisableReasons;
    procedure DoBeforeAction(var DoAction: Boolean); virtual;
    procedure DoGetQuestion(var Question: string; var Buttons: TMsgDlgButtons; var HelpCtx: Longint); virtual;
    function DoConfirmAction: Boolean; virtual;
    procedure DoAction; virtual;
    procedure UpdateEnabled; virtual;
    procedure LoadGlyph; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
  published
    property Action;
  //  property AllowAllUp;
    //property Anchors;
    property AutoSize;
    //property BiDiMode;
    property Appearance;
    property GlyphPosition;

    property Constraints;
  //  property GroupIndex;
  //  property Down;
  //  property DropDownButton;
  //  property DropDownMenu;

    property AutoDisable: Boolean read FAutoDisable write FAutoDisable;
    property ConfirmAction: Boolean read FConfirmAction write FConfirmAction;
    property ConfirmActionString: String read FConfirmActionString write SetConfirmActionString;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DBButtonType: TDBButtonType read FDBButtonType write SetDBButtonType;
    property DisableControl: TDBBDisableControls read FDisableControls write FDisableControls;

    property Caption;
    property Enabled;
    property DrawPosition;
    //property Flat: Boolean read FFlat write SetFlat default True;
    property Font;
    property Glyph;
    property GlyphHot;
    property GlyphDown;
    property GlyphDisabled;
    //property GlyphChecked;
    property ImageIndex;
    property Picture;
    property PictureDisabled;
    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;
    property ParentStyler;
    property Position;
    //property Rounded: Boolean read FRounded write SetRounded default False;
    property Shaded;
    property ShowCaption;
    property ShowHint;
    //property Spacing: Integer read FSpacing write SetSpacing default 4;
    //property Style;
    //property Transparent: Boolean read FTransparent write SetTransparent;
    property Version;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
  //  property OnDropDown;

    property OnBeforeAction: TBeforeActionEvent read FOnBeforeAction write FOnBeforeAction;
    property OnAfterAction: TAfterActionEvent read FOnAfterAction write FOnAfterAction;
    property OnGetConfirm: TGetConfirmEvent read FOnGetConfirm write FOnGetConfirm;
    property OnGetEnabled: TGetEnabledEvent read FOnGetEnabled write FOnGetEnabled;
    property OnEnabledChanged: TNotifyEvent read FOnEnabledChanged write FOnEnabledChanged;
  end;


  TDockedEvent = procedure(Sender: TObject; AdvDockPanel: TAdvDockPanel) of object;

  TOptionEvent = procedure(Sender: TObject; ClientPoint, ScreenPoint: TPoint) of object;


  TAdvCustomToolBar = class(TCustomControl)
  private
    FATBControls: TDbgList;
    FRUControls: TDbgList;
    FLUHidedControls: TDbgList;
    FInternalToolBarStyler: TCustomAdvToolBarStyler;
    FToolBarStyler: TCustomAdvToolBarStyler;
    FCurrentToolBarStyler: TCustomAdvToolBarStyler;
    FParentStyler: Boolean;
    FDragGripWidth: integer;
    FPopupIndicatorWidth: integer;
    FCurrentDock: TAdvDockPanel;
    FLastDock: TAdvDockPanel;
    FPosition: TDockAlign;
    FOldCursor: TCursor;
    FDraging: Boolean;
    FOldMouseX: integer;
    FOldMouseY: integer;
    FHotPopupIndicator: Boolean;
    FDownPopupIndicator: Boolean;
    FRow: integer;
    FToolBarState: TToolBarState;
    FAllowBoundChange: boolean;
    FFullSize: Boolean;
    FDockableTo: TDockableTo;
    FDockList: TDbgList;
    FFloatingWindow: TFloatingWindow;
    FOwner: TComponent;
    FCaption: string;
    FCaptionFont: TFont;
    FShowOptionIndicator: Boolean;
    FShowPopupIndicator: Boolean;
    FShowClose: Boolean;
    FCaptionHeight: integer;
    FHotCustomizedBtn: Boolean;
    FDownCustomizedBtn: Boolean;
    FHotCloseBtn: Boolean;
    FDownCloseBtn: Boolean;
    FImages: TCustomImageList;
    FMenu: TMainMenu;
    FMergedMenu: TMainMenu;
    FTimerID: integer;
    FTempMenu: TAdvPopupMenu;
    FInMenuLoop: Boolean;
    FMenuResult: Boolean;
    FCaptureChangeCancels: Boolean;
    FMenuDropped: Boolean;
    FMenuButton: TAdvCustomToolBarButton;
    FButtonMenu: TMenuItem;
    FInternalControlPositioning: Boolean;
    FAutoRUL: Boolean;
    FFloatingRows: integer;
    FSizeAtDock: integer;
    FMinLength: integer;
    FMaxLength: integer;
    FOldState: TToolBarState;
    FShowRightHandle: Boolean;
    FOnClose: TNotifyEvent;
    FOnOptionClick: TOptionEvent;
    FOnDocked: TDockedEvent;
    FOnUnDocked: TNotifyEvent;
    FPersistence: TPersistence;
    FMenuImages: TCustomImageList;
    FTempMenuItemCount: integer;
    FHotButton: TAdvCustomToolBarButton;
    FMenuFocused: Boolean;
    FOptionMenu: TPopupMenu;
    FAllowFloating: Boolean;
    FLocked: Boolean;
    FOptionWindow: TOptionSelectorWindow;
    FOptionWindowPanel: TControlSelectorPanel;
    FInternalControlUpdation: Boolean;
    FAutoOptionMenu: Boolean;
    FHintOptionButton: string;
    FHintCloseButton: string;
    FTextAutoOptionMenu: String;
    FTextOptionMenu: String;
    FAutoArrangeButtons: Boolean;
    FParentForm: TCustomForm;
    FAutoHiding: Boolean;
    FDisabledImages: TCustomImageList;
    FAutoMDIButtons: Boolean;
    FMDIButtonsVisible: Boolean;
    FMDIDownCloseBtn: Boolean;
    FMDIHotCloseBtn: Boolean;
    FMDIDownMaxBtn: Boolean;
    FMDIHotMaxBtn: Boolean;
    FMDIDownMinBtn: Boolean;
    FMDIHotMinBtn: Boolean;
    FMDIChildForm: TCustomForm;
    FMenuItemTimer: TTimer;
    FNextMenuHotButton: TAdvCustomToolBarButton;

    procedure MenuItemTimerOnTime(Sender: TObject);

    procedure InitializeOptionWindow;
    procedure ShowOptionWindow(X, Y: Integer; ForcePoint: Boolean=True);
    procedure HideOptionWindow;
    procedure OnOptionWindowHide(Sender: TObject);

    procedure DrawDragGrip;
    procedure DrawPopupIndicator;
    procedure DrawCustomizedBtn;
    procedure DrawCloseBtn;

    procedure DrawMDIButtons;
    function GetMDIMinBtnRect: TRect;
    function GetMDIMaxBtnRect: TRect;
    function GetMDICloseBtnRect: TRect;
    function PtOnMDIMin(P: TPoint): Boolean;
    function PtOnMDIMax(P: TPoint): Boolean;
    function PtOnMDIClose(P: TPoint): Boolean;
    procedure MDICloseBtnClick;
    procedure MDIMaxBtnClick;
    procedure MDIMinBtnClick;

    function PtOnDragGrip(P: TPoint): Boolean;
    function PtOnPopupIndicator(P: TPoint): Boolean;
    function PtOnGripCaption(P: TPoint): Boolean;
    function PtOnCustomizedBtn(P: TPoint): Boolean;
    function PtOnCloseBtn(P: TPoint): Boolean;

    function GetMyClientRect: TRect;
    function GetCaptionRect: TRect;
    function FWCustomizedBtnRect: TRect; // FW for Floating Window
    function FWCloseBtnRect: TRect;

    procedure CloseBtnClick;
    procedure OptionIndicatorClick;

    procedure UpdateSize;

    function GetMenuItemCount: integer;
    procedure OnMainMenuChange(Sender: TObject; Source: TMenuItem; Rebuild: Boolean);

    procedure BuildSequenceControlList;
    procedure CNDropDownClosed(var Message: TMessage); message CN_DROPDOWNCLOSED;

    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure WMTimer(var Message: TWMTimer); message WM_TIMER;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure CNChar(var Message: TWMChar); message CN_CHAR;
    procedure CNSysKeyDown(var Message: TWMSysKeyDown); message CN_SYSKEYDOWN;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMGetDlgCode(var Message: TMessage); message WM_GETDLGCODE;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMHintShow(var Msg: TCMHintShow); message CM_HINTSHOW;
    procedure WMEraseBkGnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetToolBarStyler(const Value: TCustomAdvToolBarStyler);
    procedure SetParentStyler(const Value: Boolean);
    procedure SetDragGripWidth(const Value: integer);
    procedure SetPopupIndicatorWidth(const Value: integer);
    procedure SetPosition(const Value: TDockAlign);
    procedure SetRow(const Value: integer);
    procedure SetAllowBoundChange(const Value: boolean);
    procedure SetFullSize(const Value: Boolean);
    procedure SetDockableTo(const Value: TDockableTo);
    procedure SetCaption(const Value: string);
    procedure SetCaptionFont(const Value: TFont);
    procedure SetShowOptionIndicator(const Value: Boolean);
    procedure SetShowPopupIndicator(const Value: Boolean);
    procedure SetShowClose(const Value: Boolean);
    procedure SetCaptionHeight(const Value: integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetMenu(const Value: TMainMenu);
    procedure SetAutoRUL(const Value: Boolean);
    procedure SetFloatingRows(const Value: integer);
    procedure SetShowRightHandle(const Value: Boolean);
    procedure SetPersistence(const Value: TPersistence);
    function GetShowHint: Boolean;
    procedure SetShowHint(const Value: Boolean);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetAllowFloating(const Value: Boolean);
    procedure SetLocked(const Value: Boolean);
    procedure SetAutoOptionMenu(const Value: Boolean);
    procedure SetAutoArrangeButtons(const Value: Boolean);
    procedure SetDisabledImages(const Value: TCustomImageList);
    function GetToolBarControlCount: Integer;
    function GetToolBarControls(index: Integer): TControl;
    procedure AddMergedMenuItems;
    procedure DeleteMergedMenuItems;
    procedure SetAutoMDIButtons(const Value: Boolean);
    procedure SetMDIButtonsVisible(const Value: Boolean);
  protected
    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    procedure Loaded; override;
    procedure UpdateMe(PropID: integer);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure WndProc(var Message: TMessage); override;
    procedure Paint; override;

    procedure SetControlsPosition(UpdateMySize: boolean = true);
    function AddAdvToolBarControl(aControl: TAdvCustomToolBarControl): integer;
    procedure InsertAdvToolBarControl(aControl: TAdvCustomToolBarControl; Index: integer);
    procedure RemoveAdvToolBarControl(aControl: TAdvCustomToolBarControl);
    function ButtonAtPos(X, Y: Integer): TAdvCustomToolBarButton;
    function GetMaxLength: Integer;
    procedure AdjustSizeOfAllButtons(MenuButtonsOnly: Boolean = False);
    function GetSizeAtDock(ForFloating: Boolean): Integer;
    procedure GetMaxControlSize(var W, H: Integer);
    procedure GetMaxExternalControlSize(var W, H: Integer);
    procedure GetMaxToolBarButtonSize(var W, H: Integer);

    procedure InsertControl(Control: TControl);
    procedure RemoveControl(Control: TControl);
    function ControlIndex(OldIndex, ALeft, ATop: Integer): Integer;
    function ReorderControl(OldIndex, ALeft, ATop: Integer): Integer;
    procedure AdjustControl(Control: TControl);

    function CheckMenuDropdown(Button: TAdvCustomToolBarButton): Boolean; dynamic;
    procedure CancelMenu; dynamic;
    procedure ClearTempMenu;
    procedure ClickButton(Button: TAdvCustomToolBarButton; RealClick: Boolean = false); dynamic;
    function FindButtonFromAccel(Accel: Word): TAdvCustomToolBarButton;
    function TrackMenu(Button: TAdvCustomToolBarButton): Boolean; dynamic;
    procedure InitMenu(Button: TAdvCustomToolBarButton); dynamic;
    procedure UpdateButtonHot(Button: TAdvCustomToolBarButton);
    function SetButtonHot(Button: TAdvCustomToolBarButton): Boolean; overload;
    function SetButtonHot(ButtonNumber: Integer): Boolean; overload;

    procedure UpControlInRUL(aControl: TControl);
    procedure UpdateRULists;

    procedure SavePosition;
    procedure LoadPosition;

    function GetFloatingWindowSizes(aRows: integer; var aHeight, aWidth: integer): Boolean;
    procedure GetFloatingSizes(var aHeight, aWidth: integer);
    function GetMaxFloatingRowCount: integer;
    property FloatingRows: integer read FFloatingRows write SetFloatingRows default 1;

    function AcceptableDockPanel(ADockPanel: TAdvDockPanel): Boolean;
    procedure BeginMove(Shift: TShiftState; X, Y: Integer);
    procedure Move(Shift: TShiftState; X, Y: Integer);
    procedure EndMove;
    procedure SetFloating(X: integer = 0; Y: integer = 0; ForcePoint: Boolean = false);
    function CanShrink: integer;
    function CanExpand: integer;
    property AllowBoundChange: boolean read FAllowBoundChange write SetAllowBoundChange default false;
    property DragGripWidth: integer read FDragGripWidth write SetDragGripWidth default 7;
    property PopupIndicatorWidth: integer read FPopupIndicatorWidth write SetPopupIndicatorWidth default 14;
    //property MinLength: integer read FMinLength;
    property Row: integer read FRow write SetRow default -1;
    property ToolBarState: TToolBarState read FToolBarState;

    property Persistence: TPersistence read FPersistence write SetPersistence;

    property AutoRUL: Boolean read FAutoRUL write SetAutoRUL default true;

    property Locked: Boolean read FLocked write SetLocked;
    property AllowFloating: Boolean read FAllowFloating write SetAllowFloating;

    property AutoOptionMenu: Boolean read FAutoOptionMenu write SetAutoOptionMenu;

    property AutoArrangeButtons: Boolean read FAutoArrangeButtons write SetAutoArrangeButtons default True;

    property AutoMDIButtons: Boolean read FAutoMDIButtons write SetAutoMDIButtons;
    function GetMyParentForm: TCustomForm;
    property MDIButtonsVisible: Boolean read FMDIButtonsVisible write SetMDIButtonsVisible;

    property Caption: string read FCaption write SetCaption;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
    property CaptionHeight: integer read FCaptionHeight write SetCaptionHeight default DEFAULT_CAPTIONHEIGHT;
    property HintOptionButton: string read FHintOptionButton write FHintOptionButton;
    property HintCloseButton: string read FHintCloseButton write FHintCloseButton;
    property OptionMenu: TPopupMenu read FOptionMenu write FOptionMenu;
    property ShowPopupIndicator: Boolean read FShowPopupIndicator write SetShowPopupIndicator default true;
    property ShowClose: Boolean read FShowClose write SetShowClose default true;
    property ShowOptionIndicator: Boolean read FShowOptionIndicator write SetShowOptionIndicator default true;
    property ShowRightHandle: Boolean read FShowRightHandle write SetShowRightHandle default true;
    property DockableTo: TDockableTo read FDockableTo write SetDockableTo default [daLeft, daTop, daRight, daBottom];
    property FullSize: Boolean read FFullSize write SetFullSize default false;
    property ToolBarStyler: TCustomAdvToolBarStyler read FToolBarStyler write SetToolBarStyler;
    property ParentStyler: Boolean read FParentStyler write SetParentStyler default true;
    property Position: TDockAlign read FPosition write SetPosition default daTop;
    property Version: string read GetVersion write SetVersion;

    property Images: TCustomImageList read FImages write SetImages;
    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property Menu: TMainMenu read FMenu write SetMenu;

    property TextAutoOptionMenu: String read FTextAutoOptionMenu write FTextAutoOptionMenu;
    property TextOptionMenu: String read FTextOptionMenu write FTextOptionMenu;

    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnOptionClick: TOptionEvent read FOnOptionClick write FOnOptionClick;
    property OnDocked: TDockedEvent read FOnDocked write FOnDocked;
    property OnUnDocked: TNotifyEvent read FOnUnDocked write FOnUnDocked;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    function IsShortCut(var Message: TWMKey): Boolean; dynamic;

    procedure SetToolBarFloating(P: TPoint);
    procedure UpdateMenu;
    procedure MergeMenu(AMenu: TMainMenu);
    procedure UnmergeMenu(AMenu: TMainMenu);

    property ShowHint: Boolean read GetShowHint write SetShowHint default True;
    function GetVersionNr: Integer;

    procedure MoveToolBarControl(FromIndex, ToIndex: integer);
    procedure InsertToolBarControl(Index: integer; AControl: TControl);
    function AddToolBarControl(AControl: TControl): Integer;
    function IndexOfToolBarControl(AControl: TControl): Integer;

    property ToolBarControls[index: Integer]: TControl read GetToolBarControls;
    property ToolBarControlCount: Integer read GetToolBarControlCount;
  end;

  TAdvToolBar = class(TAdvCustomToolBar)
  public
  published
    property AllowFloating;
    property AutoArrangeButtons;
    property AutoMDIButtons;
    property AutoOptionMenu;
    property Locked;
    property Caption;
    property CaptionFont;
    property CaptionHeight;
    property HintOptionButton;
    property HintCloseButton;
    property ShowRightHandle;
    property ShowClose;
    property ShowOptionIndicator;
    property DockableTo;
    property FullSize;
    property TextAutoOptionMenu;
    property TextOptionMenu;

    property ToolBarStyler;
    property ParentStyler;
    //property Position;
    property Images;
    property DisabledImages;
    property Menu;
    property OptionMenu;
    property ShowHint;
    property Version;

    property OnClose;
    property OnOptionClick;
    property OnDocked;
    property OnUnDocked;
    property OnDragOver;
    property OnDragDrop;
    property OnEndDrag;
    property OnStartDrag;
  end;

  TResizingClip = (rcLeft, rcTop, rcRight, rcBottom);

  TFloatingWindow = class(TCustomForm)
  private
    FAdvCustomToolBar: TAdvCustomToolBar;
    FOwner: TComponent;
    FBorderWidth: integer;
    FBorderColor: TColor;
    FOldCursor: TCursor;
    FResizing: Boolean;
    FMouseX: integer;
    FMouseY: integer;
    FResizingDir: integer; // (0: None), (i: Expand), (2: Shrink)
    FResizingClip: TResizingClip;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure SetBorderWidth(const Value: integer);
    procedure SetBorderColor(const Value: TColor);
  protected
    procedure Loaded; override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
    function GetParentWnd: HWnd;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    procedure SetWindowSize;
  published
{$IFDEF TMSDOTNET}
    //property OnHide;
{$ENDIF}
    property AdvCustomToolBar: TAdvCustomToolBar read FAdvCustomToolBar write FAdvCustomToolBar;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 2;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clGray;
  end;

  // Option Selector window

  TOptionSelectorWindow = class(TCustomForm)
  private
    FAdvToolBar: TAdvCustomToolBar;
    FOptionsPanel: TOptionSelectorPanel;
    FHideOnDeActivate: Boolean;
    FShowAbove: Boolean;
    FOwner: TComponent;
    FHideTimer: TTimer;
    FShowLeft: Boolean;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure HideTimerOnTime(Sender: TObject);
  protected
    procedure Paint; override;
    function GetParentWnd: HWnd;
    procedure CreateParams(var Params: TCreateParams); override;
    property HideOnDeActivate: Boolean read FHideOnDeActivate write FHideOnDeActivate;
    property ShowAbove: Boolean read FShowAbove write FShowAbove;
    property ShowLeft: Boolean read FShowLeft write FShowLeft default false;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    procedure SetWindowSize;
  published
{$IFDEF TMSDOTNET}
    //property AutoScroll;
    //property BorderIcons;
    //property FormStyle;
    property OnHide;
{$ENDIF}
    property AdvToolBar: TAdvCustomToolBar read FAdvToolBar write FAdvToolBar;
    property OptionsPanel: TOptionSelectorPanel read FOptionsPanel write FOptionsPanel;
  end;


  TOptionSelectorPanel = class(TCustomPanel)
  private
    FOwner: TComponent;
    FColorTo: TColor;
    FGradientDirection: TGradientDirection;
    FWindowBorderColor: TColor;
    FOnShouldHide: TNotifyEvent;
    FMarginY: Integer;
    FMarginX: Integer;
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure SetWindowBorderColor(const Value: TColor);
    procedure SetMarginX(const Value: Integer);
    procedure SetMarginY(const Value: Integer);
  protected
    procedure Paint; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function GetVisibleHeight: integer; virtual;

    property OnShouldHide: TNotifyEvent read FOnShouldHide write FOnShouldHide;
    property MarginX: Integer read FMarginX write SetMarginX;
    property MarginY: Integer read FMarginY write SetMarginY;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property WindowBorderColor: TColor read FWindowBorderColor write SetWindowBorderColor default clGray;
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection;
  end;

  TSelectorItem = class(TObject)
  private
    FHeight: Integer;
    FCaption: TCaption;
    FBRect: TRect;
    FWidth: Integer;
    procedure SetCaption(const Value: TCaption);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    property BRect: TRect read FBRect write FBRect;
  public
    constructor Create;
    destructor Destroy; override;

    property Caption: TCaption read FCaption write SetCaption;
    property Height: Integer read FHeight write SetHeight;
    property Width: Integer read FWidth write SetWidth;
  end;

  TControlSelectorPanel = class (TOptionSelectorPanel)
  private
    FControlList: TDbgList;
    FAddAndRemoveBtn: TSelectorItem;
    FAddAndRemoveBtnHot: Boolean;
    FAddAndRemoveBtnDown: Boolean;
    FItemColorDown: TColor;
    FItemColorHot: TColor;
    FSeparatorSize: Integer;
    FItemColorDownTo: TColor;
    FItemColorHotTo: TColor;
    FItemTextColorHot: TColor;
    FItemTextColor: TColor;
    FItemTextColorDown: TColor;
    FAddAndRemovePopup: TATBPopupWindow;
    FShowAddAndRemoveBtn: Boolean;
    FOptionsBtn: TSelectorItem;
    FOptionsBtnHot: Boolean;
    FOptionsBtnDown: Boolean;
    FOptionsMenu: TPopupMenu;
    FTimer: TTimer;
    procedure TimerOnTime(Sender: TObject);
    procedure OnAddAndRemoveWindowHide(Sender: TObject);
    procedure OnAARWindowDeActivateHide(Sender: TObject);
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetItemColorDown(const Value: TColor);
    procedure SetItemColorHot(const Value: TColor);
    procedure SetItemColorDownTo(const Value: TColor);
    procedure SetItemColorHotTo(const Value: TColor);
    procedure SetItemTextColor(const Value: TColor);
    procedure SetItemTextColorHot(const Value: TColor);
    procedure SetItemTextColorDown(const Value: TColor);
    procedure SetShowAddAndRemoveBtn(const Value: Boolean);
    function GetShowOptionsBtn: Boolean;
    procedure SetOptionsMenu(const Value: TPopupMenu);
    procedure SetTextAutoOptionMenu(const Value: String);
    procedure SetTextOptionMenu(const Value: String);
    function GetTextAutoOptionMenu: String;
    function GetTextOptionMenu: String;
  protected
    procedure Paint; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure ShowAddAndRemovePopup;
    procedure HideAddAndRemovePopup;

    procedure ShowOptionsBtnPopup;
    procedure HideOptionsBtnPopup;

    procedure ReSetButtonSize;

    property ControlList: TDbgList read FControlList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ArrangeControls;
    function AddControl(AControl: TControl): Integer;
    procedure RemoveControl(AControl: TControl);
    function IsEmpty: Boolean;

    property ShowAddAndRemoveBtn: Boolean read FShowAddAndRemoveBtn write SetShowAddAndRemoveBtn;
    property ShowOptionsBtn: Boolean read GetShowOptionsBtn;
    property TextAutoOptionMenu: String read GetTextAutoOptionMenu write SetTextAutoOptionMenu;
    property TextOptionMenu: String read GetTextOptionMenu write SetTextOptionMenu;
    property OptionsMenu: TPopupMenu read FOptionsMenu write SetOptionsMenu;
    property ItemColorHot: TColor read FItemColorHot write SetItemColorHot;
    property ItemColorHotTo: TColor read FItemColorHotTo write SetItemColorHotTo;
    property ItemColorDown: TColor read FItemColorDown write SetItemColorDown;
    property ItemColorDownTo: TColor read FItemColorDownTo write SetItemColorDownTo;
    property ItemTextColor: TColor read FItemTextColor write SetItemTextColor;
    property ItemTextColorHot: TColor read FItemTextColorHot write SetItemTextColorHot;
    property ItemTextColorDown: TColor read FItemTextColorDown write SetItemTextColorDown;
  published
  end;


  // AdvToolBar PopupMenu

  TATBPopupWindow = class(TCustomForm)
  private
    FAdvToolBar: TAdvCustomToolBar;
    FPopupPanel: TATBPopupPanel;
    FHideOnDeActivate: Boolean;
    FShowAbove: Boolean;
    FOwner: TComponent;
    FHideTimer: TTimer;
    FShowLeft: Boolean;
    FItems: TATBMenuItem;
    FOnDeActivateHide: TNotifyEvent;
    procedure CreatePopupPanel;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure HideTimerOnTime(Sender: TObject);
    procedure SetPopupPanel(const Value: TATBPopupPanel);
  protected
    procedure Paint; override;
    function GetParentWnd: HWnd;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateItems;
    property HideOnDeActivate: Boolean read FHideOnDeActivate write FHideOnDeActivate;
    property ShowAbove: Boolean read FShowAbove write FShowAbove;
    property ShowLeft: Boolean read FShowLeft write FShowLeft default false;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    procedure SetWindowSize;

    procedure Hide;
  published
{$IFDEF TMSDOTNET}
    //property AutoScroll;
    //property BorderIcons;
    //property FormStyle;
    property OnHide;
{$ENDIF}
    property AdvToolBar: TAdvCustomToolBar read FAdvToolBar write FAdvToolBar;
    property PopupPanel: TATBPopupPanel read FPopupPanel write SetPopupPanel;
    property OnDeActivateHide: TNotifyEvent read FOnDeActivateHide write FOnDeActivateHide;
  end;


  TATBCustomPopupPanel = class(TCustomPanel)
  private
    FOwner: TComponent;
    FColorTo: TColor;
    FGradientDirection: TGradientDirection;
    FWindowBorderColor: TColor;
    FOnShouldHide: TNotifyEvent;
    FMarginY: Integer;
    FMarginX: Integer;
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure SetWindowBorderColor(const Value: TColor);
    procedure SetMarginX(const Value: Integer);
    procedure SetMarginY(const Value: Integer);
  protected
    procedure Paint; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function GetVisibleHeight: integer; virtual;

    property OnShouldHide: TNotifyEvent read FOnShouldHide write FOnShouldHide;
    property MarginX: Integer read FMarginX write SetMarginX;
    property MarginY: Integer read FMarginY write SetMarginY;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property WindowBorderColor: TColor read FWindowBorderColor write SetWindowBorderColor default clGray;
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection;
  end;

  TATBMenuItem = class(TObject)
  private
    FEnabled: Boolean;
    FVisible: Boolean;
    FBoundRect: TRect;
    FItems: TList;
    FParentItem: TATBMenuItem;
    FHeight: Integer;
    FCaption: TCaption;
    FWidth: Integer;
    FChecked: Boolean;
    FHint: string;
    FAutoCheck: Boolean;
    FObjects: TObject;
    procedure SetCaption(const Value: TCaption);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    function GetCount: integer;
    function GetItem(Index: Integer): TATBMenuItem;
    procedure SetChecked(const Value: Boolean);
    procedure SetEnabled(const Value: Boolean);
    procedure SetFParentItem(const Value: TATBMenuItem);
    procedure SetVisible(const Value: Boolean);
    procedure SetAutoCheck(const Value: Boolean);
  protected
    property BoundRect: TRect read FBoundRect write FBoundRect;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function HasChildren: Boolean;
    function Add: TATBMenuItem;
    procedure RemoveItem(ItemIndex: Integer);

    property AutoCheck: Boolean read FAutoCheck write SetAutoCheck;
    property Caption: TCaption read FCaption write SetCaption;
    property Height: Integer read FHeight write SetHeight;
    property Width: Integer read FWidth write SetWidth;
    property Checked: Boolean read FChecked write SetChecked;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Hint: string read FHint write FHint;
    property Visible: Boolean read FVisible write SetVisible;
    property ParentItem: TATBMenuItem read FParentItem write SetFParentItem;

    property Objects: TObject read FObjects write FObjects;

    property Count: integer read GetCount;
    property Items[Index: Integer]: TATBMenuItem read GetItem; default;
  end;

  TATBPopupPanel = class (TATBCustomPopupPanel)
  private
    FItems: TATBMenuItem;
    FAdvMenuStyler: TCustomAdvMenuStyler;
    FItemHeight: Integer;
    FHotItem: Integer;
    FPopupItem: Integer;
    FShowImageBar: Boolean;
    FShowIconBar: Boolean;
    FImageBarSize: Integer;
    FImageBarColorTo: TColor;
    FImageBarColor: TColor;
    FItemPopup: TATBPopupWindow;
    procedure OnItemPopupHide(Sender: TObject);
    procedure OnItemPopupDeActivateHide(Sender: TObject);
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetAdvMenuStyler(const Value: TCustomAdvMenuStyler);
    procedure SetItems(const Value: TATBMenuItem);
    procedure SetItemHeight(const Value: Integer);
    procedure SetHotItem(const Value: Integer);
    procedure SetShowImageBar(const Value: Boolean);
    procedure SetShowIconBar(const Value: Boolean);
    procedure SetImageBarSize(const Value: Integer);
  protected
    procedure Paint; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure ShowItemPopup;
    procedure HideItemPopup;
    procedure BeforeHide;

    procedure ItemClick(ItemIndex: Integer);

    function IsAnyAutoCheckItem: Boolean;
    procedure DrawItem(ItemIndex: Integer);
    procedure DrawAllItems;

    property ImageBarSize: Integer read FImageBarSize write SetImageBarSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure InvalidateItem(ItemIndex: Integer);
    function IndexOfItemAt(X, Y: Integer): Integer;
    procedure ToggleCheck(ItemIndex: Integer);
    procedure ArrangeItems;

    property HotItem: Integer read FHotItem write SetHotItem;
    property ItemHeight: Integer read FItemHeight write SetItemHeight;
    property Items: TATBMenuItem read FItems write SetItems;
    property AdvMenuStyler: TCustomAdvMenuStyler read FAdvMenuStyler write SetAdvMenuStyler;
    property ShowImageBar: Boolean read FShowImageBar write SetShowImageBar;
    property ShowIconBar: Boolean read FShowIconBar write SetShowIconBar;
    property ImageBarColor: TColor read FImageBarColor write FImageBarColor;
    property ImageBarColorTo: TColor read FImageBarColorTo write FImageBarColorTo;
  published
  end;

procedure DrawVerticalText(Canvas: TCanvas; Text: String; TextP: TPoint);

implementation
uses
  {$IFDEF DELPHI6_LVL}
  VDBConsts
  {$ELSE}
  DBConsts
  {$ENDIF}
  ;

type
  PDockInfo = ^TDockInfo;
  TDockInfo = record
    Dock: TAdvDockPanel;
    DockRect: TRect;
  end;


//----------------------------------------------------------------- DrawGradient

procedure DrawGradient(Canvas: TCanvas; FromColor, ToColor: TColor; Steps: Integer; R: TRect; Direction: Boolean);
var
  diffr, startr, endr: Integer;
  diffg, startg, endg: Integer;
  diffb, startb, endb: Integer;
  rstepr, rstepg, rstepb, rstepw: Real;
  i, stepw: Word;

begin
  if Direction then
    R.Right := R.Right - 1
  else
    R.Bottom := R.Bottom - 1;

  if Steps = 0 then
    Steps := 1;

  FromColor := ColorToRGB(FromColor);
  ToColor := ColorToRGB(ToColor);

  startr := (FromColor and $0000FF);
  startg := (FromColor and $00FF00) shr 8;
  startb := (FromColor and $FF0000) shr 16;
  endr := (ToColor and $0000FF);
  endg := (ToColor and $00FF00) shr 8;
  endb := (ToColor and $FF0000) shr 16;

  diffr := endr - startr;
  diffg := endg - startg;
  diffb := endb - startb;

  rstepr := diffr / steps;
  rstepg := diffg / steps;
  rstepb := diffb / steps;

  if Direction then
    rstepw := (R.Right - R.Left) / Steps
  else
    rstepw := (R.Bottom - R.Top) / Steps;

  with Canvas do
  begin
    for i := 0 to steps - 1 do
    begin
      endr := startr + Round(rstepr * i);
      endg := startg + Round(rstepg * i);
      endb := startb + Round(rstepb * i);
      stepw := Round(i * rstepw);
      Pen.Color := endr + (endg shl 8) + (endb shl 16);
      Brush.Color := Pen.Color;
      if Direction then
        Rectangle(R.Left + stepw, R.Top, R.Left + stepw + Round(rstepw) + 1, R.Bottom)
      else
        Rectangle(R.Left, R.Top + stepw, R.Right, R.Top + stepw + Round(rstepw) + 1);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure Draw3DLine(Canvas: TCanvas; FromPoint, ToPoint: TPoint; Embossed: Boolean; VerticalLine: Boolean = true);
begin
  with Canvas do
  begin
    if Embossed then
      Pen.Color := clWhite
    else
      Pen.Color := clBtnShadow;

    if VerticalLine then
    begin
      MoveTo(FromPoint.X - 1, FromPoint.Y - 1);
      LineTo(ToPoint.X - 1, ToPoint.Y);
      LineTo(ToPoint.X + 1, ToPoint.Y);
    end
    else
    begin
      MoveTo(FromPoint.X - 1, FromPoint.Y + 1);
      LineTo(FromPoint.X - 1, FromPoint.Y - 1);
      LineTo(ToPoint.X + 1, ToPoint.Y - 1);
    end;

    if Embossed then
      Pen.Color := clBtnShadow
    else
      Pen.Color := clWhite;

    if VerticalLine then
    begin
      MoveTo(ToPoint.X + 1, ToPoint.Y);
      LineTo(ToPoint.X + 1, FromPoint.Y);
      LineTo(ToPoint.X - 1, FromPoint.Y);
    end
    else
    begin
      MoveTo(ToPoint.X + 1, ToPoint.Y - 1);
      LineTo(ToPoint.X + 1, ToPoint.Y + 1);
      LineTo(FromPoint.X, FromPoint.Y + 1);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure DrawVerticalText(Canvas: TCanvas; Text: String; TextP: TPoint);
var
  i, ci, j: Integer;
  Lp1, Lp2: TPoint;
  S: String;
begin
  // First find char to be underlined
  ci := -1;
  i := 1;
  j := 1;
  while i <= length(Text) do
  begin
    if Text[i] = '&' then
    begin
      if i <= length(Text)-1 then
        if Text[i+1] = '&' then
        begin
          inc(i);
        end
        else
        begin
          ci := j;
          dec(j);
        end;
    end;
    inc(i);
    inc(j);
  end;
  
  // now remove double occurance of '&&' to '&'
  Text := StripHotkey(Text);
 {
  i := 1;
  while i <= length(Text) do
  begin
    if Text[i] = '&' then
    begin
      if i < length(Text)-1 then
        if Text[i+1] = '&' then
        begin
          //ci := -1;
          inc(i);
        end
        else
          ci := i +1;
    end;
    inc(i);
  end;
  }

  Canvas.TextOut(TextP.X, Textp.Y, Text);

  // draw underline
  if ci >= 0 then
  begin
    j := Canvas.TextHeight(Text);
    Lp1.X := TextP.X - j+1;
    Lp2.X := Lp1.X;
    S := '';
    i := 1;
    while i < ci do
    begin
      S := S + Text[i];
      inc(i);
    end;
    Lp1.Y := TextP.Y + Canvas.TextWidth(S);
    Lp2.Y := Lp1.Y + Canvas.TextWidth(Text[ci]);

    Canvas.Pen.Color := Canvas.Font.Color;
    Canvas.MoveTo(Lp1.X, Lp1.Y);
    Canvas.LineTo(Lp2.X, Lp2.Y);
  end;
end;

//------------------------------------------------------------------------------

procedure CenterRect(var Rect: TRect; const Width, Height: Integer);
begin
  with Rect do
  begin
    Right := (Left + Right + Width) div 2;
    Bottom := (Top + Bottom + Height) div 2;
    Left := Right - Width;
    Top := Bottom - Height;
  end;
end;

{
function GetUniqueName(AOwner: TComponent; S: string): string;
var
  i: integer;
  Found: boolean;
begin
  Result := S;
  i := 1;
  Found := false;
  while not found do
  begin
    Result := S + inttostr(i);
    if AOwner.FindComponent(Result) = nil then
      Found := true;
    inc(i);
  end;
end;
}

//------------------------------------------------------------------------------

{ TCustomAdvToolBarStyler }

procedure TCustomAdvToolBarStyler.AddControl(AControl: TCustomControl);
begin
  FControlList.Add(AControl);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.Assign(Source: TPersistent);
begin
  if Source is TCustomAdvToolBarStyler then
  begin
    if Assigned(FCurrentAdvMenuStyler) and Assigned(TCustomAdvToolBarStyler(Source).AdvMenuStyler) then
      FCurrentAdvMenuStyler.Assign(TCustomAdvToolBarStyler(Source).AdvMenuStyler);

    Color.Assign(TCustomAdvToolBarStyler(Source).Color);
    DockColor.Assign(TCustomAdvToolBarStyler(Source).DockColor);
    
    BackGround.Assign(TCustomAdvToolBarStyler(Source).BackGround);
    BackGroundTransparent := TCustomAdvToolBarStyler(Source).BackGroundTransparent;
    BackGroundDisplay := TCustomAdvToolBarStyler(Source).BackGroundDisplay;
    Font.Assign(TCustomAdvToolBarStyler(Source).Font);

    DragGripStyle := TCustomAdvToolBarStyler(Source).DragGripStyle;
    DragGripImage.Assign(TCustomAdvToolBarStyler(Source).DragGripImage);

    RightHandleImage.Assign(TCustomAdvToolBarStyler(Source).RightHandleImage);

    FloatingWindowBorderColor := TCustomAdvToolBarStyler(Source).FloatingWindowBorderColor;
    FloatingWindowBorderWidth := TCustomAdvToolBarStyler(Source).FloatingWindowBorderWidth;
    CaptionColor := TCustomAdvToolBarStyler(Source).CaptionColor;
    CaptionColorTo := TCustomAdvToolBarStyler(Source).CaptionColorTo;
    CaptionTextColor := TCustomAdvToolBarStyler(Source).CaptionTextColor;
    CaptionBorderColor := TCustomAdvToolBarStyler(Source).CaptionBorderColor;

    //Style := TCustomAdvToolBarStyler(Source).Style;
    ButtonAppearance := TCustomAdvToolBarStyler(Source).ButtonAppearance;
  end
  else
    inherited Assign(Source);
end;

//------------------------------------------------------------------------------

constructor TCustomAdvToolBarStyler.Create(AOwner: TComponent);
begin
  inherited;
  FControlList := TDbgList.Create;
  FBackGround := TBitMap.Create;
  FBackGroundTransparent := true;
  FBackGroundDisplay := bdTile;
  FFont := TFont.Create;
  FDragGripStyle := dsDots;
  FDragGripImage := TBitMap.Create;
  //FPopupIndicatorStyle:= psOffice2003;
  FRightHandleImage := TBitMap.Create;
  //FToolBarStyle := bsCustom;
  FTransparent := False;
  FRoundEdges := True;
  FRightHandleColor := RGB(158, 158, 158); //RGB(141, 141, 141);
  FRightHandleColorHot := RGB(182, 189, 210);
  FRightHandleColorDown := $76C1FF;
  FRightHandleColorDownTo:= RGB(255, 160, 45);
  FFloatingWindowBorderColor := RGB(109, 109, 109); ;
  FFloatingWindowBorderWidth := 2;
  FCaptionColor := RGB(128, 128, 128); //clGray;
  FCaptionColorTo := clNone;
  FCaptionTextColor := clWhite;
  FCaptionBorderColor := clNone;

  FBevel:= bvNone;

  FColor := TGradientBackground.Create;
  FDockColor := TGradientBackground.Create;

  FColor.OnChange := BackgroundChanged;
  FDockColor.OnChange := BackgroundChanged;

  FButtonAppearance := TButtonAppearance.Create;

  FInternalAdvMenuStyler := TAdvMenuStyler.Create(self);
  FInternalAdvMenuStyler.Name := 'InternalMenuStyler';
  //FAdvMenuStyler := FInternalAdvMenuStyler;
  FAdvMenuStyler := nil;
  FCurrentAdvMenuStyler := FInternalAdvMenuStyler;

  //Style := bsOffice2003Blue;
  //FTransparent:= true;
end;

//------------------------------------------------------------------------------

destructor TCustomAdvToolBarStyler.Destroy;
begin
  FFont.Free;
  FBackGround.Free;
  FDragGripImage.Free;
  FRightHandleImage.Free;
  FControlList.Free;
  FButtonAppearance.Free;
  FInternalAdvMenuStyler.Free;
  FColor.Free;
  FDockColor.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.Change(PropID: integer);
var
  i: integer;
begin
  for i := 0 to FControlList.Count - 1 do
  begin
    if TCustomControl(FControlList[i]) is TAdvDockPanel then
      TAdvDockPanel(FControlList[i]).UpdateMe(PropID)
    else if TCustomControl(FControlList[i]) is TAdvToolBar then
      TAdvToolBar(FControlList[i]).UpdateMe(PropID);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: integer;
begin
  inherited;
  if not (csDestroying in ComponentState) and (Operation = opRemove) then
  begin
    if AComponent = AdvMenuStyler then
      AdvMenuStyler := nil
    else
    begin
      i := FControlList.IndexOf(AComponent);
      if i >= 0 then
        FControlList.Remove(AComponent);
    end;
  end;

end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.RemoveControl(AControl: TCustomControl);
var
  i: integer;
begin
  i := FControlList.IndexOf(AControl);
  if i >= 0 then
    FControlList.Delete(i);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetAdvMenuStyler(
  const Value: TCustomAdvMenuStyler);
begin
  FAdvMenuStyler := Value;
  if FAdvMenuStyler = nil then
    FCurrentAdvMenuStyler := FInternalAdvMenuStyler
  else
    FCurrentAdvMenuStyler := FAdvMenuStyler;
    
  Change(6);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetBackGround(const Value: TBitMap);
begin
  FBackGround.Assign(Value);
  Change(1);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetBackGroundDisplay(
  const Value: TBackGroundDisplay);
begin
  if FBackGroundDisplay <> Value then
  begin
    FBackGroundDisplay := Value;
    Change(1);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetBackGroundTransparent(
  const Value: Boolean);
begin
  if FBackGroundTransparent <> Value then
  begin
    FBackGroundTransparent := Value;
    Change(1);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetColor(const Value: TGradientBackground);
begin
  FColor.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetDragGripImage(const Value: TBitMap);
begin
  FDragGripImage.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetDragGripStyle(
  const Value: TDragGripStyle);
begin
  if FDragGripStyle <> Value then
  begin
    FDragGripStyle := Value;
    Change(5);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Change(1);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetRightHandleImage(
  const Value: TBitmap);
begin
  FRightHandleImage.Assign(Value);
  Change(2);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetRoundEdges(const Value: boolean);
begin
  FRoundEdges := Value;
  Change(2);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetRightHandleColor(const Value: TColor);
begin
  if FRightHandleColor <> Value then
  begin
    FRightHandleColor := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetRightHandleColorHot(const Value: TColor);
begin
  if FRightHandleColorHot <> Value then
  begin
    FRightHandleColorHot := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetRightHandleColorTo(const Value: TColor);
begin
  if (FRightHandleColorTo <> Value) then
  begin
    FRightHandleColorTo := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetRightHandleColorHotTo(const Value: TColor);
begin
  if (FRightHandleColorHotTo <> Value) then
  begin
    FRightHandleColorHotTo := Value;
    Change(2);
  end;  
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetCaptionBorderColor(
  const Value: TColor);
begin
  if FCaptionBorderColor <> Value then
  begin
    FCaptionBorderColor := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetCaptionColor(const Value: TColor);
begin
  if FCaptionColor <> Value then
  begin
    FCaptionColor := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetCaptionColorTo(const Value: TColor);
begin
  if FCaptionColorTo <> Value then
  begin
    FCaptionColorTo := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetCaptionTextColor(const Value: TColor);
begin
  if FCaptionTextColor <> Value then
  begin
    FCaptionTextColor := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetFloatingWindowBorderColor(
  const Value: TColor);
begin
  if FFloatingWindowBorderColor <> Value then
  begin
    FFloatingWindowBorderColor := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetFloatingWindowBorderWidth(
  const Value: integer);
begin
  if FFloatingWindowBorderWidth <> Value then
  begin
    FFloatingWindowBorderWidth := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetTButtonAppearance(
  const Value: TButtonAppearance);
begin
  FButtonAppearance.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetDockColor(
  const Value: TGradientBackground);
begin
  FDockColor.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.Loaded;
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.BackgroundChanged(Sender: TObject);
begin
  Change(2);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetRightHandleColorDown(
  const Value: TColor);
begin
  if FRightHandleColorDown <> Value then
  begin
    FRightHandleColorDown := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetRightHandleColorDownTo(
  const Value: TColor);
begin
  if FRightHandleColorDownTo <> Value then
  begin
    FRightHandleColorDownTo := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetBevel(const Value: TPanelBevel);
begin
  if FBevel <> Value then
  begin
    FBevel := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SetUseBevel(const Value: Boolean);
begin
  if FUseBevel <> Value then
  begin
    FUseBevel := Value;
    Change(2);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.SavePropToFile(var F: TextFile);
var
  s: String;
  sl: TStringList;
begin
  sl:= TStringList.Create;

  if AutoThemeAdapt then
    s := 'True'
  else
    s := 'False';
  sl.Values['AutoThemeAdapt'] := s;
  Writeln(F, sl.CommaText);

  //AdvMenuStyler: TCustomAdvMenuStyler read FAdvMenuStyler write SetAdvMenuStyler; // PropID: 0
  //---- ButtonAppearance
  sl.Clear;
  with ButtonAppearance do
  begin
    s := 'ButtonAppearance.Color=' + ColorToString(Color);                                      Writeln(F, s);
    s := 'ButtonAppearance.ColorTo=' + ColorToString(ColorTo);                                  Writeln(F, s);
    s := 'ButtonAppearance.ColorChecked=' + ColorToString(ColorChecked);                        Writeln(F, s);
    s := 'ButtonAppearance.ColorCheckedTo=' + ColorToString(ColorCheckedTo);                    Writeln(F, s);
    s := 'ButtonAppearance.ColorDown=' + ColorToString(ColorDown);                              Writeln(F, s);
    s := 'ButtonAppearance.ColorDownTo=' + ColorToString(ColorDownTo);                          Writeln(F, s);
    s := 'ButtonAppearance.ColorHot=' + ColorToString(ColorHot);                                Writeln(F, s);
    s := 'ButtonAppearance.ColorHotTo=' + ColorToString(ColorHotTo);                            Writeln(F, s);
    s := 'ButtonAppearance.CaptionTextColor=' + ColorToString(CaptionTextColor);                Writeln(F, s);
    s := 'ButtonAppearance.CaptionTextColorHot=' + ColorToString(CaptionTextColorHot);          Writeln(F, s);
    s := 'ButtonAppearance.CaptionTextColorDown=' + ColorToString(CaptionTextColorDown);        Writeln(F, s);
    s := 'ButtonAppearance.CaptionTextColorChecked=' + ColorToString(CaptionTextColorChecked);  Writeln(F, s);

    if GradientDirection = gdHorizontal then
      s := 'ButtonAppearance.GradientDirection=' + 'gdHorizontal'
    else
      s := 'ButtonAppearance.GradientDirection=' + 'gdVertical';
    Writeln(F, s);

    if GradientDirectionHot = gdHorizontal then
      s := 'ButtonAppearance.GradientDirectionHot=' + 'gdHorizontal'
    else
      s := 'ButtonAppearance.GradientDirectionHot=' + 'gdVertical';
    Writeln(F, s);

    if GradientDirectionDown = gdHorizontal then
      s := 'ButtonAppearance.GradientDirectionDown=' + 'gdHorizontal'
    else
      s := 'ButtonAppearance.GradientDirectionDown=' + 'gdVertical';
    Writeln(F, s);

    if GradientDirectionChecked = gdHorizontal then
      s := 'ButtonAppearance.GradientDirectionChecked=' + 'gdHorizontal'
    else
      s := 'ButtonAppearance.GradientDirectionChecked=' + 'gdVertical';
    Writeln(F, s);

    s := 'ButtonAppearance.BorderColor=' + ColorToString(BorderColor);               Writeln(F, s);
    s := 'ButtonAppearance.BorderDownColor=' + ColorToString(BorderDownColor);       Writeln(F, s);
    s := 'ButtonAppearance.BorderHotColor=' + ColorToString(BorderHotColor);         Writeln(F, s);
    s := 'ButtonAppearance.BorderCheckedColor=' + ColorToString(BorderCheckedColor); Writeln(F, s);

    //--- Caption Font
    s := 'ButtonAppearance.CaptionFont.Color=' + ColorToString(CaptionFont.Color);  Writeln(F, s);
    sl.Clear;
    if fsBold in CaptionFont.Style then       sl.Add('fsBold');
    if fsItalic in CaptionFont.Style then     sl.Add('fsItalic');
    if fsUnderline in CaptionFont.Style then  sl.Add('fsUnderline');
    if fsStrikeOut in CaptionFont.Style then  sl.Add('fsStrikeOut');
    s := 'ButtonAppearance.CaptionFont.Style=' + sl.CommaText;
    Writeln(F, s);
    s := 'ButtonAppearance.CaptionFont.Size=' + InttoStr(CaptionFont.Size);    Writeln(F, s);

    sl.Clear;
    sl.Values['ButtonAppearance.CaptionFont.Name'] := CaptionFont.Name;
    s := sl.CommaText; {'ButtonAppearance.CaptionFont.Name=' + CaptionFont.Name; }             Writeln(F, s);
  end;

  //--- Color
  s := 'Color.Color=' + ColorToString(Color.Color);        Writeln(F, s);
  s := 'Color.ColorTo=' + ColorToString(Color.ColorTo);    Writeln(F, s);
  if Color.Direction = gdHorizontal then
    s := 'Color.Direction=gdHorizontal'
  else
    s := 'Color.Direction=gdVertical';
  Writeln(F, s);
  s := 'Color.Steps=' + InttoStr(Color.Steps);             Writeln(F, s);

  s := 'DockColor.Color=' + ColorToString(DockColor.Color);      Writeln(F, s);
  s := 'DockColor.ColorTo=' + ColorToString(DockColor.ColorTo);  Writeln(F, s);
  if DockColor.Direction = gdHorizontal then
    s := 'DockColor.Direction=gdHorizontal'
  else
    s := 'DockColor.Direction=gdVertical';
  Writeln(F, s);
  s := 'DockColor.Steps=' + InttoStr(DockColor.Steps);           Writeln(F, s);

  {property BackGround: TBitMap read FBackGround write SetBackGround;
  property BackGroundTransparent: Boolean read FBackGroundTransparent write SetBackGroundTransparent default true;
  property BackGroundDisplay: TBackGroundDisplay read FBackGroundDisplay write SetBackGroundDisplay default bdTile;
  }
  s := 'Font.Color=' + ColorToString(Font.Color);  Writeln(F, s);
  sl.Clear;
  if fsBold in Font.Style then       sl.Add('fsBold');
  if fsItalic in Font.Style then     sl.Add('fsItalic');
  if fsUnderline in Font.Style then  sl.Add('fsUnderline');
  if fsStrikeOut in Font.Style then  sl.Add('fsStrikeOut');
  s := 'Font.Style=' + sl.CommaText;
  Writeln(F, s);
  s := 'Font.Size=' + InttoStr(Font.Size);       Writeln(F, s);

  sl.Clear;
  sl.Values['Font.Name'] := Font.Name;
  s := sl.CommaText; {'Font.Name="' + Font.Name+'"'; }                Writeln(F, s);

  {===== AdvToolBar Properties -PropID: 2- =====}
  case DragGripStyle of
    dsDots:        s := 'DragGripStyle=dsDots';
    dsSingleLine:  s := 'DragGripStyle=dsSingleLine';
    dsDoubleLine:  s := 'DragGripStyle=dsDoubleLine';
    dsFlatDots:    s := 'DragGripStyle=dsFlatDots';
    dsNone:        s := 'DragGripStyle=dsNone';
  end;
  Writeln(F, s);
  //property DragGripImage: TBitMap read FDragGripImage write SetDragGripImage;

  //property RightHandleImage: TBitmap read FRightHandleImage write SetRightHandleImage;
  s := 'RightHandleColor=' + ColorToString(RightHandleColor);                   Writeln(F, s);
  s := 'RightHandleColorHot=' + ColorToString(RightHandleColorHot);             Writeln(F, s);
  s := 'RightHandleColorTo=' + ColorToString(RightHandleColorTo);               Writeln(F, s);
  s := 'RightHandleColorHotTo=' + ColorToString(RightHandleColorHotTo);         Writeln(F, s);
  s := 'RightHandleColorDown=' + ColorToString(RightHandleColorDown);           Writeln(F, s);
  s := 'RightHandleColorDownTo=' + ColorToString(RightHandleColorDownTo);       Writeln(F, s);

  s := 'FloatingWindowBorderColor=' + ColorToString(FloatingWindowBorderColor); Writeln(F, s);
  s := 'FloatingWindowBorderWidth=' + IntToStr(FloatingWindowBorderWidth);      Writeln(F, s);
  s := 'CaptionColor=' + ColorToString(CaptionColor);                           Writeln(F, s);
  s := 'CaptionColorTo=' + ColorToString(CaptionColorTo);                       Writeln(F, s);
  s := 'CaptionTextColor=' + ColorToString(CaptionTextColor);                   Writeln(F, s);
  s := 'CaptionBorderColor=' + ColorToString(CaptionBorderColor);               Writeln(F, s);

  sl.free;
  {
  case Bevel of
    bvNone:     s := 'bvNone';
    bvLowered:  s := 'bvLowered';
    bvRaised:   s := 'bvRaised';
    bvSpace:    s := 'bvSpace';
  end;
  Writeln(F, s);

  if RoundEdges then
    s := 'True'
  else
  Transparent: Boolean
  UseBevel: Boolean
  }
end;

//------------------------------------------------------------------------------

procedure TCustomAdvToolBarStyler.LoadPropFromFile(var F: TextFile);
var
  s: String;
  sl: TStringList;
begin
  sl:= TStringList.Create;

  try
    Readln(F, s);
    Sl.CommaText := s;
    if UpperCase(sl.Values['AutoThemeAdapt']) = 'TRUE' then
      AutoThemeAdapt := True
    else
      AutoThemeAdapt := False;

    //AdvMenuStyler: TCustomAdvMenuStyler read FAdvMenuStyler write SetAdvMenuStyler; // PropID: 0
    //---- ButtonAppearance
    sl.Clear;
    with ButtonAppearance do
    begin
      Readln(F, s);    Sl.CommaText := s;
      ButtonAppearance.Color := StringToColor(sl.Values['ButtonAppearance.Color']);

      Readln(F, s);    Sl.CommaText := s;
      ButtonAppearance.ColorTo := StringToColor(sl.Values['ButtonAppearance.ColorTo']);

      Readln(F, s);    Sl.CommaText := s;
      ButtonAppearance.ColorChecked := StringToColor(sl.Values['ButtonAppearance.ColorChecked']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.ColorCheckedTo := StringToColor(sl.Values['ButtonAppearance.ColorCheckedTo']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.ColorDown := StringToColor(sl.Values['ButtonAppearance.ColorDown']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.ColorDownTo := StringToColor(sl.Values['ButtonAppearance.ColorDownTo']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.ColorHot := StringToColor(sl.Values['ButtonAppearance.ColorHot']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.ColorHotTo := StringToColor(sl.Values['ButtonAppearance.ColorHotTo']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.CaptionTextColor := StringToColor(sl.Values['ButtonAppearance.CaptionTextColor']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.CaptionTextColorHot := StringToColor(sl.Values['ButtonAppearance.CaptionTextColorHot']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.CaptionTextColorDown := StringToColor(sl.Values['ButtonAppearance.CaptionTextColorDown']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.CaptionTextColorChecked := StringToColor(sl.Values['ButtonAppearance.CaptionTextColorChecked']);

      Readln(F, s);  Sl.CommaText := s;
      if UpperCase(sl.Values['ButtonAppearance.GradientDirection']) = UpperCase('gdHorizontal') then
        ButtonAppearance.GradientDirection := gdHorizontal
      else
        ButtonAppearance.GradientDirection := gdVertical;

      Readln(F, s);  Sl.CommaText := s;
      if UpperCase(sl.Values['ButtonAppearance.GradientDirectionHot']) = UpperCase('gdHorizontal') then
        ButtonAppearance.GradientDirectionHot := gdHorizontal
      else
        ButtonAppearance.GradientDirectionHot := gdVertical;

      Readln(F, s);  Sl.CommaText := s;
      if UpperCase(sl.Values['ButtonAppearance.GradientDirectionDown']) = UpperCase('gdHorizontal') then
        ButtonAppearance.GradientDirectionDown := gdHorizontal
      else
        ButtonAppearance.GradientDirectionDown := gdVertical;

      Readln(F, s);  Sl.CommaText := s;
      if UpperCase(sl.Values['ButtonAppearance.GradientDirectionChecked']) = UpperCase('gdHorizontal') then
        ButtonAppearance.GradientDirectionChecked := gdHorizontal
      else
        ButtonAppearance.GradientDirectionChecked := gdVertical;

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.BorderColor := StringToColor(sl.Values['ButtonAppearance.BorderColor']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.BorderDownColor := StringToColor(sl.Values['ButtonAppearance.BorderDownColor']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.BorderHotColor := StringToColor(sl.Values['ButtonAppearance.BorderHotColor']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.BorderCheckedColor := StringToColor(sl.Values['ButtonAppearance.BorderCheckedColor']);

      //--- Caption Font
      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.CaptionFont.Color := StringToColor(sl.Values['ButtonAppearance.CaptionFont.Color']);

      sl.Clear;
      Readln(F, s);   Sl.CommaText := s;
      sl.CommaText := sl.Values['ButtonAppearance.CaptionFont.Style'];

      ButtonAppearance.CaptionFont.Style := [];
      if (sl.IndexOf('fsBold') >= 0) then ButtonAppearance.CaptionFont.Style := ButtonAppearance.CaptionFont.Style + [fsBold];
      if (sl.IndexOf('fsItalic') >= 0) then ButtonAppearance.CaptionFont.Style := ButtonAppearance.CaptionFont.Style + [fsItalic];
      if (sl.IndexOf('fsUnderline') >= 0) then ButtonAppearance.CaptionFont.Style := ButtonAppearance.CaptionFont.Style + [fsUnderline];
      if (sl.IndexOf('fsStrikeOut') >= 0) then ButtonAppearance.CaptionFont.Style := ButtonAppearance.CaptionFont.Style + [fsStrikeOut];

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.CaptionFont.Size := StrToInt(sl.Values['ButtonAppearance.CaptionFont.Size']);

      Readln(F, s);   Sl.CommaText := s;
      ButtonAppearance.CaptionFont.Name := sl.Values['ButtonAppearance.CaptionFont.Name'];
    end;

    //--- Color
    Readln(F, s);   Sl.CommaText := s;
    Color.Color := StringToColor(sl.Values['Color.Color']);

    Readln(F, s);   Sl.CommaText := s;
    Color.ColorTo := StringToColor(sl.Values['Color.ColorTo']);

    Readln(F, s);   Sl.CommaText := s;
    if UpperCase(sl.Values['Color.Direction']) = UpperCase('gdHorizontal') then
      Color.Direction := gdHorizontal
    else
      Color.Direction := gdVertical;

    Readln(F, s);   Sl.CommaText := s;
    Color.Steps := StrToInt(sl.Values['Color.Steps']);

    Readln(F, s);   Sl.CommaText := s;
    DockColor.Color := StringToColor(sl.Values['DockColor.Color']);

    Readln(F, s);   Sl.CommaText := s;
    DockColor.ColorTo := StringToColor(sl.Values['DockColor.ColorTo']);

    Readln(F, s);   Sl.CommaText := s;
    if UpperCase(sl.Values['DockColor.Direction']) = UpperCase('gdHorizontal') then
      DockColor.Direction := gdHorizontal
    else
      DockColor.Direction := gdVertical;

    Readln(F, s);   Sl.CommaText := s;
    DockColor.Steps := StrToInt(sl.Values['DockColor.Steps']);

    {property BackGround: TBitMap read FBackGround write SetBackGround;
    property BackGroundTransparent: Boolean read FBackGroundTransparent write SetBackGroundTransparent default true;
    property BackGroundDisplay: TBackGroundDisplay read FBackGroundDisplay write SetBackGroundDisplay default bdTile;
    }

    Readln(F, s);   Sl.CommaText := s;
    Font.Color := StringToColor(sl.Values['Font.Color']);

    sl.Clear;
    Readln(F, s);   Sl.CommaText := s;
    sl.CommaText := sl.Values['Font.Style'];
    Font.Style := [];
    if (sl.IndexOf('fsBold') >= 0) then Font.Style := Font.Style + [fsBold];
    if (sl.IndexOf('fsItalic') >= 0) then Font.Style := Font.Style + [fsItalic];
    if (sl.IndexOf('fsUnderline') >= 0) then Font.Style := Font.Style + [fsUnderline];
    if (sl.IndexOf('fsStrikeOut') >= 0) then Font.Style := Font.Style + [fsStrikeOut];


    Readln(F, s);   Sl.CommaText := s;
    Font.Size := StrToInt(sl.Values['Font.Size']);

    Readln(F, s);   Sl.CommaText := s;
    Font.Name := sl.Values['Font.Name'];

    Readln(F, s);   Sl.CommaText := s;
    if (sl.Values['DragGripStyle']) = UpperCase('dsDots') then
      DragGripStyle := dsDots
    else if (sl.Values['DragGripStyle']) = UpperCase('dsSingleLine') then
      DragGripStyle := dsSingleLine
    else if (sl.Values['DragGripStyle']) = UpperCase('dsDoubleLine') then
      DragGripStyle := dsDoubleLine
    else if (sl.Values['DragGripStyle']) = UpperCase('dsFlatDots') then
      DragGripStyle := dsFlatDots
    else if (sl.Values['DragGripStyle']) = UpperCase('dsNone') then
      DragGripStyle := dsNone;

    //property DragGripImage: TBitMap read FDragGripImage write SetDragGripImage;

    //property RightHandleImage: TBitmap read FRightHandleImage write SetRightHandleImage;
    Readln(F, s);   Sl.CommaText := s;
    RightHandleColor := StringToColor(sl.Values['RightHandleColor']);

    Readln(F, s);   Sl.CommaText := s;
    RightHandleColorHot := StringToColor(sl.Values['RightHandleColorHot']);

    Readln(F, s);   Sl.CommaText := s;
    RightHandleColorTo := StringToColor(sl.Values['RightHandleColorTo']);

    Readln(F, s);   Sl.CommaText := s;
    RightHandleColorHotTo := StringToColor(sl.Values['RightHandleColorHotTo']);

    Readln(F, s);   Sl.CommaText := s;
    RightHandleColorDown := StringToColor(sl.Values['RightHandleColorDown']);

    Readln(F, s);   Sl.CommaText := s;
    RightHandleColorDownTo := StringToColor(sl.Values['RightHandleColorDownTo']);

    Readln(F, s);   Sl.CommaText := s;
    FloatingWindowBorderColor := StringToColor(sl.Values['FloatingWindowBorderColor']);

    Readln(F, s);   Sl.CommaText := s;
    FloatingWindowBorderWidth := StrToInt(sl.Values['FloatingWindowBorderWidth']);

    Readln(F, s);   Sl.CommaText := s;
    CaptionColor := StringToColor(sl.Values['CaptionColor']);

    Readln(F, s);   Sl.CommaText := s;
    CaptionColorTo := StringToColor(sl.Values['CaptionColorTo']);

    Readln(F, s);   Sl.CommaText := s;
    CaptionTextColor := StringToColor(sl.Values['CaptionTextColor']);

    Readln(F, s);   Sl.CommaText := s;
    CaptionBorderColor := StringToColor(sl.Values['CaptionBorderColor']);
  except
    raise Exception.Create('Corrupt file');
  end;
  sl.free;
end;

//------------------------------------------------------------------------------

{ TAdvDockPanel }

constructor TAdvDockPanel.Create(AOwner: TComponent);
begin
  inherited; //This csMenuEvents causes Atl+Key stack overflow problem
  ControlStyle := ControlStyle + [csAcceptsControls {, csMenuEvents}] - [csClickEvents, csCaptureMouse, csOpaque];

  FMyImage := TBitMap.Create;

  inherited Align := alTop;
  FDockAlign := daTop;

  FInternalToolBarStyler := TCustomAdvToolBarStyler.Create(self);
  FInternalToolBarStyler.Name := 'InternalStyler';
//  FInternalToolBarStyler.Color := RGB(212, 208, 200);
//  FInternalToolBarStyler.ColorTo := RGB(245, 245, 244);
//  FInternalToolBarStyler.GradientDirection := gdHorizontal;
  FToolBarStyler := nil;
  FCurrentToolBarStyler := FInternalToolBarStyler;
  FCurrentToolBarStyler.AddControl(self);
  {$IFDEF DELPHI6_LVL}
  FInternalToolBarStyler.SetSubComponent(True);
  {$ENDIF}

  FRows := TRowCollection.Create(self);
  FOffSetX := 1;
  FOffSetY := 0;

  FToolBars := TDbgList.Create;
  FHiddenToolBars := TDbgList.Create;

  FMinimumSize := MINDOCKPANELHEIGHT;

  FPersistence:= TPersistence.Create(self);
  FPersistence.OnChange:= OnPersistenceChange;

  FUseRunTimeHeight := False;
  
  DoubleBuffered := true;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
  //if not (csDesigning in ComponentState) then
    //Params.WindowClass.Style:= Params.WindowClass.Style and not (CS_HREDRAW or CS_VREDRAW);
end;

//------------------------------------------------------------------------------

destructor TAdvDockPanel.Destroy;
begin
  if FPersistence.Enabled and not (csDesigning in ComponentState) then
    SaveToolBarsPosition;

  FInternalToolBarStyler.Free;
  FRows.Free;
  FToolBars.Free;
  FHiddenToolBars.Free;
  FMyImage.Free;
  FPersistence.Free;
  inherited;
end;

//------------------------------------------------------------------------------

function TAdvDockPanel.AddToolBar(aAdvToolBar: TAdvCustomToolBar): integer;
var
  i: Integer;
begin
//  OutputDebugString(PChar('left: ' + inttostr(aAdvToolBar.Left)));
  if LockHeight and not (csDesigning in ComponentState) and (FPropertiesLoaded) then
  begin
    Result := -1;
    i := IsAllowedInAnyRow(aAdvToolBar);
    if (i >= 0) then
    begin
      aAdvToolBar.FCurrentDock := nil;
      aAdvToolBar.Position := self.Align;
      aAdvToolBar.FCurrentDock := self;

      FToolBars.Add(aAdvToolBar);
      Result := FRows.Items[i].AddToolBar(aAdvToolBar);

      aAdvToolBar.Persistence.Enabled := self.Persistence.Enabled;
      aAdvToolBar.Persistence.Key := self.Persistence.Key;
      aAdvToolBar.Persistence.Location := Self.Persistence.Location;
    end;
  end
  else
  begin
    aAdvToolBar.FCurrentDock := nil;
    aAdvToolBar.Position := self.Align;
    aAdvToolBar.FCurrentDock := self;

    FToolBars.Add(aAdvToolBar);

    if not (csLoading in ComponentState) then
    begin
      with FRows.Add do
      begin
        //aAdvToolBar.Row:= Index;
        Result := AddToolBar(aAdvToolBar);
      end;
    end
    else
      Result:= 0;

    aAdvToolBar.Persistence.Enabled := self.Persistence.Enabled;
    aAdvToolBar.Persistence.Key := self.Persistence.Key;
    aAdvToolBar.Persistence.Location := Self.Persistence.Location;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.AlignControls(AControl: TControl;
  var ARect: TRect);
begin
  inherited;
 { if AControl is TAdvCustomToolBar then
    if not TAdvCustomToolBar(AControl).AllowBoundChange then
      FRows[TAdvCustomToolBar(AControl).Row].ArrangeToolBars;  }
end;

//------------------------------------------------------------------------------

function TAdvDockPanel.GetAlign: TDockAlign;
begin
  Result := FDockAlign;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.Loaded;
var
  i, j, L, T: integer;
  TempToolBarList: TDbgList;
  Added: Boolean;
begin
  inherited;

  TempToolBarList := TDbgList.Create;
  for i := 0 to FToolBars.Count-1 do
  begin
    Added := false;
    for j := 0 to TempToolBarList.Count-1 do
    begin
      if Align in [daTop, daBottom] then
      begin
        if TAdvCustomToolBar(TempToolBarList[j]).Top > TAdvCustomToolBar(FToolBars[i]).Top then
        begin
          TempToolBarList.Insert(j, FToolBars[i]);
          Added := True;
          Break;
        end
        else if TAdvCustomToolBar(TempToolBarList[j]).Top = TAdvCustomToolBar(FToolBars[i]).Top then
        begin
          if TAdvCustomToolBar(TempToolBarList[j]).Left > TAdvCustomToolBar(FToolBars[i]).Left then
          begin
            TempToolBarList.Insert(j, FToolBars[i]);
            Added := True;
            Break;
          end;
        end;
      end
      else  // Position in [daLeft, daBottom] then
      begin
        if TAdvCustomToolBar(TempToolBarList[j]).Left > TAdvCustomToolBar(FToolBars[i]).Left then
        begin
          TempToolBarList.Insert(j, FToolBars[i]);
          Added := True;
          Break;
        end
        else if TAdvCustomToolBar(TempToolBarList[j]).Left = TAdvCustomToolBar(FToolBars[i]).Left then
        begin
          if TAdvCustomToolBar(TempToolBarList[j]).Top > TAdvCustomToolBar(FToolBars[i]).Top then
          begin
            TempToolBarList.Insert(j, FToolBars[i]);
            Added := True;
            Break;
          end;
        end;
      end;
    end;
    if not Added then
      TempToolBarList.Add(FToolBars[i]);
  end;

  for j := 0 to TempToolBarList.Count-1 do
  begin
    L := TAdvCustomToolBar(TempToolBarList[j]).Left;
    T := TAdvCustomToolBar(TempToolBarList[j]).Top;
    with FRows.Add do
      AddToolBar(TAdvCustomToolBar(TempToolBarList[j]));

    TAdvCustomToolBar(TempToolBarList[j]).Left := L;
    TAdvCustomToolBar(TempToolBarList[j]).Top := T;
  end;
  TempToolBarList.Free;

  if FPersistence.Enabled and not (csDesigning in ComponentState) then
    LoadToolBarsPosition;
{  for i:=0 to FRows.Count-1 do
    FRows.Items[i].ArrangeToolBars;  }

  FPropertiesLoaded := True;  
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  // Check remove for ToolBar, Styler
  if not (csDestroying in ComponentState) and (Operation = opRemove) then
  begin
    if AComponent = ToolBarStyler then
      ToolBarStyler := nil
    else if AComponent is TAdvCustomToolBar then
    begin
      if (TAdvCustomToolBar(AComponent).Row >= 0) and (TAdvCustomToolBar(AComponent).Row < FRows.Count) then
        RemoveToolBar(TAdvCustomToolBar(AComponent));
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.Paint;
var
  R: TRect;
  c, ro: integer;
begin
  inherited;

  FMyImage.Width := Width;
  FMyImage.Height := Height;

  R := ClientRect;
  with FCurrentToolBarStyler, FMyImage.Canvas do
  begin
    if DockColor.ColorTo <> clNone then
      DrawGradient(FMyImage.Canvas, DockColor.Color, DockColor.ColorTo, DockColor.Steps, R, DockColor.Direction = gdHorizontal)
    else
    begin
      Pen.Color := DockColor.Color;
      Brush.Color := DockColor.Color;
      Rectangle(R);
    end;

    if not BackGround.Empty then
    begin
       // have to shift to on change event
       //set color
     { if BackGroundTransparent then
      begin
        BackGround.Transparent:= true;
        BackGround.TransparentMode:= tmAuto;
      end;  }
      case BackGroundDisplay of
        bdTile:
          begin
            c := 1;
            ro := 1;
            while ro < Height - 2 do
            begin
              while c < width - 2 do
              begin
                Draw(c, ro, BackGround);
                c := c + BackGround.Width;
              end;
              c := 1;
              ro := ro + BackGround.Height;
            end;
          end;
        bdCenter:
          begin
            Draw((Width - BackGround.Width) div 2, (Height - BackGround.Height) div 2, BackGround);
          end;
        bdStretch:
          begin
            StretchDraw(Rect(R.Left + 2, R.Top + 2, R.Right - 2, R.Bottom - 2), BackGround);
          end;
      end;
    end;
  end;

  Canvas.Draw(0, 0, FMyImage);
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.RemoveToolBar(aAdvToolBar: TAdvCustomToolBar);
var
  i: integer;
begin
  if not (csLoading in ComponentState) then
    if FRows.Count > aAdvToolBar.Row then
      FRows.Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);

  i := FToolBars.IndexOf(aAdvToolBar);
  if i >= 0 then
    FToolBars.Delete(i);

  i := FHiddenToolBars.IndexOf(aAdvToolBar);
  if i >= 0 then
    FHiddenToolBars.Delete(i);
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetAlign(const Value: TDockAlign);
var
  i: integer;
begin
  if Value <> FDockAlign then
  begin
    FDockAlign := Value;
    case FDockAlign of
      daLeft: inherited Align := alLeft;
      daTop: inherited Align := alTop;
      daRight: inherited Align := alRight;
      daBottom: inherited Align := alBottom;
    end;

    for i := 0 to FToolBars.Count - 1 do
      TAdvCustomToolBar(FToolBars[i]).Position := FDockAlign;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetParent(AParent: TWinControl);
begin
  if (AParent is TAdvDockPanel) or (AParent is TAdvCustomToolBar) then
    raise Exception.Create('Invalid Parent');

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetToolBarStyler(
  const Value: TCustomAdvToolBarStyler);
var
  i: integer;
begin
  if (FToolBarStyler <> Value) or (Value = nil) then
  begin
    if Assigned(FToolBarStyler) and (FToolBarStyler <> FInternalToolBarStyler) then
      FToolBarStyler.RemoveControl(self);

    FToolBarStyler := Value;

    if FToolBarStyler = nil then
    begin
      //FToolBarStyler := FInternalToolBarStyler
      FCurrentToolBarStyler := FInternalToolBarStyler;
    end
    else
    begin
      FCurrentToolBarStyler := FToolBarStyler;
      FToolBarStyler.AddControl(self);
    end;

    if not (csDestroying in ComponentState) and not (csLoading in ComponentState) then
    begin
      for i := 0 to FToolBars.Count - 1 do
        TAdvCustomToolBar(FToolBars[i]).ParentStyler := TAdvCustomToolBar(FToolBars[i]).ParentStyler;
    end;

    PopupMenu := PopupMenu;   // Refresh Styler
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.UpdateMe(PropID: integer);
begin
  Color := FCurrentToolBarStyler.DockColor.Color;
  case PropID of
    6: PopupMenu := PopupMenu;
  end;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

function TAdvDockPanel.GetAdvToolBarCount: integer;
begin
  Result := FToolBars.Count;
end;

//------------------------------------------------------------------------------

function TAdvDockPanel.GetAdvToolBars(index: integer): TAdvCustomToolBar;
begin
  Result := TAdvCustomToolBar(FToolBars[index]);
end;

//------------------------------------------------------------------------------

function TAdvDockPanel.GetRowCount: integer;
begin
  Result := FRows.Count;
end;

//------------------------------------------------------------------------------

function TAdvDockPanel.GetMyImage: TBitMap;
begin
  Result := FMyImage;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetToolBarBounds(aAdvToolBar: TAdvCustomToolBar;
  var ALeft, ATop, AWidth, AHeight: Integer);
begin                                  // FF: Btn.showCaption when not visible
  if (csLoading in ComponentState) or (not aAdvToolBar.Visible) then
    exit;

  if Align in [daTop, daBottom] then
  begin
    FRows.SetToolBarTopAndHeight(aAdvToolBar, ATop, AHeight);
    FRows.Items[aAdvToolBar.Row].SetToolBarLeftAndWidth(aAdvToolBar, ALeft, AWidth);
  end
  else // if Position in [daLeft, daRight] then
  begin
    FRows.SetToolBarLeftAndWidth(aAdvToolBar, ALeft, AWidth);
    FRows.Items[aAdvToolBar.Row].SetToolBarTopAndHeight(aAdvToolBar, ATop, AHeight);
    //OutputDebugString(pchar(aAdvToolBar.Name+' T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' H:'+inttostr(aAdvToolBar.Height)+' W:'+inttostr(aAdvToolBar.Width)));
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.UpdateToolBarVisibility(
  aAdvToolBar: TAdvCustomToolBar);
var
  I: Integer;
begin
  if aAdvToolBar.Visible then
  begin
    I := FHiddenToolBars.IndexOf(aAdvToolBar);
    if I >= 0 then
      FHiddenToolBars.Delete(i);
  end
  else
  begin
    I := FHiddenToolBars.IndexOf(aAdvToolBar);
    if I < 0 then
      FHiddenToolBars.Add(aAdvToolBar);
  end;
  FRows.UpdateToolBarVisibility(aAdvToolBar);
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetToolBarFullSize(aAdvToolBar: TAdvCustomToolBar);
begin
  FRows.SetToolBarFullSize(aAdvToolBar);
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.WMSize(var Message: TWMSize);
begin
  FRows.SetRowsPosition;
end;

//------------------------------------------------------------------------------

{ AdvToolbar menu support }

var
  ToolMenuHook: HHOOK;
  InitDone: Boolean = False;
  MenuToolBar , MenuToolBar2: TAdvCustomToolBar;
  MenuButtonIndex: Integer;
  LastMenuItem: TMenuItem;
  LastMousePos: TPoint;
  StillModal: Boolean;

function ToolMenuGetMsgHook(Code: Integer; WParam: Longint; var Msg: TMsg): Longint; stdcall;
const
  RightArrowKey: array[Boolean] of Word = (VK_LEFT, VK_RIGHT);
  LeftArrowKey: array[Boolean] of Word = (VK_RIGHT, VK_LEFT);
var
  P: TPoint;
  Target: TControl;
  Item: Integer;
  FindKind: TFindItemKind;
  ParentMenu: TMenu;
  MouseTarget: Boolean;

  function FindButton(Forward: Boolean): TAdvCustomToolBarButton;
  var
    ToolBar: TAdvCustomToolBar;
    I, J, Count: Integer;
  begin
    ToolBar := MenuToolBar;
    if ToolBar <> nil then
    begin
      J := MenuButtonIndex;
      I := J;
      Count := ToolBar.FATBControls.Count; // .ControlCount;
      if Forward then
        repeat
          if I = Count - 1 then
            I := 0
          else
            Inc(I);
          if TControl(ToolBar.FATBControls[I]) is TAdvCustomToolBarButton then
          begin
            Result := TAdvCustomToolBarButton(TControl(ToolBar.FATBControls[I]) {ToolBar.Controls[I]});
            if Result.Visible and Result.Enabled {and Result.Grouped} then Exit;
          end;
        until I = J
      else
        repeat
          if I = 0 then
            I := Count - 1
          else
            Dec(I);
          if TControl(ToolBar.FATBControls[I]) is TAdvCustomToolBarButton then
          begin
            Result := TAdvCustomToolBarButton(TControl(ToolBar.FATBControls[I]) {ToolBar.Controls[I]});
            if Result.Visible and Result.Enabled {and Result.Grouped} then Exit;
          end;
        until I = J;
    end;
    Result := nil;
  end;

begin
  MouseTarget := false;
  if LastMenuItem <> nil then
  begin
    ParentMenu := LastMenuItem.GetParentMenu;
    if ParentMenu <> nil then
    begin
      if ParentMenu.IsRightToLeft then
        if Msg.WParam = VK_LEFT then
          Msg.WParam := VK_RIGHT
        else if Msg.WParam = VK_RIGHT then
          Msg.WParam := VK_LEFT;
    end;
  end;
  Result := CallNextHookEx(ToolMenuHook, Code, WParam, Longint(@Msg));
  if Result <> 0 then Exit;
  if (Code = MSGF_MENU) then
  begin
    Target := nil;
    if not InitDone then
    begin
      InitDone := True;
      PostMessage(Msg.Hwnd, WM_KEYDOWN, VK_DOWN, 0);
    end;
    case Msg.Message of
      WM_MENUSELECT:
        begin
          if (HiWord(Msg.WParam) = $FFFF) and (Msg.LParam = 0) then
          begin
            if not StillModal then
              MenuToolBar.CancelMenu;
            Exit;
          end
          else
            StillModal := False;
          FindKind := fkCommand;
          if HiWord(Msg.WParam) and MF_POPUP <> 0 then FindKind := fkHandle;
          if FindKind = fkHandle then
            Item := GetSubMenu(Msg.LParam, LoWord(Msg.WParam))
          else
            Item := LoWord(Msg.WParam);
          LastMenuItem := MenuToolBar.FTempMenu.FindItem(Item, FindKind);
        end;
      WM_SYSKEYDOWN:
        if Msg.WParam = VK_MENU then
        begin
          MenuToolBar.CancelMenu;
          Exit;
        end;
      WM_KEYDOWN:
        if Msg.WParam = VK_RETURN then
          MenuToolBar.FMenuResult := True
        else if Msg.WParam = VK_ESCAPE then
          StillModal := True
        else if LastMenuItem <> nil then
        begin
          if (Msg.WParam = VK_RIGHT) and (LastMenuItem.Count = 0) then
            Target := FindButton(True)
          else if (Msg.WParam = VK_LEFT) and (LastMenuItem.GetParentComponent is TPopupMenu) then
            Target := FindButton(False)
          else
            Target := nil;
          if Target <> nil then
          begin
            P := Target.ClientToScreen(Point(0, 0));
            MouseTarget := false;
          end;
        end;
      WM_MOUSEMOVE:
        begin
          P := Msg.pt;
          if (P.X <> LastMousePos.X) or (P.Y <> LastMousePos.Y) then
          begin
            Target := FindDragTarget(P, False);
            LastMousePos := P;
            MouseTarget := true;
          end;
        end;
    end;
    if (Target <> nil) and (Target is TAdvCustomToolBarButton) and (TAdvCustomToolBarButton(Target).IsMenuButton) then
    begin
      with TAdvCustomToolBarButton(Target) do
        if (Index <> MenuButtonIndex) {and Grouped} and (Parent <> nil) and
          Parent.HandleAllocated then
        begin
          StillModal := True;
          MenuToolBar.FCaptureChangeCancels := False;
          MenuToolBar.ClickButton(TAdvCustomToolBarButton(Target), MouseTarget);
          //MenuToolBar.ClickButton(TAdvCustomToolBarButton(Target));
        end;
    end;
  end;
end;

procedure InitToolMenuHooks;
begin
  StillModal := False;
  GetCursorPos(LastMousePos);
  if ToolMenuHook = 0 then
    ToolMenuHook := SetWindowsHookEx(WH_MSGFILTER, @ToolMenuGetMsgHook, 0,
      GetCurrentThreadID);
end;

procedure ReleaseToolMenuHooks;
begin
  if ToolMenuHook <> 0 then UnhookWindowsHookEx(ToolMenuHook);
  ToolMenuHook := 0;
  LastMenuItem := nil;
  MenuToolBar := nil;
  MenuButtonIndex := -1;
  InitDone := False;
end;

//----------------------------------------------

var
  ToolMenuKeyHook: HHOOK;

procedure ReleaseToolMenuKeyHooks; forward;

function ToolMenuKeyMsgHook(Code: Integer; WParam: Longint; var Msg: TMsg): Longint; stdcall;
begin
  if (Code = HC_ACTION) then
  begin
    if Msg.Message = CM_DEACTIVATE then
      MenuToolBar2.CancelMenu
    else if Msg.message = WM_COMMAND then
      ReleaseToolMenuKeyHooks
    else if (ToolMenuHook = 0) and ((Msg.Message = WM_CHAR) or
      (Msg.Message = WM_KEYDOWN) or (Msg.Message = WM_KEYUP) or
      (Msg.Message = WM_SYSKEYDOWN) or (Msg.Message = WM_SYSKEYUP)) then
      Msg.hwnd := MenuToolBar2.Handle;
  end;
  Result := CallNextHookEx(ToolMenuKeyHook, Code, WParam, Longint(@Msg))
end;

procedure InitToolMenuKeyHooks;
begin
  if ToolMenuKeyHook = 0 then
    ToolMenuKeyHook := SetWindowsHookEx(WH_GETMESSAGE, @ToolMenuKeyMsgHook, 0,
      GetCurrentThreadID);
end;

procedure ReleaseToolMenuKeyHooks;
begin
  if ToolMenuKeyHook <> 0 then UnhookWindowsHookEx(ToolMenuKeyHook);
  ToolMenuKeyHook := 0;
  MenuToolBar2 := nil;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetPersistence(const Value: TPersistence);
begin
  FPersistence.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.LoadToolBarsPosition;
var
  i, j, ATBCount, RC, R, L, T, W, H, SV: integer;
  AToolBar: TAdvCustomToolBar;
  {$IFDEF DELPHI4_LVL}
  IniFile: TCustomIniFile;
  {$ELSE}
  IniFile: TIniFile;
  {$ENDIF}
  N: String;
  OldV: Boolean;
  TempToolBarList: TStringList;
  DockList: TDbgList;
  TempList: TDbgList;

  function GetToolBarByName(aName: String): TAdvCustomToolBar;
  var
    i: integer;
  begin
    Result:= nil;
    i:= TempToolBarList.IndexOf(N);
    if i >= 0 then
    begin
      Result:= TAdvCustomToolBar(TempToolBarList.Objects[i]);
      TempToolBarList.Delete(i);
    end;
  end;

 { function GetToolBarByName(aName: String): TAdvCustomToolBar;
  var
    r, i: integer;
  begin
    Result:= nil;
    for r:=0 to FRows.Count-1 do
      for i:= 0 to FRows.Items[r].ToolBarList.Count-1 do
        if UpperCase(aName) = UpperCase(TAdvCustomToolBar(FRows.Items[r].ToolBarList[i]).Name) then
        begin
          Result:= TAdvCustomToolBar(FRows.Items[r].ToolBarList[i]);
          Break;
        end;
  end;
  }

  function GetParentForm: TCustomForm;
  var
    ParentCtrl: TWinControl;
  begin
    Result := nil;
    ParentCtrl := self.Parent;
    while Assigned(ParentCtrl) do
    begin
      if ParentCtrl is TCustomForm then
      begin
        Result := TCustomForm(ParentCtrl);
        break;
      end;
      ParentCtrl := ParentCtrl.Parent;
    end;
  end;

  procedure BuildDockPanelList;
    procedure SearchChildForDockPanel(ParentCtrl: TWinControl);
    var
      i: integer;
    begin
      if (ParentCtrl = nil) or (ContainsControl(ParentCtrl)) {or (not ParentCtrl.Showing)} then
        exit;

      if not (ParentCtrl is TAdvDockPanel) and (ParentCtrl is TWinControl) then
      begin
        for i := 0 to ParentCtrl.ControlCount - 1 do
        begin
          if (ParentCtrl.Controls[i] is TWinControl) then
            SearchChildForDockPanel(TWinControl(ParentCtrl.Controls[i]));
        end;
      end;

      if (ParentCtrl is TAdvDockPanel) then
      begin
        if (DockList.IndexOf(ParentCtrl) < 0) then
          DockList.Add(ParentCtrl);
      end;
    end;

  begin
    SearchChildForDockPanel(GetParentForm);
  end;

  function SearchToolBarByName(aName: String): TAdvCustomToolBar;
  var
    i, j: integer;
  begin
    Result:= nil;
    for i:= 0 to DockList.Count-1 do
    begin
      for j:= 0 to TAdvDockPanel(DockList[i]).ToolBars.Count-1 do
      begin
        if UpperCase(aName) = UpperCase(TAdvCustomToolBar(TAdvDockPanel(DockList[i]).ToolBars[j]).Name) then
        begin
          Result:= TAdvCustomToolBar(TAdvDockPanel(DockList[i]).ToolBars[j]);
          break;
        end;
      end;
    end;
  end;

begin
  if (FPersistence.Enabled) and (FPersistence.Key <>'') and
     (FPersistence.Section<>'') and
     (not (csDesigning in ComponentState)) then
  begin
    {$IFDEF DELPHI4_LVL}
    if FPersistence.location = plRegistry then
      IniFile := TRegistryIniFile.Create(FPersistence.Key)
    else
    {$ENDIF}
      IniFile := TIniFile(tIniFile.Create(FPersistence.Key));

    TempToolBarList:= TStringList.Create;
    for j:=0 to FRows.Count-1 do
      for i:= 0 to FRows.Items[j].ToolBarList.Count-1 do
        TempToolBarList.AddObject(TAdvCustomToolBar(FRows.Items[j].ToolBarList[i]).name, FRows.Items[j].ToolBarList[i]);

    ATBCount:= 0;

    with IniFile do
    begin
      ATBCount:= ReadInteger(FPersistence.section,'ToolBarCount', ATBCount);

      if ATBCount > 0 then
      begin
        RC := ReadInteger(FPersistence.section,'RowCount', FRows.Count);
        FRows.Clear;
        for j:= 0 to RC-1 do
          FRows.Add;

        DockList:= TDbgList.Create;
        BuildDockPanelList;

        for i:= 1 to ATBCount do
        begin
          N := ReadString(FPersistence.section, 'Name'+inttostr(i), self.name);
          AToolBar := GetToolBarByName(N);
          if AToolBar = nil then // ToolBar not found
          begin
            // search and Add ToolBar
            AToolBar:= SearchToolBarByName(N);
            if AToolBar <> nil then
            begin
              AToolBar.Parent:= self;
              self.RemoveToolBar(AToolBar);
            end;
          end;

          if AToolBar <> nil then    // ToolBar Found
          begin
            R := ReadInteger(FPersistence.section, N+'.Row', AToolBar.FRow);
            L := ReadInteger(FPersistence.section, N+'.Left', AToolBar.Left);
            T := ReadInteger(FPersistence.section, N+'.Top', AToolBar.Top);
            W := ReadInteger(FPersistence.section, N+'.Width', AToolBar.Width);
            H := ReadInteger(FPersistence.section, N+'.Height', AToolBar.Height);
            SV := ReadInteger(FPersistence.section, N+'.Visible', Integer(AToolBar.Visible));

            if R < FRows.Count then
            begin
              FRows.Items[R].FToolBarList.Add(AToolBar);
              AToolBar.FRow:= R;
            end;

            OldV:= AToolBar.AllowBoundChange;
            AToolBar.AllowBoundChange:= true;

            if (W <> AToolBar.Width) then
              AToolBar.Width := W;

            if (L <> AToolBar.Left) then
              AToolBar.Left := L;

            if (T <> AToolBar.Top) then
              AToolBar.Top := T;

            if (H <> AToolBar.Height) then
              AToolBar.Height := H;

            AToolBar.AllowBoundChange:= OldV;

            if AToolBar.Visible <> Boolean(SV) then
              AToolBar.Visible := Boolean(SV);

            //OutputDebugString(PChar(inttostr(R)));
          end;
        end;

        TempList := TDbgList.Create;
        for i:=0 to FRows.Count-1 do
          TempList.Add(FRows.Items[i]);

        for i:=0 to TempList.Count-1 do
          FRows.DeleteMeIfEmpty(TempList[i]);

        TempList.Free;
       { for i:=0 to FRows.Count-1 do
          FRows.DeleteMeIfEmpty(FRows.Items[i]);
        }

        for i:= 0 to TempToolBarList.Count-1 do
        begin
          with FRows.Add do
          begin
            AddToolBar(TAdvCustomToolBar(TempToolBarList.Objects[i]));
          end;
        end;

        FRows.SetRowsPosition;
        DockList.Free;
      end;

    end;
    IniFile.Free;
    TempToolBarList.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SaveToolBarsPosition;
var
  r, i, c: integer;
  AToolBar: TAdvCustomToolBar;
  {$IFDEF DELPHI4_LVL}
  IniFile: TCustomIniFile;
  {$ELSE}
  IniFile: TIniFile;
  {$ENDIF}
begin
  if (FPersistence.Enabled) and (FPersistence.Key <>'') and
     (FPersistence.Section <>'') and
     (not (csDesigning in ComponentState)) then
  begin
    {$IFDEF DELPHI4_LVL}
    if FPersistence.Location = plRegistry then
      IniFile := TRegistryIniFile.Create(FPersistence.Key)
    else
    {$ENDIF}
      IniFile := TIniFile.Create(FPersistence.Key);

    with IniFile do
    begin
      i:= 0;
      for r:=0 to FRows.Count-1 do
        i:= i + FRows.Items[r].ToolBarList.Count;

      i := i + FHiddenToolBars.Count;

      WriteInteger(FPersistence.section,'ToolBarCount', i);
      WriteInteger(FPersistence.section,'RowCount', FRows.Count);

      c:= 1;
      for r:=0 to FRows.Count-1 do
      begin
        for i:= 0 to FRows.Items[r].ToolBarList.Count-1 do
        begin
          AToolBar:= FRows.Items[r].ToolBarList[i];
          WriteString(FPersistence.section, 'Name'+inttostr(c), AToolBar.Name);
          WriteInteger(FPersistence.section, AToolBar.Name+'.Row', AToolBar.FRow);
          WriteInteger(FPersistence.section, AToolBar.Name+'.Left', AToolBar.Left);
          WriteInteger(FPersistence.section, AToolBar.Name+'.Top', AToolBar.Top);
          WriteInteger(FPersistence.section, AToolBar.Name+'.Width', AToolBar.Width);
          WriteInteger(FPersistence.section, AToolBar.Name+'.Height', AToolBar.Height);
          WriteInteger(FPersistence.section, AToolBar.Name+'.Visible', Integer(AToolBar.Visible));
          inc(c);
        end;
      end;

      // Saving Invisible ToolBars
      for i:= 0 to FHiddenToolBars.Count-1 do
      begin
        AToolBar:= FHiddenToolBars[i];
        WriteString(FPersistence.section, 'Name'+inttostr(c), AToolBar.Name);
        WriteInteger(FPersistence.section, AToolBar.Name+'.Row', AToolBar.FRow);
        WriteInteger(FPersistence.section, AToolBar.Name+'.Left', AToolBar.Left);
        WriteInteger(FPersistence.section, AToolBar.Name+'.Top', AToolBar.Top);
        WriteInteger(FPersistence.section, AToolBar.Name+'.Width', AToolBar.Width);
        WriteInteger(FPersistence.section, AToolBar.Name+'.Height', AToolBar.Height);
        WriteInteger(FPersistence.section, AToolBar.Name+'.Visible', Integer(AToolBar.Visible));
        inc(c);
      end;

    end;
    IniFile.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.CreateWnd;
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.OnPersistenceChange(Sender: TObject);
var
  i, j: integer;
begin
  for j:=0 to FRows.Count-1 do
    for i:= 0 to FRows.Items[j].ToolBarList.Count-1 do
    begin
      TAdvCustomToolBar(FRows.Items[j].ToolBarList[i]).Persistence.Enabled := self.Persistence.Enabled;
      TAdvCustomToolBar(FRows.Items[j].ToolBarList[i]).Persistence.Key := self.Persistence.Key;
      TAdvCustomToolBar(FRows.Items[j].ToolBarList[i]).Persistence.Location := self.Persistence.Location;
    end;
end;

//------------------------------------------------------------------------------

function TAdvDockPanel.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

function TAdvDockPanel.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetMinimumSize(const Value: Integer);
begin
  if (FMinimumSize <> Value) and (Value > 0) then
  begin
    FMinimumSize := Value;
    if not (csDesigning in ComponentState) then
      FRows.SetParentSize;
  end;
end;

//------------------------------------------------------------------------------

function TAdvDockPanel.GetPopupMenuEx: TPopupMenu;
begin
  Result := Inherited PopupMenu;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetPopupMenuEx(const Value: TPopupMenu);
begin
  Inherited PopupMenu := Value;
  if Assigned(PopupMenu) and (PopupMenu is TAdvPopupMenu) and Assigned(FCurrentToolBarStyler) then
    TAdvPopupMenu(PopupMenu).MenuStyler := FCurrentToolBarStyler.CurrentAdvMenuStyler;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.CMShowingChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetLockHeight(const Value: Boolean);
begin
  if FLockHeight <> Value then
  begin
    FLockHeight := Value;
  end;
end;

//------------------------------------------------------------------------------

function TAdvDockPanel.IsAllowedInAnyRow(
  aAdvToolBar: TAdvCustomToolBar): Integer;
var
  i: Integer;
begin
  Result := -1;
  case Align of
    daTop, daLeft:
    begin
      for i:= FRows.Count-1 downto 0 do
      begin
        if FRows.Items[i].IsAllowed(aAdvToolBar) then
        begin
          Result := i;
          Break;
        end;
      end;
    end;
    daBottom, daRight:
    begin
      for i:= 0 to FRows.Count-1 do
      begin
        if FRows.Items[i].IsAllowed(aAdvToolBar) then
        begin
          Result := i;
          Break;
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvDockPanel.SetUseRunTimeHeight(const Value: Boolean);
begin
  if FUseRunTimeHeight <> Value then
  begin
    FUseRunTimeHeight := Value;
    FRows.SetRowsPosition;
  end;
end;

//------------------------------------------------------------------------------

{ TAdvCustomToolBar }

procedure TAdvCustomToolBar.AlignControls(AControl: TControl;
  var ARect: TRect);
begin
  inherited;

  if AControl <> nil then
    //if FindControlItem(AControl)<> nil then
    //begin
      //FItems.AddNewControlItem(AControl);
      //SetItemsPosition;
    //end;

    if not FInternalControlPositioning then
    begin
      if (AControl <> nil) then
        AdjustControl(AControl)
      else
        SetControlsPosition;
    end;
end;

//------------------------------------------------------------------------------

constructor TAdvCustomToolBar.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls] - [csOpaque];
  Height := DEFAULT_TOOLBARHEIGHT;
  FMinLength := DEFAULT_MINLENGTH;
  Constraints.MinWidth := FMinLength;
  FOwner := AOwner;

  FInternalToolBarStyler := TCustomAdvToolBarStyler.Create(self);
  FInternalToolBarStyler.Name := 'InternalStyler';
  //FInternalToolBarStyler.GradientDirection:= gdVertical;
  //FToolBarStyler := FInternalToolBarStyler;
  FToolBarStyler := nil;
  FCurrentToolBarStyler := FInternalToolBarStyler;
  FInternalToolBarStyler.AddControl(self);
  {$IFDEF DELPHI6_LVL}
  FInternalToolBarStyler.SetSubComponent(True);
  {$ENDIF}

  FATBControls := TDbgList.Create;
  FRUControls := TDbgList.Create;
  FLUHidedControls := TDbgList.Create;
  FAutoRUL := true;

  FParentStyler := True;
  FDragGripWidth := 7;
  FPopupIndicatorWidth := DEFAULT_POPUPINDICATORWIDTH;//14;
  FCurrentDock := nil;
  FPosition := daTop;
  FRow := -1;
  FToolBarState := tsDocked;

  FDockableTo := [daLeft, daTop, daRight, daBottom];
  FFloatingWindow := nil;

  FCaption := '';
  FCaptionFont := TFont.Create;
  ShowPopupIndicator := true;
  ShowOptionIndicator := true;
  FShowClose := true;
  FCaptionHeight := DEFAULT_CAPTIONHEIGHT;

  FFloatingRows := 1;
  FSizeAtDock := Height;

  FShowRightHandle := true;
  FMaxLength := Constraints.MinWidth;

  FPersistence:= TPersistence.Create(self);
  FPersistence.Section:= TOOLBAR_SECTION;
  //----
  Constraints.MaxWidth := Constraints.MinWidth;
  //----

  ShowHint := True;

  FTempMenuItemCount := 0;
  FHotButton := nil;

  FAllowFloating := True;
  FLocked := False;

  DoubleBuffered := true;

  FAutoOptionMenu := False;
  FOptionWindow := nil;
  FOptionWindowPanel := nil;

  FTextAutoOptionMenu := 'Add or Remove Buttons';
  FTextOptionMenu := 'Options';

  FAutoArrangeButtons := True;
  FTimerID := 0;

  FMergedMenu := nil;

  FAutoMDIButtons := False;
  FMDIChildForm := nil;

  FMenuItemTimer := TTimer.Create(self);
  FMenuItemTimer.Interval := 1;
  FMenuItemTimer.Enabled := False;
  FMenuItemTimer.OnTimer := MenuItemTimerOnTime;

  FNextMenuHotButton := nil;
end;

//------------------------------------------------------------------------------

destructor TAdvCustomToolBar.Destroy;
begin
  if FPersistence.Enabled and not (csDesigning in ComponentState) then
    SavePosition;

  FInternalToolBarStyler.Free;
  FCaptionFont.Free;

  FLUHidedControls.Free;
  FRUControls.Free;
  FATBControls.Free;
  FPersistence.Free;

  //if Assigned(FOptionWindowPanel) then   // do not destroy, parent is responsible to destroy
  //  FOptionWindowPanel.Free;

  if Assigned(FOptionWindow) then
    FOptionWindow.Free;

  FMenuItemTimer.Free;

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.BuildSequenceControlList;
var
  i, j, ToIndex: integer;
begin
  if FATBControls = nil then
    FATBControls := TDbgList.Create;

  FATBControls.Clear;
  for i := 0 to self.ControlCount - 1 do
  begin
    ToIndex := 0;
    for j := FATBControls.Count - 1 downto 0 do
    begin
      if Position in [daTop, daBottom] then
      begin
        if self.Controls[i].Left >= TControl(FATBControls[j]).Left then
        begin
          ToIndex := j + 1;
          break;
        end;
      end
      else //Position in [daLeft, daRight] then
      begin
        if self.Controls[i].Top >= TControl(FATBControls[j]).Top then
        begin
          ToIndex := j + 1;
          break;
        end;
      end;
    end;
    FATBControls.Insert(ToIndex, self.Controls[i]);
  end;

  if FAutoRUL then
  begin
    FRUControls.Clear;
    {$IFDEF DELPHI6_LVL}
    FRUControls.Assign(FATBControls, laCopy);
    {$ENDIF}
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.Loaded;
var
  i: Integer;
begin
  inherited;
  FOldCursor := Cursor;

  BuildSequenceControlList;
  SetControlsPosition;

  if FPersistence.Enabled and not (csDesigning in ComponentState) then
    LoadPosition;

  if (csDesigning in ComponentState) then
  begin
    if Assigned(FMenu) then
      FMenuImages := FMenu.Images;
    FTempMenuItemCount := 0;
  end;

  if Assigned(FMenu) then
  begin
    for i := 0 to FATBControls.Count - 1 do
    begin
      if TControl(FATBControls[i]) is TAdvToolBarMenuButton then
        TAdvToolBarMenuButton(FAtbControls[i]).AdjustSize;
    end;
  end;

  if AutoMDIButtons then
  begin
    FAutoMDIButtons := False;
    AutoMDIButtons := True;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  if (Operation = opInsert) then
  begin
   { if AComponent is TControl then
      if TControl(AComponent).Parent = self then
        Caption:= 'ddd'+ TControl(AComponent).Name;
      }
  end;

  if not (csDestroying in ComponentState) and (Operation = opRemove) then
  begin
    if (AComponent = FImages) then
    begin
      Images := nil;
      //SetItemsPosition;
      Invalidate;
    end;

    if (AComponent = ToolBarStyler) then
      ToolBarStyler := nil;
    if (AComponent = OptionMenu) then
      FOptionMenu := nil;

    if (AComponent is TControl) then
      RemoveControl(TControl(AComponent));

    if (AComponent is TMainMenu) and (AComponent = FMergedMenu) then
      UnmergeMenu(FMergedMenu);
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.FWCloseBtnRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
  if (ToolBarState = tsFloating) and ShowClose then
  begin
    Result := GetCaptionRect;
    Result := Rect(Result.Right - CaptionHeight - 1, Result.Top, Result.Right - 1, Result.Bottom);
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.FWCustomizedBtnRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
  if (ToolBarState = tsFloating) and ShowOptionIndicator then
  begin
    if ShowClose then
    begin
      Result := FWCloseBtnRect;
      Result := Rect(Result.Left - CaptionHeight - 2, Result.Top, Result.Left - 2, Result.Bottom);
    end
    else
    begin
      Result := GetCaptionRect;
      Result := Rect(Result.Right - CaptionHeight - 1, Result.Top, Result.Right - 1, Result.Bottom);
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetCaptionRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
  if ToolBarState = tsFloating then
  begin
    Result := ClientRect;
    Result.Bottom := Result.Top + CaptionHeight;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetMyClientRect: TRect;
begin
  Result := ClientRect;
  if ToolBarState = tsFloating then
    Result.Top := GetCaptionRect.Bottom {+1};
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.Paint;
var
  R, CapR, TextR, SegR: TRect;
  c, ro, i: integer;
  //rgn1: HRGN;
  HorzGradient: boolean;
 { SaveIndex: integer;
  aDC: HDC;
  R2: TRect; }
  GSteps: Integer;
  GRounded: Boolean;
  GColorFrom: TColor;
  GColorTo: TColor;
begin
  inherited;

  R := GetMyClientRect; // ClientRect;
  CapR := GetCaptionRect;

  with FCurrentToolBarStyler, Canvas do
  begin
    // float style painting
    if ToolBarState = tsFloating then
    begin
      if (CaptionColor <> clNone) or (CaptionColorTo <> clNone) then
      begin
        if (CaptionColor <> clNone) and (CaptionColorTo <> clNone) then
          DrawGradient(Canvas, CaptionColor, CaptionColorTo, 80, CapR, false)
        else
        begin
          Pen.Color := CaptionColor;
          Brush.Color := CaptionColor;
          Rectangle(CapR);
        end;
      end;

      if CaptionBorderColor <> clNone then
      begin
        Pen.Color := CaptionBorderColor;
        Brush.Style := bsClear;
        Rectangle(CapR);
      end;

      if Caption <> '' then
      begin
        Canvas.Font.Assign(CaptionFont);
        Canvas.Font.Color := CaptionTextColor;
        if ShowOptionIndicator then
          TextR := Rect(CapR.Left + 3, CapR.Top, FWCustomizedBtnRect.Left, CapR.Bottom)
        else if ShowClose then
          TextR := Rect(CapR.Left + 3, CapR.Top, FWCloseBtnRect.Left, CapR.Bottom)
        else
          TextR := Rect(CapR.Left + 3, CapR.Top, CapR.Right, CapR.Bottom);
        DrawText(Canvas.Handle, PChar(Caption), -1, TextR, DT_SINGLELINE or DT_VCENTER);
      end;

      DrawCustomizedBtn;
      DrawCloseBtn;
    end;

    R := Rect(R.Left, R.Top, R.Right + 1, R.Bottom + 1);

    if RoundEdges then
    begin
     { rgn1 := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 12, 12);
      SelectClipRgn(Canvas.Handle, rgn1); }
    end;

    HorzGradient := Color.Direction = gdHorizontal;

    if (Position in [daLeft, daRight]) and not ParentStyler then
      HorzGradient := not HorzGradient;

    GRounded := RoundEdges;
    GSteps := Color.Steps;
    GColorFrom := Color.Color;
    GColorTo := Color.ColorTo;

    if FullSize then
    begin
      HorzGradient := not HorzGradient;
      GSteps := 256;
      GColorFrom := DockColor.Color;
      GColorTo := DockColor.ColorTo;

      if ToolBarState = tsFloating then
      begin
        GColorTo := DockColor.Color;
        GColorFrom := DockColor.Color;
      end;
      GRounded := False;
    end;

    if not Transparent then
    begin
      if Color.ColorTo <> clNone then
      begin
        if (ToolBarState in [tsDocked, tsFixed]) or ((ToolBarState = tsFloating) and (FFloatingRows = 1)) then
          DrawGradient(Canvas, GColorFrom, GColorTo, GSteps, R, HorzGradient)
        else
        begin
          SegR := Rect(R.Left, R.Top, R.Right, R.Top + FSizeAtDock);
          for i := 1 to FFloatingRows do
          begin
            DrawGradient(Canvas, GColorFrom, GColorTo, GSteps, SegR, HorzGradient);
            SegR.Top := SegR.Top + FSizeAtDock;
            SegR.Bottom := SegR.Bottom + FSizeAtDock;
          end;
        end;
      end
      else
      begin
        Pen.Color := Color.Color;
        Brush.Color := Color.Color;
        Rectangle(R);
      end;

      if not BackGround.Empty then
      begin
         // have to shift to on change event
         //set color
       { if BackGroundTransparent then
        begin
          BackGround.Transparent:= true;
          BackGround.TransparentMode:= tmAuto;
        end;  }
        case BackGroundDisplay of
          bdTile:
            begin
              c := 1;
              ro := 1;
              while ro < Height - 2 do
              begin
                while c < width - 2 do
                begin
                  Canvas.Draw(c, ro, BackGround);
                  c := c + BackGround.Width;
                end;
                c := 1;
                ro := ro + BackGround.Height;
              end;
            end;
          bdCenter:
            begin
              Canvas.Draw((Width - BackGround.Width) div 2, (Height - BackGround.Height) div 2, BackGround);
            end;
          bdStretch:
            begin
              Canvas.StretchDraw(Rect(R.Left + 2, R.Top + 2, R.Right - 2, R.Bottom - 2), BackGround);
            end;
        end;
      end;

    end
    else // Transparent
    begin
      //Canvas.CopyRect(R, FcurrentDock.getMyImage.Canvas, Rect(Left, Top, Left+Width, Top+Height));
      (*  SaveIndex:= SaveDC(self.Canvas.Handle);
      if FcurrentDock.GetMyImage.Palette <> 0 then
      begin
        SelectPalette(self.Canvas.Handle, FcurrentDock.GetMyImage.Palette, true);
        RealizePalette(self.Canvas.Handle);
      end;
      aDC := CreateCompatibleDC(self.Canvas.Handle);
      SelectObject(aDC, FcurrentDock.GetMyImage.Handle);
      R2:= R;
      {while R2.Left < R2.Right do
      begin
        while R2.Top < R2.Bottom do
        begin  }
          BitBlt(self.Canvas.Handle, R2.Left, R2.Top, R2.Right-R2.Left, Height, aDc, Left, Top, SRCCOPY);
      {    Inc(R2.Top, 16);
        end;
        R2.Top:= R.Top;
        Inc(R2.Left, 16);
      end;  }
      if aDC <> 0 then
        DeleteDC(aDC);
      RestoreDC(self.Canvas.Handle, SaveIndex); *)
    end;

    if FUseBevel then
    begin
      if ToolbarState <> tsFloating then
      begin
        case FBevel of
          bvRaised, bvSpace:
          begin
            Pen.Color := clWhite;
            MoveTo(0, Height);
            LineTo(0, 0);
            LineTo(Width, 0);

            Pen.Color := clBtnShadow;
            MoveTo(Width-1, 0);
            LineTo(Width-1, Height-1);
            LineTo(0, Height-1);
          end;
          bvLowered:
          begin
            Pen.Color := clBtnShadow;
            MoveTo(1, Height);
            LineTo(1, 1);
            LineTo(Width, 1);

            Pen.Color := clWhite;
            MoveTo(Width-1, 1);
            LineTo(Width-1, Height-1);
            LineTo(1, Height-1);
          end;
          bvNone:
          begin
          end;
        end;
      end;
    end;

    DrawMDIButtons;
    DrawDragGrip;
    DrawPopupIndicator;

    if GRounded and (Bevel = bvNone) then
    begin
      if Assigned(FCurrentDock) and (self.parent is TAdvDockPanel) then
      begin
        if Position in [daTop, daBottom] then
        begin
          Canvas.Pixels[R.Left, R.Top] := FCurrentDock.Canvas.Pixels[self.Left - 1, self.Top - 1];
          Canvas.Pixels[R.Left + 1, R.Top] := FCurrentDock.Canvas.Pixels[self.Left + 1, self.Top - 1];
          Canvas.Pixels[R.Left, R.Top + 1] := FCurrentDock.Canvas.Pixels[self.Left - 1, self.Top];

          Canvas.Pixels[R.Left, R.Bottom - 2] := FCurrentDock.Canvas.Pixels[self.Left - 1, self.Top + Height];
          Canvas.Pixels[R.Left + 1, R.Bottom - 2] := FCurrentDock.Canvas.Pixels[self.Left - 1, self.Top + Height];
          Canvas.Pixels[R.Left, R.Bottom - 3] := FCurrentDock.Canvas.Pixels[self.Left - 1, self.Top + Height];

          if not ShowRightHandle and (ToolBarState <> tsFloating) and not FullSize then
          begin
            Canvas.Pixels[R.Right - 2, R.Top] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top];
            Canvas.Pixels[R.Right - 3, R.Top] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 2, self.Top];
            Canvas.Pixels[R.Right - 2, R.Top + 1] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top];

            Canvas.Pixels[R.Right - 2, R.Bottom - 2] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top + Height];
            Canvas.Pixels[R.Right - 3, R.Bottom - 2] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 2, self.Top + Height];
            Canvas.Pixels[R.Right - 2, R.Bottom - 3] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top + Height];
          end;

        end
        else
        begin
          Canvas.Pixels[R.Left, R.Top] := FCurrentDock.Canvas.Pixels[self.Left - 1, self.Top - 1];
          Canvas.Pixels[R.Left + 1, R.Top] := FCurrentDock.Canvas.Pixels[self.Left + 1, self.Top - 1];
          Canvas.Pixels[R.Left, R.Top + 1] := FCurrentDock.Canvas.Pixels[self.Left - 1, self.Top];

          Canvas.Pixels[R.Right - 1, R.Top] := FCurrentDock.getmyImage.Canvas.Pixels[self.Left + Width, self.Top]; //FCurrentDock.Canvas.Pixels[self.Left+ Width+1, self.Top];
          Canvas.Pixels[R.Right - 2, R.Top] := FCurrentDock.getmyImage.Canvas.Pixels[self.Left + Width - 1, self.Top]; //FCurrentDock.Canvas.Pixels[self.Left+ Width+1, self.Top];
          Canvas.Pixels[R.Right - 1, R.Top + 1] := FCurrentDock.getmyImage.Canvas.Pixels[self.Left + Width, self.Top + 1]; //FCurrentDock.Canvas.Pixels[self.Left+ Width+1, self.Top];

          if not ShowRightHandle and (ToolBarState <> tsFloating) and not FullSize then
          begin
            Canvas.Pixels[R.Left, R.Bottom - 2] :=  FCurrentDock.GetMyImage.Canvas.Pixels[self.Left {-1} + 1, self.Top + Height];
            Canvas.Pixels[R.Left + 1, R.Bottom - 2] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left {-1} + 2, self.Top + Height];
            Canvas.Pixels[R.Left, R.Bottom - 3] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left {-1} + 1, self.Top + Height];

            Canvas.Pixels[R.Right - 2, R.Bottom - 2] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top + Height];
            Canvas.Pixels[R.Right - 3, R.Bottom - 2] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 2, self.Top + Height];
            Canvas.Pixels[R.Right - 2, R.Bottom - 3] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top + Height];
          end;

        end;

       {
        Canvas.Pixels[R.Right-2, R.Top]:= FCurrentDock.Canvas.Pixels[self.Left+Width+1, self.Top];
        Canvas.Pixels[R.Right-3, R.Top]:= FCurrentDock.Canvas.Pixels[self.Left+Width+1, self.Top];
        Canvas.Pixels[R.Right-2, R.Top+1]:= FCurrentDock.Canvas.Pixels[self.Left+Width+1, self.Top];

        Canvas.Pixels[R.Right-2, R.Bottom-2]:= FCurrentDock.Canvas.Pixels[self.Left+Width+1, self.Top + Height];
        Canvas.Pixels[R.Right-3, R.Bottom-2]:= FCurrentDock.Canvas.Pixels[self.Left+Width+1, self.Top + Height];
        Canvas.Pixels[R.Right-2, R.Bottom-3]:= FCurrentDock.Canvas.Pixels[self.Left+Width+1, self.Top + Height];
       }
      end;
     { SelectClipRgn(Canvas.Handle, 0);
      DeleteObject(rgn1);  }
    end;
  end; // with
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.DrawDragGrip;
var
  R: TRect;

  procedure DrawDots(ARect: TRect);
  var
    i: integer;
  begin
    if Position in [daTop, daBottom] then
    begin
      ARect.Left := ARect.Left + 3;
      ARect.Top := ARect.Top + 4;
      for i := 1 to (ARect.Bottom - 8) div 4 do
      begin
        Canvas.Brush.Color := clWhite;
        Canvas.Pen.Color := clWhite;
        Canvas.Rectangle(ARect.Left + 1, ARect.Top + 1, ARect.Left + 3, ARect.Top + 3);

        Canvas.Brush.Color := clBtnShadow;
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Rectangle(ARect.Left, ARect.Top, ARect.Left + 2, ARect.Top + 2);
        ARect.Top := ARect.Top + 4;
      end;
    end
    else //if Position in [daLeft, daRight] then
    begin
      ARect.Left := ARect.Left + 4;
      ARect.Top := ARect.Top + 3;
      for i := 1 to (ARect.Right - 8) div 4 do
      begin
        Canvas.Brush.Color := clWhite;
        Canvas.Pen.Color := clWhite;
        Canvas.Rectangle(ARect.Left + 1, ARect.Top + 1, ARect.Left + 3, ARect.Top + 3);

        Canvas.Brush.Color := clBtnShadow;
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Rectangle(ARect.Left, ARect.Top, ARect.Left + 2, ARect.Top + 2);
        ARect.Left := ARect.Left + 4;
      end;
    end;
  end;

  procedure DrawLines(ARect: TRect; DoubleLine: Boolean);
  begin
    if DoubleLine then
    begin
      if Position in [daTop, daBottom] then
      begin
        Draw3DLine(Canvas, Point(ARect.Left + 2, ARect.Bottom - 4), Point(ARect.Left + 2, ARect.Top + 3), true);
        Draw3DLine(Canvas, Point(ARect.Left + 5, ARect.Bottom - 4), Point(ARect.Left + 5, ARect.Top + 3), true);
      end
      else
      begin
        Draw3DLine(Canvas, Point(ARect.Left + 3, ARect.Top + 2), Point(ARect.Right - 5, ARect.Top + 2), true, false);
        Draw3DLine(Canvas, Point(ARect.Left + 3, ARect.Top + 5), Point(ARect.Right - 5, ARect.Top + 5), true, false);
      end;
    end
    else
    begin
      if Position in [daTop, daBottom] then
        Draw3DLine(Canvas, Point(ARect.Left + 4, ARect.Bottom - 4), Point(ARect.Left + 4, ARect.Top + 3), true)
      else
        Draw3DLine(Canvas, Point(ARect.Left + 3, ARect.Top + 4), Point(ARect.Right - 5, ARect.Top + 4), true, false);
    end;
  end;

  procedure DrawFlatDots(ARect: TRect);
  var
    i: integer;
  begin
    if Position in [daTop, daBottom] then
    begin
      ARect.Left := ARect.Left + 1;
      ARect.Top := ARect.Top + 3;
      for i := 1 to (ARect.Bottom - 8) div 2 do
      begin
        Canvas.Pen.Color := RGB(165, 165, 165);
        Canvas.MoveTo(ARect.Left + 1, ARect.Top + 1);
        Canvas.LineTo(ARect.Left + 4, ARect.Top + 1);
        ARect.Top := ARect.Top + 2;
      end;
    end
    else //if Position in [daLeft, daRight] then
    begin
      ARect.Left := ARect.Left + 3;
      ARect.Top := ARect.Top + 1;
      for i := 1 to (ARect.Right - 8) div 2 do
      begin
        Canvas.Pen.Color := RGB(165, 165, 165);
        Canvas.MoveTo(ARect.Left + 1, ARect.Top + 1);
        Canvas.LineTo(ARect.Left + 1, ARect.Top + 4);

        ARect.Left := ARect.Left + 2;
      end;
    end;
  end;

begin
  if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
  begin
    if Position in [daTop, daBottom] then
      R := Rect(1, 1, DragGripWidth, Height)
    else
      R := Rect(1, 1, Width, DragGripWidth);

    with FCurrentToolBarStyler, Canvas do
    begin
      if not DragGripImage.Empty then
      begin
        Canvas.StretchDraw(Rect(R.Left, R.Top, R.Right, R.Bottom), DragGripImage);
      end
      else
      begin
        case DragGripStyle of
          dsDots: DrawDots(R);
          dsSingleLine: DrawLines(R, false);
          dsDoubleLine: DrawLines(R, true);
          dsFlatDots: DrawFlatDots(R);
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
// Color : 129, 129, 129
// ColorTo: 161, 161, 161

procedure TAdvCustomToolBar.DrawPopupIndicator;
var
  R: TRect;
  //rgn1, rgn2: HRGN;
  clr, clrto, brClr: TColor;

  procedure DrawScrollArrows(R: TRect);
  begin
    if CanExpand <= 0 then
      exit;

    with Canvas do
    begin
      if Position in [daTop, daBottom] then
      begin
        //  |_
        //  |
        Pen.Color := clBlack;
        moveto(R.Right - 6, R.Top + 5);
        LineTo(R.Right - 6, R.Top + 8);
        moveto(R.Right - 6, R.Top + 6);
        LineTo(R.Right - 4, R.Top + 6);
        //  |_
        //  |
        moveto(R.Right - 10, R.Top + 5);
        LineTo(R.Right - 10, R.Top + 8);
        moveto(R.Right - 10, R.Top + 6);
        LineTo(R.Right - 8, R.Top + 6);

        //  |-
        Pen.Color := clWhite;
        moveto(R.Right - 5, R.Top + 7);
        LineTo(R.Right - 5, R.Top + 9);
        moveto(R.Right - 5, R.Top + 7);
        LineTo(R.Right - 3, R.Top + 7);
        //  |-
        moveto(R.Right - 9, R.Top + 7);
        LineTo(R.Right - 9, R.Top + 9);
        moveto(R.Right - 9, R.Top + 7);
        LineTo(R.Right - 7, R.Top + 7);
      end
      else
      begin
        //  -|-
        Pen.Color := clBlack;
        moveto(R.Left + 5, R.Top + 5);
        LineTo(R.Left + 8, R.Top + 5);
        moveto(R.Left + 6, R.Top + 5);
        LineTo(R.Left + 6, R.Top + 7);
        //  -|-
        moveto(R.Left + 5, R.Top + 9);
        LineTo(R.Left + 8, R.Top + 9);
        moveto(R.Left + 6, R.Top + 9);
        LineTo(R.Left + 6, R.Top + 11);
        //  |-
        Pen.Color := clWhite;
        moveto(R.Left + 7, R.Top + 6);
        LineTo(R.Left + 9, R.Top + 6);
        moveto(R.Left + 7, R.Top + 6);
        LineTo(R.Left + 7, R.Top + 8);
        //  |-
        moveto(R.Left + 7, R.Top + 10);
        LineTo(R.Left + 9, R.Top + 10);
        moveto(R.Left + 7, R.Top + 10);
        LineTo(R.Left + 7, R.Top + 12);
      end;
    end;
  end;

  procedure DrawFlatScrollArrows(R: TRect);
  begin
    if CanExpand <= 0 then
      exit;

    with Canvas do
    begin
      Pen.Color:= clBlack;
      if Position in [daTop, daBottom] then
      begin
        MoveTo(R.Left + 8, R.Top + 3);
        LineTo(R.Left + 11, R.Top + 6);
        MoveTo(R.Left + 11, R.Top + 6);
        LineTo(R.Left + 7, R.Top + 10);

        MoveTo(R.Left + 6, R.Top + 3);
        LineTo(R.Left + 9, R.Top + 6);
        MoveTo(R.Left + 9, R.Top + 6);
        LineTo(R.Left + 5, R.Top + 10);
      end
      else // Position in [daLeft, daRight] then
      begin
        MoveTo(R.Left + 3, R.Top + 6);
        LineTo(R.Left + 5, R.Top + 8);
        MoveTo(R.Left + 5, R.Top + 8);
        LineTo(R.Left + 8, R.Top + 5);

        MoveTo(R.Left + 3, R.Top + 8);
        LineTo(R.Left + 5, R.Top + 10);
        MoveTo(R.Left + 5, R.Top + 10);
        LineTo(R.Left + 8, R.Top + 7);
      end;
    end;
  end;

  procedure DrawOptionsIndicator(R: TRect);
  begin
    if not ShowOptionIndicator then
      Exit;

    with Canvas do
    begin
      if Position in [daTop, daBottom] then
      begin
        Pen.Color := clBlack;
        moveto(R.Right - 9, R.Bottom - 11);
        LineTo(R.Right - 4, R.Bottom - 11);

        moveto(R.Right - 9, R.Bottom - 8);
        LineTo(R.Right - 4, R.Bottom - 8);
        moveto(R.Right - 8, R.Bottom - 7);
        LineTo(R.Right - 5, R.Bottom - 7);
        Pixels[R.Right - 7, R.Bottom - 6] := clBlack;

        Pen.Color := clWhite;
        moveto(R.Right - 8, R.Bottom - 10);
        LineTo(R.Right - 3, R.Bottom - 10);

        moveto(R.Right - 5, R.Bottom - 7);
        LineTo(R.Right - 3, R.Bottom - 7);
        moveto(R.Right - 6, R.Bottom - 6);
        LineTo(R.Right - 4, R.Bottom - 6);
        Pixels[R.Right - 6, R.Bottom - 5] := clWhite;
      end
      else
      begin
        Pen.Color := clBlack;
        moveto(R.Right - 9, R.Top + 5);
        LineTo(R.Right - 9, R.Top + 10);

        moveto(R.Right - 6, R.Top + 5);
        LineTo(R.Right - 6, R.Top + 10);
        moveto(R.Right - 5, R.Top + 6);
        LineTo(R.Right - 5, R.Top + 9);
        Pixels[R.Right - 4, R.Top + 7] := clBlack;

        Pen.Color := clWhite;
        moveto(R.Right - 8, R.Top + 6);
        LineTo(R.Right - 8, R.Top + 11);

        moveto(R.Right - 5, R.Top + 9);
        LineTo(R.Right - 5, R.Top + 11);
        moveto(R.Right - 4, R.Top + 8);
        LineTo(R.Right - 2, R.Top + 8);
        Pixels[R.Right - 4, R.Top + 9] := clWhite;
      end;
    end;
  end;

  procedure DrawFlatOptionsIndicator(R: TRect);
  begin
    if not ShowOptionIndicator then
      Exit;

    with Canvas do
    begin
      if Position in [daTop, daBottom] then
      begin
        Pen.Color := clBlack;
        moveto(R.Right - 9, R.Bottom - 9);
        LineTo(R.Right - 4, R.Bottom - 9);

        moveto(R.Right - 9, R.Bottom - 7);
        LineTo(R.Right - 4, R.Bottom - 7);
        moveto(R.Right - 8, R.Bottom - 6);
        LineTo(R.Right - 5, R.Bottom - 6);
        Pixels[R.Right - 7, R.Bottom - 5] := clBlack;
      end
      else
      begin
        Pen.Color := clBlack;
        moveto(R.Right - 9, R.Top + 6);
        LineTo(R.Right - 9, R.Top + 11);

        moveto(R.Right - 6, R.Top + 6);
        LineTo(R.Right - 6, R.Top + 11);
        moveto(R.Right - 5, R.Top + 7);
        LineTo(R.Right - 5, R.Top + 10);
        Pixels[R.Right - 4, R.Top + 8] := clBlack;
      end;
    end;
  end;

begin
  if ShowPopupIndicator and ShowRightHandle and (ToolBarState <> tsFloating) and not FullSize then
  begin
    if Position in [daTop, daBottom] then
      R := Rect(Width - PopupIndicatorWidth, 0, Width + 1, Height + 1)
    else
      R := Rect(0, Height - PopupIndicatorWidth, Width, Height);

    {
    if FCurrentToolBarStyler.Style = bsOffice2000 then
    begin
      if Position in [daTop, daBottom] then
        R := Rect(R.Left, R.Top+1, R.Right - 2, R.Bottom -2)
      else
        R := Rect(R.Left+1, R.Top+1, R.Right-1, R.Bottom);
    end;
    }
    if not FCurrentToolBarStyler.RoundEdges then
    begin
      if Position in [daTop, daBottom] then
        R := Rect(R.Left-1, R.Top+1, R.Right - 2, R.Bottom -2)
      else
        R := Rect(R.Left+1, R.Top, R.Right-1, R.Bottom-1);

    end;

    if FDownPopupIndicator or (Assigned(FOptionWindow) and (FOptionWindow.Visible)) then
    begin
      clr := FCurrentToolBarStyler.RightHandleColorDown;
      clrto := FCurrentToolBarStyler.RightHandleColorDownTo;
      brClr := FCurrentToolBarStyler.ButtonAppearance.BorderDownColor;
    end
    else if FHotPopupIndicator then
    begin
      clr := FCurrentToolBarStyler.RightHandleColorHot;
      clrto := FCurrentToolBarStyler.RightHandleColorHotTo;
      brClr := FCurrentToolBarStyler.ButtonAppearance.BorderHotColor;
    end
    else
    begin
      clr := FCurrentToolBarStyler.RightHandleColor;
      clrto := FCurrentToolBarStyler.RightHandleColorTo;
      brClr := FCurrentToolBarStyler.ButtonAppearance.BorderColor;
    end;

    with FCurrentToolBarStyler, Canvas do
    begin
      if not RightHandleImage.Empty then
      begin
        Canvas.StretchDraw(Rect(R.Left, R.Top, R.Right, R.Bottom), RightHandleImage);
      end
      else
      begin
        //case FCurrentToolBarStyler.Style of
          //bsOffice2003Blue, bsOffice2003Silver, bsOffice2003Olive:
          //begin
            // Draw BackGround
        if (Clr <> clNone) and (ClrTo <> clNone) then
        begin
          Pen.Color := clr;
          Brush.Color := clr;
          if Position in [daTop, daBottom] then
          begin
            DrawGradient(Canvas, clr, clrto, 16, Rect(R.Left + 3, R.Top, R.Right, R.Bottom), false);
            //Rectangle(R.Left + 3, R.Top, R.Right, R.Bottom);
          end
          else
          begin
            DrawGradient(Canvas, clr, clrto, 16, Rect(R.Left, R.Top + 3, R.Right, R.Bottom), true);
            //Rectangle(R.Left, R.Top + 3, R.Right, R.Bottom);
          end;
        end
        else
        begin
          Pen.Color := clr;
          Brush.Color := clr;
          if Position in [daTop, daBottom] then
          begin
            Rectangle(R.Left + 3, R.Top, R.Right, R.Bottom);
          end
          else
          begin
            Rectangle(R.Left, R.Top + 3, R.Right, R.Bottom);
          end;
        end;

        if RoundEdges then
        begin
          {
          rgn1 := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 10, 10);
          rgn2 := CreateRectRgn(R.Left, R.Top, R.Left +5, R.Bottom-1);
          CombineRgn(rgn1, rgn1, rgn2, RGN_OR);
          SelectClipRgn(Canvas.Handle, rgn1);

          Pen.Color:= RightHandleColor;
          Brush.Color:= RightHandleColor;
          RoundRect(R.Left-8, R.Top, R.Right, R.Bottom, 12, 12);

          SelectClipRgn(Canvas.Handle, 0);
          DeleteObject(rgn1);
          DeleteObject(rgn2);


          rgn1 := CreateRoundRectRgn(R.Left, R.Top, R.Left+5, R.Bottom, 10, 10);
          rgn2 := CreateRectRgn(R.Left, R.Top, R.Left+1 , R.Bottom-1);
          CombineRgn(rgn1, rgn1, rgn2, RGN_OR);
          SelectClipRgn(Canvas.Handle, rgn1);
          }

          if ClrTo = clNone then
            ClrTo := Clr;
          
          if Position in [daTop, daBottom] then
          begin
            if Assigned(FCurrentDock) and (self.parent is TAdvDockPanel) then
            begin // UnComment Numbers to remove GetMyImage
              Canvas.Pixels[R.Right - 2, R.Top] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top];
              Canvas.Pixels[R.Right - 3, R.Top] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 2, self.Top];
              Canvas.Pixels[R.Right - 2, R.Top + 1] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top];

              Canvas.Pixels[R.Right - 2, R.Bottom - 2] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top + Height];
              Canvas.Pixels[R.Right - 3, R.Bottom - 2] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 2, self.Top + Height];
              Canvas.Pixels[R.Right - 2, R.Bottom - 3] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top + Height];
            end;

            Canvas.Pixels[R.Left + 1, R.Bottom - 2] := clrto;
            Canvas.Pixels[R.Left + 2, R.Bottom - 2] := clrto;
            Canvas.Pixels[R.Left + 2, R.Bottom - 3] := clrto;

            Canvas.Pixels[R.Left + 1, R.Top] := clr;
            Canvas.Pixels[R.Left + 2, R.Top] := clr;
            Canvas.Pixels[R.Left + 2, R.Top + 1] := clr;
          end
          else // if Position in [daLeft, daRight] then
          begin
            if Assigned(FCurrentDock) and (self.parent is TAdvDockPanel) then
            begin
              Canvas.Pixels[R.Left, R.Bottom - 1] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left {-1} + 1, self.Top + Height];
              Canvas.Pixels[R.Left + 1, R.Bottom - 1] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left {-1} + 2, self.Top + Height];
              Canvas.Pixels[R.Left, R.Bottom - 2] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left {-1} + 1, self.Top + Height];

              Canvas.Pixels[R.Right - 1, R.Bottom - 1] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top + Height];
              Canvas.Pixels[R.Right - 2, R.Bottom - 1] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 2, self.Top + Height];
              Canvas.Pixels[R.Right - 1, R.Bottom - 2] := FCurrentDock.GetMyImage.Canvas.Pixels[self.Left + Width {+1} - 1, self.Top + Height];

            end;

          //clr:= clred;

            Canvas.Pixels[R.Left, R.Top + 2] := clr;
            Canvas.Pixels[R.Left + 1, R.Top + 2] := clr;
            Canvas.Pixels[R.Left, R.Top + 1] := clr;

            Canvas.Pixels[R.Right - 1, R.Top + 2] := clrto;
            Canvas.Pixels[R.Right - 2, R.Top + 2] := clrto;
            Canvas.Pixels[R.Right - 1, R.Top + 1] := clrto;

          end;
          //Canvas.Pixels[R.Right-2, R.Bottom-2]:= FCurrentDock.Canvas.Pixels[self.Left+Width+1, self.Top + Height];
          // Canvas.Pixels[R.Right-3, R.Bottom-2]:= FCurrentDock.Canvas.Pixels[self.Left+Width+1, self.Top + Height];
          // Canvas.Pixels[R.Right-2, R.Bottom-3]:= FCurrentDock.Canvas.Pixels[self.Left+Width+1, self.Top + Height];

          {
          if ColorTo <> clNone then
          begin
            if GradientDirection = gdHorizontal then
            begin
              DrawGradient(canvas, Canvas.Pixels[R.Left-8, R.Top+2], ColorTo, GradientStep, Rect(R.Left-8, R.Top, R.Left + 4, R.Bottom), true);
            end
            else
             DrawGradient(canvas, Color, ColorTo, GradientStep, Rect(R.Left-8, R.Top, R.Left + 4, R.Bottom), false);
          end
          else
          begin
            Pen.Color:= Color;
            Brush.Color:= Color;
            RoundRect(R.Left-8, R.Top, R.Left + 4, R.Bottom, 12, 12);
          end;
          SelectClipRgn(Canvas.Handle, 0);
          DeleteObject(rgn1);
          DeleteObject(rgn2);
          }

          //--- Scroll Arrows
          DrawScrollArrows(R);

          //---- Popup Indicator
          DrawOptionsIndicator(R);
        end
        else // if not RoundEdges then
        begin
          if brClr <> clNone then
          begin   // Draw Border
            Pen.Color := brClr;
            Brush.Style := bsClear;
            if Position in [daTop, daBottom] then
            begin
              Rectangle(R.Left + 3, R.Top, R.Right-1, R.Bottom-1);
            end
            else
            begin
              Rectangle(R.Left, R.Top + 3, R.Right, R.Bottom);
            end;
          end;

          //--- Scroll Arrows
          DrawFlatScrollArrows(R);

          //---- Popup Indicator
          DrawFlatOptionsIndicator(R);
        end;
          //end;
        //end;
      end;
    end;

  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.DrawCloseBtn;
var
  R: TRect;
  Clr: TColor;

  procedure DrawCross(R: TRect; Clr: TColor);
  begin
    with Canvas do
    begin
      Pen.Color := Clr;
                     {/}
      MoveTo(R.Left, R.Top + 7);
      LineTo(R.Left + 8, R.Top);
      MoveTo(R.Left + 1, R.Top + 7);
      LineTo(R.Left + 7, R.Top);
                     {\}
      MoveTo(R.Left, R.Top + 1);
      LineTo(R.Left + 8, R.Top + 8);
      MoveTo(R.Left + 1, R.Top + 1);
      LineTo(R.Left + 7, R.Top + 8);

    (*                {/}
      MoveTo(R.Right{Left} -1, R.top+1);//  R.Bottom - 4 - 1);
      LineTo(R.Left -1, R.Bottom);
      MoveTo(R.Right{Left} -1, R.Top); //R.Bottom - 4 - 1);
      LineTo(R.Left, R.Bottom);
                    {\}
      MoveTo(R.Right{Left}-1 , R.Bottom - 1);
      LineTo(R.Left + 1, R.top); // R.Bottom - 5 - 1);
      MoveTo(R.Right{Left} , R.Bottom - 1);
      LineTo(R.Left, R.top); // R.Bottom - 5 - 1);
    *)

    end;
  end;
begin
  if (ToolBarState = tsFloating) and (ShowClose) then
  begin
    R := FWCloseBtnRect;
    with Canvas do
    begin
      if FDownCloseBtn then
      begin
        Pen.Color := clBlack;
        Brush.Color := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.Color;
        Rectangle(R);
        Clr := clWhite;
      end
      else if FHotCloseBtn then
      begin
        Pen.Color := clBlack;
        Brush.Color := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.HoverColor;
        Rectangle(R);
        Clr := clBlack;
      end
      else
      begin
        Pen.Color := FCurrentToolBarStyler.CaptionColor;
        Brush.Color := FCurrentToolBarStyler.CaptionColor;
        Rectangle(R);
        Clr := clWhite;
      end;

      DrawCross(Rect(R.Left + 4, R.Top + 4, R.Right - 4, R.Bottom - 4), Clr);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.DrawCustomizedBtn;
var
  R: TRect;
  Clr: TColor;
begin
  if ToolBarState = tsFloating then
  begin
    R := FWCustomizedBtnRect;
    with Canvas do
    begin
      if FDownCustomizedBtn then
      begin
        Pen.Color := clBlack;
        Brush.Color := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.Color;
        Rectangle(R);
        Clr := clWhite; // TODO: can be replaced
      end
      else if FHotCustomizedBtn then
      begin
        Pen.Color := clBlack;
        Brush.Color := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.HoverColor;
        Rectangle(R);
        Clr := clBlack;
      end
      else
      begin
        Pen.Color := FCurrentToolBarStyler.CaptionColor;
        Brush.Color := FCurrentToolBarStyler.CaptionColor;
        Rectangle(R);
        Clr := clWhite;
      end;

      Canvas.Pen.Color := Clr;
             {-------}
      Canvas.MoveTo(R.Left + 5, R.Bottom - 10);
      Canvas.LineTo(R.Left + 12, R.Bottom - 10);
              {-----}
      Canvas.MoveTo(R.Left + 6, R.Bottom - 9);
      Canvas.LineTo(R.Left + 11, R.Bottom - 9);
               {---}
      Canvas.MoveTo(R.Left + 7, R.Bottom - 8);
      Canvas.LineTo(R.Left + 10, R.Bottom - 8);
                {-}
      Canvas.MoveTo(R.Left + 8, R.Bottom - 7);
      Canvas.LineTo(R.Left + 9, R.Bottom - 7);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetDragGripWidth(const Value: integer);
begin
  FDragGripWidth := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetParent(AParent: TWinControl);
var
  OldHandle: HWND;
  OldParent: TWinControl;
  Docked, UnDocked: Boolean;
  //OldValue: Boolean;
begin
  //inherited;

  OldParent := inherited Parent;

  Docked := false;
  UnDocked := false;

  if AParent <> Parent then
  begin
    if FDraging then
    begin
      OldHandle := 0;
      if Assigned(AParent) then
      begin
        OldHandle := WindowHandle;
        WindowHandle := 0
      end;

      inherited SetParent(nil);

      try
        if OldHandle <> 0 then
        begin
          WindowHandle := OldHandle;
          Windows.SetParent(OldHandle, AParent.Handle);
        end;
        inherited;
      except
        raise;
      end;
    end
    else
      inherited;

    FOldState := FToolBarState;

    if AParent is TAdvDockPanel then
    begin
      if AParent <> FCurrentDock then
      begin
        if FCurrentDock <> nil then
        begin
          FCurrentDock.RemoveToolBar(self);
        end;

        if OldParent is TFloatingWindow then
        begin
          if FTimerID <> 0 then
          begin
            KillTimer(Handle, FTimerID);
            FTimerID := 0;
          end;

          if Position in [daTop, daBottom] then
          begin
            //Height := Height - CaptionHeight;

            Constraints.MinHeight := 0;
            Constraints.MaxHeight := 0;
            Height := FSizeAtDock;
          end;
        end;
        //FCurrentDock:= TAdvDockPanel(AParent);
        //FCurrentDock.AddToolBar(self);
        FToolBarState := tsDocked;
        if TAdvDockPanel(AParent).AddToolBar(self) = -1 then // Will Set FCurrentDock
        begin
          FToolBarState := FOldState; 
        end
        else
        begin
          Docked := true;
          //FToolBarState:= tsDocked;

          FLastDock := TAdvDockPanel(AParent);
          ParentStyler := ParentStyler;

          if FFloatingWindow <> nil then
          begin
            FFloatingWindow.Visible := false;
            //FFloatingWindow:= nil;
          end;
        end;
      end;
    end
    else if AParent is TFloatingWindow then
    begin
      FToolBarState := tsFloating;
      if FCurrentDock <> nil then
      begin
        FCurrentDock.RemoveToolBar(self);
        FCurrentDock := nil;
      end;

      UnDocked := true;
      //OldValue:= FInternalControlPositioning;
      //FInternalControlPositioning:= true;
      if Position in [daLeft, daRight] then
        Position := daTop;
      //FInternalControlPositioning:= OldValue;

      if Position in [daTop, daBottom] then
        Height := Height + CaptionHeight;
    end
    else
    begin
      ParentStyler := false;
      FToolBarState := tsFixed;
    end;

    //SetItemsPosition;
    
    SetControlsPosition;

    if not (csLoading in ComponentState) then
    begin
      if Docked and Assigned(OnDocked) and Assigned(AParent) and (AParent is TAdvDockPanel) then
        FOnDocked(self, TAdvDockPanel(aParent))
      else if UnDocked and Assigned(FOnUnDocked) and Assigned(AParent) and (AParent is TFloatingWindow) then
        FOnUnDocked(self);
    end;
    
  end;

  if (csDesigning in ComponentState) then
  begin
    if (AParent is TAdvDockPanel) then
    begin
      ToolBarStyler := (AParent as TAdvDockPanel).FCurrentToolBarStyler;
    end;
  end; 
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetParentStyler(const Value: Boolean);
begin
  if (FParentStyler <> Value) or Value then
  begin
    FParentStyler := Value;
    ToolBarStyler := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetPopupIndicatorWidth(const Value: integer);
begin
  FPopupIndicatorWidth := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetToolBarStyler(
  const Value: TCustomAdvToolBarStyler);
begin
  if (FToolBarStyler <> Value) or (Value = nil) then
  begin
    if Assigned(FToolBarStyler) and (FToolBarStyler <> FInternalToolBarStyler) then
      FToolBarStyler.RemoveControl(self);

    FToolBarStyler := Value;

    if FParentStyler and Assigned(FLastDock) and not(csDestroying in FLastDock.FCurrentToolBarStyler.ComponentState) then
      FToolBarStyler := FLastDock.FCurrentToolBarStyler;

    if FToolBarStyler = nil then
    begin
      //FToolBarStyler := FInternalToolBarStyler
      FCurrentToolBarStyler := FInternalToolBarStyler;
    end
    else
    begin
      FCurrentToolBarStyler := FToolBarStyler;
      FToolBarStyler.AddControl(self);
    end;

    //FCurrentToolBarStyler := FToolBarStyler;

    AdjustSizeOfAllButtons();
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.UpdateMe(PropID: integer);
begin
  Color := FCurrentToolBarStyler.Color.Color;
  case PropID of
    5: SetControlsPosition;
    6:
    begin
      if not (csLoading in ComponentState) then
        AdjustSizeOfAllButtons(True);
    end;
  end;
  
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetPosition(const Value: TDockAlign);
var
  i: integer;
  //OldPos: TDockAlign;
  OldV: Boolean;
begin
  if FPosition <> Value then
  begin
    //OldPos:= FPosition;
    FPosition := Value;
    OldV := AllowBoundChange;
    AllowBoundChange := true;
{
    if (ToolBarState = tsFloating) or (FOldState = tsFloating) then
    begin
      H := FSizeAtDock;
      W := self.width;
    end
    else
    begin
      H:= self.Height;
      W:= self.Width;
    end;
}
    //FMaxLength := GetMaxLength;   // FF: Control hiding issue when changing DockPanel
    if (Value in [daTop, daBottom]) then
    begin
      //if (OldPos in [daLeft, daRight]) then
      begin
      {  if (csLoading in ComponentState) then
        begin
          Constraints.MinWidth:= FMinLength;
          Constraints.MaxWidth:= FMinLength;
        end
        else
        begin
          Constraints.MinWidth:= Constraints.MinHeight;
          Constraints.MaxWidth:= Constraints.MaxHeight;
        end;
       }
        Constraints.MinHeight := 0;
        Constraints.MaxHeight := 0;
        Constraints.MinWidth := FMinLength;
        Constraints.MaxWidth := FMaxLength;
        Width := FMaxLength;
        Height := FSizeAtDock;

       {
        if (csLoading in ComponentState) then
        begin
          Width:= H;
          Height:= FMinLength;//W;
        end
        else
        begin
          Width:= H;
          Height:= W;
        end;
        }
      end;
    end
    else if (Value in [daLeft, daRight]) then
    begin
      //if (OldPos in [daTop, daBottom]) then
      begin
       { if (csLoading in ComponentState) then
        begin
          Constraints.MinHeight:= FMinLength; //Constraints.MinWidth;
          Constraints.MaxHeight:= FMinLength; //Constraints.MaxWidth;
        end
        else
        begin
          Constraints.MinHeight:= Constraints.MinWidth;
          Constraints.MaxHeight:= Constraints.MaxWidth;
        end;
        }
        Constraints.MinWidth := 0;
        Constraints.MaxWidth := 0;
        Constraints.MinHeight := FMinLength;
        Constraints.MaxHeight := FMaxLength;
        Width := FSizeAtDock;
        Height := FMaxLength;

        {
        if (csLoading in ComponentState) then
        begin
          Width:= H;
          Height:= FMinLength;//W;
        end
        else
        begin
          Width:= H;
          Height:= W;
        end;
        }
      end;
    end;

    AllowBoundChange := OldV;

    OldV := FInternalControlPositioning;
    FInternalControlPositioning := true;
    for i := 0 to FATBControls.Count - 1 do
    begin
      if TControl(FATBControls[i]) is TAdvCustomToolBarControl then
        TAdvCustomToolBarControl(FAtbControls[i]).Position := Value;
    end;
    FInternalControlPositioning := OldV;

    FMaxLength := GetMaxLength;   // FF: Control hiding issue when changing DockPanel
    if (Value in [daTop, daBottom]) then
    begin
      Constraints.MinWidth := FMinLength;
      Constraints.MaxWidth := FMaxLength;
      Width := FMaxLength;
    end
    else if (Value in [daLeft, daRight]) then
    begin
      Constraints.MinHeight := FMinLength;
      Constraints.MaxHeight := FMaxLength;
      Height := FMaxLength;
    end;
    SetControlsPosition(false);

    UpdateRULists;  // to make sure control hide/unhide correctly
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.WMEraseBkGnd(var Msg: TMessage);
begin
  Msg.Result := 1;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CMMouseLeave(var Message: TMessage);
var
  R: TRect;
begin
  inherited;

  if not FDraging then
    if self.Cursor = crSizeAll then
      self.Cursor := FOldCursor;

  if FHotPopupIndicator or FDownPopupIndicator then
  begin
    FHotPopupIndicator := false;
    FDownPopupIndicator := false;
    DrawPopupIndicator;
  end;

  if ToolBarState = tsFloating then
  begin
    if FDownCustomizedBtn or FHotCustomizedBtn then
    begin
      FDownCustomizedBtn := false;
      FHotCustomizedBtn := false;
      DrawCustomizedBtn;
    end;
    if FDownCloseBtn or FHotCloseBtn then
    begin
      FDownCloseBtn := false;
      FHotCloseBtn := false;
      DrawCloseBtn;
    end;
  end  // not Floating
  else
  begin

    if FMDIDownCloseBtn or FMDIHotCloseBtn then
    begin
      FMDIDownCloseBtn := false;
      FMDIHotCloseBtn := False;
      R := GetMDICloseBtnRect;
      InvalidateRect(Handle, @R, True);
    end;

    if FMDIDownMaxBtn or FMDIHotMaxBtn then
    begin
      FMDIDownMaxBtn := False;
      FMDIHotMaxBtn := false;
      R := GetMDIMaxBtnRect;
      InvalidateRect(Handle, @R, True);
    end;

    if FMDIDownMinBtn or FMDIHotMinBtn then
    begin
      FMDIDownMinBtn := False;
      FMDIHotMinBtn := false;
      R := GetMDIMinBtnRect;
      InvalidateRect(Handle, @R, True);
    end;

  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if not FDraging then
  begin
    if ToolBarState = tsDocked then
    begin
      if PtOnDragGrip(Point(X, Y)) then
      begin
        if not Locked then
          BeginMove(Shift, X, Y);

       { FOldMouseX := X;
        FOldMouseY := Y;
        //SetCapture(Handle);
        FDraging:= true;  }
      end
      else if not (csDesigning in ComponentState) then
      begin
        if PtOnPopupIndicator(Point(X, Y)) or PtOnCustomizedBtn(Point(X, Y)) then
        begin
          FDownPopupIndicator:= true;
          DrawPopupIndicator;

          OptionIndicatorClick;
        end;

        // MDI Buttons
        if PtOnMDIClose(Point(X, Y)) then
        begin
          FMDIDownCloseBtn := true;
          DrawMDIButtons;
        end;
        if PtOnMDIMax(Point(X, Y)) then
        begin
          FMDIDownMaxBtn := true;
          DrawMDIButtons;
        end;
        if PtOnMDIMin(Point(X, Y)) then
        begin
          FMDIDownMinBtn := true;
          DrawMDIButtons;
        end;

      end;

    end
    else if ToolBarState = tsFloating then
    begin
      if PtOnGripCaption(Point(X, Y)) then
      begin
        //Screen.Cursor:= OldCursor;
        if Screen.Cursor <> crSizeAll then
          Screen.Cursor := crSizeAll;

        BeginMove(Shift, X, Y);

       // if Screen.Cursor = crSizeAll then
          //self.Cursor:= OldCursor;

      end
      else
      begin
        if PtOnCustomizedBtn(Point(X, Y)) then
        begin
          if not FDownCustomizedBtn then
          begin
            FDownCustomizedBtn := true;
            DrawCustomizedBtn;
            OptionIndicatorClick;
          end;
        end;

        if PtOnCloseBtn(Point(X, Y)) then
        begin
          if not FDownCloseBtn then
          begin
            FDownCloseBtn := true;
            DrawCloseBtn;
          end;
        end;

      end;
    end
    else
    begin

    end;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.BeginMove(Shift: TShiftState; X, Y: Integer);
var
  DockInfo: PDockInfo;
  Msg: TMsg;
  CurP: TPoint;

  function GetParentForm: TCustomForm;
  var
    ParentCtrl: TWinControl;
  begin
    Result := nil;
    ParentCtrl := FLastDock.Parent;
    while Assigned(ParentCtrl) do
    begin
      if ParentCtrl is TCustomForm then
      begin
        Result := TCustomForm(ParentCtrl);
        break;
      end;
      ParentCtrl := ParentCtrl.Parent;
    end;
  end;

  procedure BuildDockPanelList;
    procedure SearchChildForDockPanel(ParentCtrl: TWinControl);
    var
      i: integer;
    begin
      if (ParentCtrl = nil) or (ContainsControl(ParentCtrl)) or (not ParentCtrl.Showing) then
        exit;

      if not (ParentCtrl is TAdvDockPanel) and (ParentCtrl is TWinControl) then
      begin
        for i := 0 to ParentCtrl.ControlCount - 1 do
        begin
          if (ParentCtrl.Controls[i] is TWinControl) then
            SearchChildForDockPanel(TWinControl(ParentCtrl.Controls[i]));
        end;
      end;

      if (ParentCtrl is TAdvDockPanel) then
      begin
        if (FDockList.IndexOf(ParentCtrl) < 0) and AcceptableDockPanel(TAdvDockPanel(ParentCtrl)) then
        begin
          New(DockInfo);
          DockInfo.Dock := TAdvDockPanel(ParentCtrl);
          GetWindowRect(DockInfo.Dock.Handle, DockInfo.DockRect);
          case DockInfo.Dock.Align of
            daLeft: DockInfo.DockRect.Right := DockInfo.DockRect.Right + 15;
            daTop: DockInfo.DockRect.Bottom := DockInfo.DockRect.Bottom + 15;
            daRight: DockInfo.DockRect.Left := DockInfo.DockRect.Left - 15;
            daBottom: DockInfo.DockRect.Top := DockInfo.DockRect.Top - 15;
          end;
          FDockList.Add(DockInfo);
        end;
      end;
    end;

  begin
    SearchChildForDockPanel(GetParentForm);
  end;

begin
  FDockList := TDbgList.Create;
  BuildDockPanelList;

  FOldMouseX := X;
  FOldMouseY := Y;
  SetCapture(Handle);
  FDraging := true;

  while GetCapture = Handle do
  begin
    case integer(GetMessage(Msg, 0, 0, 0)) of
      -1: break;
      0:
        begin
          PostQuitMessage(Msg.WParam);
          Break;
        end;
    end;

    case Msg.message of
      WM_MOUSEMOVE:
        begin
          GetCursorPos(CurP); // SmallPointToPoint(TSmallPoint(DWord(GetMessagePos)));
          CurP := ScreenToClient(CurP);
          Move(Shift, curP.X, Curp.Y);
        end;
      WM_LBUTTONUP:
        begin
          EndMove;
          break;
        end;
    else
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
  end;
  EndMove;
  //OutputDebugString(Pchar('DockCount: ' +inttostr(FDockList.count)));
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.Move(Shift: TShiftState; X, Y: Integer);
var
  ax, ay, i, OldRow: integer;
  P: TPoint;
  ExceedBounds, FoundNewParent: Boolean;
  Rgn1, Rgn2: HRGN;
begin
  if FDraging then
  begin
    ExceedBounds := false;
    if ToolBarState = tsDocked then
    begin
      OldRow := Row;
      if Position in [daTop, daBottom] then
      begin
        ax := left + (X - FOldMouseX);
        //ay:= top + (Y - FOldMouseY);
        // OutputDebugString(PChar('Lf: '+inttostr(Left) + ' ax: '+ inttostr(ax)));
        Left := ax;
        ay := Y; //ScreenToClient(Point(X, Y)).Y;
        if (ay > Height) then
          Top := Top + (ay - Height)
        else if (ay < 0) then
          Top := Top + (ay);

        if Top <> ay then
        begin
          if ay > Height then
          begin
            if (Row = OldRow) and ((Top + (ay {- Height})) > FCurrentDock.Height + DEFAULT_TOOLBARHEIGHT) then
              ExceedBounds := true;
          end
          else if ay < 0 then
          begin
            if (Row = OldRow) and (Top + ay < -DEFAULT_TOOLBARHEIGHT) then
              ExceedBounds := true;
          end;
        end;

        if (Left <> ax) and not ExceedBounds then
        begin
          if ax > Width then
          begin
            if ax > FCurrentDock.Width + DEFAULT_TOOLBARHEIGHT then
              ExceedBounds := true;
          end
          else if ax < 0 then
          begin
            if ax < -DEFAULT_TOOLBARHEIGHT then
              ExceedBounds := true;
          end;
        end;
      end
      else // if Position in [daLeft, daRight] then
      begin
        ay := Top + (Y - FOldMouseY);
        Top := ay;

        ax := X; //ScreenToClient(Point(X, Y)).Y;
        if (ax > Width) then
          Left := Left + (ax - Width)
        else if (ax < 0) then
          Left := Left + (ax);

        if Left <> ax then
        begin
          if ax > Width then
          begin
            if (Row = OldRow) and ((Left + (ax)) > FCurrentDock.Width + DEFAULT_TOOLBARHEIGHT) then
              ExceedBounds := true;
          end
          else if ax < 0 then
          begin
            if (Row = OldRow) and (Left + ax < -DEFAULT_TOOLBARHEIGHT) then
              ExceedBounds := true;
          end;
        end;

        if (Top <> ay) and not ExceedBounds then
        begin
          if ay > Height then
          begin
            if ay > FCurrentDock.Height + DEFAULT_TOOLBARHEIGHT then
              ExceedBounds := true;
          end
          else if ay < 0 then
          begin
            if ay < -DEFAULT_TOOLBARHEIGHT then
              ExceedBounds := true;
          end;
        end;

      end;

      if Position in [daTop, daBottom] then
      begin
        Rgn1 := CreateRectRgn(Width - 2, 0, Width, 2);
        Rgn2 := CreateRectRgn(Width - 2, Height - 2, Width, Height);
      end
      else
      begin
        Rgn1 := CreateRectRgn(0, Height - 3, 3, Height);
        Rgn2 := CreateRectRgn(Width - 3, Height - 3, Width, Height);
      end;

      CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
      InvalidateRgn(Handle, Rgn1, true);

      DeleteObject(Rgn1);
      DeleteObject(Rgn2);

    end
    else if ToolBarState = tsFloating then
    begin
      ax := left + (X - FOldMouseX);
      ay := top + (Y - FOldMouseY);
      P := ClientToScreen(Point(aX, aY));
      FFloatingWindow.Left := P.X;
      FFloatingWindow.Top := P.Y;
    end;

    if not AllowFloating then
      ExceedBounds := False;
      
    if ExceedBounds or (ToolBarState = tsFloating) then
    begin
      FoundNewParent := false;
      for i := 0 to FDockList.Count - 1 do
      begin
        P := ClientToScreen(Point(X, Y));
        if PtInRect(PDockInfo(FDockList[i]).DockRect, P) then
        begin
          if Parent <> PDockInfo(FDockList[i]).Dock then
          begin
            Parent := PDockInfo(FDockList[i]).Dock;
            FoundNewParent := true;
            if FFloatingWindow <> nil then
            begin
              FFloatingWindow.Free;
              FFloatingWindow := nil;
            end;

            //if GetCapture <> Handle then
              //SetCapture(Handle);
            break;
          end;
        end;
      end;

      if not FoundNewParent and not (ToolBarState = tsFloating) then
      begin
        SetFloating;
      end;
    end;

    //OutputDebugString(PChar('Top: ' + inttostr(y) + ' Left: ' + inttostr(x)));
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.EndMove;
var
  i: integer;
  DockInfo: PDockInfo;
begin
  if Screen.Cursor = crSizeAll then // TODO: Temporary
    Screen.Cursor := crDefault;

  FDraging := false;
  if GetCapture = Handle then
    ReleaseCapture;
  // Dispose DockList
  if Assigned(FDockList) then
  begin
    for i := 0 to FDockList.Count - 1 do
    begin
      DockInfo := FDockList[i];
      Dispose(DockInfo);
    end;
    FDockList.free;
    FDockList := nil;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.ButtonAtPos(X, Y: Integer): TAdvCustomToolBarButton;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to FATBControls.Count - 1 do
  begin
    if (TControl(FATBControls[i]) is TAdvCustomToolBarButton) and TControl(FATBControls[i]).Visible and TControl(FATBControls[i]).Enabled
        and (((FLUHidedControls.IndexOf(FATBControls[i]) < 0) and (ToolBarState = tsDocked)) or (ToolBarState in [tsFloating, tsFixed]))
        and (TControl(FATBControls[i]).Left <= X) and (TControl(FATBControls[i]).Left + TControl(FATBControls[i]).Width >= X)
        and (TControl(FATBControls[i]).Top <= Y) and (TControl(FATBControls[i]).Top + TControl(FATBControls[i]).Height >= Y) then
    begin
      Result := TAdvCustomToolBarButton(FATBControls[i]);
      Break;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Button: TAdvCustomToolBarButton;
  R: TRect;
begin
  inherited;

  if FDraging then
  begin
   { ax:= left + (X - FOldMouseX);
    ay:= top + (Y - FOldMouseY);
    //if ax > 100 then
    Left:= ax;
    //Top:= ay;
    ay:= Y;//ScreenToClient(Point(X, Y)).Y;
    if (ay > Height) then
      Top:= Top + (ay - Height)
    else if (ay < 0) then
      Top:= Top + (ay);

    OutputDebugString(PChar('Top: '+inttostr(y)+' Left: '+inttostr(x)));
    }
    //Move(Shift, X, Y);
  end;

  if not FDraging then
  begin
    if not (ssLeft in Shift) and not Locked then
    begin
      if PtOnDragGrip(Point(X, Y)) then
        self.Cursor := crSizeAll
      else if self.Cursor = crSizeAll then
        self.Cursor := FOldCursor;
    end;

    if not (csDesigning in ComponentState) then
    begin
      if PtOnPopupIndicator(Point(X, Y)) then
      begin
        if not FHotPopupIndicator then
        begin
          FHotPopupIndicator := true;
          DrawPopupIndicator;
        end;
      end
      else if FHotPopupIndicator then
      begin
        FHotPopupIndicator := false;
        DrawPopupIndicator;
      end;

      if FMenuFocused then
      begin
        Button := ButtonAtPos(X, Y);
        if (Button <> nil) and (Button <> FHotButton) then
          SetButtonHot(Button);
      end;

      // MDI Buttons
      if PtOnMDIClose(Point(X, Y)) then
      begin
        if not FMDIHotCloseBtn then
        begin
          FMDIHotCloseBtn := true;
          DrawMDIButtons;
        end;
      end
      else if FMDIHotCloseBtn then
      begin
        FMDIHotCloseBtn := false;
        R := GetMDICloseBtnRect;
        InvalidateRect(Handle, @R, True);
        //DrawMDIButtons;
      end;

      if PtOnMDIMax(Point(X, Y)) then
      begin
        if not FMDIHotMaxBtn then
        begin
          FMDIHotMaxBtn := true;
          DrawMDIButtons;
        end;
      end
      else if FMDIHotMaxBtn then
      begin
        FMDIHotMaxBtn := false;
        R := GetMDIMaxBtnRect;
        InvalidateRect(Handle, @R, True);
        //DrawMDIButtons;
      end;

      if PtOnMDIMin(Point(X, Y)) then
      begin
        if not FMDIHotMinBtn then
        begin
          FMDIHotMinBtn := true;
          DrawMDIButtons;
        end;
      end
      else if FMDIHotMinBtn then
      begin
        FMDIHotMinBtn := false;
        R := GetMDIMinBtnRect;
        InvalidateRect(Handle, @R, True);
        //DrawMDIButtons;
      end;

    end;

    if ToolBarState = tsFloating then
    begin
      if PtOnCustomizedBtn(Point(X, Y)) then
      begin
        if not FHotCustomizedBtn then
        begin
          FHotCustomizedBtn := true;
          DrawCustomizedBtn;
        end;
      end
      else if FHotCustomizedBtn then
      begin
        FHotCustomizedBtn := false;
        DrawCustomizedBtn;
      end;

      if PtOnCloseBtn(Point(X, Y)) then
      begin
        if not FHotCloseBtn then
        begin
          FHotCloseBtn := true;
          DrawCloseBtn;
        end;
      end
      else if FHotCloseBtn then
      begin
        FHotCloseBtn := false;
        DrawCloseBtn;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if FDownPopupIndicator then
  begin
    FDownPopupIndicator:= false;
    DrawPopupIndicator;
  end;

  if not (csDesigning in ComponentState) then
  begin
    if FMDIDownCloseBtn then
    begin
      FMDIDownCloseBtn := False;
      FMDIHotCloseBtn := False;
      DrawMDIButtons;
      if PtOnMDIClose(Point(X, Y)) then
        MDICloseBtnClick;
    end;
    if FMDIDownMaxBtn then
    begin
      FMDIDownMaxBtn := False;
      FMDIHotMaxBtn := False;
      DrawMDIButtons;
      MDIMaxBtnClick;
    end;
    if FMDIDownMinBtn then
    begin
      FMDIDownMinBtn := False;
      FMDIHotMinBtn := False;
      DrawMDIButtons;
      MDIMinBtnClick;
    end;
  end;

  if ToolBarState = tsFloating then
  begin
    if FDownCustomizedBtn then
    begin
      FDownCustomizedBtn := false;
      DrawCustomizedBtn;
    end;
    if FDownCloseBtn then
    begin
      FDownCloseBtn := false;
      DrawCloseBtn;
      CloseBtnClick;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.PtOnDragGrip(P: TPoint): Boolean;
begin
  Result := false;
  if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
  begin
    if Position in [daTop, daBottom] then
      Result := PtInRect(Rect(0, 0, DragGripWidth, Height), P)
    else
      Result := PtInRect(Rect(0, 0, Width, DragGripWidth), P);
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.PtOnPopupIndicator(P: TPoint): Boolean;
begin
  Result := false;
  if ShowPopupIndicator and ShowRightHandle then
  begin
    if Position in [daTop, daBottom] then
      Result := PtInRect(Rect(Width - PopupIndicatorWidth, 0, Width, Height), P)
    else
      Result := PtInRect(Rect(0, Height - PopupIndicatorWidth, Width, Height), P);
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.PtOnGripCaption(P: TPoint): Boolean;
var
  CapR: TRect;
begin
  Result := false;
  if ToolBarState = tsFloating then
  begin
    CapR := GetCaptionRect;
    if ShowOptionIndicator then
      CapR := Rect(CapR.Left, CapR.Top, FWCustomizedBtnRect.Left, CapR.Bottom)
    else if ShowClose then
      CapR := Rect(CapR.Left, CapR.Top, FWCloseBtnRect.Left, CapR.Bottom)
    else
      CapR := Rect(CapR.Left, CapR.Top, CapR.Right, CapR.Bottom);

    Result := PtInRect(CapR, P);
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.PtOnCloseBtn(P: TPoint): Boolean;
begin
  Result := false;
  if ToolBarState = tsFloating then
    Result := PtInRect(FWCloseBtnRect, P);
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.PtOnCustomizedBtn(P: TPoint): Boolean;
begin
  Result := false;
  if ToolBarState = tsFloating then
    Result := PtInRect(FWCustomizedBtnRect, P);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetRow(const Value: integer);
begin
  FRow := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
var
  OldWidth, OldHeight: integer;
begin
  //OutputDebugString(pchar(Name+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft)+' AH:'+inttostr(AHeight)+' AW:'+inttostr(AWidth)));
  //if name = 'AdvToolBar4' then
    //OutputDebugString(pchar(Name+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft)+' AH:'+inttostr(AHeight)+' AW:'+inttostr(AWidth)+' W:'+inttostr(Width)));


  OldWidth := Width;
  OldHeight := Height;

  if (Self.ToolBarState = tsDocked) and Assigned(FCurrentDock) then
  begin
    if not AllowBoundChange then
      FCurrentDock.SetToolBarBounds(self, ALeft, ATop, AWidth, AHeight);
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  end
  else
    inherited;

  if (Position in [daTop, daBottom]) then
  begin
    if not (csLoading in ComponentState) and (OldWidth <> Width) then
      UpdateRULists;
  end
  else // position in [daLeft, daRight]
  begin
    if not (csLoading in ComponentState) and (OldHeight <> Height) then
      UpdateRULists;
  end;

  //OutputDebugString(pchar(Name+' T:'+inttostr(top)+' L:'+inttostr(Left)+' H:'+inttostr(Height)+' W:'+inttostr(Width)+' MaxH:'+inttostr(Constraints.maxHeight)));
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.CanShrink: integer;
begin
  if Position in [daTop, daBottom] then
    Result := Width - Constraints.MinWidth
  else
    Result := Height - Constraints.MinHeight;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.CanExpand: integer;
begin
  if Position in [daTop, daBottom] then
    Result := Constraints.MaxWidth - Width
  else
    Result := Constraints.MaxHeight - Height;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetAllowBoundChange(const Value: boolean);
begin
  FAllowBoundChange := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetFullSize(const Value: Boolean);
begin
  if Value <> FFullSize then
  begin
    FFullSize := Value;
    if (Self.ToolBarState = tsDocked) and Assigned(FCurrentDock) and FFullSize then
    begin
      ParentStyler := true;
      FCurrentDock.SetToolBarFullSize(self);
    end
    else if (Self.ToolBarState = tsDocked) and Assigned(FCurrentDock) and not FFullSize then
    begin
      UpdateSize;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetDockableTo(const Value: TDockableTo);
begin
  FDockableTo := Value;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.AcceptableDockPanel(ADockPanel: TAdvDockPanel): Boolean;
begin
  Result := (ADockPanel.Align in DockableTo);
  if Result and ADockPanel.LockHeight and not (csDesigning in ADockPanel.ComponentState) and (ADockPanel.FPropertiesLoaded) then
    Result := (ADockPanel.IsAllowedInAnyRow(self) >= 0);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetToolBarFloating(P: TPoint);
begin
  if (FFloatingWindow = nil) and (ToolBarState <> tsFloating) then
  begin
    SetFloating(P.X, P.Y, true);
  end
  else
  begin
    FFloatingWindow.Left := P.X;
    FFloatingWindow.Top := P.Y;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetFloating(X: integer = 0; Y: integer = 0; ForcePoint: Boolean = false);
var
  P: TPoint;

  function GetMyParentForm: TCustomForm;
  var
    ParentCtrl: TWinControl;
  begin
    Result := nil;
    ParentCtrl := self.Parent;
    if Assigned(FCurrentDock) then
      ParentCtrl := FCurrentDock
    else if Assigned(FLastDock) then
      ParentCtrl := FLastDock;

    while Assigned(ParentCtrl) do
    begin
      if ParentCtrl is TCustomForm then
      begin
        Result := TCustomForm(ParentCtrl);
        break;
      end;
      ParentCtrl := ParentCtrl.Parent;
    end;
  end;

begin
  if (FFloatingWindow = nil) and (ToolBarState <> tsFloating) then
  begin
    FFloatingWindow := TFloatingWindow.CreateNew(FOwner);
    FFloatingWindow.BorderIcons := [];
    FFloatingWindow.BorderStyle := bsNone;
    FFloatingWindow.Ctl3D := false;
    FFloatingWindow.FormStyle := fsStayOnTop;
    //FFloatingWindow.Width := 100;
    //FFloatingWindow.Height := 100;
    //FFloatingWindow.AutoScroll := true;
    FFloatingWindow.BorderWidth := FCurrentToolBarStyler.FloatingWindowBorderWidth;
    FFloatingWindow.BorderColor := FCurrentToolBarStyler.FloatingWindowBorderColor;

    if FCurrentToolBarStyler.Color.ColorTo <> clNone then
      FFloatingWindow.Color := FCurrentToolBarStyler.Color.ColorTo
    else
      FFloatingWindow.Color := FCurrentToolBarStyler.Color.Color;

    //P:= ClientToScreen(Point(Left, Top));
    if ForcePoint then
    begin
      P := Point(X, Y);
    end
    else
    begin
      GetCursorPos(P);
      //P:= ScreenToClient(P);
    end;

    //if Position in [daLeft, daRight] then
      //Position:= daTop;

  {  if Position in [daTop, daBottom] then
      FSizeAtDock := Height
    else // daLeft, daRight
      FSizeAtDock := Width;
   }
    FSizeAtDock := GetSizeAtDock(True);

    FLUHidedControls.Clear;

    Parent := FFloatingWindow;
    FFloatingWindow.AdvCustomToolBar := self;
    FFloatingWindow.SetWindowSize;
    FFloatingWindow.Left := P.X;
    FFloatingWindow.Top := P.Y;
    //FFloatingWindow.Visible := true;

    FParentForm := GetParentForm(FLastDock);
    if FParentForm.Visible and not FFloatingWindow.Visible then
      FFloatingWindow.Visible := True
    else
    begin
      FFloatingWindow.Visible := False;
      FAutoHiding := True;
    end;
    FTimerID:= SetTimer(Handle, 500, 40, nil);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    if ToolBarState = tsFloating then
      Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetCaptionFont(const Value: TFont);
begin
  FCaptionFont.Assign(Value);
  if ToolBarState = tsFloating then
    Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetShowOptionIndicator(const Value: Boolean);
begin
  if FShowOptionIndicator <> Value then
  begin
    FShowOptionIndicator := Value;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetShowPopupIndicator(const Value: Boolean);
begin
  if FShowPopupIndicator <> Value then
  begin
    FShowPopupIndicator := Value;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetShowClose(const Value: Boolean);
begin
  FShowClose := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetCaptionHeight(const Value: integer);
begin
  FCaptionHeight := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CloseBtnClick;
begin
  if ToolBarState = tsFloating then
  begin
    FFloatingWindow.Visible := false;
    self.Visible := False;
    if Assigned(FOnClose) then
      FOnClose(self);
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetSizeAtDock(ForFloating: Boolean): Integer;
var
  w, h, atbW, atbH: Integer;
begin
  w := 0;
  h := 0;
  atbW := 0;
  atbH := 0;
  GetMaxControlSize(w, h);
  GetMaxToolBarButtonSize(atbW, atbH);
  if (ToolBarState = tsFloating) or ForFloating then
  begin
    if Position in [daTop, daBottom] then
    begin
      Result := h + 4;
    end
    else
    begin
      w := 0;
      h := 0;
      GetMaxExternalControlSize(w, h);
      Result := Max(h, atbW);
      Result := Result + 4;
    end;
  end
  else
  begin
    if Position in [daTop, daBottom] then
    begin
      Result := h + 4;
    end
    else
    begin
      Result := w + 4;
    end;
  end;
  Result := Max(Result, DEFAULT_TOOLBARHEIGHT);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.GetMaxControlSize(var W, H: Integer);
var
  i: Integer;
begin
  for i := 0 to FATBControls.count - 1 do
  begin
    if not (TControl(FATBControls[i]) is TAdvToolBarSeparator) then
    begin
      W := Max( W, TControl(FATBControls[i]).Width);
      H := Max(H, TControl(FATBControls[i]).Height);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.GetMaxExternalControlSize(var W, H: Integer);
var
  i: Integer;
begin
  for i := 0 to FATBControls.count - 1 do
  begin
    if not (TControl(FATBControls[i]) is TAdvCustomToolBarControl) then
    begin
      W := Max( W, TControl(FATBControls[i]).Width);
      H := Max(H, TControl(FATBControls[i]).Height);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.GetMaxToolBarButtonSize(var W, H: Integer);
var
  i: Integer;
begin
  for i := 0 to FATBControls.count - 1 do
  begin
    if not (TControl(FATBControls[i]) is TAdvToolBarSeparator) and (TControl(FATBControls[i]) is TAdvCustomToolBarButton) then
    begin
      W := Max( W, TControl(FATBControls[i]).Width);
      H := Max(H, TControl(FATBControls[i]).Height);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetControlsPosition(UpdateMySize: boolean = true);
var
  i, x, y: integer;
begin
  if (csLoading in ComponentState) then
    exit;

  if (ToolBarState = tsFloating) then
  begin
    x := 2;
    y := 2 + CaptionHeight;

    if FFloatingRows = 1 then
    begin
      FInternalControlPositioning := true;
      for i := 0 to FATBControls.Count - 1 do
      begin
        if TControl(FATBControls[i]).Visible then
        begin
          TControl(FATBControls[i]).Left := x;
          TControl(FATBControls[i]).Top := y;
          x := x + TControl(FATBControls[i]).Width;
        end
        else
        begin
          TControl(FATBControls[i]).Top := Height + 2;
        end;
      end;
      FInternalControlPositioning := false;

      if UpdateMySize then
        UpdateSize;
    end
    else
    begin
      // first set the Size
      if UpdateMySize then
        UpdateSize;

      //  Then set the controls position
      FInternalControlPositioning := true;
      for i := 0 to FATBControls.Count - 1 do
      begin
        if TControl(FATBControls[i]).Visible then
        begin
          if TControl(FATBControls[i]).Width > (self.Width - x - 2) then
          begin
            x := 2;
            y := y + FSizeAtDock { + 2};
          end;
          TControl(FATBControls[i]).Left := x;
          TControl(FATBControls[i]).Top := y;
          x := x + TControl(FATBControls[i]).Width;
        end
        else
        begin
          TControl(FATBControls[i]).Top := Height + 2;
        end;
      end;
      FInternalControlPositioning := false;

    end;

  end
  else if Position in [daTop, daBottom] then
  begin
    if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
      x := DragGripWidth + 2
    else
      x := 2;

    if Self.ToolBarState in [tsDocked, tsFixed] then
      y := 2
    else
      y := 2 + CaptionHeight;


    FInternalControlPositioning := true;
    for i := 0 to FATBControls.Count - 1 do
    begin
      if TControl(FATBControls[i]).Visible then
      begin
        if (FLUHidedControls.IndexOf(FATBControls[i]) >= 0) then
        begin
          //TControl(FATBControls[i]).Left :=
          if TControl(FATBControls[i]).Parent = self then
            TControl(FATBControls[i]).Top := Height + 2;
        end
        else
        begin
          TControl(FATBControls[i]).Left := x;
          TControl(FATBControls[i]).Top := y;
          x := x + TControl(FATBControls[i]).Width;
        end;
      end
      else
      begin
        TControl(FATBControls[i]).Top := Height + 2;
      end;
    end;
    FInternalControlPositioning := false;

    if UpdateMySize then
      UpdateSize;

    { // Check for Controls exceeding the boundries and hide them
    for i:=0 to ControlCount-1 do
    begin
      self.Controls[i].Left := x;
      self.Controls[i].Top := y;
      x:= x + self.Controls[i].Width;
    end;
    }
  end
  else // if Position in [daLeft, daRight] then
  begin

    if Self.ToolBarState in [tsDocked, tsFixed] then
    begin
      if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
        y := DragGripWidth + 2
      else
        y := 2;

      FInternalControlPositioning := true;
      for i := 0 to FATBControls.Count - 1 do
      begin
        if TControl(FATBControls[i]).Visible then
        begin
          if (FLUHidedControls.IndexOf(FATBControls[i]) >= 0) then
          begin
            if TControl(FATBControls[i]).Parent = self then
              TControl(FATBControls[i]).Left := Width + 2;
            //TControl(FATBControls[i]).Top := Height + 2;
          end
          else
          begin
            TControl(FATBControls[i]).Left := 2;
            TControl(FATBControls[i]).Top := y;
            y := y + TControl(FATBControls[i]).Height;
          end;
        end
        else
        begin
          TControl(FATBControls[i]).Left := Width + 2;
        end;
      end;
      FInternalControlPositioning := false;

    end
    else // ToolBarState = tsFloating
    begin
      y := 2 + CaptionHeight;
      FInternalControlPositioning := true;
      for i := 0 to FATBControls.Count - 1 do
      begin
        if TControl(FATBControls[i]).Visible then
        begin
          TControl(FATBControls[i]).Left := 2;
          TControl(FATBControls[i]).Top := y;
          y := y + TControl(FATBControls[i]).Height;
        end;
      end;
      FInternalControlPositioning := false;
    end;

    if UpdateMySize then
      UpdateSize;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.UpdateSize;
var
  H, W, i, MaxS, MaxCtrlS: integer;
begin
  if (FToolBarState = tsFloating) then
  begin
    Constraints.MinHeight := 0;
    Constraints.MaxHeight := 0;
    Constraints.MinWidth := 0;
    Constraints.MaxWidth := 0;
    if FFloatingRows = 1 then
    begin
      W := FMinLength;
      if FATBControls.Count > 0 then
      begin
        i := FATBControls.count - 1;
        while i >= 0 do
        begin
          if TControl(FATBControls[i]).visible then
            break;
          dec(i);
        end;

        if i >= 0 then
          W := TControl(FATBControls[i]).Left + TControl(FATBControls[i]).Width + 2;
      end;
      w := Max(w, FMinLength);
      self.Width := w;
      self.Height := FSizeAtDock + CaptionHeight;
    end
    else
    begin
      GetFloatingSizes(h, w);
      self.Width := w;
      self.Height := h;
    end;

    if Assigned(FFloatingWindow) and (FFloatingWindow.Visible) then
      FFloatingWindow.SetWindowSize;

  end
  else if Position in [daTop, daBottom] then
  begin
    if FullSize and false then
    begin
      if (FToolBarState = tsDocked) and Assigned(FCurrentDock) then
      begin
        //W:= FCurrentDock.Width;
        //Constraints.MaxWidth:= W;
        //Constraints.MinWidth:= W;
      end;
    end
    else
    begin
      W := FMinLength;
      if FATBControls.Count > 0 then
      begin
        i := FATBControls.count - 1;
        while i >= 0 do
        begin
          if (FLUHidedControls.IndexOf(FATBControls[i]) < 0) and TControl(FATBControls[i]).visible then
            break;
          dec(i);
        end;

        if i >= 0 then
          W := TControl(FATBControls[i {FATBControls.Count-1}]).Left + TControl(FATBControls[i {FATBControls.Count-1}]).Width
        else
          W := MIN_BUTTONSIZE;

        if ShowPopupIndicator {CustomizedOption} then
        begin
          if (FToolBarState = tsFloating) then
            W := W + 2
          else
            W := W + PopupIndicatorWidth;
        end;
      end;

      if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
        MaxS := DragGripWidth + 2
      else
        MaxS := 2;

      MaxCtrlS := DEFAULT_TOOLBARHEIGHT;
      for i := 0 to FATBControls.count - 1 do
      begin
        if TControl(FATBControls[i]).visible then
        begin
          MaxS := MaxS + TControl(FATBControls[i]).Width;
          if not (TControl(FATBControls[i]) is TAdvToolBarSeparator) then
            MaxCtrlS := Max(MaxCtrlS, TControl(FATBControls[i]).Height + 4);
        end;
      end;

      if ShowPopupIndicator then
        MaxS := MaxS + PopupIndicatorWidth;

      MaxS := Max(MaxS, W);
      //FMaxLength:= W;
      FMaxLength := MaxS;

      if (FToolBarState = tsFloating) then
      begin
       { if FullSize then
        begin
          Constraints.MinHeight:= 0;
          Constraints.MaxHeight:= 0;

          Constraints.MinWidth:= 0;
          Constraints.MaxWidth:= W;
          Constraints.MinWidth:= W;
          Width:= W;
        end
        else
        begin
          Constraints.MinHeight:= 0;
          Constraints.MaxHeight:= 0;

          if Constraints.MinWidth > W then
            Constraints.MinWidth:= W;

          Constraints.MaxWidth:= W;

          Width:= W;
        end; }
      end
      else // tsDocked, tsFixed
      begin
        if FullSize then
        begin

        end
        else
        begin
          Constraints.MinHeight := 0;
          Constraints.MaxHeight := 0;

          Constraints.MinWidth := FMinLength;
          if Constraints.MinWidth > W then
            Constraints.MinWidth := W;

          //d:= W - Constraints.MaxWidth;
          Constraints.MaxWidth := FMaxLength; //W;

          // To Adjust size change, not to happened empty space with Shrunk ToolBar
          //Width:= Width + d;

          //Width:= W;  // TODO: remove this and uncomment above line
          //Height := FSizeAtDock;

          if W > Width then
          begin
            Width := W;
          end
          else if W < Width then
          begin
            if Width > FMaxLength then
              Width := W;
          end;

          if MaxCtrlS <> Height then
          begin
            Height := MaxCtrlS;
            //Height := FSizeAtDock;
          end;

        end;
      end;
    end;

  end
  else // if Position in [daLeft, daRight] then
  begin
    if FullSize then
    begin
      if (FToolBarState = tsDocked) and Assigned(FCurrentDock) then
      begin
        //H:= FCurrentDock.Height;
        //Constraints.MaxHeight:= H;
      end;
    end
    else
    begin
      H := FMinLength;
      if FATBControls.Count > 0 then
      begin
        i := FATBControls.count - 1;
        while i >= 0 do
        begin
          if (FLUHidedControls.IndexOf(FATBControls[i]) < 0) and TControl(FATBControls[i]).visible then
            break;
          dec(i);
        end;

        if i >= 0 then
          H := TControl(FATBControls[i {FATBControls.Count-1}]).Top + TControl(FATBControls[i {FATBControls.Count-1}]).Height
        else
          H := MIN_BUTTONSIZE;

        if ShowPopupIndicator {CustomizedOption} then
          H := H + PopupIndicatorWidth;
      end;


      if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
        MaxS := DragGripWidth + 2
      else
        MaxS := 2;

      MaxCtrlS := DEFAULT_TOOLBARHEIGHT;
      for i := 0 to FATBControls.count - 1 do
      begin
        if TControl(FATBControls[i]).visible then
        begin
          MaxS := MaxS + TControl(FATBControls[i]).Height;
          if not (TControl(FATBControls[i]) is TAdvToolBarSeparator) then
            MaxCtrlS := Max(MaxCtrlS, TControl(FATBControls[i]).Width + 4);
        end;
      end;

      if ShowPopupIndicator then
        MaxS := MaxS + PopupIndicatorWidth;

      MaxS := Max(MaxS, H);
      FMaxLength := MaxS;


      Constraints.MinWidth := 0;
      Constraints.MaxWidth := 0;

      Constraints.MinHeight := FMinLength;
      if Constraints.MinHeight > H then
        Constraints.MinHeight := H;
      Constraints.MaxHeight := FMaxLength;
      //FMaxLength:= H;


      //d:= W - Constraints.MaxWidth;

      // To Adjust size change, not to happened empty space with Shrunk ToolBar
      //Height:= Height + d;

      //Width := FSizeAtDock;
      //Height:= H;  // TODO: remove this and uncomment above line

      if H > Height then
      begin
        Height := H;
      end
      else if H < Height then
      begin
        if Height > FMaxLength then
          Height := H;
      end;

      if MaxCtrlS <> Width then
      begin
        Width := MaxCtrlS;
      end;

    end;

  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetImages(const Value: TCustomImageList);
var
  i: integer;
  OldImages: TCustomImageList;
begin
  if Value <> FImages then
  begin
    OldImages := FImages;
    FImages := Value;

    if Assigned(OldImages) then
    begin
      if Assigned(FImages) then
      begin
        if Position in [daTop, daBottom] then
          Height := Height + (FImages.Height - OldImages.Height)
        else
          Width := Width + (FImages.Width - OldImages.Width);
      end
      else
      begin
        if Position in [daTop, daBottom] then
          Height := Height - OldImages.Height
        else
          Width := Width - OldImages.Width;
      end;
    end;

    FInternalControlPositioning := True;
    for i := 0 to FATBControls.Count - 1 do
    begin
      if TControl(FATBControls[i]) is TAdvCustomToolBarControl then
        TAdvCustomToolBarControl(FAtbControls[i]).AdjustSize;
    end;
    FInternalControlPositioning := False;

    SetControlsPosition;

    if Assigned(OldImages) then
    begin
      for i := 0 to FATBControls.Count - 1 do
      begin
        if TControl(FATBControls[i]) is TAdvCustomToolBarControl then
          TAdvCustomToolBarControl(FAtbControls[i]).AdjustSize;
      end;
    end;

    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetMenu(const Value: TMainMenu);
var
  I, j: Integer;
begin
  if FMenu = Value then exit;
  if csAcceptsControls in ControlStyle then
  begin
    ControlStyle := [csCaptureMouse, csClickEvents,
      csDoubleClicks, csMenuEvents, csSetCaption];
    RecreateWnd;
  end;

  //ShowCaptions := True;

  if Assigned(FMenu) then
    for I := FATBControls.Count - 1 downto 0 do
    begin
      if (TControl(FATBControls[I]) is TAdvToolBarMenuButton) and (TAdvToolBarMenuButton(FATBControls[I]).FToolBarCreated) then
        TAdvToolBarMenuButton(FATBControls[I]).Free;
    end;

  if Assigned(FMenu) then
  begin
    FMenu.RemoveFreeNotification(Self);
    //if (csDesigning in ComponentState) then
      //FMenu.OnChange:= nil;
  end;
  FMenu := Value;
  if not Assigned(FMenu) then exit;
  FMenu.FreeNotification(Self);

  if FMenu.Handle = 0 then
  begin
    { Do nothing just required to call GetHandle
      which internally calls InternalReThinkHotKeys. }
  end;

  if (csDesigning in ComponentState) then
    FMenu.OnChange:= OnMainMenuChange;

  if (csLoading in ComponentState) then
  begin
    if Assigned(FMenu.Images) then
      FImages := FMenu.Images;
  end
  else
    FImages := FMenu.Images;

  if (csDesigning in ComponentState) then
    FMenuImages := FMenu.Images;

  for I := 0 to FMenu.Items.Count - 1 do
  begin
    with TAdvToolBarMenuButton.Create(Self) do
    try
      Grouped := True;
      Parent := Self;
      ShowCaption := true;
      {Buttons[I].} MenuItem := FMenu.Items[I];
      FToolBarCreated := true;
      AutoSize := True;
    except
      Free;
      raise;
    end;
  end;

  {Copy attributes from each menu item}
  j := 0;
  for I := 0 to FATBControls.Count - 1 {FMenu.Items.Count - 1} do
  begin
    if (TControl(FATBControls[I]) is TAdvToolBarMenuButton) and (TAdvToolBarMenuButton(FATBControls[I]).FToolBarCreated) then
    begin
      TAdvToolBarMenuButton(FATBControls[I]).MenuItem := FMenu.Items[j];
      // Will Be replaced by AutoSize
      //TAdvToolBarMenuButton(FATBControls[I]).Width := Canvas.TextWidth(FMenu.Items[j].Caption) + 8;

      inc(j);
      if j >= FMenu.Items.Count then
        break;
    end;
  end;

{  FMenu := Value;
  if FMenu <> nil then
  begin
    FreeAllItems;
    AddAllMenuItems(FMenu);

     // TODO: here
    SetItemsPosition;
  end;
}
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CMControlChange(var Message: TCMControlChange);
begin
  inherited;

  with Message do
  begin
    // FF: D2005
    if (Control is TOptionSelectorWindow) then
      Exit;

    if not FInternalControlUpdation then
    begin
      if Inserting then
        InsertControl(Control)
      else
        RemoveControl(Control);
    end;
  end;

  if Message.Inserting and not (csLoading in ComponentState) then
  begin
    //CheckAndCreateControlItem(Message.Control)

  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CMControlListChange(
  var Message: TCMControlListChange);
begin
  inherited;
  
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.FindButtonFromAccel(
  Accel: Word): TAdvCustomToolBarButton;
var
  I: Integer;
begin
  for I := 0 to FATBControls.Count - 1 do
    if TControl(FATBControls[I]) is TAdvCustomToolBarButton then
    begin
      Result := TAdvCustomToolBarButton(FATBControls[I]);
      if Result.Visible and Result.Enabled and IsAccel(Accel, Result.Caption) then
        Exit;
    end;
  Result := nil;

end;

procedure TAdvCustomToolBar.CMHintShow(var Msg: TCMHintShow);
begin
  inherited;

  if (ToolBarState = tsFloating) and ShowClose and ShowHint and (HintCloseButton <> '') then
  begin
    if PtInRect(FWCloseBtnRect, Msg.HintInfo.CursorPos) then
      Msg.HintInfo.HintStr := HintCloseButton;
  end;

  if (ToolBarState = tsFloating) and ShowOptionIndicator and ShowHint and (HintOptionButton <> '') then
  begin
    if PtInRect(FWCustomizedBtnRect, Msg.HintInfo.CursorPos) then
      Msg.HintInfo.HintStr := HintOptionButton;
  end;

  if (ToolBarState <> tsFloating) and ShowOptionIndicator and ShowHint and (HintOptionButton <> '') then
  begin
    if (PtOnPopupIndicator(Msg.HintInfo.CursorPos)) then
      Msg.HintInfo.HintStr := HintOptionButton;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CMDialogChar(var Message: TCMDialogChar);
var
  Button: TAdvCustomToolBarButton;
begin
  if Enabled and Showing {and ShowCaptions} then
  begin
    Button := FindButtonFromAccel(Message.CharCode);
    if Button <> nil then
    begin
      { Display a drop-down menu after hitting the accelerator key if IE3
        is installed. Otherwise, fire the OnClick event for IE4. We do this
        because the IE4 version of the drop-down metaphor is more complete,
        allowing the user to click a button OR drop-down its menu. }
     { if ((Button.Style <> tbsDropDown) or (GetComCtlVersion < ComCtlVersionIE4)) and
        ((Button.DropdownMenu <> nil) or (Button.MenuItem <> nil)) then
        TrackMenu(Button)
      else
        Button.Click; }
      // FF: ShortCut not working with AdvToolBarButton  
      if Button.IsMenuButton then
        Button.DoDropDown
      else
        Button.Click;

      Message.Result := 1;
      Exit;
    end;
  end;
  inherited;

end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.AddAdvToolBarControl(
  aControl: TAdvCustomToolBarControl): integer;
begin
  Result := FATBControls.Count;
  InsertAdvToolBarControl(aControl, Result);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.InsertAdvToolBarControl(aControl: TAdvCustomToolBarControl; Index: integer);
begin
  if Index > FATBControls.Count then
    raise exception.Create('Invalid Index');

  if FATBControls.IndexOf(aControl) < 0 then
  begin
    FATBControls.Insert(Index, aControl);
    if aControl is TAdvCustomToolBarControl then
      TAdvCustomToolBarControl(aControl).FAdvToolBar := self;

    //FRUControls.Insert(0, aControl);

    SetControlsPosition;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.RemoveAdvToolBarControl(
  aControl: TAdvCustomToolBarControl);
begin
  if FATBControls.IndexOf(aControl) >= 0 then
  begin
    FATBControls.Remove(aControl);

    //FRUControls.Remove(aControl));

    SetControlsPosition;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.AdjustControl(Control: TControl);
var
  Pos: Integer;
begin
  Pos := FATBControls.IndexOf(Control);
  if Pos = -1 then Exit;
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then
    ReorderControl(Pos, Control.Left, Control.Top);

  SetControlsPosition;
  UpdateRULists;
  if not (csDesigning in ComponentState) and AutoOptionMenu then
  begin
    if Assigned(FOptionWindow) and FOptionWindow.Visible then
    begin
      InitializeOptionWindow;
    end;
  end;

end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.ControlIndex(OldIndex, ALeft,
  ATop: Integer): Integer;
begin
  if (OldIndex >= 0) and (FATBControls.Count <= 1) then
  begin
    Result := OldIndex;
    Exit;
  end;

  Result := FATBControls.Count;
  if (ALeft = 0) or (ATop = 0) then
    exit;

  if FATBControls.Count > 0 then
  begin
    for Result := 0 to FATBControls.Count - 1 do
    begin
      if Position in [daTop, daBottom] then
      begin
        if (Result <> OldIndex) and (ALeft <= TControl(FATBControls[Result]).Left) then
          Break;
      end
      else
      begin
        if (Result <> OldIndex) and (ATop <= TControl(FATBControls[Result]).Top) then
          Break;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.ReorderControl(OldIndex, ALeft,
  ATop: Integer): Integer;
var
  Control: TControl;
begin
  Result := ControlIndex(OldIndex, ALeft, ATop);
  if Result <> OldIndex then
  begin
    { If we are inserting to the right of our deletion then account for shift }
    if OldIndex < Result then Dec(Result);
    Control := FATBControls[OldIndex];
    FATBControls.Delete(OldIndex);
    FATBControls.Insert(Result, Control);
    //SetControlsPosition;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.InsertControl(Control: TControl);
var
  FromIndex, ToIndex: Integer;
begin
  if Control is TAdvCustomToolBarControl then
  begin
    TAdvCustomToolBarControl(Control).FAdvToolBar := Self;
    TAdvCustomToolBarControl(Control).Position := self.Position;
  end;

  if not (csLoading in Control.ComponentState) or true {ch1} then
  begin
    FromIndex := FATBControls.IndexOf(Control);
    if FromIndex >= 0 then
      {ToIndex := } ReorderControl(Fromindex, Control.Left, Control.Top)
    else
    begin
      ToIndex := ControlIndex(FromIndex, Control.Left, Control.Top);
      FATBControls.Insert(ToIndex, Control);
    end;
  end
  else
  begin
    {ToIndex := } FATBControls.Add(Control);
  end;

  if FAutoRUL then
    FRUControls.Add(Control);

  SetControlsPosition;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.RemoveControl(Control: TControl);
var
  I: Integer;
begin
  I := FATBControls.IndexOf(Control);
  if I >= 0 then
  begin
    if Control is TAdvCustomToolBarButton then TAdvCustomToolBarButton(Control).FAdvToolBar := nil;
    FATBControls.Remove(Control);

    if FAutoRUL then
    begin
      FRUControls.Remove(Control);
      FLUHidedControls.Remove(Control);
    end;

    SetControlsPosition;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.CheckMenuDropdown(
  Button: TAdvCustomToolBarButton): Boolean;
var
  Hook: Boolean;
  Menu: TMenu;
  Item: TMenuItem;
  I: Integer;
  ParentMenu: TMenu;
  APoint: TPoint;

  MenuWidth, j, k: Integer;
  MeasureItemStruct: TMeasureItemStruct;
begin
  Result := False;
  if Button = nil then Exit;
  FCaptureChangeCancels := False;
  try
    if Button.DropdownMenu <> nil then
      FTempMenu := Button.DropdownMenu
    else if Button.MenuItem <> nil then
    begin
      Button.MenuItem.Click;
      ClearTempMenu;
      FTempMenu := TAdvPopupMenu.Create(Self);
      ParentMenu := Button.MenuItem.GetParentMenu;
      if ParentMenu <> nil then
        FTempMenu.BiDiMode := ParentMenu.BiDiMode;
      FTempMenu.HelpContext := Button.MenuItem.HelpContext;
      FTempMenu.TrackButton := tbLeftButton;
      Menu := Button.MenuItem.GetParentMenu;
      if Menu <> nil then
        FTempMenu.Images := Menu.Images;
      FButtonMenu := Button.MenuItem;
      for I := FButtonMenu.Count - 1 downto 0 do
      begin
        Item := FButtonMenu.Items[I];
        FButtonMenu.Delete(I);
        FTempMenu.Items.Insert(0, Item);
      end;
    end
    else
      Exit;
    SendCancelMode(nil);
    FTempMenu.PopupComponent := Self;
    Hook := Button.Grouped or true {(Button.MenuItem <> nil)};
    Hook := Hook and (FTempMenu.Items.Count > 0);
    if Hook then
    begin
      MenuButtonIndex := Button.Index;
      MenuToolBar := Self;
      InitToolMenuHooks;
    end;
    //Perform(TB_SETHOTITEM, -1, 0);
    SetButtonHot(-1);
    try
      //---------
      // correct popup point coordinates
      MenuWidth := 0;
      j := 0;
      for k := 0 to FTempMenu.Items.Count - 1 do
      begin
        if MenuWidth < Canvas.TextWidth(FTempMenu.Items[k].Caption) then
        begin
          MenuWidth := Canvas.TextWidth(FTempMenu.Items[k].Caption);
          j := k;
        end;
      end;

      if FTempMenu.Items.Count > 0 then
      begin
        with MeasureItemStruct do
        begin
          CtlType := ODT_MENU;
          itemID := FTempMenu.Items[j].Command;
          itemWidth := 10;
          itemHeight := 10;
        end;
        SendMessage(PopupList.Window, WM_MEASUREITEM, 0, lParam(@MeasureItemStruct));
        MenuWidth := MeasureItemStruct.itemWidth; //+ TriangleSize;
      end;
      //LeftSide := (0{X} - TriangleSize - MenuWidth < 0);
      //RightSide := (0{X} + TriangleSize * 2 + MenuWidth >= Screen.Width);
     {
      if (Alignment = paRight) and not LeftSide then
        Inc(X, TriangleSize)
      else if (Alignment = paLeft) and RightSide then
        Inc(X, TriangleSize)
      else if Alignment = paCenter then
        Inc(X, TriangleSize div 2);
      if X >= Screen.Width then
        X := Screen.Width - 1;
      }

      //---------
      if Position in [daTop, daBottom] then
      begin
        if Position = daTop then
        begin
          APoint := Button.ClientToScreen(Point(0, Button.ClientHeight));
          if FTempMenu.IsRightToLeft then Inc(APoint.X, Button.Width);
          FMenuDropped := True;
          if (GetSystemMetrics(SM_CYMENU) * FTempMenu.Items.Count) + APoint.Y + 10 >
          {$IFDEF DELPHI6_LVL}
            Screen.MonitorFromPoint(APoint).Height then
          {$ELSE}
            Screen.Height then
          {$ENDIF}
            //Dec(APoint.Y, Button.Height);
            Dec(APoint.Y, (GetSystemMetrics(SM_CYMENU) * FTempMenu.Items.Count) + Button.Height + 4);
        end
        else // daBottom
        begin
          APoint := Button.ClientToScreen(Point(0, Button.ClientHeight));
          if FTempMenu.IsRightToLeft then
            Inc(APoint.X, Button.Width);
          FMenuDropped := True;
          if (GetSystemMetrics(SM_CYMENU) * FTempMenu.Items.Count) + APoint.Y + 10 >
          {$IFDEF DELPHI6_LVL}
            Screen.MonitorFromPoint(APoint).Height then
          {$ELSE}
            Screen.Height then  
          {$ENDIF}  
          begin
            //Dec(APoint.Y, Button.Height);
            Dec(APoint.Y, (GetSystemMetrics(SM_CYMENU) * FTempMenu.Items.Count) + Button.Height + 4);
          end;
        end;
      end
      else // daLeft, daRight then
      begin
        if Position = daLeft then
        begin
          APoint := Button.ClientToScreen(Point(Button.ClientWidth, 1));
          //if FTempMenu.IsRightToLeft then Inc(APoint.X, Button.Width);
          FMenuDropped := True;
          {if MenuWidth + APoint.X + 30 >
             Screen.MonitorFromPoint(APoint).Width then
            Dec(APoint.X, MenuWidth+Button.Width+4);
          }
          {if (GetSystemMetrics(SM_CYMENU) * FTempMenu.Items.Count) + APoint.Y >
             Screen.MonitorFromPoint(APoint).Height then
            Dec(APoint.Y, Button.Height); }
        end
        else // daRight
        begin
          APoint := Button.ClientToScreen(Point(0, 1));
          APoint.X := APoint.X - MenuWidth;

         { LeftSide := (APoint.X - TriangleSize - MenuWidth < 0);
          RightSide := (APoint.X + TriangleSize * 2 + MenuWidth >= Screen.Width);

          if (FTempMenu.Alignment = paRight) and not LeftSide then
            Inc(APoint.X, TriangleSize)
          else if (FTempMenu.Alignment = paLeft) and RightSide then
            Inc(APoint.X, TriangleSize)
          else if FTempMenu.Alignment = paCenter then
            Inc(APoint.X, TriangleSize div 2);
          if APoint.X >= Screen.Width then
            APoint.X := Screen.Width - 1;
          }
          //if FTempMenu.IsRightToLeft then Inc(APoint.X, Button.Width);
          FMenuDropped := True;
          {if (GetSystemMetrics(SM_CYMENU) * FTempMenu.Items.Count) + APoint.Y >
             Screen.MonitorFromPoint(APoint).Height then
            Dec(APoint.Y, Button.Height); }
        end;
      end;
      //if GetComCtlVersion = ComCtlVersionIE5 then
        //Button.Invalidate;
      if FTempMenu is TAdvPopupMenu then
        TAdvPopupMenu(FTempMenu).MenuStyler := FCurrentToolBarStyler.CurrentAdvMenuStyler;

      if Hook then
        FTempMenu.Popup(APoint.X, APoint.Y);
    finally
      if Hook then ReleaseToolMenuHooks;
    end;
    FMenuButton := Button;
    Button.OnDropDownHide;
    if StillModal and FMenuFocused then
      SetButtonHot(Button);
      //Perform(TB_SETHOTITEM, Button.Index, 0);
    Result := True;
    UpControlInRUL(Button);
  finally
    PostMessage(Handle, CN_DROPDOWNCLOSED, 0, 0);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CancelMenu;
begin
  if FInMenuLoop then
  begin
    ReleaseToolMenuKeyHooks;
    MouseCapture := False;
    FMenuFocused := False;
    Perform(TB_SETANCHORHIGHLIGHT, 0, 0);
  end;
  FInMenuLoop := False;
  FCaptureChangeCancels := False;
  SetButtonHot(-1);
  //Perform(TB_SETHOTITEM, -1, 0);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.MenuItemTimerOnTime(Sender: TObject);
begin
  if (FNextMenuHotButton <> nil) then
  begin
    TrackMenu(nil);
    SetButtonHot(FNextMenuHotButton);
    FNextMenuHotButton := nil;
  end;
  FMenuItemTimer.Enabled := False;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.ClickButton(Button: TAdvCustomToolBarButton; RealClick: Boolean = false);
var
  P: TPoint;
begin
  FCaptureChangeCancels := False;
  P := Button.ClientToScreen(Point(0, 0));
  if not RealClick then
  begin
    //PostMessage(Handle, WM_LBUTTONDOWN, MK_LBUTTON, Longint(PointToSmallPoint(ScreenToClient(P))))
    if Assigned(Button.MenuItem) and (Button.MenuItem.Count > 0) then
      PostMessage(Handle, WM_LBUTTONDOWN, MK_LBUTTON, Longint(PointToSmallPoint(ScreenToClient(P))))
    else
    begin
     { keybd_event( VK_ESCAPE, Mapvirtualkey( VK_ESCAPE, 0 ), 0, 0);
      keybd_event( VK_ESCAPE, Mapvirtualkey( VK_ESCAPE, 0 ), KEYEVENTF_KEYUP, 0);}
      if Position in [daTop, daBottom] then
        P := Point(P.X, P.Y-1)
      else
        P := Point(P.X-1, P.Y);

      PostMessage(Handle, WM_LBUTTONDOWN, MK_LBUTTON, Longint(PointToSmallPoint(ScreenToClient(P))));
      PostMessage(Handle, WM_LBUTTONUP, MK_LBUTTON, Longint(PointToSmallPoint(ScreenToClient(P))));

      FNextMenuHotButton := Button;
      FMenuItemTimer.Enabled := True;
      //Button.DoDropDown;
    end;
  end
  else
  begin
    mouse_event( MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0 );
    mouse_event( MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 );
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CNDropDownClosed(var Message: TMessage);
begin
  ClearTempMenu;
  FMenuDropped := False;
  if {(GetComCtlVersion = ComCtlVersionIE5) and }(FMenuButton <> nil)
    then FMenuButton.Invalidate;
  FCaptureChangeCancels := True;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.ClearTempMenu;
var
  I: Integer;
  Item: TMenuItem;
begin
  if (FButtonMenu <> nil) and (FMenuButton <> nil) and
    (FMenuButton.MenuItem <> nil) and (FTempMenu <> nil) then
  begin
    for I := FTempMenu.Items.Count - 1 downto 0 do
    begin
      Item := FTempMenu.Items[I];
      FTempMenu.Items.Delete(I);
      FButtonMenu.Insert(0, Item);
    end;
    FTempMenu.Free;
    FTempMenu := nil;
    FMenuButton := nil;
    FButtonMenu := nil;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetAutoRUL(const Value: Boolean);
begin
  FAutoRUL := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.UpControlInRUL(aControl: TControl);
var
  i: integer;
  OldValue: Boolean;
begin
  if FATBControls.IndexOf(aControl) >= 0 then
  begin
    if FAutoArrangeButtons then
    begin
      i := FRUControls.IndexOf(aControl);
      if (i >= 0) then
        FRUControls.Move(i, 0);

      i := FLUHidedControls.IndexOf(aControl);
      if (i >= 0) then
        FLUHidedControls.Delete(i);

      if aControl.Parent <> self then
      begin
        OldValue := FInternalControlUpdation;
        FInternalControlUpdation := True;
        aControl.Parent := self;
        FInternalControlUpdation := OldValue;
      end;
    end;

    if Assigned(FOptionWindow) then
    begin
      if FOptionWindow.Visible then
      begin
        HideOptionWindow;
        UpdateRULists;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.UpdateRULists;
var
  i, j, k, l, sl, sr, df, UHS: integer;
  FoundVC, OldV: Boolean;
  aControl: TControl;
begin
  if (ToolBarState <> tsDocked) or not Assigned(FATBControls) or not Assigned(FRUControls) or not Assigned(FLUHidedControls) then
    Exit;

  i := FATBControls.Count - 1;
  while (i >= 0) do
  begin
    if (FLUHidedControls.IndexOf(FATBControls[i]) < 0) and TControl(FATBControls[i]).Visible then
      Break;
    Dec(i);
  end;

  // found rightmost visible control

  if (i >= 0) then
  begin
    if Position in [daTop, daBottom] then
    begin
      if (TControl(FATBControls[i]).Left + TControl(FATBControls[i]).Width) >= (Width - PopupIndicatorWidth) then
      begin // Hide Controls
        df := (TControl(FATBControls[i]).Left + TControl(FATBControls[i]).Width) - (Width - PopupIndicatorWidth);
        while df > 0 do
        begin
          j := FRUControls.Count - 1;
          while j >= 0 do
          begin
            if (FLUHidedControls.IndexOf(FRUControls[j]) < 0) and not (TControl(FRUControls[j]) is TAdvToolBarSeparator) then
              Break;
            dec(j);
          end;

          if j >= 0 then
          begin
            FLUHidedControls.Add(FRUControls[j]);
            Dec(df, TControl(FRUControls[j]).Width);

            // Search for Separator to hide
            k := FATBControls.IndexOf(FRUControls[j]);
            if k >= 0 then
            begin
              FoundVC := false;
              sl := -1;
              sr := -1;

              for l := k - 1 downto 0 do
              begin
                if (TControl(FATBControls[l]) is TAdvToolBarSeparator) and (FLUHidedControls.IndexOf(FATBControls[l]) < 0) then
                begin
                  sl := l;
                  break;
                end;

                if FLUHidedControls.IndexOf(FATBControls[l]) < 0 then
                begin
                  FoundVC := true;
                  break;
                end;
              end;

              if not FoundVC then
              begin
                for l := k + 1 to FATBControls.Count - 1 do
                begin
                  if (TControl(FATBControls[l]) is TAdvToolBarSeparator) and (FLUHidedControls.IndexOf(FATBControls[l]) < 0) then
                  begin
                    sr := l;
                    break;
                  end;

                  if FLUHidedControls.IndexOf(FATBControls[l]) < 0 then
                  begin
                    FoundVC := true;
                    break;
                  end;
                end;
              end;

              if not FoundVC then
              begin // Hide Separator
                if (sl >= 0) and (TControl(FATBControls[sl]) is TAdvToolBarSeparator) then
                begin
                  FLUHidedControls.Add(FATBControls[sl]);
                  dec(df, TControl(FATBControls[sl]).Width);
                end
                else if (sr >= 0) and (TControl(FATBControls[sr]) is TAdvToolBarSeparator) then
                begin
                  FLUHidedControls.Add(FATBControls[sr]);
                  dec(df, TControl(FATBControls[sr]).Width);
                end;
              end;

            end;

          end
          else
            break;
        end;
      end
      else
      if (FLUHidedControls.Count > 0) and ((TControl(FATBControls[i]).Left + TControl(FATBControls[i]).Width) < (Width - PopupIndicatorWidth)) then
      begin // UnHide Controls
        df := ((TControl(FATBControls[i]).Left + TControl(FATBControls[i]).Width) - (Width - PopupIndicatorWidth));
        while df < 0 do
        begin {(TControl(FATBControls[i]).Left + TControl(FATBControls[i]).Width + }

          j := FLUHidedControls.Count - 1;
          while j >= 0 do
          begin
            if not (TControl(FLUHidedControls[j]) is TAdvToolBarSeparator) then
            begin
              if (TControl(FLUHidedControls[j]).width <= abs(df)) then
              begin
                UHS := -1;
                // Search for Separator to Unhide
                k := FATBControls.IndexOf(FLUHidedControls[j]);
                if k >= 0 then
                begin
                  FoundVC := false;
                  sl := -1;
                  sr := -1;

                  for l := k - 1 downto 0 do
                  begin
                    if TControl(FATBControls[l]) is TAdvToolBarSeparator then
                    begin
                      sl := l;
                      break;
                    end;

                    if FLUHidedControls.IndexOf(FATBControls[l]) < 0 then
                    begin
                      FoundVC := true;
                      break;
                    end;
                  end;

                  if not FoundVC then
                  begin
                    for l := k + 1 to FATBControls.Count - 1 do
                    begin
                      if TControl(FATBControls[l]) is TAdvToolBarSeparator then
                      begin
                        sr := l;
                        break;
                      end;

                      if FLUHidedControls.IndexOf(FATBControls[l]) < 0 then
                      begin
                        FoundVC := true;
                        break;
                      end;
                    end;
                  end;

                  if not FoundVC then
                  begin // Select Separator
                    if (sl >= 0) and (FLUHidedControls.IndexOf(FATBControls[sl]) >= 0) and (TControl(FATBControls[sl]) is TAdvToolBarSeparator) then
                    begin
                      UHS := sl;
                    end
                    else if (sr >= 0) and (FLUHidedControls.IndexOf(FATBControls[sr]) >= 0) and (TControl(FATBControls[sr]) is TAdvToolBarSeparator) then
                    begin
                      UHS := sr;
                    end;
                  end;

                end;

                // Unhide here
                if UHS >= 0 then
                begin
                  if (TControl(FLUHidedControls[j]).Width + (TControl(FATBControls[UHS]).Width) <= abs(df)) then
                  begin
                    aControl := TControl(FATBControls[UHS]);
                    if not(csDesigning in ComponentState) and not(csLoading in ComponentState) and (TControl(FLUHidedControls[j]).Parent <> self) then
                    begin
                      OldV := FInternalControlUpdation;
                      FInternalControlUpdation := True;
                      TControl(FLUHidedControls[j]).Parent := self;
                      FInternalControlUpdation := OldV;
                    end;

                    Inc(df, TControl(FLUHidedControls[j]).Width);
                    FLUHidedControls.Delete(j);

                    l := FLUHidedControls.IndexOf(aControl{FATBControls[UHS]});
                    if l >= 0 then
                    begin
                      inc(df, TControl(FLUHidedControls[l]).width);
                      FLUHidedControls.Delete(l);
                    end;
                  end
                  else // no more search
                  begin
                    j := FLUHidedControls.Count - 1;
                    Break;
                  end;
                end
                else
                begin

                  if not(csDesigning in ComponentState) and not(csLoading in ComponentState) and
                    (TControl(FLUHidedControls[j]).Parent <> self) then
                  begin
                    OldV := FInternalControlUpdation;
                    FInternalControlUpdation := True;
                    TControl(FLUHidedControls[j]).Parent := self;
                    FInternalControlUpdation := OldV;
                  end;

                  if (j < FLUHidedControls.Count) then
                  begin
                    inc(df, TControl(FLUHidedControls[j]).Width);
                    FLUHidedControls.Delete(j);
                  end;
                end;

                break;
              end
              else
              begin
                j := FLUHidedControls.Count - 1;
                break;
              end;
            end;

            dec(j);
          end;

          if (j = FLUHidedControls.Count - 1) then
            Break;

          (*
          if TControl(FLUHidedControls[j]).width{)} <= abs(df){(Width - PopupIndicatorWidth)} then
          begin
            inc(df, TControl(FLUHidedControls[j]).width);
            FLUHidedControls.Delete(j);
          end
          else
            break;
          *)
        end;
      end;

    end
    else // daLeft, daRight
    begin
      if (TControl(FATBControls[i]).Top + TControl(FATBControls[i]).Height) >= (Height - PopupIndicatorWidth) then
      begin // Hide Controls
        df := (TControl(FATBControls[i]).Top + TControl(FATBControls[i]).Height) - (Height - PopupIndicatorWidth);
        while df > 0 do
        begin
          j := FRUControls.Count - 1;
          while j >= 0 do
          begin
            if (FLUHidedControls.IndexOf(FRUControls[j]) < 0) and not (TControl(FRUControls[j]) is TAdvToolBarSeparator) then
              break;
            dec(j);
          end;

          if j >= 0 then
          begin
            FLUHidedControls.Add(FRUControls[j]);
            dec(df, TControl(FRUControls[j]).Height);

            // Search for Separator to hide
            k := FATBControls.IndexOf(FRUControls[j]);
            if k >= 0 then
            begin
              FoundVC := false;
              sl := -1;
              sr := -1;

              for l := k - 1 downto 0 do
              begin
                if (TControl(FATBControls[l]) is TAdvToolBarSeparator) and (FLUHidedControls.IndexOf(FATBControls[l]) < 0) then
                begin
                  sl := l;
                  break;
                end;

                if FLUHidedControls.IndexOf(FATBControls[l]) < 0 then
                begin
                  FoundVC := true;
                  break;
                end;
              end;

              if not FoundVC then
              begin
                for l := k + 1 to FATBControls.Count - 1 do
                begin
                  if (TControl(FATBControls[l]) is TAdvToolBarSeparator) and (FLUHidedControls.IndexOf(FATBControls[l]) < 0) then
                  begin
                    sr := l;
                    break;
                  end;

                  if FLUHidedControls.IndexOf(FATBControls[l]) < 0 then
                  begin
                    FoundVC := true;
                    break;
                  end;
                end;
              end;

              if not FoundVC then
              begin // Hide Separator
                if (sl >= 0) and (TControl(FATBControls[sl]) is TAdvToolBarSeparator) then
                begin
                  FLUHidedControls.Add(FATBControls[sl]);
                  dec(df, TControl(FATBControls[sl]).Height);
                end
                else if (sr >= 0) and (TControl(FATBControls[sr]) is TAdvToolBarSeparator) then
                begin
                  FLUHidedControls.Add(FATBControls[sr]);
                  dec(df, TControl(FATBControls[sr]).Height);
                end;
              end;

            end;

          end
          else
            break;
        end;
      end
      else if (FLUHidedControls.Count > 0) and ((TControl(FATBControls[i]).Top + TControl(FATBControls[i]).Height) < (Height - PopupIndicatorWidth)) then
      begin // UnHide Controls
        df := ((TControl(FATBControls[i]).Top + TControl(FATBControls[i]).Height) - (Height - PopupIndicatorWidth));
        while df < 0 do
        begin

          j := FLUHidedControls.Count - 1;
          while j >= 0 do
          begin
            if not (TControl(FLUHidedControls[j]) is TAdvToolBarSeparator) then
            begin
              if (TControl(FLUHidedControls[j]).Height <= abs(df)) then
              begin
                UHS := -1;
                // Search for Separator to Unhide
                k := FATBControls.IndexOf(FLUHidedControls[j]);
                if k >= 0 then
                begin
                  FoundVC := false;
                  sl := -1;
                  sr := -1;

                  for l := k - 1 downto 0 do
                  begin
                    if TControl(FATBControls[l]) is TAdvToolBarSeparator then
                    begin
                      sl := l;
                      break;
                    end;

                    if FLUHidedControls.IndexOf(FATBControls[l]) < 0 then
                    begin
                      FoundVC := true;
                      break;
                    end;
                  end;

                  if not FoundVC then
                  begin
                    for l := k + 1 to FATBControls.Count - 1 do
                    begin
                      if TControl(FATBControls[l]) is TAdvToolBarSeparator then
                      begin
                        sr := l;
                        break;
                      end;

                      if FLUHidedControls.IndexOf(FATBControls[l]) < 0 then
                      begin
                        FoundVC := true;
                        break;
                      end;
                    end;
                  end;

                  if not FoundVC then
                  begin // Select Separator
                    if (sl >= 0) and (FLUHidedControls.IndexOf(FATBControls[sl]) >= 0) and (TControl(FATBControls[sl]) is TAdvToolBarSeparator) then
                    begin
                      UHS := sl;
                    end
                    else if (sr >= 0) and (FLUHidedControls.IndexOf(FATBControls[sr]) >= 0) and (TControl(FATBControls[sr]) is TAdvToolBarSeparator) then
                    begin
                      UHS := sr;
                    end;
                  end;

                end;

                // Unhide here
                if UHS >= 0 then
                begin
                  if (TControl(FLUHidedControls[j]).Height + (TControl(FATBControls[UHS]).Height) <= abs(df)) then
                  begin
                    if not(csDesigning in ComponentState) and not(csLoading in ComponentState) and (TControl(FLUHidedControls[j]).Parent <> self) then
                    begin
                      OldV := FInternalControlUpdation;
                      FInternalControlUpdation := True;
                      TControl(FLUHidedControls[j]).Parent := self;
                      FInternalControlUpdation := OldV;
                    end;

                    inc(df, TControl(FLUHidedControls[j]).Height);
                    FLUHidedControls.Delete(j);

                    l := FLUHidedControls.IndexOf(FATBControls[UHS]);
                    if l >= 0 then
                    begin
                      inc(df, TControl(FLUHidedControls[l]).Height);
                      FLUHidedControls.Delete(l);
                    end;
                  end
                  else // no more search
                  begin
                    j := FLUHidedControls.Count - 1;
                    break;
                  end;
                end
                else
                begin
                  if not(csDesigning in ComponentState) and not(csLoading in ComponentState) and (TControl(FLUHidedControls[j]).Parent <> self) then
                  begin
                    OldV := FInternalControlUpdation;
                    FInternalControlUpdation := True;
                    TControl(FLUHidedControls[j]).Parent := self;
                    FInternalControlUpdation := OldV;
                  end;

                  inc(df, TControl(FLUHidedControls[j]).Height);
                  FLUHidedControls.Delete(j);
                end;

                break;
              end
              else
              begin
                j := FLUHidedControls.Count - 1;
                break;
              end;
            end;

            dec(j);
          end;

          if (j = FLUHidedControls.Count - 1) then
            break;

          {
          if TControl(FLUHidedControls[FLUHidedControls.Count-1]).Height <= abs(df) then
          begin
            inc(df, TControl(FLUHidedControls[FLUHidedControls.Count-1]).Height);
            FLUHidedControls.Delete(FLUHidedControls.Count-1);
          end
          else
            break;  }

        end;
      end;
    end;

    SetControlsPosition(false);
  end
  else
  begin // If All Controls are hided then unhide controls
    if Position in [daTop, daBottom] then
    begin
      if (FLUHidedControls.Count > 0) then
      begin
        df := (Width - PopupIndicatorWidth);
        if (FCurrentToolBarStyler.DragGripStyle <> dsNone) then
          df := df - DragGripWidth;

        df := -df;
        while df < 0 do
        begin
          if FLUHidedControls.Count > 0 then
          begin
            if TControl(FLUHidedControls[FLUHidedControls.Count - 1]).width <= abs(df) then
            begin
              if not(csDesigning in ComponentState) and not(csLoading in ComponentState) and (TControl(FLUHidedControls[FLUHidedControls.Count - 1]).Parent <> self) then
              begin
                OldV := FInternalControlUpdation;
                FInternalControlUpdation := True;
                TControl(FLUHidedControls[FLUHidedControls.Count - 1]).Parent := self;
                FInternalControlUpdation := OldV;
              end;

              inc(df, TControl(FLUHidedControls[FLUHidedControls.Count - 1]).width);
              FLUHidedControls.Delete(FLUHidedControls.Count - 1);
            end
            else
              break;
          end;
          if FLUHidedControls.Count = 0 then
            break;
        end;
        SetControlsPosition(false);
      end;
    end
    else // Postion in [daLeft, daRight]
    begin
      if (FLUHidedControls.Count > 0) then
      begin
        df := (Height - PopupIndicatorWidth);
        if (FCurrentToolBarStyler.DragGripStyle <> dsNone) then
          df := df - DragGripWidth;

        df := -df;
        while df < 0 do
        begin
          if TControl(FLUHidedControls[FLUHidedControls.Count - 1]).Height <= abs(df) then
          begin
            if not(csDesigning in ComponentState) and not(csLoading in ComponentState) and (TControl(FLUHidedControls[FLUHidedControls.Count - 1]).Parent <> self) then
            begin
              OldV := FInternalControlUpdation;
              FInternalControlUpdation := True;
              TControl(FLUHidedControls[FLUHidedControls.Count - 1]).Parent := self;
              FInternalControlUpdation := OldV;
            end;

            inc(df, TControl(FLUHidedControls[FLUHidedControls.Count - 1]).Height);
            FLUHidedControls.Delete(FLUHidedControls.Count - 1);
          end
          else
            break;
        end;
        SetControlsPosition(false);
      end;

    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetFloatingRows(const Value: integer);
begin
  if (Value <= 0) or (Value > GetMaxFloatingRowCount) then
    exit;

  if (FFloatingRows <> Value) then
  begin
    FFloatingRows := Value;
    if (csLoading in ComponentState) then
      exit;

    //FFloatingRows := Min(FFloatingRows, GetMaxFloatingRowCount);
    SetControlsPosition;
    if (ToolBarState = tsFloating) and Assigned(FFloatingWindow) and FFloatingWindow.Visible then
      FFloatingWindow.SetWindowSize;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetMaxFloatingRowCount: integer;
var
  i, mcs, x, y: integer;
begin
  mcs := 0;
  x := 2;

  for i := 0 to FATBControls.count - 1 do
  begin
    if Position in [daTop, daBottom] then
      mcs := Max(mcs, TControl(FAtbControls[i]).Width)
    else // daLeft, daRight
      mcs := Max(mcs, TControl(FAtbControls[i]).Height);
  end;

  mcs := mcs + x;
  mcs := max(mcs, FMinLength);
  y := 1;
  for i := 0 to FATBControls.count - 1 do
  begin
    if Position in [daTop, daBottom] then
    begin
      if (TControl(FAtbControls[i]).Width > (mcs - x)) then
      begin
        inc(y);
        x := 2;
      end;
      inc(x, TControl(FAtbControls[i]).Width);
    end
    else // daLeft, daRight
    begin
      if (TControl(FAtbControls[i]).Height > (mcs - x)) then
      begin
        inc(y);
        x := 2;
      end;
      inc(x, TControl(FAtbControls[i]).Height);
    end;

    if x >= mcs then
    begin
      inc(y);
      x := 2;
    end;
  end;

  Result := y;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.GetFloatingSizes(var aHeight, aWidth: integer);
var
  i, x, y, empty: integer;
  AllSet: Boolean;
begin
  aWidth := 0;

  for i := 0 to FATBControls.count - 1 do
  begin
    if Position in [daTop, daBottom] then
      aWidth := Max(aWidth, TControl(FAtbControls[i]).Width)
    else // daLeft, daRight
      aWidth := Max(aWidth, TControl(FAtbControls[i]).Height);
  end;

  x := 2;
  aWidth := aWidth + x * 2;
  aWidth := max(aWidth, FMinLength);
  AllSet := false;
  empty := aWidth;

  while not AllSet do
  begin
    x := 2;
    y := 1;
    for i := 0 to FATBControls.count - 1 do
    begin
      if Position in [daTop, daBottom] then
      begin
        if (TControl(FAtbControls[i]).Width > (aWidth - x - 2)) then
        begin
          empty := min(empty, (aWidth - x - 2));
          inc(y);
          x := 2;
        end;
        inc(x, TControl(FAtbControls[i]).Width);
      end
      else // daLeft, daRight
      begin
        if (TControl(FAtbControls[i]).Height > (aWidth - x - 2)) then
        begin
          empty := min(empty, (aWidth - x - 2));
          inc(y);
          x := 2;
        end;
        inc(x, TControl(FAtbControls[i]).Height);
      end;

      if Y > FFloatingRows then
        break;
    end;

    if Y <= FFloatingRows then
    begin
      AllSet := true;
      aHeight := Y * FSizeAtDock + CaptionHeight;
      if Y > 1 then
      begin
        empty := min(empty, (aWidth - x - 2));
        Dec(aWidth, empty);
      end;
    end
    else
    begin
      inc(aWidth, 10);
    end;

  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetFloatingWindowSizes(aRows: integer;
  var aHeight, aWidth: integer): Boolean;
var
  i, x, y, empty: integer;
  AllSet: Boolean;
begin
  Result := false;

  if (aRows <= 0) or (aRows > GetMaxFloatingRowCount) then
    exit;

  aWidth := 0;

  for i := 0 to FATBControls.count - 1 do
  begin
    if Position in [daTop, daBottom] then
      aWidth := Max(aWidth, TControl(FAtbControls[i]).Width)
    else // daLeft, daRight
      aWidth := Max(aWidth, TControl(FAtbControls[i]).Height);
  end;

  x := 2;
  aWidth := aWidth + x * 2;
  aWidth := max(aWidth, FMinLength);
  AllSet := false;
  empty := aWidth;
  Result := true;

  while not AllSet do
  begin
    x := 2;
    y := 1;
    for i := 0 to FATBControls.count - 1 do
    begin
      if Position in [daTop, daBottom] then
      begin
        if (TControl(FAtbControls[i]).Width > (aWidth - x - 2)) then
        begin
          empty := min(empty, (aWidth - x - 2));
          inc(y);
          x := 2;
        end;
        inc(x, TControl(FAtbControls[i]).Width);
      end
      else // daLeft, daRight
      begin
        if (TControl(FAtbControls[i]).Height > (aWidth - x - 2)) then
        begin
          empty := min(empty, (aWidth - x - 2));
          inc(y);
          x := 2;
        end;
        inc(x, TControl(FAtbControls[i]).Height);
      end;

      if Y > aRows then
        break;
    end;

    if Y <= aRows then
    begin
      AllSet := true;
      aHeight := Y * FSizeAtDock + CaptionHeight;
      if Y > 1 then
      begin
        empty := min(empty, (aWidth - x - 2));
        Dec(aWidth, empty);
      end;
    end
    else
    begin
      inc(aWidth, 10);
    end;

  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetShowRightHandle(const Value: Boolean);
begin
  if FShowRightHandle <> Value then
  begin
    FShowRightHandle := Value;

    if FShowRightHandle then
    begin
      PopupIndicatorWidth := DEFAULT_POPUPINDICATORWIDTH;
    end
    else
    begin
      PopupIndicatorWidth := 4;
    end;
    SetControlsPosition;
    if Assigned(FCurrentDock) and (ToolBarState = tsDocked) then
      FCurrentDock.Rows.SetRowsPosition;

    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.OptionIndicatorClick;
var
  pt,spt: TPoint;
begin
  if (Assigned(FOnOptionClick) or Assigned(OptionMenu)) and Assigned(Parent) then
  begin
    if ToolBarState <> tsFLoating then
    begin
      pt := Point(Left + Width - 12, Top + Height + 1);
      spt := Parent.ClientToScreen(pt);
    end
    else
    begin
      if ShowClose then
        pt := Point(Left + Width - 40, Top + CaptionHeight - 2)
      else
        pt := Point(Left + Width - 20, Top + CaptionHeight - 2);
      spt := ClientToScreen(pt);
    end;

    if Assigned(FOnOptionCLick) then
      FOnOptionClick(self, pt, spt );
   { if Assigned(OptionMenu) then
    begin
      if OptionMenu is TAdvPopupMenu then
      begin
        (OptionMenu as TAdvPopupMenu).MenuStyler := ToolBarStyler.AdvMenuStyler;
      end;

      OptionMenu.Popup(spt.X,spt.Y);
    end;
    }
    ShowOptionWindow(0, 0, False);

    if FDownPopupIndicator or FHotPopupIndicator then
    begin
      FDownPopupIndicator := false;
      FHotPopupIndicator := False;
      DrawPopupIndicator;
    end;

  end
  else if Assigned(Parent) then
  begin
    ShowOptionWindow(0, 0, False);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetPersistence(const Value: TPersistence);
begin
  FPersistence.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.LoadPosition;
var
  L, T, FR, St, V, I, SV: integer;
  {$IFDEF DELPHI4_LVL}
  IniFile: TCustomIniFile;
  {$ELSE}
  IniFile: TIniFile;
  {$ENDIF}
  N : String;
begin

  if (FPersistence.Enabled) and (FPersistence.Key <>'') and
     (FPersistence.Section <>'') and
     (not (csDesigning in ComponentState)) then
  begin
    {$IFDEF DELPHI4_LVL}
    if FPersistence.location = plRegistry then
      IniFile := TRegistryIniFile.Create(FPersistence.Key)
    else
    {$ENDIF}
      IniFile := TIniFile(tIniFile.Create(FPersistence.Key));

    with IniFile do
    begin
      //OldV:= AllowBoundChange;
      //AllowBoundChange:= true;

      N := ReadString(FPersistence.section, Name+'.Name', '');
      St := ReadInteger(FPersistence.section, Name+'.State', integer(tsDocked));

      if (N <> '') and (UpperCase(N) = UpperCase(Name)) and (TToolBarState(st) = tsFloating) then
      begin
        {i := ReadInteger(FPersistence.section,'Width', Width);
        if Constraints.MaxWidth < i then
          Constraints.MaxWidth:= i;
        if (i <> Width) then
          Width := i;
        }
        //i := ReadInteger(FPersistence.section,'Height', Height);

        FR := ReadInteger(FPersistence.section, Name+'.FloatingRows', FloatingRows);
        L := ReadInteger(FPersistence.Section, Name+'.Left', Left);
        T := ReadInteger(FPersistence.section, Name+'.Top', Top);
        SetFloating(L, T, True);
        if FR > FloatingRows then
          FloatingRows:= FR;

        SV := ReadInteger(FPersistence.section, Name+'.Visible', Integer(Self.Visible));
        if self.Visible <> Boolean(SV) then
          self.Visible := Boolean(SV);
      end;

      //if (N <> '') and (UpperCase(N) = UpperCase(Name)) then
      begin
        for I:= 0 to FATBControls.Count-1 do
        begin
          if (TControl(FATBControls[i]).Name <> '') then
          begin
            V := ReadInteger(FPersistence.section, Name+'.'+TControl(FATBControls[i]).Name, Integer(TControl(FATBControls[i]).Visible));
            if V <> Integer(TControl(FATBControls[i]).Visible) then
            begin
              TControl(FATBControls[i]).Visible := Boolean(V);
            end;
          end;
        end;
      end;
      
      //AllowBoundChange:= OldV;
    end;
    IniFile.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SavePosition;
var
  N: String;
  St, i: integer;
  {$IFDEF DELPHI4_LVL}
  IniFile: TCustomIniFile;
  {$ELSE}
  IniFile: TIniFile;
  {$ENDIF}
begin
  if (FPersistence.Enabled) and (FPersistence.Key <>'') and
     (FPersistence.Section <>'') and
     (not (csDesigning in ComponentState)) then
  begin
    {$IFDEF DELPHI4_LVL}
    if FPersistence.Location = plRegistry then
      IniFile := TRegistryIniFile.Create(FPersistence.Key)
    else
    {$ENDIF}
      IniFile := TIniFile.Create(FPersistence.Key);

    with IniFile do
    begin
      if (ToolBarState = tsFloating) then
      begin
        WriteString(FPersistence.section, Name+'.Name', Name);
        WriteInteger(FPersistence.section, Name+'.State', integer(ToolBarState));
        WriteInteger(FPersistence.section, Name+'.FloatingRows', FloatingRows);
        WriteInteger(FPersistence.section, Name+'.Left', FFloatingWindow.Left);
        WriteInteger(FPersistence.section, Name+'.Top', FFloatingWindow.Top);
        WriteInteger(FPersistence.section, Name+'.Width', Width);
        WriteInteger(FPersistence.section, Name+'.Height', Height);
        WriteInteger(FPersistence.section, Name+'.Visible', integer(Self.Visible));
      end
      else
      begin
        N := ReadString(FPersistence.section, Name+'.Name', '');
        St := ReadInteger(FPersistence.section, Name+'.State', integer(tsDocked));
        if (N <> '') and (UpperCase(N) = UpperCase(Name)) and (TToolBarState(st) = tsFloating) then
        begin
          WriteInteger(FPersistence.section, Name+'.State', integer(ToolBarState));
        end;
      end;

      for I:= 0 to FATBControls.Count-1 do
      begin
        if (TControl(FATBControls[i]).Name <> '') then
          WriteInteger(FPersistence.section, Name+'.'+TControl(FATBControls[i]).Name, Integer(TControl(FATBControls[i]).Visible));
      end;
    end;
    IniFile.Free;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetShowHint: Boolean;
begin
  Result := inherited ShowHint;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetShowHint(const Value: Boolean);
begin
  inherited ShowHint := Value;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetMenuItemCount: integer;
  procedure CountChildItems(Item: TMenuItem);
  var
    i: integer;
  begin
    for i:=0 to Item.Count-1 do
      CountChildItems(Item.Items[i]);

    inc(Result);
  end;

var
  i: integer;
begin
  Result := 0;
  for i:=0 to FMenu.Items.Count - 1 do
    CountChildItems(FMenu.Items[i]);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.OnMainMenuChange(Sender: TObject;
  Source: TMenuItem; Rebuild: Boolean);
var
  I: integer;
  ReqReBuild: Boolean;
  OldMenu: TMainMenu;
begin
  if not (csDesigning in ComponentState) then
    exit;

  if FTempMenuItemCount <= 0 then
  begin
    ReqReBuild := False;

    if (Source <> nil) then
    begin
      for I := 0 to FMenu.Items.Count - 1 do
      begin
        if Source = FMenu.Items[I] then
        begin
          ReqReBuild := True;    // May Required ReBuild since it is root item
          Break;
        end;
      end;

      if ReqReBuild then
      begin
        for I := 0 to FATBControls.Count - 1 do
        begin
          if (TControl(FATBControls[I]) is TAdvToolBarMenuButton) and (TAdvToolBarMenuButton(FATBControls[I]).FToolBarCreated)
             and (TAdvToolBarMenuButton(FATBControls[I]).MenuItem = Source) then
          begin
            TAdvToolBarMenuButton(FATBControls[I]).MenuItem := TAdvToolBarMenuButton(FATBControls[I]).MenuItem;
            ReqReBuild:= false;
            Break;
          end;
        end;
      end;
    end;

  {  if Assigned(FMenuImages) and Assigned(FMenu.Images) then
      showmessage(FMenuImages.Name + ' ' + FMenu.Images.name)
    else if Assigned(FMenuImages) then
      showmessage(FMenuImages.Name)
    else if Assigned(FMenu.Images) then
      showmessage(FMenu.Images.name);

    if csLoading in ComponentState then
      showmessage('Self is loading');
    if csLoading in FMenu.ComponentState then
      showmessage('Menu is loading');
   }
    if FMenu.Images <> FMenuImages then
    begin
      FTempMenuItemCount := GetMenuItemCount - 1;
      //FMenuImages := FMenu.Images; // set in SetMenu
    end;

    if ReqReBuild or (Source = nil) then
    begin
      OldMenu := FMenu;
      SetMenu(nil);
      SetMenu(OldMenu);
    end;

  end
  else
  begin
    Dec(FTempMenuItemCount);
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.WMGetDlgCode(var Message: TMessage);
begin
  if FInMenuLoop then
    Message.Result := DLGC_WANTARROWS;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.WMSysCommand(var Message: TWMSysCommand);
var
  Button: TAdvCustomToolBarButton;
begin
  { Enter menu loop if only the Alt key is pressed -- ignore Alt-Space and let
    the default processing show the system menu. }
  if not FInMenuLoop and Enabled and Showing {and ShowCaptions} and Assigned(FMenu) then
    with Message do
      if (CmdType and $FFF0 = SC_KEYMENU) and (Key <> VK_SPACE) and
        (Key <> Word('-')) and (GetCapture = 0) then
      begin
        if Key = 0 then
          Button := nil else
          Button := FindButtonFromAccel(Key);
        if (Key = 0) or (Button <> nil) then
        begin
          TrackMenu(Button);
          Result := 1;
          Exit;
        end;
      end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.TrackMenu(
  Button: TAdvCustomToolBarButton): Boolean;
begin
  { Already in menu loop - click button to drop-down menu }
  if FInMenuLoop then
  begin
    if Button <> nil then
    begin
      ClickButton(Button);
      Result := True;
    end
    else
      Result := False;
    Exit;
  end;

  InitMenu(Button);
  try                      // FF: Menu with one root Item causing disable mouse click after showing menu
    if Assigned(Menu){ and (Menu.Items.Count > 1) }then  // FF: DropDown Menu with MenuButton only causing disable mouse click after showing menu
    begin
      FInMenuLoop := True;
      repeat
        Application.HandleMessage;
        if Application.Terminated then
          FInMenuLoop := False;
      until not FInMenuLoop;
    end;
  finally
    CancelMenu;
  end;
  Result := FMenuResult;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.InitMenu(Button: TAdvCustomToolBarButton);
{var
  Button2: TAdvCustomToolBarButton;
  MP: TPoint;  }
begin
  Perform(TB_SETANCHORHIGHLIGHT, 1, 0);
  MenuToolBar2 := Self;
  MouseCapture := True;
  FMenuFocused := True;
  InitToolMenuKeyHooks;
  if Button <> nil then
  begin
    //Perform(TB_SETHOTITEM, Button.Index, 0);
    SetButtonHot(Button.Index);
    //ClickButton(Button);
    Button.DoDropDown;
  end
  else
  begin
    SetButtonHot(0);
   { GetCursorPos(MP);
    Mp := ScreenToClient(Mp);
    Button2 := ButtonAtPos(Mp.X, MP.Y);
    if (Button2 <> nil) then
    begin
      Button2.FUnHotTimer.Enabled := False;
      Button2.FMouseInControl := false;
      Button2.FHot := false;
      if Button2.Enabled then
        Button2.InvalidateMe;
    end;}
  end;
    //Perform(TB_SETHOTITEM, 0, 0);
  if Button = nil then
    FCaptureChangeCancels := True;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CNSysKeyDown(var Message: TWMSysKeyDown);
begin
  inherited;
  if (Message.CharCode = VK_MENU) then
    CancelMenu;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CNChar(var Message: TWMChar);
begin
  { We got here through the installed ToolMenuKeyHook }
  if FInMenuLoop and not (csDesigning in ComponentState) then
    with Message do
      if Perform(CM_DIALOGCHAR, CharCode, KeyData) <> 0 then
        Result := 1;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.WMCaptureChanged(var Message: TMessage);
begin
  inherited;
  if FInMenuLoop and FCaptureChangeCancels then CancelMenu;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.WMKeyDown(var Message: TWMKeyDown);
var
  //Item: Integer;
  I: Integer;
  Button: TAdvCustomToolBarButton;
  P: TPoint;
begin
  if FInMenuLoop then
  begin
    //Item := Perform(TB_GETHOTITEM, 0, 0);
    Button := FHotButton;
    case Message.CharCode of
      VK_RETURN, VK_DOWN:
        begin
          //if (Item > -1) and (Item < FATBControls.Count) then
          if Button <> nil then
          begin
            //Button := TAdvCustomToolBarButton(FATBControls[Item]);
            P := Button.ClientToScreen(Point(1, 1));
            Button.DoDropDown;
            //ClickButton(Button);
          end;
          { Prevent default processing }
          if Message.CharCode = VK_DOWN then Exit;
        end;
      VK_ESCAPE: CancelMenu;
      VK_LEFT:
      begin
        if FHotButton <> nil then
        begin
          I := FHotButton.Index;
          I := I -1;
          if (I < 0) or (I >= FATBControls.Count) then
            I := FATBControls.Count-1;

          if I >= 0 then
            SetButtonHot(I);
        end;
      end;
      VK_RIGHT:
      begin
        if FHotButton <> nil then
        begin
          I := FHotButton.Index;
          I := I +1;
          if (I < 0) or (I >= FATBControls.Count) then
            I := 0;
          if I >= 0 then
            SetButtonHot(I);
        end;
      end;
    end;
  end;
  inherited;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.SetButtonHot(Button: TAdvCustomToolBarButton): Boolean;
begin
  Result := false;
  if Assigned(Button) then
  begin
    Button.Hot := True;
    Result := True;
  end
  else if FHotButton <> nil then
  begin
    FHotButton.Hot := false;
    Result := True;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.SetButtonHot(ButtonNumber: Integer): Boolean;
var
  I, J: Integer;
  Button: TAdvCustomToolBarButton;
begin
  Result := False;
  if ButtonNumber >= 0 then
  begin
    Button := nil;
    J := 0;
    for i := 0 to FATBControls.Count - 1 do
    begin
      if (TControl(FATBControls[i]) is TAdvToolBarMenuButton) and TControl(FATBControls[i]).Visible and TControl(FATBControls[i]).Enabled
          and (((FLUHidedControls.IndexOf(FATBControls[i]) < 0) and (ToolBarState = tsDocked)) or (ToolBarState in [tsFloating, tsFixed])) then
      begin
        if (J = ButtonNumber) then
        begin
          Button := TAdvCustomToolBarButton(FATBControls[i]);
          break;
        end;
        inc(J);
      end;
    end;
    if Button <> nil then
      Result := SetButtonHot(Button);
  end
  else
  begin
    Result := True;
    SetButtonHot(nil);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.UpdateButtonHot(Button: TAdvCustomToolBarButton);
begin
  if Assigned(Button) then
  begin
    if Button.Hot then
    begin
      if (FHotButton <> nil) and (FHotButton <> Button) then
        FHotButton.Hot := false;
      FHotButton := Button;
    end
    else
    begin
      if FHotButton = Button then
        FHotButton := nil;
    end;

  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetAllowFloating(const Value: Boolean);
begin
  if FAllowFloating <> Value then
  begin
    FAllowFloating := Value;
    if (ToolBarState = tsFloating) and not FAllowFloating then
      FAllowFloating := True;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetLocked(const Value: Boolean);
begin
  if FLocked <> Value then
  begin
    FLocked := Value;
    if (ToolBarState = tsFloating) and Value then
      FLocked := False;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.InitializeOptionWindow;
var
  i: Integer;
begin
  if not (csDesigning in ComponentState){ and AutoOptionMenu} then
  begin
    if not Assigned(FOptionWindow) then
    begin
      FOptionWindow := TOptionSelectorWindow.CreateNew(self);
      FOptionWindow.Parent := self;   // FF: D2005
      FOptionWindow.BorderIcons := [];
      FOptionWindow.BorderStyle := bsNone;
      FOptionWindow.Ctl3D := false;
      FOptionWindow.FormStyle := fsStayOnTop;
      FOptionWindow.Visible := False;
      FOptionWindow.Width := 10;
      FOptionWindow.Height := 10;
      FOptionWindow.AutoScroll := False;
      FOptionWindow.BorderWidth := 0;
      FOptionWindow.OnHide := OnOptionWindowHide;
      FOptionWindow.AdvToolBar := Self;
    end;

    if not Assigned(FOptionWindowPanel) then
    begin
      FOptionWindowPanel := TControlSelectorPanel.Create(FOptionWindow);
      FOptionWindowPanel.Parent := FOptionWindow;
    end;
    
    FOptionWindowPanel.ShowAddAndRemoveBtn := AutoOptionMenu;
    if Assigned(self.OptionMenu) then
      if (self.OptionMenu is TAdvPopupMenu) then
        TAdvPopupMenu(OptionMenu).MenuStyler := FCurrentToolBarStyler.CurrentAdvMenuStyler;
        
    FOptionWindowPanel.OptionsMenu := self.OptionMenu;
    FOptionWindowPanel.TextAutoOptionMenu := self.TextAutoOptionMenu;
    FOptionWindowPanel.TextOptionMenu := self.TextOptionMenu;

    if Assigned(FMenu) then
    begin
      FOptionWindowPanel.ItemColorHot := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.HoverColor;
      FOptionWindowPanel.ItemColorHotTo := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.HoverColorTo;
      FOptionWindowPanel.ItemColorDown := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.SelectedColor;
      FOptionWindowPanel.ItemColorDownTo := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.SelectedColorTo;
      FOptionWindowPanel.ItemTextColor := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.Font.Color;
      FOptionWindowPanel.ItemTextColorHot := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.HoverTextColor;
      FOptionWindowPanel.ItemTextColorDown := FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.SelectedTextColor;
    end
    else
    begin
      FOptionWindowPanel.ItemColorHot := FCurrentToolBarStyler.ButtonAppearance.ColorHot;
      FOptionWindowPanel.ItemColorHotTo := FCurrentToolBarStyler.ButtonAppearance.ColorHotTo;
      FOptionWindowPanel.ItemColorDown := FCurrentToolBarStyler.ButtonAppearance.ColorDown;
      FOptionWindowPanel.ItemColorDownTo := FCurrentToolBarStyler.ButtonAppearance.ColorDownTo;
      FOptionWindowPanel.ItemTextColor := FCurrentToolBarStyler.ButtonAppearance.CaptionTextColor;
      FOptionWindowPanel.ItemTextColorHot := FCurrentToolBarStyler.ButtonAppearance.CaptionTextColorHot;
      FOptionWindowPanel.ItemTextColorDown := FCurrentToolBarStyler.ButtonAppearance.CaptionTextColorDown;
    end;

    FOptionWindow.OptionsPanel := FOptionWindowPanel;
    FOptionWindowPanel.ControlList.Clear;

    // Assigning Hidden Controls
    FInternalControlUpdation := True;
    for i:= 0 to FLUHidedControls.Count-1 do
    begin
      if not (TControl(FLUHidedControls[i]) is TAdvToolBarSeparator) then
        FOptionWindowPanel.AddControl(TControl(FLUHidedControls[i]));
    end;
    FInternalControlUpdation := False;

    FOptionWindowPanel.ArrangeControls;

    FOptionWindow.SetWindowSize;

  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.OnOptionWindowHide(Sender: TObject);
begin
 { State := absUp; }
  UpdateRULists;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.ShowOptionWindow(X, Y: Integer; ForcePoint: Boolean=True);
var
  pt, spt: TPoint;
  R: TRect;
  {$IFDEF DELPHI9_LVL}
  w,h: Integer;
  {$ENDIF}
begin
  //if not AutoOptionMenu then
    //exit;

  InitializeOptionWindow;
  if not ForcePoint then
  begin
    if ToolBarState <> tsFLoating then
    begin
      pt := Point(Left + Width - 12, Top + Height + 1);
      spt := Parent.ClientToScreen(pt);

    {$IFNDEF TMSDOTNET}
      SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
    {$ENDIF}
    {$IFDEF TMSDOTNET}
      SystemParametersInfo(SPI_GETWORKAREA, 0, R, 0);
    {$ENDIF}

      if R.Bottom < (spt.Y + FOptionWindow.Height + 2) then
        spt.Y := spt.Y - ((spt.Y + FOptionWindow.Height + 2) - R.Bottom);

      if (R.Right < spt.X + FOptionWindow.Width) then
      begin
        if Position = daRight then
          spt.X := ClientToScreen(Point(Left - FOptionWindow.Width, Top + Height + 1)).X
        else
          spt.X := spt.X - ((spt.X + FOptionWindow.Width) - R.Right);
      end;

    end
    else
    begin
      if ShowClose then
        pt := Point(Left + Width - 40, Top + CaptionHeight - 2)
      else
        pt := Point(Left + Width - 20, Top + CaptionHeight - 2);
      spt := ClientToScreen(pt);
    end;
    X := spt.X;
    Y := spt.Y;
  end;

  if not FOptionWindowPanel.IsEmpty then
  begin
    {$IFDEF DELPHI9_LVL}
    w := FOptionWindow.Width;
    h := FOptionWindow.Height;
    FOptionWindow.Width := 0;
    FOptionWindow.Height := 0;
    FOptionWindow.Visible := True;
    {$ENDIF}

    FOptionWindow.Left := X;
    FOptionWindow.Top := Y;
    FOptionWindow.Visible := True;

    {$IFDEF DELPHI9_LVL}
    FOptionWindow.Width := w;
    FOptionWindow.Height := h;
    {$ENDIF}
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.HideOptionWindow;
begin
  if Assigned(FOptionWindow) and FOptionWindow.visible then
  begin
    FOptionWindow.visible := False;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetAutoOptionMenu(const Value: Boolean);
begin
  if FAutoOptionMenu <> Value then
  begin
    FAutoOptionMenu := Value;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.UpdateMenu;
var
  ReAssignMenu, ItemFound: Boolean;
  I, J: Integer;
  OldMenu: TMainMenu;
begin
  if Assigned(FMenu) then
  begin
    ReAssignMenu := False;

    for I := 0 to FMenu.Items.Count - 1 do
    begin
      ItemFound := False;
      for J := 0 to FATBControls.Count - 1 do
      begin
        if (TControl(FATBControls[J]) is TAdvToolBarMenuButton) and (TAdvToolBarMenuButton(FATBControls[J]).FToolBarCreated)
           and (TAdvToolBarMenuButton(FATBControls[J]).MenuItem = FMenu.Items[I]) then
        begin
          TAdvToolBarMenuButton(FATBControls[J]).MenuItem := FMenu.Items[I]; // Refresh Item
          ItemFound := True;
          Break;
        end;
      end;

      if not ItemFound then
      begin
        ReAssignMenu := True;
        Break;
      end;
    end;

    if ReAssignMenu then
    begin
      OldMenu := FMenu;
      SetMenu(nil);
      SetMenu(OldMenu);
    end;

  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.AdjustSizeOfAllButtons(
  MenuButtonsOnly: Boolean);
var
  I: Integer;  
begin
  for i := 0 to FATBControls.Count - 1 do
  begin
    if MenuButtonsOnly then
    begin
      if TControl(FATBControls[i]) is TAdvToolBarMenuButton then
        TAdvToolBarMenuButton(FAtbControls[i]).AdjustSize;
    end
    else
    begin
      if TControl(FATBControls[i]) is TAdvCustomToolBarButton then
        TAdvCustomToolBarButton(FAtbControls[i]).AdjustSize;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  if (Self.ToolBarState = tsDocked) and Assigned(FCurrentDock) then
  begin
    if not (csDesigning in ComponentState) then
      FCurrentDock.UpdateToolBarVisibility(self);
  end
  else if (Self.ToolBarState = tsFloating) then
  begin
    if (FFloatingWindow <> nil) {and (FFloatingWindow.Visible)} then
    begin
      FAutoHiding := Self.Visible;
      FFloatingWindow.Visible := Self.Visible;
    end;  
  end;

end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.IsShortCut(var Message: TWMKey): Boolean;
begin
  Result := False;
  if Assigned(FMenu) then
    Result := FMenu.IsShortCut(Message);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetAutoArrangeButtons(const Value: Boolean);
begin
  if FAutoArrangeButtons <> Value then
  begin
    FAutoArrangeButtons := Value;

    if not FAutoArrangeButtons and not(csLoading in ComponentState) and FAutoRUL then
    begin
      FRUControls.Clear;
      {$IFDEF DELPHI6_LVL}
      FRUControls.Assign(FATBControls, laCopy);
      {$ENDIF}
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetMaxLength: Integer;
var
  x, y, i, w: Integer;
begin
  W := FMinLength;
  if (Position in [daTop, daBottom]) or (FToolBarState = tsFloating) then
  begin
    if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
      x := DragGripWidth + 2
    else
      x := 2;
    {
    if Self.ToolBarState in [tsDocked, tsFixed] then
      y := 2
    else
      y := 2 + CaptionHeight;
    }

    for i := 0 to FATBControls.Count - 1 do
    begin
      if TControl(FATBControls[i]).Visible then
        x := x + TControl(FATBControls[i]).Width;
    end;

    if ShowPopupIndicator then
      x := x + PopupIndicatorWidth;

    x := Max(x, W);
    Result := x;
  end
  else // if Position in [daLeft, daRight] then
  begin
    if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
      y := DragGripWidth + 2
    else
      y := 2;

    for i := 0 to FATBControls.Count - 1 do
    begin
      if TControl(FATBControls[i]).Visible then
        y := y + TControl(FATBControls[i]).Height;
    end;

    if ShowPopupIndicator then
      y := y + PopupIndicatorWidth;

    y := Max(y, W);
    Result := y;
  end;
end;
(*
var
  i, W, H, MaxS, MaxCtrlS: Integer;
begin
  if (Position in [daTop, daBottom]) or (FToolBarState = tsFloating) then
  begin
    W := FMinLength;
    if FATBControls.Count > 0 then
    begin
      i := FATBControls.count - 1;
      while i >= 0 do
      begin
        if {(FLUHidedControls.IndexOf(FATBControls[i]) < 0) and }TControl(FATBControls[i]).visible then
          break;
        dec(i);
      end;

      if i >= 0 then
        W := TControl(FATBControls[i]).Left + TControl(FATBControls[i]).Width
      else
        W := MIN_BUTTONSIZE;

      if ShowPopupIndicator then
      begin
        if (FToolBarState = tsFloating) then
          W := W + 2
        else
          W := W + PopupIndicatorWidth;
      end;
    end;

    if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
      MaxS := DragGripWidth + 2
    else
      MaxS := 2;

    MaxCtrlS := DEFAULT_TOOLBARHEIGHT;
    for i := 0 to FATBControls.count - 1 do
    begin
      if TControl(FATBControls[i]).visible then
      begin
        MaxS := MaxS + TControl(FATBControls[i]).Width;
        if not (TControl(FATBControls[i]) is TAdvToolBarSeparator) then
          MaxCtrlS := Max(MaxCtrlS, TControl(FATBControls[i]).Height + 4);
      end;
    end;

    if ShowPopupIndicator then
      MaxS := MaxS + PopupIndicatorWidth;

    MaxS := Max(MaxS, W);
    Result := MaxS;
  end
  else // if Position in [daLeft, daRight] then
  begin
    H := FMinLength;
    if FATBControls.Count > 0 then
    begin
      i := FATBControls.count - 1;
      while i >= 0 do
      begin
        if {(FLUHidedControls.IndexOf(FATBControls[i]) < 0) and }TControl(FATBControls[i]).visible then
          break;
        dec(i);
      end;

      if i >= 0 then
        H := TControl(FATBControls[i]).Top + TControl(FATBControls[i]).Height
      else
        H := MIN_BUTTONSIZE;

      if ShowPopupIndicator then
        H := H + PopupIndicatorWidth;
    end;

    if (FCurrentToolBarStyler.DragGripStyle <> dsNone) and (ToolBarState <> tsFloating) then
      MaxS := DragGripWidth + 2
    else
      MaxS := 2;

    MaxCtrlS := DEFAULT_TOOLBARHEIGHT;
    for i := 0 to FATBControls.count - 1 do
    begin
      if TControl(FATBControls[i]).visible then
      begin
        MaxS := MaxS + TControl(FATBControls[i]).Height;
        if not (TControl(FATBControls[i]) is TAdvToolBarSeparator) then
          MaxCtrlS := Max(MaxCtrlS, TControl(FATBControls[i]).Width + 4);
      end;
    end;

    if ShowPopupIndicator then
      MaxS := MaxS + PopupIndicatorWidth;

    MaxS := Max(MaxS, H);
    Result := MaxS;
  end;
end;
*)
//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.WMTimer(var Message: TWMTimer);
begin
  inherited;
  if not FParentForm.Visible and FFloatingWindow.Visible then
  begin
    FFloatingWindow.Visible := False;
    FAutoHiding := True;
  end;

  if FParentForm.Visible and not FFloatingWindow.Visible and FAutoHiding then
  begin
    FAutoHiding := False;
    FFloatingWindow.Visible := True;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.WndProc(var Message: TMessage);
begin
  if (Message.Msg = WM_DESTROY) then
  begin
    if FTimerID <> 0 then
    begin
      KillTimer(Handle, FTimerID);
      FTimerID := 0;
    end;
  end;

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetDisabledImages(const Value: TCustomImageList);
var
  i: Integer;
begin
  if Value <> FDisabledImages then
  begin
    FDisabledImages := Value;

    for i := 0 to FATBControls.Count - 1 do
    begin
      if TControl(FATBControls[i]) is TAdvCustomToolBarControl then
        TAdvCustomToolBarControl(FAtbControls[i]).AdjustSize;
    end;

    Invalidate;
  end;

end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetToolBarControlCount: Integer;
begin
  Result := FATBControls.Count;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetToolBarControls(index: Integer): TControl;
begin
  Result := nil;
  if (Index >= 0) and (Index < FATBControls.Count) then
    Result := FATBControls[Index];
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.IndexOfToolBarControl(
  AControl: TControl): Integer;
begin
  Result := FATBControls.IndexOf(AControl);
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.AddToolBarControl(AControl: TControl): Integer;
var
  i: Integer;
begin
  Result := -1;
  if (AControl <> nil) and (FATBControls.IndexOf(AControl) < 0) and (AControl.Parent <> self) then
  begin
    AControl.Parent := Self;
    i := FATBControls.IndexOf(AControl);
    if i >= 0 then
    begin
      MoveToolBarControl(I, ToolBarControlCount-1);
      Result := ToolBarControlCount-1;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.InsertToolBarControl(Index: integer;
  AControl: TControl);
var
  i: Integer;  
begin
  if (Index >= 0) and (Index < FATBControls.Count) and (AControl <> nil) and (FATBControls.IndexOf(AControl) < 0) and (AControl.Parent <> self) then
  begin
    i := AddToolBarControl(AControl);
    MoveToolBarControl(i, Index);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.MoveToolBarControl(FromIndex,
  ToIndex: integer);
var
  i: Integer;
  aControl: TControl;
begin
  if (FromIndex >= 0) and (FromIndex < FATBControls.Count) and (ToIndex >= 0) and (ToIndex < FATBControls.Count) and (FromIndex <> ToIndex) then
  begin
    aControl := FATBControls[FromIndex];
    FATBControls.Move(FromIndex, ToIndex);
    
    if not FAutoArrangeButtons and false then
    begin
      i := FRUControls.IndexOf(aControl);
      if (i >= 0) and (ToIndex < FRUControls.Count) then
        FRUControls.Move(i, ToIndex);
    end;

    SetControlsPosition;
    UpdateRULists;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.AddMergedMenuItems;
var
  I, J: Integer;
  MergedItemFound: Boolean;
  ItemsList: TList;
begin
  if FMergedMenu <> nil then
  begin
    ItemsList := TList.Create;
    for I := 0 to FMergedMenu.Items.Count - 1 do
    begin
      MergedItemFound := False;
      for J := 0 to FATBControls.Count - 1 do
      begin
        if (TControl(FATBControls[J]) is TAdvToolBarMenuButton) and (TAdvToolBarMenuButton(FATBControls[J]).FToolBarCreated) and (FMergedMenu.Items[I].GroupIndex > 0)
           and Assigned(TAdvToolBarMenuButton(FATBControls[J]).MenuItem) and (TAdvToolBarMenuButton(FATBControls[J]).MenuItem.GroupIndex = FMergedMenu.Items[I].GroupIndex)
           and (ItemsList.IndexOf(FATBControls[J]) < 0) then
        begin
          TAdvToolBarMenuButton(FATBControls[J]).MenuItem := FMergedMenu.Items[I];
          TAdvToolBarMenuButton(FATBControls[J]).FInternalTag := 1;
          MergedItemFound := True;
          ItemsList.Add(FATBControls[J]);
          Break;
        end;
      end;

      if not MergedItemFound then
      begin
        with TAdvToolBarMenuButton.Create(Self) do
        try
          Grouped := True;
          Parent := Self;
          ShowCaption := true;
          MenuItem := FMergedMenu.Items[I];
          FInternalTag := 1;
          //FToolBarCreated := true;
          AutoSize := True;
        except
          Free;
          raise;
        end;
      end;
    end;
    
  ItemsList.Free;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.DeleteMergedMenuItems;
var
  I: Integer;
begin
  for I := FATBControls.Count - 1 downto 0 do
  begin
    if (TControl(FATBControls[I]) is TAdvToolBarMenuButton) and (TAdvToolBarMenuButton(FATBControls[I]).FInternalTag = 1) then
      TAdvToolBarMenuButton(FATBControls[I]).Free;
  end;
  UpdateMenu;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.MergeMenu(AMenu: TMainMenu);
begin
  if (AMenu <> nil) and (Menu <> nil) then
  begin
    if (FMergedMenu <> AMenu) and (FMergedMenu <> Menu) then
    begin
      if FMergedMenu <> nil then
      begin
        //FMerged.FMergedWith := nil;
        DeleteMergedMenuItems;
        FMergedMenu := nil;
      end;
      FMergedMenu := AMenu;
      AddMergedMenuItems;
      FMergedMenu.FreeNotification(Self);
    end;
  end
  else
  begin
    DeleteMergedMenuItems;
    FMergedMenu := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.UnmergeMenu(AMenu: TMainMenu);
begin
  if (AMenu <> nil) and (FMergedMenu = AMenu) then
    MergeMenu(nil);
end;

//------------------------------------------------------------------------------
function TAdvCustomToolBar.GetMyParentForm: TCustomForm;
var
  ParentCtrl: TWinControl;
begin
  Result := nil;
  ParentCtrl := self.Parent;
  if Assigned(FCurrentDock) then
    ParentCtrl := FCurrentDock
  else if Assigned(FLastDock) then
    ParentCtrl := FLastDock;

  while Assigned(ParentCtrl) do
  begin
    if ParentCtrl is TCustomForm then
    begin
      Result := TCustomForm(ParentCtrl);
      break;
    end;
    ParentCtrl := ParentCtrl.Parent;
  end;
end;

//------------------------------------------------------------------------------
{ Auto MDI Buttons Support }

var
  MDIToolBar: TAdvCustomToolBar;
  WndProcHooked: Boolean;

function ATBWindowProc(hWnd: HWND; uMsg: Integer; WParam: WPARAM; lParam: LPARAM): LRESULT; {$IFNDEF TMSDOTNET} stdcall; {$ENDIF}
begin
  if Assigned(MDIToolBar) then
  begin
    if (uMsg = WM_WINDOWPOSCHANGED{WM_WINDOWPOSCHANGING}) then
    begin
      //MDIChildForm := TProForm(MDIToolBar.GetMyParentForm).ActiveMDIChild;
      //if Assigned(MDIChildForm) and (MDIChildForm.WindowState = wsMaximized) and MDIToolBar.MDIButtonsVisible and (MDIToolBar.ToolBarState <> tsFloating) then
      //if MDIToolBar.MDIButtonsVisible then
      MDIToolBar.Invalidate;
    end;
  end;
  Result := CallWindowProc(IntPtr(GetWindowLong(hWnd, GWL_USERDATA)), hwnd, uMsg, wParam, lParam);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetAutoMDIButtons(const Value: Boolean);
var
  WindowHandle: THandle;
  OldWndProc: Integer;
begin
  if (FAutoMDIButtons <> Value) then
  begin
    FAutoMDIButtons := Value;
    if (csDesigning in ComponentState) or (csLoading in ComponentState) then
      Exit;
      
    if FAutoMDIButtons and FullSize and Assigned(Menu) then
    begin
      WindowHandle := GetMyParentForm.Handle;
      if (GetWindowLong(WindowHandle, GWL_WNDPROC) <> Integer(@ATBWindowProc)) then
      begin
        MDIToolBar := Self;
        FMDIChildForm := nil;
        SetWindowLong(WindowHandle, GWL_USERDATA, GetWindowLong(WindowHandle, GWL_WNDPROC));
        SetWindowLong(WindowHandle, GWL_WNDPROC, Integer(@ATBWindowProc));
        WndProcHooked := True;
      end;
    end
    else
    begin
      if WndProcHooked then
      begin // UnHook here
        WndProcHooked := False;
        MDIToolBar := nil;
        FMDIChildForm := nil;

        WindowHandle := GetMyParentForm.Handle;
        OldWndProc := GetWindowLong(WindowHandle, GWL_USERDATA);
        SetWindowRgn(WindowHandle, 0, True);
        if OldWndProc <> 0 then
        begin
          SetWindowLong(WindowHandle, GWL_WNDPROC, OldWndProc);
          SetWindowLong(WindowHandle, GWL_USERDATA, 0);
        end;

        Invalidate;
      end;
      FAutoMDIButtons := False;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.SetMDIButtonsVisible(const Value: Boolean);
begin
  if (FMDIButtonsVisible <> Value) then
  begin
    FMDIButtonsVisible := Value;
    Invalidate;
  end;

  {  MDIChildForm := TProForm(GetMyParentForm).ActiveMDIChild;
    if Assigned(MDIChildForm) then
    begin
   }
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.DrawMDIButtons;
  procedure DrawCross(R: TRect; Clr: TColor);
  begin
    with Canvas do
    begin
      Pen.Color := Clr;
                     {/}
      MoveTo(R.Left, R.Top + 7);
      LineTo(R.Left + 8, R.Top);
      MoveTo(R.Left + 1, R.Top + 7);
      LineTo(R.Left + 7, R.Top);
                     {\}
      MoveTo(R.Left, R.Top + 1);
      LineTo(R.Left + 8, R.Top + 8);
      MoveTo(R.Left + 1, R.Top + 1);
      LineTo(R.Left + 7, R.Top + 8);
    end;
  end;

  procedure DrawMaximize(R: TRect; Clr: TColor; HorzDir: Boolean);
  begin
    with Canvas do
    begin
      Pen.Color := Clr;

      if HorzDir then
      begin
        MoveTo(R.Left + 2, R.Top);
        LineTo(R.Left + 8, R.Top);
        MoveTo(R.Left + 2, R.Top + 1);
        LineTo(R.Left + 8, R.Top + 1);
        MoveTo(R.Left + 8, R.Top);
        LineTo(R.Left + 8, R.Top + 6);

        MoveTo(R.Left, R.Top + 3);
        LineTo(R.Left + 7, R.Top + 3);
        MoveTo(R.Left, R.Top + 4);
        LineTo(R.Left + 7, R.Top + 4);
        MoveTo(R.Left, R.Top + 4);
        LineTo(R.Left, R.Top + 8);
        LineTo(R.Left + 6, R.Top + 8);
        LineTo(R.Left + 6, R.Top + 4);

        Pen.Color := clSilver;
        MoveTo(R.Left + 2, R.Top + 2);
        LineTo(R.Left + 2, R.Top + 3);
      end
      else
      begin
        MoveTo(R.Right - 5, R.Top + 2);
        LineTo(R.Right - 5, R.Top + 8);
        MoveTo(R.Right - 6, R.Top + 2);
        LineTo(R.Right - 6, R.Top + 8);
        MoveTo(R.Right - 5, R.Top + 8);
        LineTo(R.Right - 11, R.Top + 8);

        MoveTo(R.Right - 8, R.Top);
        LineTo(R.Right - 8, R.Top + 7);
        MoveTo(R.Right - 9, R.Top);
        LineTo(R.Right - 9, R.Top + 7);
        MoveTo(R.Right - 9, R.Top);
        LineTo(R.Right - 13, R.Top);
        LineTo(R.Right - 13, R.Top + 6);
        LineTo(R.Right - 9, R.Top + 6);
      end;
    end;

  end;

  procedure DrawMinimize(R: TRect; Clr: TColor; HorzDir: Boolean);
  begin
    with Canvas do
    begin
      Pen.Color := Clr;

      if HorzDir then
      begin
        MoveTo(R.Left, R.Top);
        LineTo(R.Left + 6, R.Top);
        MoveTo(R.Left , R.Top + 1);
        LineTo(R.Left + 6, R.Top + 1);
      end
      else
      begin
        MoveTo(R.Left, R.Top);
        LineTo(R.Left, R.Top + 6);
        MoveTo(R.Left + 1, R.Top);
        LineTo(R.Left + 1, R.Top + 6);
      end;
    end;
  end;

var
  R, R2: TRect;
  Clr, ClrTo, BrClr, GlpClr: TColor;
  GDHoriztl: Boolean;

begin
  FMDIChildForm := TProForm(GetMyParentForm).ActiveMDIChild;
  if FAutoMDIButtons and Assigned(FMDIChildForm) and (FMDIChildForm.WindowState = wsMaximized){ and FMDIButtonsVisible} and (ToolBarState <> tsFloating) then
  begin
    FMDIButtonsVisible := True;
    // Close Button
    R := self.GetMDICloseBtnRect;
    //Canvas.Draw(R.left, R.Top, FMDICloseGlyph);

    with Canvas, FCurrentToolBarStyler.ButtonAppearance do
    begin
      // Close Button
      if FMDIDownCloseBtn then
      begin
        Clr := ColorDown;
        ClrTo := ColorDownTo;
        BrClr := BorderDownColor;
        GlpClr := clBlack;
        GDHoriztl := GradientDirectionDown = gdHorizontal;
      end
      else if FMDIHotCloseBtn then
      begin
        Clr := ColorHot;
        ClrTo := ColorHotTo;
        BrClr := BorderHotColor;
        GlpClr := clBlack;
        GDHoriztl := GradientDirectionHot = gdHorizontal;
      end
      else
      begin
        Clr := clNone;
        ClrTo := clNone;
        BrClr := clNone;
        GlpClr := clBlack;
        GDHoriztl := GradientDirection = gdHorizontal;
      end;

      // BackGround
      if (Clr <> clNone) and (ClrTo <> clNone) then
        DrawGradient(Canvas, Clr, ClrTo, 40, R, GDHoriztl)
      else if (Clr <> clNone) then
      begin
        Brush.Color := Clr;
        Pen.Color := Clr;
        Rectangle(R);
      end;

      // Border
      if BrClr <> clNone then
      begin
        Brush.Style := bsClear;
        Pen.Color := BrClr;
        Rectangle(R);
      end;

      R2 := R;
      R2.Left := R.Left + ((R.Right - R.Left) - 8) div 2;
      R2.Top := R.Top + ((R.Bottom - R.Top) - 8) div 2;
      DrawCross(R2, GlpClr);

      // Max Button
      R := GetMDIMaxBtnRect;
      if FMDIDownMaxBtn then
      begin
        Clr := ColorDown;
        ClrTo := ColorDownTo;
        BrClr := BorderDownColor;
        GlpClr := clBlack;
        GDHoriztl := GradientDirectionDown = gdHorizontal;
      end
      else if FMDIHotMaxBtn then
      begin
        Clr := ColorHot;
        ClrTo := ColorHotTo;
        BrClr := BorderHotColor;
        GlpClr := clBlack;
        GDHoriztl := GradientDirectionHot = gdHorizontal;
      end
      else
      begin
        Clr := clNone;
        ClrTo := clNone;
        BrClr := clNone;
        GlpClr := clBlack;
        GDHoriztl := GradientDirection = gdHorizontal;
      end;

      // BackGround
      if (Clr <> clNone) and (ClrTo <> clNone) then
        DrawGradient(Canvas, Clr, ClrTo, 40, R, GDHoriztl)
      else if (Clr <> clNone) then
      begin
        Brush.Color := Clr;
        Pen.Color := Clr;
        Rectangle(R);
      end;

      // Border
      if BrClr <> clNone then
      begin
        Brush.Style := bsClear;
        Pen.Color := BrClr;
        Rectangle(R);
      end;

      if not (biMaximize in TProForm(FMDIChildForm).BorderIcons) then
        GlpClr := clGray;

      R2 := R;
      R2.Left := R.Left + ((R.Right - R.Left) - 8) div 2;
      R2.Top := R.Top + ((R.Bottom - R.Top) - 8) div 2;
      DrawMaximize(R2, GlpClr, Position in [daTop, daBottom]);

      // Min Button
      R := GetMDIMinBtnRect;
      if FMDIDownMinBtn then
      begin
        Clr := ColorDown;
        ClrTo := ColorDownTo;
        BrClr := BorderDownColor;
        GlpClr := clBlack;
        GDHoriztl := GradientDirectionDown = gdHorizontal;
      end
      else if FMDIHotMinBtn then
      begin
        Clr := ColorHot;
        ClrTo := ColorHotTo;
        BrClr := BorderHotColor;
        GlpClr := clBlack;
        GDHoriztl := GradientDirectionHot = gdHorizontal;
      end
      else
      begin
        Clr := clNone;
        ClrTo := clNone;
        BrClr := clNone;
        GlpClr := clBlack;
        GDHoriztl := GradientDirection = gdHorizontal;
      end;

      // BackGround
      if (Clr <> clNone) and (ClrTo <> clNone) then
        DrawGradient(Canvas, Clr, ClrTo, 40, R, GDHoriztl)
      else if (Clr <> clNone) then
      begin
        Brush.Color := Clr;
        Pen.Color := Clr;
        Rectangle(R);
      end;

      // Border
      if BrClr <> clNone then
      begin
        Brush.Style := bsClear;
        Pen.Color := BrClr;
        Rectangle(R);
      end;

      R2 := R;
      if Position in [daTop, daBottom] then
      begin
        R2.Left := R.Left + ((R.Right - R.Left) - 6) div 2;
        R2.Top := R.Bottom - 6;
      end
      else
      begin
        R2.Top := R.Top + ((R.Bottom - R.Top) - 6) div 2;
        R2.Left := R.Left + 5;
      end;

      if not (biMinimize in TProForm(FMDIChildForm).BorderIcons) then
        GlpClr := clGray;

      DrawMinimize(R2, GlpClr, Position in [daTop, daBottom]);
    end; // with ends



  end
  else if FMDIButtonsVisible then
    FMDIButtonsVisible := False;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.PtOnMDIClose(P: TPoint): Boolean;
begin
  Result := False;
  if PtInRect(GetMDICloseBtnRect, P) then
    Result := True;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.PtOnMDIMax(P: TPoint): Boolean;
begin
  Result := False;
  if PtInRect(GetMDIMaxBtnRect, P) and Assigned(FMDIChildForm) and (biMaximize in TProForm(FMDIChildForm).BorderIcons) then
    Result := True;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.PtOnMDIMin(P: TPoint): Boolean;
begin
  Result := False;
  if PtInRect(GetMDIMinBtnRect, P) and Assigned(FMDIChildForm) and (biMinimize in TProForm(FMDIChildForm).BorderIcons) then
    Result := True;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetMDICloseBtnRect: TRect;
var
  x, y: Integer;
begin
  Result := Rect(0, 0, 0, 0);
  if Assigned(FMDIChildForm) then
  begin
    if (biSystemMenu in TProForm(FMDIChildForm).BorderIcons) then
    begin
      case Position of
        daTop, daBottom:
        begin
          x := Width - 3 - MDIBTNSIZE;
          if ShowOptionIndicator and not FullSize then
            x := x - PopupIndicatorWidth;
          y := max(2, (Height - MDIBTNSIZE) div 2);
          Result := Rect(x, y, x + MDIBTNSIZE, y + MDIBTNSIZE);
        end;
        daLeft, daRight:
        begin
          x := Height - 3 - MDIBTNSIZE;
          if ShowOptionIndicator and not FullSize then
            x := x - PopupIndicatorWidth;
          y := max(2, (Width - MDIBTNSIZE) div 2);
          Result := Rect(y, x, y + MDIBTNSIZE, x + MDIBTNSIZE);
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetMDIMaxBtnRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
  if Assigned(FMDIChildForm) and (ToolBarState <> tsFloating) then
  begin
    if (biSystemMenu in TProForm(FMDIChildForm).BorderIcons) {and (biMaximize in TProForm(FMDIChildForm).BorderIcons)} then
    begin
      case Position of
        daTop, daBottom:
        begin
          Result := GetMDICloseBtnRect;
          Result.Right := Result.Left - 1;
          Result.Left := Result.Right - MDIBTNSIZE;
        end;
        daLeft, daRight:
        begin
          Result := GetMDICloseBtnRect;
          Result.Bottom := Result.Top - 1;
          Result.Top := Result.Bottom - MDIBTNSIZE;
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBar.GetMDIMinBtnRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
  if Assigned(FMDIChildForm) and (ToolBarState <> tsFloating) then
  begin
    if (biSystemMenu in TProForm(FMDIChildForm).BorderIcons){ and (biMinimize in TProForm(FMDIChildForm).BorderIcons)} then
    begin
      case Position of
        daTop, daBottom:
        begin
          Result := GetMDIMaxBtnRect;
          Result.Right := Result.Left - 1;
          Result.Left := Result.Right - MDIBTNSIZE;
        end;
        daLeft, daRight:
        begin
          Result := GetMDIMaxBtnRect;
          Result.Bottom := Result.Top - 1;
          Result.Top := Result.Bottom - MDIBTNSIZE;
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.MDICloseBtnClick;
begin
  FMDIChildForm := TProForm(GetMyParentForm).ActiveMDIChild;
  if FAutoMDIButtons and Assigned(FMDIChildForm) and (FMDIChildForm.WindowState = wsMaximized) and FMDIButtonsVisible and (ToolBarState <> tsFloating) then
    FMDIChildForm.Close;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.MDIMaxBtnClick;
begin
  FMDIChildForm := TProForm(GetMyParentForm).ActiveMDIChild;
  if FAutoMDIButtons and Assigned(FMDIChildForm) and (FMDIChildForm.WindowState = wsMaximized) and FMDIButtonsVisible and (ToolBarState <> tsFloating)
    and (biMaximize in TProForm(FMDIChildForm).BorderIcons) then
    FMDIChildForm.WindowState := wsNormal;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBar.MDIMinBtnClick;
begin
  FMDIChildForm := TProForm(GetMyParentForm).ActiveMDIChild;
  if FAutoMDIButtons and Assigned(FMDIChildForm) and (FMDIChildForm.WindowState = wsMaximized) and FMDIButtonsVisible and (ToolBarState <> tsFloating)
    and (biMinimize in TProForm(FMDIChildForm).BorderIcons) then
    FMDIChildForm.WindowState := wsMinimized;
end;

//------------------------------------------------------------------------------

{ TRowCollectionItem }

constructor TRowCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  FToolBarList := TDbgList.Create;
end;

//------------------------------------------------------------------------------

destructor TRowCollectionItem.Destroy;
begin
  if Assigned(TRowCollection(Collection).OnDeleteItem) then
    TRowCollection(Collection).OnDeleteItem(TRowCollection(Collection), Index);

  FToolBarList.Free;
  inherited;
end;

//------------------------------------------------------------------------------

function TRowCollectionItem.AddToolBar(
  aAdvToolBar: TAdvCustomToolBar): integer;
var
  OldValue: boolean;
  S: integer;
begin
  Result := -1;
  if FToolBarList.IndexOf(aAdvToolBar) < 0 then
  begin
    if IsAllowed(aAdvToolBar) then
    begin
      Result := FToolBarList.Add(aAdvToolBar);
      OldValue := aAdvToolBar.AllowBoundChange;
      aAdvToolBar.AllowBoundChange := true;

      if TAdvDockPanel(TRowCollection(Collection).FOwner).Align in [daTop, daBottom] then
      begin
        if aAdvToolBar.FullSize then
        begin
          S := (RowRect.Right - RowRect.Left) - TRowCollection(Collection).OffSetX * 2;
          aAdvToolBar.Constraints.MinWidth := 0;
          aAdvToolBar.Constraints.MaxWidth := S;
          aAdvToolBar.Constraints.MinWidth := S;
          aAdvToolBar.Width := S;
          aAdvToolBar.UpdateRULists;   // Since Min/MaxWidth Changes Height Internally, does not call SetBound
        end
        else
        begin
          if Result > 0 then
            aAdvToolBar.Left := TAdvCustomToolBar(FToolBarList[Result - 1]).Left + TAdvCustomToolBar(FToolBarList[Result - 1]).width + TRowCollection(Collection).OffSetX
          else
            aAdvToolBar.Left := (RowRect.Left + TRowCollection(Collection).OffSetX);
            //aAdvToolBar.Left := RowRect.Right - (aAdvToolBar.Width + TRowCollection(Collection).OffSetX);
        end;
      end
      else // daLeft, daRight
      begin
        if aAdvToolBar.FullSize then
        begin
          S := (RowRect.Bottom - RowRect.Top) - TRowCollection(Collection).OffSetX * 2;
          aAdvToolBar.Constraints.MinHeight := 0;
          aAdvToolBar.Constraints.MaxHeight := S;
          aAdvToolBar.Constraints.MinHeight := S;
          aAdvToolBar.Height := S;
          aAdvToolBar.UpdateRULists;  // Since Min/MaxHeight Changes Height Internally, does not call SetBound
        end
        else
        begin
          if Result > 0 then
            aAdvToolBar.Top := TAdvCustomToolBar(FToolBarList[Result - 1]).Top + TAdvCustomToolBar(FToolBarList[Result - 1]).Height + TRowCollection(Collection).OffSetX
          else
            aAdvToolBar.Top := RowRect.Bottom - (aAdvToolBar.Height + TRowCollection(Collection).OffSetX);
        end;
      end;

      aAdvToolBar.AllowBoundChange := OldValue;
      aAdvToolBar.Row := index;

      TRowCollection(Collection).SetRowsPosition;
      //ArrangeToolBars;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TRowCollectionItem.GetHeight: integer;
var
  i: integer;
begin
  Result := DEFAULT_TOOLBARHEIGHT;
  for i := 0 to FToolBarList.count - 1 do
  begin  
    if TRowCollection(Collection).FOwner.Align in [daTop, daBottom] then
      Result := max(Result, TAdvCustomToolBar(FToolBarList[i]).Height)
    else
      Result := max(Result, TAdvCustomToolBar(FToolBarList[i]).Width);
  end;
end;

//------------------------------------------------------------------------------

function TRowCollectionItem.GetRowRect: TRect;
begin
  Result := FRowRect;
end;

//------------------------------------------------------------------------------

procedure TRowCollectionItem.ArrangeToolBars; // FRowRect should already been set before this method call
var
  i, {x, dif,} j, k: integer;
  EmptySpace, expw, shkw, emptsp2: integer;
  aAdvToolBar, atb: TAdvCustomToolBar;
  OldValue: Boolean;
begin
  if TRowCollection(Collection).FOwner.Align in [daTop, daBottom] then
  begin
   { EmptySpace:= TRowCollection(Collection).OffSetX;
    for i:=0 to FToolBarList.Count-1 do
    begin
      EmptySpace:= EmptySpace + TAdvCustomToolBar(FToolBarList[i]).Width + TRowCollection(Collection).OffSetX;
    end;

    if EmptySpace < (FRowRect.Right - FRowRect.Left) then
      EmptySpace:= (FRowRect.Right - FRowRect.Left) - EmptySpace
    else
      EmptySpace:= 0;  }

    //x:= TAdvDockPanel(TRowCollection(Collection).Owner).OffSetX + TRowCollection(Collection).OffSetX;
    for i := 0 to FToolBarList.Count - 1 do
    begin
      // Setting Top
      aAdvToolBar := TAdvCustomToolBar(FToolBarList[i]);
      OldValue := aAdvToolBar.AllowBoundChange;
      aAdvToolBar.AllowBoundChange := true;
      aAdvToolBar.Top := FRowRect.Top; //+ TRowCollection(Collection).OffSetY;
      if aAdvToolBar.Row <> Index then
        aAdvToolBar.Row := Index;
      aAdvToolBar.AllowBoundChange := OldValue;

      if (i = 0) and aAdvToolBar.FullSize then
      begin
        OldValue := aAdvToolBar.AllowBoundChange;
        aAdvToolBar.AllowBoundChange := true;
        //expw := (FRowRect.Right - FRowRect.Left) - TRowCollection(Collection).OffSetX * 2 + 4;
        expw := (FRowRect.Right - FRowRect.Left) - TRowCollection(Collection).OffSetX * 2;
        aAdvToolBar.Constraints.MinWidth := 0;
        aAdvToolBar.Constraints.MaxWidth := expw;
        aAdvToolBar.Constraints.MinWidth := expw;
        //aAdvToolBar.Left := FRowRect.Left -2; //+ TRowCollection(Collection).OffSetX;
        aAdvToolBar.Left := FRowRect.Left + TRowCollection(Collection).OffSetX;
        aAdvToolBar.Width := expw;
        aAdvToolBar.AllowBoundChange := OldValue;
        Break;
      end;

     (* if TAdvCustomToolBar(FToolBarList[i]).Left < x then
      begin
        if EmptySpace = 0 then
        begin
          if i > 0 then
          begin
           { if TAdvCustomToolBar(FToolBarList[i-1]).CanShrink > 0 then
            begin
              expw:= 0;
              for j:= i to FToolBarList.Count-1 do
              begin
                expw:= expw + TAdvCustomToolBar(FToolBarList[j]).CanExpand;
              end;

              dif:= min(min(TAdvCustomToolBar(FToolBarList[i-1]).CanShrink, expw), x - TAdvCustomToolBar(FToolBarList[i]).Left);

            end
            else
              TAdvCustomToolBar(FToolBarList[i]).Left:= x; }
          end
          else
            TAdvCustomToolBar(FToolBarList[i]).Left:= x;
        end
        else
          TAdvCustomToolBar(FToolBarList[i]).Left:= x;
      end
      else if TAdvCustomToolBar(FToolBarList[i]).Left > x then
      begin

      end;
      *)
      //TAdvCustomToolBar(FToolBarList[i]).Width
      //TAdvCustomToolBar(FToolBarList[i]).Left:= x;   // this has to be changed


      if i = FToolBarList.Count - 1 then
        EmptySpace := GetSpace(aAdvToolBar, nil)
      else
        EmptySpace := GetSpace(aAdvToolBar, TAdvCustomToolBar(FToolBarList[i + 1]));

      // Expand Width If empty space next to it, of its and remaining of all its previous ToolBars
      if EmptySpace > 0 then
      begin
        for j := i downto 0 do
        begin
          atb := TAdvCustomToolBar(FToolBarList[j]);
          expw := min(atb.CanExpand, EmptySpace);

          if expw > 0 then
          begin
            OldValue := atb.AllowBoundChange;
            atb.AllowBoundChange := true;
            atb.Width := atb.Width + expw;
            atb.AllowBoundChange := OldValue;

            // moving right to adjust expand width
            for k := j + 1 to i do
            begin
              atb := TAdvCustomToolBar(FToolBarList[k]);
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Left := atb.Left + expw;
              atb.AllowBoundChange := OldValue;
            end;
          end;

          EmptySpace := EmptySpace - expw;
          if EmptySpace <= 0 then
            Break;

        end;
      end
      else if EmptySpace < 0 then // If -ve empty space the cover empty space on the left
      begin
        for j := i downto 0 do
        begin
          atb := TAdvCustomToolBar(FToolBarList[j]);
          if j > 0 then
            emptsp2 := GetSpace(TAdvCustomToolBar(FToolBarList[j - 1]), atb)
          else
            emptsp2 := GetSpace(nil, atb);

          emptsp2 := min(emptsp2, abs(EmptySpace));

          if emptsp2 > 0 then
          begin
            OldValue := atb.AllowBoundChange;
            atb.AllowBoundChange := true;
            atb.Left := atb.Left - emptsp2;
            atb.AllowBoundChange := OldValue;

            // moving Left to make space
            for k := j + 1 to i do
            begin
              atb := TAdvCustomToolBar(FToolBarList[k]);
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Left := atb.Left - emptsp2;
              atb.AllowBoundChange := OldValue;
            end;

            EmptySpace := EmptySpace + emptsp2; // Note: EmptySpace is -ve
          end;

          if EmptySpace >= 0 then
            break;
        end;

        // If further Space required then shrink Left side ToolBars
        if EmptySpace < 0 then
        begin
          for j := i downto 0 do
          begin
            atb := TAdvCustomToolBar(FToolBarList[j]);

            shkw := min(atb.CanShrink, abs(EmptySpace));

            if shkw > 0 then
            begin
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Width := atb.Width - shkw;
              atb.AllowBoundChange := OldValue;

              // moving Left to make space
              for k := j + 1 to i do
              begin
                atb := TAdvCustomToolBar(FToolBarList[k]);
                OldValue := atb.AllowBoundChange;
                atb.AllowBoundChange := true;
                atb.Left := atb.Left - shkw;
                atb.AllowBoundChange := OldValue;
              end;

              EmptySpace := EmptySpace + shkw; // Note: EmptySpace is -ve
            end;

            if EmptySpace >= 0 then
              break;
          end;


        end;
      end;

      // if ToolBar is Shrunk the check for the empty space on the left.
      expw := aAdvToolBar.CanExpand;
      if expw > 0 then
      begin
        for j := i downto 0 do
        begin
          atb := TAdvCustomToolBar(FToolBarList[j]);
          if j > 0 then
            emptsp2 := GetSpace(TAdvCustomToolBar(FToolBarList[j - 1]), atb)
          else
            emptsp2 := GetSpace(nil, atb);

          emptsp2 := min(emptsp2, expw);

          if emptsp2 > 0 then
          begin
            OldValue := atb.AllowBoundChange;
            atb.AllowBoundChange := true;
            atb.Left := atb.Left - emptsp2;
            atb.AllowBoundChange := OldValue;

            // moving Left to make space
            for k := j + 1 to i do
            begin
              atb := TAdvCustomToolBar(FToolBarList[k]);
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Left := atb.Left - emptsp2;
              atb.AllowBoundChange := OldValue;
            end;

            atb := TAdvCustomToolBar(FToolBarList[j]);
            OldValue := atb.AllowBoundChange;
            atb.AllowBoundChange := true;
            atb.width := atb.width + emptsp2;
            atb.AllowBoundChange := OldValue;

            expw := expw - emptsp2;
          end;

          if expw <= 0 then
            break;
        end;
      end;

      //x:= x + TRowCollection(Collection).OffSetX + TAdvCustomToolBar(FToolBarList[i]).Width;
    end;

    // checking for the over lapping and cutting ToolBars
    for i := 0 to FToolBarList.Count - 1 do
    begin
      aAdvToolBar := TAdvCustomToolBar(FToolBarList[i]);
      if (i = 0) then    // Checking First ToolBar Front Edge
      begin
        EmptySpace := GetSpace(nil, aAdvToolBar);
        if EmptySpace < 0 then
        begin
          atb := TAdvCustomToolBar(FToolBarList[i]);
          OldValue := atb.AllowBoundChange;
          atb.AllowBoundChange := true;
          atb.Left := atb.Left + abs(EmptySpace);
          atb.AllowBoundChange := OldValue;
        end;
      end;

      if i = FToolBarList.Count - 1 then       // Last or the only ToolBar
      begin
        EmptySpace := GetSpace(aAdvToolBar, nil);
        // checking for cutting last AdvToolBar
        if EmptySpace < 0 then // If -ve empty space the cover empty space on the left
        begin
          for j := i downto 0 do
          begin
            atb := TAdvCustomToolBar(FToolBarList[j]);
            if j > 0 then
              emptsp2 := GetSpace(TAdvCustomToolBar(FToolBarList[j - 1]), atb)
            else
              emptsp2 := GetSpace(nil, atb);

            emptsp2 := min(emptsp2, abs(EmptySpace));

            if emptsp2 > 0 then
            begin
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Left := atb.Left - emptsp2;
              atb.AllowBoundChange := OldValue;

              // moving Left to make space
              for k := j + 1 to i do
              begin
                atb := TAdvCustomToolBar(FToolBarList[k]);
                OldValue := atb.AllowBoundChange;
                atb.AllowBoundChange := true;
                atb.Left := atb.Left - emptsp2;
                atb.AllowBoundChange := OldValue;
              end;

              EmptySpace := EmptySpace + emptsp2; // Note: EmptySpace is -ve
            end;

            if EmptySpace >= 0 then
              break;
          end;

          // If further Space required then shrink Left side ToolBars
          if EmptySpace < 0 then
          begin
            for j := i downto 0 do
            begin
              atb := TAdvCustomToolBar(FToolBarList[j]);

              shkw := min(atb.CanShrink, abs(EmptySpace));

              if shkw > 0 then
              begin
                OldValue := atb.AllowBoundChange;
                atb.AllowBoundChange := true;
                atb.Width := atb.Width - shkw;
                atb.AllowBoundChange := OldValue;

                // moving Left to make space
                for k := j + 1 to i do
                begin
                  atb := TAdvCustomToolBar(FToolBarList[k]);
                  OldValue := atb.AllowBoundChange;
                  atb.AllowBoundChange := true;
                  atb.Left := atb.Left - shkw;
                  atb.AllowBoundChange := OldValue;
                end;

                EmptySpace := EmptySpace + shkw; // Note: EmptySpace is -ve
              end;

              if EmptySpace >= 0 then
                break;
            end;

          end;
        end;

        EmptySpace := 0;
        atb := nil;
      end
      else
      begin
        atb := TAdvCustomToolBar(FToolBarList[i + 1]);
        EmptySpace := GetSpace(aAdvToolBar, atb);
      end;

      if (EmptySpace < 0) and (atb <> nil) then
      begin
        OldValue := atb.AllowBoundChange;
        atb.AllowBoundChange := true;
        atb.Left := atb.Left + abs(EmptySpace);
        atb.AllowBoundChange := OldValue;
      end;
    end;

  end
  else // if Position in [daLeft, daRight] then
  begin
   { for i:=0 to FToolBarList.Count-1 do
    begin
      TAdvCustomToolBar(FToolBarList[i]).Left:= FRowRect.Left + TRowCollection(Collection).OffSetY;
    end;
    }

    for i := 0 to FToolBarList.Count - 1 do
    begin
      // Setting Left
      aAdvToolBar := TAdvCustomToolBar(FToolBarList[i]);
      OldValue := aAdvToolBar.AllowBoundChange;
      aAdvToolBar.AllowBoundChange := true;
      aAdvToolBar.Left := FRowRect.Left;
      if aAdvToolBar.Row <> Index then
        aAdvToolBar.Row := Index;
      aAdvToolBar.AllowBoundChange := OldValue;

      if (i = 0) and aAdvToolBar.FullSize then
      begin
        OldValue := aAdvToolBar.AllowBoundChange;
        aAdvToolBar.AllowBoundChange := true;
        expw := (FRowRect.Bottom - FRowRect.Top) - TRowCollection(Collection).OffSetX * 2;
        aAdvToolBar.Constraints.MinHeight := 0;
        aAdvToolBar.Constraints.MaxHeight := expw;
        aAdvToolBar.Constraints.MinHeight := expw;
        aAdvToolBar.Top := FRowRect.Top + TRowCollection(Collection).OffSetX;
        aAdvToolBar.Height := expw;
        aAdvToolBar.AllowBoundChange := OldValue;

        break;
      end;

      if i = FToolBarList.Count - 1 then
        EmptySpace := GetSpace(aAdvToolBar, nil)
      else
        EmptySpace := GetSpace(aAdvToolBar, TAdvCustomToolBar(FToolBarList[i + 1]));

      // Expand Height If empty space next to it, of its and remaining of all its previous ToolBars
      if EmptySpace > 0 then
      begin
        for j := i downto 0 do
        begin
          atb := TAdvCustomToolBar(FToolBarList[j]);
          expw := min(atb.CanExpand, EmptySpace);

          if expw > 0 then
          begin
            OldValue := atb.AllowBoundChange;
            atb.AllowBoundChange := true;
            //if (atb.Height + expw) = 100 then
              //showmessage('This is1:'+inttostr(atb.Height + expw));
            atb.Height := atb.Height + expw;
            atb.AllowBoundChange := OldValue;

            // moving Down to adjust expand Height
            for k := j + 1 to i do
            begin
              atb := TAdvCustomToolBar(FToolBarList[k]);
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Top := atb.Top + expw;
              atb.AllowBoundChange := OldValue;
            end;
          end;

          EmptySpace := EmptySpace - expw;
          if EmptySpace <= 0 then
            Break;

        end;
      end
      else if EmptySpace < 0 then // If -ve empty space the cover empty space on the Top
      begin
        for j := i downto 0 do
        begin
          atb := TAdvCustomToolBar(FToolBarList[j]);
          if j > 0 then
            emptsp2 := GetSpace(TAdvCustomToolBar(FToolBarList[j - 1]), atb)
          else
            emptsp2 := GetSpace(nil, atb);

          emptsp2 := min(emptsp2, abs(EmptySpace));

          if emptsp2 > 0 then
          begin
            OldValue := atb.AllowBoundChange;
            atb.AllowBoundChange := true;
            atb.Top := atb.Top - emptsp2;
            atb.AllowBoundChange := OldValue;

            // moving Left to make space
            for k := j + 1 to i do
            begin
              atb := TAdvCustomToolBar(FToolBarList[k]);
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Top := atb.Top - emptsp2;
              atb.AllowBoundChange := OldValue;
            end;

            EmptySpace := EmptySpace + emptsp2; // Note: EmptySpace is -ve
          end;

          if EmptySpace >= 0 then
            break;
        end;

        // If further Space required then shrink Top ToolBars
        if EmptySpace < 0 then
        begin
          for j := i downto 0 do
          begin
            atb := TAdvCustomToolBar(FToolBarList[j]);

            shkw := min(atb.CanShrink, abs(EmptySpace));

            if shkw > 0 then
            begin
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Height := atb.Height - shkw;
              atb.AllowBoundChange := OldValue;

              // moving up to make space
              for k := j + 1 to i do
              begin
                atb := TAdvCustomToolBar(FToolBarList[k]);
                OldValue := atb.AllowBoundChange;
                atb.AllowBoundChange := true;
                atb.Top := atb.Top - shkw;
                atb.AllowBoundChange := OldValue;
              end;

              EmptySpace := EmptySpace + shkw; // Note: EmptySpace is -ve
            end;

            if EmptySpace >= 0 then
              break;
          end;


        end;
      end;

      // if ToolBar is Shrunk the check for the empty space on Top.
      expw := aAdvToolBar.CanExpand;
      if expw > 0 then
      begin
        for j := i downto 0 do
        begin
          atb := TAdvCustomToolBar(FToolBarList[j]);
          if j > 0 then
            emptsp2 := GetSpace(TAdvCustomToolBar(FToolBarList[j - 1]), atb)
          else
            emptsp2 := GetSpace(nil, atb);

          emptsp2 := min(emptsp2, expw);

          if emptsp2 > 0 then
          begin
            OldValue := atb.AllowBoundChange;
            atb.AllowBoundChange := true;
            atb.Top := atb.Top - emptsp2;
            atb.AllowBoundChange := OldValue;

            // moving up to make space
            for k := j + 1 to i do
            begin
              atb := TAdvCustomToolBar(FToolBarList[k]);
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Top := atb.Top - emptsp2;
              atb.AllowBoundChange := OldValue;
            end;

            atb := TAdvCustomToolBar(FToolBarList[j]);
            OldValue := atb.AllowBoundChange;
            atb.AllowBoundChange := true;
            //if (atb.Height + emptsp2) = 100 then
              //showmessage('This is2: '+inttostr(atb.Height)+' '+ inttostr(emptsp2)+' MH'+inttostr(atb.Constraints.MaxHeight));
            atb.Height := atb.Height + emptsp2;
            atb.AllowBoundChange := OldValue;

            expw := expw - emptsp2;
          end;

          if expw <= 0 then
            break;
        end;
      end;

    end;

    // checking for the over lapping and cutting ToolBars
    for i := 0 to FToolBarList.Count - 1 do
    begin
      aAdvToolBar := TAdvCustomToolBar(FToolBarList[i]);
      if (i = 0) then    // Checking First ToolBar Front Edge
      begin
        EmptySpace := GetSpace(nil, aAdvToolBar);
        if EmptySpace < 0 then
        begin
          atb := TAdvCustomToolBar(FToolBarList[i]);
          OldValue := atb.AllowBoundChange;
          atb.AllowBoundChange := true;
          atb.Top := atb.Top + abs(EmptySpace);
          atb.AllowBoundChange := OldValue;
        end;
      end;

      if i = FToolBarList.Count - 1 then
      begin
        EmptySpace := GetSpace(aAdvToolBar, nil);
        // checking for cutting last AdvToolBar
        if EmptySpace < 0 then // If -ve empty space the cover empty space on the Top
        begin
          for j := i downto 0 do
          begin
            atb := TAdvCustomToolBar(FToolBarList[j]);
            if j > 0 then
              emptsp2 := GetSpace(TAdvCustomToolBar(FToolBarList[j - 1]), atb)
            else
              emptsp2 := GetSpace(nil, atb);

            emptsp2 := min(emptsp2, abs(EmptySpace));

            if emptsp2 > 0 then
            begin
              OldValue := atb.AllowBoundChange;
              atb.AllowBoundChange := true;
              atb.Top := atb.Top - emptsp2;
              atb.AllowBoundChange := OldValue;

              // moving Left to make space
              for k := j + 1 to i do
              begin
                atb := TAdvCustomToolBar(FToolBarList[k]);
                OldValue := atb.AllowBoundChange;
                atb.AllowBoundChange := true;
                atb.Top := atb.Top - emptsp2;
                atb.AllowBoundChange := OldValue;
              end;

              EmptySpace := EmptySpace + emptsp2; // Note: EmptySpace is -ve
            end;

            if EmptySpace >= 0 then
              break;
          end;

          // If further Space required then shrink Top ToolBars
          if EmptySpace < 0 then
          begin
            for j := i downto 0 do
            begin
              atb := TAdvCustomToolBar(FToolBarList[j]);

              shkw := min(atb.CanShrink, abs(EmptySpace));

              if shkw > 0 then
              begin
                OldValue := atb.AllowBoundChange;
                atb.AllowBoundChange := true;
                atb.Height := atb.Height - shkw;
                atb.AllowBoundChange := OldValue;

                // moving up to make space
                for k := j + 1 to i do
                begin
                  atb := TAdvCustomToolBar(FToolBarList[k]);
                  OldValue := atb.AllowBoundChange;
                  atb.AllowBoundChange := true;
                  atb.Top := atb.Top - shkw;
                  atb.AllowBoundChange := OldValue;
                end;

                EmptySpace := EmptySpace + shkw; // Note: EmptySpace is -ve
              end;

              if EmptySpace >= 0 then
                break;
            end;

          end;
        end;

        EmptySpace := 0;
        atb := nil;
      end
      else
      begin
        atb := TAdvCustomToolBar(FToolBarList[i + 1]);
        EmptySpace := GetSpace(aAdvToolBar, atb);
      end;

      if (EmptySpace < 0) and (atb <> nil) then
      begin
        OldValue := atb.AllowBoundChange;
        atb.AllowBoundChange := true;
        atb.Top := atb.Top + abs(EmptySpace);
        atb.AllowBoundChange := OldValue;
      end;
    end;

  end; // end of daLeft, daRight
end;

//------------------------------------------------------------------------------

procedure TRowCollectionItem.SetRowRect(R: TRect);
begin
  FRowRect := R;
end;

//------------------------------------------------------------------------------
{
Rules:
 Allow towards Left when
   *) if self is not full size
   *) there is empty space on left side
   *) if No empty space on the row then allow that much that
      any toolbar is expandable on right(self included) and any tool bar is shrinkale on left
      so that no empty space happened.

 Allow towards Right when
   *) if self is not full size
   *) there is empty space on Right side
   *) if No empty space on the row then allow that much that
      any toolbar is Shrinkable on right(self included) and any tool bar is expandable on left
      so that no empty space happened.
}

procedure TRowCollectionItem.SetToolBarLeftAndWidth(
  aAdvToolBar: TAdvCustomToolBar; var ALeft, AWidth: integer);
var
  tbIdx, exp, i, TotalLeft, TotalWidth: integer;
  OldValue: boolean;
  L, EmptSp, j, k, M: integer;
  ATb: TAdvCustomToolBar;

  function TotalExpand(ToolBarIndex: integer; TowardsRight: boolean): integer;
  var
    i: integer;
  begin
    Result := 0;
    if TowardsRight then
    begin
      for i := ToolBarIndex to FToolBarList.Count - 1 do
        Result := Result + TAdvCustomToolBar(FToolBarList[i]).CanExpand;
    end
    else
    begin
      for i := ToolBarIndex - 1 downto 0 do
        Result := Result + TAdvCustomToolBar(FToolBarList[i]).CanExpand;
    end;
  end;

begin
  tbIdx := FToolBarList.IndexOf(aAdvToolBar);
  if tbIdx < 0 then
    raise exception.Create('Invalid ToolBar Index');

  //dif:= 0;
  //exp:= 0;
  if TAdvDockPanel(TRowCollection(Collection).FOwner).Align in [daTop, daBottom] then
  begin
    if aAdvToolBar.Left > ALeft then // Towards Left
    begin
    
      if (ALeft < (RowRect.Left + TRowCollection(Collection).OffSetX)) then
        ALeft := (RowRect.Left + TRowCollection(Collection).OffSetX);

      TotalLeft := aAdvToolBar.Left - ALeft;
     { if (ALeft <= (RowRect.Left + TRowCollection(Collection).OffSetX)) then
      begin
        if tbIdx = 0 then
          ALeft := RowRect.Left + TRowCollection(Collection).OffSetX
        else
          ALeft := aAdvToolBar.Left;
      end
      else} if (tbIdx = 0) then
      begin
        //do nothing
      end
      else if (tbIdx > 0) then
      begin
           // Covering Empty space on the Left
        for i := tbIdx downto 0 do
        begin
          ATb := TAdvCustomToolBar(FToolBarList[i]);
          if i > 0 then
            EmptSp := GetSpace(TAdvCustomToolBar(FToolBarList[i - 1]), ATb)
          else
            EmptSp := GetSpace(nil, ATb);

          if EmptSp > 0 then
          begin
            //move Atb left to Available and required space
            L := min(EmptSp, TotalLeft);
            TotalLeft := TotalLeft - L;
            for j := i to tbIdx do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[j]);
              OldValue := ATb.AllowBoundChange;
              ATb.AllowBoundChange := true;
              ATb.Left := ATb.Left - L;
              ATb.AllowBoundChange := OldValue;
            end;
          end;
          if TotalLeft <= 0 then
            break;
        end;


        if TotalLeft > 0 then
        begin
          EmptSp := 0;
          // checking empty space on the right
          for i := tbIdx to FToolBarList.Count - 1 do
          begin
            ATb := TAdvCustomToolBar(FToolBarList[i]);
            if i < FToolBarList.Count - 1 then
              EmptSp := GetSpace(ATb, TAdvCustomToolBar(FToolBarList[i + 1]))
            else
              EmptSp := GetSpace(ATb, nil);
          end;

          // if not empty space and left further required then shrink Left ToolBars
          if EmptSp <= 0 then
          begin
            for i := tbIdx - 1 downto 0 do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[i]);
              L := min(TotalLeft, ATb.CanShrink);

              L := min(L, TotalExpand(tbIdx, true)); // TotalExpand toward Right

              TotalLeft := TotalLeft - L;

              if L > 0 then
              begin
                // Shrink ToolBar
                OldValue := ATb.AllowBoundChange;
                ATb.AllowBoundChange := true;
                ATb.Width := ATb.Width - L;
                ATb.AllowBoundChange := OldValue;

                // Updating Left On Shrink
                for j := i + 1 to tbIdx - 1 do
                begin
                  ATb := TAdvCustomToolBar(FToolBarList[j]);
                  OldValue := ATb.AllowBoundChange;
                  ATb.AllowBoundChange := true;
                  ATb.Left := ATb.Left - L;
                  ATb.AllowBoundChange := OldValue;
                end;

                // Expand ToolBars
                for k := tbIdx to FToolBarList.Count - 1 do
                begin
                  ATb := TAdvCustomToolBar(FToolBarList[k]);
                  exp := min(L, ATb.CanExpand);
                  OldValue := ATb.AllowBoundChange;
                  ATb.AllowBoundChange := true;
                  ATb.Width := ATb.Width + exp;
                  //if k > tbIdx then
                  ATb.Left := ATb.Left - exp;
                  ATb.AllowBoundChange := OldValue;

                  L := L - exp;
                  if L <= 0 then
                    break;
                end;
              end;

              if TotalLeft <= 0 then
                break;
            end;
          end;

        end;

        {
        PrevToolBar:= TAdvCustomToolBar(FToolBarList[tbIdx-1]);
        if aAdvToolBar.Left <= (PrevToolBar.Left + PrevToolBar.Width + TRowCollection(Collection).OffSetX) then
        begin
          if PrevToolBar.Left = (TAdvDockPanel(TRowCollection(Collection).Owner).OffSetX + TRowCollection(Collection).OffSetX) then
          begin
            dif:= min(PrevToolBar.CanShrink, (aAdvToolBar.Left - ALeft));
            if dif > 0 then
            begin
              OldValue:= PrevToolBar.AllowBoundChange;
              PrevToolBar.AllowBoundChange:= true;
              PrevToolBar.Width:= PrevToolBar.Width - dif;
              PrevToolBar.AllowBoundChange:= OldValue;
            end;
          end;
        end;
         }

        // OutputDebugString(PChar('TotLf: '+inttostr(TotalLeft)));
        // Inserting ToolBar
        if (TotalLeft > 0)  and not (csLoading in aAdvToolBar.ComponentState) then  // since tbIdx > 0
        begin
          if (aAdvToolBar.Left - TotalLeft) <= (TAdvCustomToolBar(FToolBarList[tbIdx-1]).Left + 5 ) then
          begin
            OldValue := aAdvToolBar.AllowBoundChange;
            aAdvToolBar.AllowBoundChange := true;
            FToolBarList.Move(tbIdx, tbIdx-1);
            aAdvToolBar.Left := TAdvCustomToolBar(FToolBarList[tbIdx-1]).Left;
            self.ArrangeToolBars;
            aAdvToolBar.AllowBoundChange := OldValue;
          end;
        end;

        ALeft := aAdvToolBar.Left;
        AWidth := aAdvToolBar.Width;
      end;
    end
    else if aAdvToolBar.Left < ALeft then // Towards Right
    begin

      TotalLeft := ALeft - aAdvToolBar.Left;
     { if (ALeft >= (RowRect.Right - TRowCollection(Collection).OffSetX)) then
      begin
        if tbIdx = FToolBarList.Count-1 then
          ALeft:= RowRect.Right - TRowCollection(Collection).OffSetX - aAdvToolBar.Width;
      end
      else if (tbIdx = 0) then
      begin
        //do nothing
      end
      else if (tbIdx > 0) then }
      begin
        // Covering Empty space on the Right
        for i := tbIdx to FToolBarList.Count - 1 do
        begin
          ATb := TAdvCustomToolBar(FToolBarList[i]);
          if i < FToolBarList.Count - 1 then
            EmptSp := GetSpace(ATb, TAdvCustomToolBar(FToolBarList[i + 1]))
          else
            EmptSp := GetSpace(ATb, nil);

          if EmptSp > 0 then
          begin
            //move Atb Right to Available and required space
            L := min(EmptSp, TotalLeft);
            TotalLeft := TotalLeft - L;
            for j := tbIdx to i do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[j]);
              OldValue := ATb.AllowBoundChange;
              ATb.AllowBoundChange := true;
              ATb.Left := ATb.Left + L;
              ATb.AllowBoundChange := OldValue;
            end;
          end;

          if TotalLeft <= 0 then
            break;
        end;


        if TotalLeft > 0 then
        begin
          // checking empty space on the Left
          EmptSp := 0;
          for i := tbIdx downto 0 do
          begin
            ATb := TAdvCustomToolBar(FToolBarList[i]);
            if i > 0 then
              EmptSp := EmptSp + GetSpace(TAdvCustomToolBar(FToolBarList[i - 1]), ATb)
            else
              EmptSp := EmptSp + GetSpace(nil, ATb);
          end;

          // if not empty space and Right further required then shrink Right ToolBars
          if EmptSp <= 0 then
          begin
            TotalLeft := min(TotalLeft, TotalExpand(tbIdx, false));

            for i := FToolBarList.Count - 1 downto tbIdx do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[i]);
              L := min(TotalLeft, ATb.CanShrink);
              TotalLeft := TotalLeft - L;

              if L > 0 then
              begin
                // Adjust left
                OldValue := ATb.AllowBoundChange;
                ATb.AllowBoundChange := true;
                ATb.Width := ATb.Width - L;
                ATb.Left := ATb.Left + L;
                ATb.AllowBoundChange := OldValue;

                for j := i - 1 downto tbIdx + 1 do
                begin
                  ATb := TAdvCustomToolBar(FToolBarList[j]);
                  OldValue := ATb.AllowBoundChange;
                  ATb.AllowBoundChange := true;
                  ATb.Left := ATb.Left + L;
                  ATb.AllowBoundChange := OldValue;
                end;

                // Expand ToolBars on the Left side
                for k := tbIdx - 1 downto 0 do
                begin
                  ATb := TAdvCustomToolBar(FToolBarList[k]);
                  exp := min(L, ATb.CanExpand);
                  OldValue := ATb.AllowBoundChange;
                  ATb.AllowBoundChange := true;
                  ATb.Width := ATb.Width + exp;
                  ATb.AllowBoundChange := OldValue;

                  // Move ToolBars for Increase width
                  for M := k + 1 to tbIdx - 1 do
                  begin
                    ATb := TAdvCustomToolBar(FToolBarList[M]);
                    OldValue := ATb.AllowBoundChange;
                    ATb.AllowBoundChange := true;
                    ATb.Left := ATb.Left + exp;
                    ATb.AllowBoundChange := OldValue;
                  end;

                  L := L - exp;
                  if L <= 0 then
                    break;
                end;


              end;

              if TotalLeft <= 0 then
                break;
            end;
          end;

        end;
       {
        if (TotalLeft > 0) then  // since tbIdx > 0
        begin
          if (aAdvToolBar.Left + TotalLeft) > (TAdvCustomToolBar(FToolBarList[tbIdx+1]).Left + 2 ) then
          begin
            OldValue := aAdvToolBar.AllowBoundChange;
            aAdvToolBar.AllowBoundChange := true;
            FToolBarList.Move(tbIdx, tbIdx+1);
            aAdvToolBar.Left := TAdvCustomToolBar(FToolBarList[tbIdx+1]).Left;
            self.ArrangeToolBars;
            aAdvToolBar.AllowBoundChange := OldValue;
          end;
        end;  }

        ALeft := aAdvToolBar.Left;
        AWidth := aAdvToolBar.Width;
      end;


    end
    else if aAdvToolBar.Width > AWidth then // Decrease width
    begin

    end
    else if aAdvToolBar.Width < AWidth then // Increase Width
    begin

      TotalWidth := AWidth - aAdvToolBar.Width;
      // Covering Empty space on the Right
      for i := tbIdx to FToolBarList.Count - 1 do
      begin
        ATb := TAdvCustomToolBar(FToolBarList[i]);
        if i < FToolBarList.Count - 1 then
          EmptSp := GetSpace(ATb, TAdvCustomToolBar(FToolBarList[i + 1]))
        else
          EmptSp := GetSpace(ATb, nil);

        if EmptSp > 0 then
        begin
          //move Atb Right to Available and required space
          L := min(EmptSp, TotalWidth);
          TotalWidth := TotalWidth - L;
          for j := tbIdx + 1 to i do
          begin
            ATb := TAdvCustomToolBar(FToolBarList[j]);
            OldValue := ATb.AllowBoundChange;
            ATb.AllowBoundChange := true;
            ATb.Left := ATb.Left + L;
            ATb.AllowBoundChange := OldValue;
          end;

          ATb := TAdvCustomToolBar(FToolBarList[tbIdx]);
          OldValue := ATb.AllowBoundChange;
          ATb.AllowBoundChange := true;
          ATb.Width := ATb.Width + L;
          ATb.AllowBoundChange := OldValue;
        end;

        if TotalWidth <= 0 then
          break;
      end;


      if TotalWidth > 0 then
      begin
        // checking empty space on the Left
        EmptSp := 0;
        for i := tbIdx downto 0 do
        begin
          ATb := TAdvCustomToolBar(FToolBarList[i]);
          if i > 0 then
            EmptSp := EmptSp + GetSpace(TAdvCustomToolBar(FToolBarList[i - 1]), ATb)
          else
            EmptSp := EmptSp + GetSpace(nil, ATb);
        end;

        if EmptSP > 0 then
        begin
          // Covering Empty space on the Left
          for i := tbIdx downto 0 do
          begin
            ATb := TAdvCustomToolBar(FToolBarList[i]);
            if i > 0 then
              EmptSp := GetSpace(TAdvCustomToolBar(FToolBarList[i - 1]), ATb)
            else
              EmptSp := GetSpace(nil, ATb);

            if EmptSp > 0 then
            begin
              //move Atb left to Available and required space
              L := min(EmptSp, TotalWidth);
              TotalWidth := TotalWidth - L;
              for j := i to tbIdx do
              begin
                ATb := TAdvCustomToolBar(FToolBarList[j]);
                OldValue := ATb.AllowBoundChange;
                ATb.AllowBoundChange := true;
                ATb.Left := ATb.Left - L;
                ATb.AllowBoundChange := OldValue;
              end;

              ATb := TAdvCustomToolBar(FToolBarList[tbIdx]);
              OldValue := ATb.AllowBoundChange;
              ATb.AllowBoundChange := true;
              ATb.Width := ATb.Width + L;
              ATb.AllowBoundChange := OldValue;
            end;
            if TotalWidth <= 0 then
              break;
          end;


        end
        else if EmptSp <= 0 then // if not empty space and Inc Width further required then shrink Right ToolBars
        begin
        (*  TotalWidth:= min(TotalWidth, TotalExpand(tbIdx, false));

          for i:= FToolBarList.Count-1 downto tbIdx + 1  do
          begin
            ATb:= TAdvCustomToolBar(FToolBarList[i]);
            L:= min(TotalWidth, ATb.CanShrink);
            TotalWidth:= TotalWidth - L;

            if L > 0 then
            begin
              // Adjust left
              OldValue:= ATb.AllowBoundChange;
              ATb.AllowBoundChange:= true;
              ATb.Width:= ATb.Width - L;
              ATb.Left:= ATb.Left + L;
              ATb.AllowBoundChange:= OldValue;

              for j:= i-1 downto tbIdx+1 do
              begin
                ATb:= TAdvCustomToolBar(FToolBarList[j]);
                OldValue:= ATb.AllowBoundChange;
                ATb.AllowBoundChange:= true;
                ATb.Left:= ATb.Left + L;
                ATb.AllowBoundChange:= OldValue;
              end;

              {
              // Expand ToolBars on the Left side
              for k:= tbIdx-1 downto 0 do
              begin
                ATb:= TAdvCustomToolBar(FToolBarList[k]);
                exp:= min(L, ATb.CanExpand);
                OldValue:= ATb.AllowBoundChange;
                ATb.AllowBoundChange:= true;
                ATb.Width:= ATb.Width + exp;
                ATb.AllowBoundChange:= OldValue;

                // Move ToolBars for Increase width
                for M:= k+1 to tbIdx-1 do
                begin
                  ATb:= TAdvCustomToolBar(FToolBarList[M]);
                  OldValue:= ATb.AllowBoundChange;
                  ATb.AllowBoundChange:= true;
                  ATb.Left:= ATb.Left + exp;
                  ATb.AllowBoundChange:= OldValue;
                end;

                L:= L - exp;
                if L <=0 then
                  break;
              end;
              }

            end;

            if TotalWidth <=0 then
              break;
          end;   *)
        end;

      end;
      ALeft := aAdvToolBar.Left;
      AWidth := aAdvToolBar.Width;

    end;


  end;
end;

//------------------------------------------------------------------------------

procedure TRowCollectionItem.SetToolBarTopAndHeight(
  aAdvToolBar: TAdvCustomToolBar; var ATop, AHeight: integer);
var
  tbIdx, exp, i, TotalUp, TotalHeight: integer;
  OldValue: boolean;
  L, EmptSp, j, k, M: integer;
  ATb: TAdvCustomToolBar;

  function TotalExpand(ToolBarIndex: integer; DownWards: boolean): integer;
  var
    i: integer;
  begin
    Result := 0;
    if DownWards then
    begin
      for i := ToolBarIndex to FToolBarList.Count - 1 do
        Result := Result + TAdvCustomToolBar(FToolBarList[i]).CanExpand;
    end
    else
    begin
      for i := ToolBarIndex - 1 downto 0 do
        Result := Result + TAdvCustomToolBar(FToolBarList[i]).CanExpand;
    end;
  end;

begin
  tbIdx := FToolBarList.IndexOf(aAdvToolBar);
  if tbIdx < 0 then
    raise exception.Create('Invalid ToolBar Index');

  if TAdvDockPanel(TRowCollection(Collection).FOwner).Align in [daLeft, daRight] then
  begin
    if aAdvToolBar.Top > ATop then // Upwards
    begin
      if (ATop < (RowRect.Top + TRowCollection(Collection).OffSetX)) then
        ATop := (RowRect.Top + TRowCollection(Collection).OffSetX);

      TotalUp := aAdvToolBar.Top - ATop;
      {if (ATop <= (RowRect.Top + TRowCollection(Collection).OffSetX)) then
      begin
        if tbIdx = 0 then
          ATop := RowRect.Top + TRowCollection(Collection).OffSetX
        else
          ATop := aAdvToolBar.Top;
      end
      else} if (tbIdx = 0) then
      begin
        //do nothing
      end
      else if (tbIdx > 0) then
      begin
           // Covering Empty space on the Top
        for i := tbIdx downto 0 do
        begin
          ATb := TAdvCustomToolBar(FToolBarList[i]);
          if i > 0 then
            EmptSp := GetSpace(TAdvCustomToolBar(FToolBarList[i - 1]), ATb)
          else
            EmptSp := GetSpace(nil, ATb);

          if EmptSp > 0 then
          begin
            //move Atb Up to Available and required space
            L := min(EmptSp, TotalUp);
            TotalUp := TotalUp - L;
            for j := i to tbIdx do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[j]);
              OldValue := ATb.AllowBoundChange;
              ATb.AllowBoundChange := true;
              ATb.Top := ATb.Top - L;
              ATb.AllowBoundChange := OldValue;
            end;
          end;
          if TotalUp <= 0 then
            break;
        end;


        if TotalUp > 0 then
        begin
          EmptSp := 0;
          // checking empty space towards Down
          for i := tbIdx to FToolBarList.Count - 1 do
          begin
            ATb := TAdvCustomToolBar(FToolBarList[i]);
            if i < FToolBarList.Count - 1 then
              EmptSp := GetSpace(ATb, TAdvCustomToolBar(FToolBarList[i + 1]))
            else
              EmptSp := GetSpace(ATb, nil);
          end;

          // if not empty space and Top further required then shrink Up ToolBars
          if EmptSp <= 0 then
          begin
            for i := tbIdx - 1 downto 0 do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[i]);
              L := min(TotalUp, ATb.CanShrink);

              L := min(L, TotalExpand(tbIdx, true)); // TotalExpand downwards

              TotalUp := TotalUp - L;

              if L > 0 then
              begin
                // Shrink ToolBar
                OldValue := ATb.AllowBoundChange;
                ATb.AllowBoundChange := true;
                ATb.Height := ATb.Height - L;
                ATb.AllowBoundChange := OldValue;

                // Updating Top On Shrink
                for j := i + 1 to tbIdx - 1 do
                begin
                  ATb := TAdvCustomToolBar(FToolBarList[j]);
                  OldValue := ATb.AllowBoundChange;
                  ATb.AllowBoundChange := true;
                  ATb.Top := ATb.Top - L;
                  ATb.AllowBoundChange := OldValue;
                end;

                // Expand ToolBars
                for k := tbIdx to FToolBarList.Count - 1 do
                begin
                  ATb := TAdvCustomToolBar(FToolBarList[k]);
                  exp := min(L, ATb.CanExpand);
                  OldValue := ATb.AllowBoundChange;
                  ATb.AllowBoundChange := true;
                  ATb.Height := ATb.Height + exp;
                  //if k > tbIdx then
                  ATb.Top := ATb.Top - exp;
                  ATb.AllowBoundChange := OldValue;

                  L := L - exp;
                  if L <= 0 then
                    break;
                end;
              end;

              if TotalUp <= 0 then
                break;
            end;
          end;

        end;

        // Inserting ToolBar
        if (TotalUp > 0) and not (csLoading in aAdvToolBar.ComponentState) then  // since tbIdx > 0
        begin
          if (aAdvToolBar.Top - TotalUp) <= (TAdvCustomToolBar(FToolBarList[tbIdx-1]).Top + 5 ) then
          begin
            OldValue := aAdvToolBar.AllowBoundChange;
            aAdvToolBar.AllowBoundChange := true;
            FToolBarList.Move(tbIdx, tbIdx-1);
            aAdvToolBar.Top := TAdvCustomToolBar(FToolBarList[tbIdx-1]).Top;
            self.ArrangeToolBars;
            aAdvToolBar.AllowBoundChange := OldValue;
          end;
        end;

        ATop := aAdvToolBar.Top;
        AHeight := aAdvToolBar.Height;
      end;
    end
    else if aAdvToolBar.Top < ATop then // DownWards
    begin

      TotalUp := ATop - aAdvToolBar.Top;

      begin
        // Covering Empty space downwards
        for i := tbIdx to FToolBarList.Count - 1 do
        begin
          ATb := TAdvCustomToolBar(FToolBarList[i]);
          if i < FToolBarList.Count - 1 then
            EmptSp := GetSpace(ATb, TAdvCustomToolBar(FToolBarList[i + 1]))
          else
            EmptSp := GetSpace(ATb, nil);

          if EmptSp > 0 then
          begin
            //move Atb Down to Available and required space
            L := min(EmptSp, TotalUp);
            TotalUp := TotalUp - L;
            for j := tbIdx to i do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[j]);
              OldValue := ATb.AllowBoundChange;
              ATb.AllowBoundChange := true;
              ATb.Top := ATb.Top + L;
              ATb.AllowBoundChange := OldValue;
            end;
          end;

          if TotalUp <= 0 then
            break;
        end;


        if TotalUp > 0 then
        begin
          // checking empty space on the Top
          EmptSp := 0;
          for i := tbIdx downto 0 do
          begin
            ATb := TAdvCustomToolBar(FToolBarList[i]);
            if i > 0 then
              EmptSp := EmptSp + GetSpace(TAdvCustomToolBar(FToolBarList[i - 1]), ATb)
            else
              EmptSp := EmptSp + GetSpace(nil, ATb);
          end;

          // if not empty space and Down further required then shrink Down ToolBars
          if EmptSp <= 0 then
          begin
            TotalUp := min(TotalUp, TotalExpand(tbIdx, false));

            for i := FToolBarList.Count - 1 downto tbIdx do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[i]);
              L := min(TotalUp, ATb.CanShrink);
              TotalUp := TotalUp - L;

              if L > 0 then
              begin
                // Adjust Top
                OldValue := ATb.AllowBoundChange;
                ATb.AllowBoundChange := true;
                ATb.Height := ATb.Height - L;
                ATb.Top := ATb.Top + L;
                ATb.AllowBoundChange := OldValue;

                for j := i - 1 downto tbIdx + 1 do
                begin
                  ATb := TAdvCustomToolBar(FToolBarList[j]);
                  OldValue := ATb.AllowBoundChange;
                  ATb.AllowBoundChange := true;
                  ATb.Top := ATb.Top + L;
                  ATb.AllowBoundChange := OldValue;
                end;

                // Expand Top ToolBars
                for k := tbIdx - 1 downto 0 do
                begin
                  ATb := TAdvCustomToolBar(FToolBarList[k]);
                  exp := min(L, ATb.CanExpand);
                  OldValue := ATb.AllowBoundChange;
                  ATb.AllowBoundChange := true;
                  ATb.Height := ATb.Height + exp;
                  ATb.AllowBoundChange := OldValue;

                  // Move ToolBars for Increase Height
                  for M := k + 1 to tbIdx - 1 do
                  begin
                    ATb := TAdvCustomToolBar(FToolBarList[M]);
                    OldValue := ATb.AllowBoundChange;
                    ATb.AllowBoundChange := true;
                    ATb.Top := ATb.Top + exp;
                    ATb.AllowBoundChange := OldValue;
                  end;

                  L := L - exp;
                  if L <= 0 then
                    break;
                end;


              end;

              if TotalUp <= 0 then
                break;
            end;
          end;

        end;
        ATop := aAdvToolBar.Top;
        AHeight := aAdvToolBar.Height;
      end;


    end
    else if aAdvToolBar.Height > AHeight then // Dec Height
    begin

    end
    else if aAdvToolBar.Height < AHeight then // Inc Height
    begin

      TotalHeight := AHeight - aAdvToolBar.Height;

      begin
        // Covering Empty space downwards
        for i := tbIdx to FToolBarList.Count - 1 do
        begin
          ATb := TAdvCustomToolBar(FToolBarList[i]);
          if i < FToolBarList.Count - 1 then
            EmptSp := GetSpace(ATb, TAdvCustomToolBar(FToolBarList[i + 1]))
          else
            EmptSp := GetSpace(ATb, nil);

          if EmptSp > 0 then
          begin
            //move Atb Down to Available and required space
            L := min(EmptSp, TotalHeight);
            TotalHeight := TotalHeight - L;
            for j := tbIdx + 1 to i do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[j]);
              OldValue := ATb.AllowBoundChange;
              ATb.AllowBoundChange := true;
              ATb.Top := ATb.Top + L;
              ATb.AllowBoundChange := OldValue;
            end;

            ATb := TAdvCustomToolBar(FToolBarList[tbIdx]);
            OldValue := ATb.AllowBoundChange;
            ATb.AllowBoundChange := true;
            ATb.Height := ATb.Height + L;
            ATb.AllowBoundChange := OldValue;
          end;

          if TotalHeight <= 0 then
            break;
        end;


        if TotalHeight > 0 then
        begin
          // checking empty space on the Top
         { EmptSp:= 0;
          for i:= tbIdx downto 0 do
          begin
            ATb:= TAdvCustomToolBar(FToolBarList[i]);
            if i > 0 then
              EmptSp:= EmptSp + GetSpace(TAdvCustomToolBar(FToolBarList[i-1]), ATb)
            else
              EmptSp:= EmptSp + GetSpace(nil, ATb);
          end;  }

          //if EmptSP > 0 then
          begin
            for i := tbIdx downto 0 do
            begin
              ATb := TAdvCustomToolBar(FToolBarList[i]);
              if i > 0 then
                EmptSp := GetSpace(TAdvCustomToolBar(FToolBarList[i - 1]), ATb)
              else
                EmptSp := GetSpace(nil, ATb);

              if EmptSp > 0 then
              begin
                //move Atb Up to Available and required space
                L := min(EmptSp, TotalHeight);
                TotalHeight := TotalHeight - L;
                for j := i to tbIdx do
                begin
                  ATb := TAdvCustomToolBar(FToolBarList[j]);
                  OldValue := ATb.AllowBoundChange;
                  ATb.AllowBoundChange := true;
                  ATb.Top := ATb.Top - L;
                  if i = tbIdx then
                    ATb.Height := ATb.Height + L;
                  ATb.AllowBoundChange := OldValue;
                end;
              end;

              if TotalHeight <= 0 then
                break;
            end;

          end;
          //else if EmptSp <=0 then  // if not empty space and Down further required then shrink Down ToolBars
          if TotalHeight > 0 then
          begin
           { TotalUp:= min(TotalUp, TotalExpand(tbIdx, false));

            for i:= FToolBarList.Count-1 downto tbIdx  do
            begin
              ATb:= TAdvCustomToolBar(FToolBarList[i]);
              L:= min(TotalUp, ATb.CanShrink);
              TotalUp:= TotalUp - L;

              if L > 0 then
              begin
                // Adjust Top
                OldValue:= ATb.AllowBoundChange;
                ATb.AllowBoundChange:= true;
                ATb.Height:= ATb.Height - L;
                ATb.Top:= ATb.Top + L;
                ATb.AllowBoundChange:= OldValue;

                for j:= i-1 downto tbIdx+1 do
                begin
                  ATb:= TAdvCustomToolBar(FToolBarList[j]);
                  OldValue:= ATb.AllowBoundChange;
                  ATb.AllowBoundChange:= true;
                  ATb.Top:= ATb.Top + L;
                  ATb.AllowBoundChange:= OldValue;
                end;

                // Expand Top ToolBars
                for k:= tbIdx-1 downto 0 do
                begin
                  ATb:= TAdvCustomToolBar(FToolBarList[k]);
                  exp:= min(L, ATb.CanExpand);
                  OldValue:= ATb.AllowBoundChange;
                  ATb.AllowBoundChange:= true;
                  ATb.Height:= ATb.Height + exp;
                  ATb.AllowBoundChange:= OldValue;

                  // Move ToolBars for Increase Height
                  for M:= k+1 to tbIdx-1 do
                  begin
                    ATb:= TAdvCustomToolBar(FToolBarList[M]);
                    OldValue:= ATb.AllowBoundChange;
                    ATb.AllowBoundChange:= true;
                    ATb.Top:= ATb.Top + exp;
                    ATb.AllowBoundChange:= OldValue;
                  end;

                  L:= L - exp;
                  if L <=0 then
                    break;
                end;


              end;

              if TotalUp <=0 then
                break;
            end; }
          end;

        end;
        ATop := aAdvToolBar.Top;
        AHeight := aAdvToolBar.Height;
      end;

    end;


  end;

end;

//------------------------------------------------------------------------------

procedure TRowCollectionItem.RemoveToolBar(aAdvToolBar: TAdvCustomToolBar; DeleteIfEmpty: Boolean = True);
var
  i: integer;
begin
  i := FToolBarList.IndexOf(aAdvToolBar);
  if i >= 0 then
  begin
    FToolBarList.Delete(i);
    ArrangeToolBars;
    if DeleteIfEmpty then
      TRowCollection(Collection).DeleteMeIfEmpty(self);
  end;
end;

//------------------------------------------------------------------------------

function TRowCollectionItem.GetSpace(FirstAdvToolBar,
  SecondAdvToolBar: TAdvCustomToolBar): integer;
begin
  if TAdvDockPanel(TRowCollection(Collection).FOwner).Align in [daTop, daBottom] then
  begin
    if (FirstAdvToolBar <> nil) and (SecondAdvToolBar <> nil) then
      Result := SecondAdvToolBar.Left - (FirstAdvToolBar.Left + FirstAdvToolBar.Width + TRowCollection(Collection).OffSetX)
    else if (FirstAdvToolBar <> nil) then
      Result := RowRect.Right - (FirstAdvToolBar.Left + FirstAdvToolBar.Width + TRowCollection(Collection).OffSetX)
    else if (SecondAdvToolBar <> nil) then
      Result := SecondAdvToolBar.Left - (RowRect.Left + TRowCollection(Collection).OffSetX)
    else
      Result := 0;
  end
  else // daLeft, daRight
  begin
    if (FirstAdvToolBar <> nil) and (SecondAdvToolBar <> nil) then
      Result := SecondAdvToolBar.Top - (FirstAdvToolBar.Top + FirstAdvToolBar.Height + TRowCollection(Collection).OffSetX)
    else if (FirstAdvToolBar <> nil) then
      Result := RowRect.Bottom - (FirstAdvToolBar.Top + FirstAdvToolBar.Height + TRowCollection(Collection).OffSetX)
    else if (SecondAdvToolBar <> nil) then
      Result := SecondAdvToolBar.Top - (RowRect.Top + TRowCollection(Collection).OffSetX)
    else
      Result := 0;
  end;
end;

//------------------------------------------------------------------------------

function TRowCollectionItem.IsAllowed(
  aAdvToolBar: TAdvCustomToolBar): Boolean;
begin
  Result := true;
  if ToolBarList.Count >= 1 then
  begin
    Result := not TAdvCustomToolBar(FToolBarList[0]).FullSize;
  end;

  if Result and aAdvToolBar.FullSize then
    Result := ToolBarList.Count = 0;
end;

//------------------------------------------------------------------------------

{ TRowCollection }

function TRowCollection.Add: TRowCollectionItem;
begin
  Result := TRowCollectionItem(inherited Add); 
  SetRowsPosition;
end;

//------------------------------------------------------------------------------

constructor TRowCollection.Create(AOwner: TAdvDockPanel);
begin
  inherited Create(TRowCollectionItem);
  FOwner := AOwner;
  FOffSetX := 2;
  FOffSetY := 1;
end;

//------------------------------------------------------------------------------

procedure TRowCollection.DeleteMeIfEmpty(AItem: TRowCollectionItem);
var
  i: integer;
begin
  i := AItem.Index;
  if (AItem.ToolBarList.Count <= 0) and not (FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded)) then
  begin
    Delete(i);
    SetRowsPosition;
  end;
end;

//------------------------------------------------------------------------------

function TRowCollection.GetItem(Index: Integer): TRowCollectionItem;
begin
  Result := TRowCollectionItem(inherited Items[Index]);
end;

//------------------------------------------------------------------------------

function TRowCollection.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

//------------------------------------------------------------------------------

function TRowCollection.Insert(Index: Integer): TRowCollectionItem;
{var
  i: integer;  }
begin
  Result := TRowCollectionItem(inherited Insert(Index));
  SetRowsPosition;
 { for i:=index+1 to Count-1 do
    items[i].ArrangeToolBars;  }
end;

//------------------------------------------------------------------------------

function TRowCollection.IsToolBarAlreadyAdded(
  aAdvToolBar: TAdvCustomToolBar): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
  begin
    if Items[I].ToolBarList.IndexOf(aAdvToolBar) >= 0 then
    begin
      Result := I;
      Break;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TRowCollection.MoveToolBarToRow(aAdvToolBar: TAdvCustomToolBar;
  ARowIndex: integer);
var
  OldIndex: integer;
begin
  if (ARowIndex < 0) or (ARowIndex >= Count) then
    raise exception.Create('Invalid Row Index');

  if Assigned(aAdvToolBar) and (aAdvToolBar.Row <> ARowIndex) then
  begin
    if Items[ARowIndex].IsAllowed(aAdvToolBar) then
    begin
      OldIndex := aAdvToolBar.Row;
      Items[OldIndex].RemoveToolBar(aAdvToolBar, false);
      Items[ARowIndex].AddToolBar(aAdvToolBar);
      Self.DeleteMeIfEmpty(Items[OldIndex]);
      //Items[OldIndex].RemoveToolBar(aAdvToolBar);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TRowCollection.SetItem(Index: Integer;
  const Value: TRowCollectionItem);
begin
  inherited Items[Index] := Value;
end;

//------------------------------------------------------------------------------

procedure TRowCollection.SetParentSize;
var
  s, df: Integer;
begin
  if FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded) then
    Exit;

  if FOwner.Align in [daTop, daBottom] then
  begin
    if FOwner.Align = daTop then
    begin
      if csDesigning in FOwner.ComponentState then
      begin
        if FOwner.UseRunTimeHeight then
        begin
          if Count > 0 then
            FOwner.Height := Items[Count - 1].RowRect.bottom + FOwner.OffSetY
          else
            FOwner.Height := FOwner.MinimumSize;// MINDOCKPANELHEIGHT;
        end
        else
        begin
          if Count > 0 then
            FOwner.Height := Items[Count - 1].RowRect.bottom + FOwner.OffSetY + (DEFAULT_TOOLBARHEIGHT div 2)
          else
            FOwner.Height := (DEFAULT_TOOLBARHEIGHT div 2) + FOwner.OffSetY * 2;
        end;
      end
      else
      begin
        if Count > 0 then
          FOwner.Height := Items[Count - 1].RowRect.bottom + FOwner.OffSetY
        else
          FOwner.Height := FOwner.MinimumSize;// MINDOCKPANELHEIGHT;
      end;
    end
    else   // daBottom
    begin
      if csDesigning in FOwner.ComponentState then
      begin
        if FOwner.UseRunTimeHeight then
        begin
          if Count > 0 then
            s := Items[Count - 1].RowRect.bottom + FOwner.OffSetY
          else
            s := FOwner.MinimumSize;// MINDOCKPANELHEIGHT;
        end
        else
        begin
          if Count > 0 then
            s := Items[Count - 1].RowRect.bottom + FOwner.OffSetY + (DEFAULT_TOOLBARHEIGHT div 2)
          else
            s := (DEFAULT_TOOLBARHEIGHT div 2) + FOwner.OffSetY * 2;
        end;
      end
      else
      begin
        if Count > 0 then
          s := Items[Count - 1].RowRect.bottom + FOwner.OffSetY
        else
          s := FOwner.MinimumSize;// MINDOCKPANELHEIGHT;
      end;

      if FOwner.Height < s then
      begin
        df := s - FOwner.Height;
        FOwner.SetBounds(FOwner.Left, FOwner.Top-df, FOwner.Width, s);
      end
      else
        FOwner.Height := s;
    end;
  end
  else if FOwner.Align in [daLeft, daRight] then
  begin
    if FOwner.Align = daLeft then
    begin
      if csDesigning in FOwner.ComponentState then
      begin
        if FOwner.UseRunTimeHeight then
        begin
          if Count > 0 then
            FOwner.Width := Items[Count - 1].RowRect.Right + FOwner.OffSetX
          else
            FOwner.Width := FOwner.MinimumSize; // MINDOCKPANELHEIGHT;
        end
        else
        begin
          if Count > 0 then
            FOwner.Width := Items[Count - 1].RowRect.Right + FOwner.OffSetX + (DEFAULT_TOOLBARHEIGHT div 2)
          else
            FOwner.Width := (DEFAULT_TOOLBARHEIGHT div 2) + FOwner.OffSetX * 2;
        end;
      end
      else
      begin
        if Count > 0 then
          FOwner.Width := Items[Count - 1].RowRect.Right + FOwner.OffSetX
        else
          FOwner.Width := FOwner.MinimumSize; // MINDOCKPANELHEIGHT;
      end;
    end
    else  // daRight
    begin
      if csDesigning in FOwner.ComponentState then
      begin
        if FOwner.UseRunTimeHeight then
        begin
          if Count > 0 then
            s := Items[Count - 1].RowRect.Right + FOwner.OffSetX
          else
            s := FOwner.MinimumSize; // MINDOCKPANELHEIGHT;
        end
        else
        begin
          if Count > 0 then
            s := Items[Count - 1].RowRect.Right + FOwner.OffSetX + (DEFAULT_TOOLBARHEIGHT div 2)
          else
            s := (DEFAULT_TOOLBARHEIGHT div 2) + FOwner.OffSetX * 2;
        end;
      end
      else
      begin
        if Count > 0 then
          s := Items[Count - 1].RowRect.Right + FOwner.OffSetX
        else
          s := FOwner.MinimumSize; // MINDOCKPANELHEIGHT;
      end;

      if FOwner.Width < s then
      begin
        df := s - FOwner.Width;
        FOwner.SetBounds(FOwner.Left - df, FOwner.Top, s, FOwner.Height);
      end
      else
        FOwner.Width := s;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TRowCollection.SetRowsPosition;
var
  i, y, x: integer;
begin
  if FOwner.Align in [daTop, daBottom] then
  begin
    y := OffSetY;
    for i := 0 to Count - 1 do
    begin  
      Items[i].SetRowRect(Rect(FOwner.OffSetX, y, FOwner.Width - FOwner.OffSetX, y + Items[i].Height + OffSetY));
      Items[i].ArrangeToolBars;
      y := y + items[i].Height + OffSetY;
    end;
  end
  else if FOwner.Align in [daLeft, daRight] then
  begin
    x := OffSetY;
    for i := 0 to Count - 1 do
    begin
      Items[i].SetRowRect(Rect(x, FOwner.OffSetX, x + Items[i].Height + OffSetY, FOwner.Height - FOwner.OffSetX));
      Items[i].ArrangeToolBars;
      x := x + items[i].Height + OffSetY;
    end;
  end;  
  SetParentSize;
end;

//------------------------------------------------------------------------------

procedure TRowCollection.SetToolBarFullSize(
  aAdvToolBar: TAdvCustomToolBar);
{var
  OldValue: Boolean;
  S : integer;  }
begin
  if Assigned(aAdvToolBar) and (aAdvToolBar.Row >= 0) and (aAdvToolBar.Row < Count) then
  begin
    Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
    Insert(aAdvToolBar.Row).AddToolBar(aAdvToolBar);

    {
    OldValue:= aAdvToolBar.AllowBoundChange;
    aAdvToolBar.AllowBoundChange:= true;
    if FOwner.Align in [daTop, daBottom] then
    begin
      S:= (Items[aAdvToolBar.Row].RowRect.Right - Items[aAdvToolBar.Row].RowRect.Left) - Self.OffSetX*2;
      aAdvToolBar.Width := S;
      aAdvToolBar.Constraints.MaxWidth := S;
      aAdvToolBar.Constraints.MinWidth := S;
    end
    else // daLeft, daRight
    begin
      S:= (Items[aAdvToolBar.Row].RowRect.Bottom - Items[aAdvToolBar.Row].RowRect.Top) - Self.OffSetX*2;
      aAdvToolBar.Height := S;
      aAdvToolBar.Constraints.MaxHeight := S;
      aAdvToolBar.Constraints.MinHeight := S;
    end;

    aAdvToolBar.AllowBoundChange := OldValue; }
    Items[aAdvToolBar.Row].ArrangeToolBars;
  end;
end;

//------------------------------------------------------------------------------
{
Perform ToolBar Row Management
Rules:
  Add ToolBar in a row when
   *) Row has no fullsize Toolbar
   *) Row has the capacity to add this toolbar with its minlength, including max shrink to all toolbars.
}

procedure TRowCollection.SetToolBarLeftAndWidth(
  aAdvToolBar: TAdvCustomToolBar; var ALeft, AWidth: integer);
var
  Allowed, OldValue: Boolean;
  i: integer;
begin
  if FOwner.Align in [daTop, daBottom] then
  begin
  end
  else
  begin
    if (ALeft <= Items[aAdvToolBar.Row].RowRect.Left - 3) and (ALeft >= Items[aAdvToolBar.Row].RowRect.Left - 5)
      and (Items[aAdvToolBar.Row].ToolBarList.Count > 1) {and (aAdvToolBar.Row > 0)} then
    begin // go up and insert new row
      if FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded) then
      begin

      end
      else
      begin
        Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
        Insert(aAdvToolBar.Row).AddToolBar(aAdvToolBar);
      end;
      ALeft := aAdvToolBar.Left;

      //showmessage('1: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end
    else if (ALeft < Items[aAdvToolBar.Row].RowRect.Left - 6) and (aAdvToolBar.Row > 0) then
    begin // go up and Add in existing row
      for i := 0 to aAdvToolBar.Row - 1 do
      begin
        if (ALeft >= Items[i].RowRect.Left) and (ALeft < Items[i].RowRect.Right) then
        begin
          Allowed := Items[i].IsAllowed(aAdvToolBar);
          if Allowed then
          begin
            MoveToolBarToRow(aAdvToolBar, i);
          end
          else
          begin
            if FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded) then
            begin

            end
            else
            begin
              Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
              Insert(i).AddToolBar(aAdvToolBar);
            end;
          end;
          break;
        end;
      end;
      {
      Allowed:= Items[aAdvToolBar.Row-1].IsAllowed(aAdvToolBar);
      if Allowed then
      begin
        MoveToolBarToRow(aAdvToolBar, aAdvToolBar.Row-1);
      end; }
      ALeft := aAdvToolBar.Left;

      //showmessage('1: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end
    else if (ALeft >= Items[aAdvToolBar.Row].RowRect.Left + 3) and (ALeft <= Items[aAdvToolBar.Row].RowRect.Left + 5)
      and (Items[aAdvToolBar.Row].ToolBarList.Count > 1) {and (aAdvToolBar.Row < Count-1)} then
    begin // go down and insert a NewRow
      if FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded) then
      begin

      end
      else
      begin
        Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
        if (aAdvToolBar.Row + 1) >= Count then
          Add.AddToolBar(aAdvToolBar)
        else
          Insert(aAdvToolBar.Row + 1).AddToolBar(aAdvToolBar);
      end;
      ALeft := aAdvToolBar.Left;

      //showmessage('3: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end
    else if (ALeft > Items[aAdvToolBar.Row].RowRect.Left + 5) and (aAdvToolBar.Row < Count - 1) then
    begin // go down and add in existing row
      for i := aAdvToolBar.Row + 1 to Count - 1 do
      begin
        if {(ATop > Items[i].RowRect.Top) and }(ALeft < Items[i].RowRect.Right) then
        begin
          Allowed := Items[i].IsAllowed(aAdvToolBar);
          if Allowed then
          begin
            MoveToolBarToRow(aAdvToolBar, i);
          end
          else
          begin
            if FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded) then
            begin

            end
            else
            begin
              Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
              if i + 1 >= Count then
                Add.AddToolBar(aAdvToolBar)
              else
                Insert(i + 1).AddToolBar(aAdvToolBar);
            end;
          end;
          break;
        end;
      end;
      {
      Allowed:= Items[aAdvToolBar.Row+1].IsAllowed(aAdvToolBar);
      if Allowed then
      begin
        MoveToolBarToRow(aAdvToolBar, aAdvToolBar.Row+1);
      end; }
      ALeft := aAdvToolBar.Left;

      //showmessage('4: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end
    else
    begin
      ALeft := Items[aAdvToolBar.Row].RowRect.Left; // Set Old Top

      //showmessage('5: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end;

    if AWidth <> aAdvToolBar.Width then
    begin
      OldValue := aAdvToolBar.AllowBoundChange;
      aAdvToolBar.AllowBoundChange := true;
      aAdvToolBar.Width := AWidth;
      aAdvToolBar.AllowBoundChange := OldValue;
      SetRowsPosition;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TRowCollection.SetToolBarTopAndHeight(
  aAdvToolBar: TAdvCustomToolBar; var ATop, AHeight: integer);
var
  Allowed, OldValue: Boolean;
  i: integer;
begin
  if FOwner.Align in [daTop, daBottom] then
  begin
    //aAdvToolBar.AllowBoundChange:= true;

    if (ATop <= Items[aAdvToolBar.Row].RowRect.Top - 3) and (ATop >= Items[aAdvToolBar.Row].RowRect.Top - 5)
      and (Items[aAdvToolBar.Row].ToolBarList.Count > 1) {and (aAdvToolBar.Row > 0)} then
    begin // go up and insert new row
      if FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded) then
      begin

      end
      else
      begin
        Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
        Insert(aAdvToolBar.Row).AddToolBar(aAdvToolBar);
      end;
      ATop := aAdvToolBar.top;

      //showmessage('1: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end
    else if (ATop < Items[aAdvToolBar.Row].RowRect.Top - 6) and (aAdvToolBar.Row > 0) then
    begin // go up and Add in existing row
      for i := 0 to Count - 1 do
      begin
        if (i <> aAdvToolBar.Row) and (ATop >= Items[i].RowRect.Top) and (ATop < Items[i].RowRect.Bottom) then
        begin
          Allowed := Items[i].IsAllowed(aAdvToolBar);
          if Allowed then
          begin
            MoveToolBarToRow(aAdvToolBar, i);
          end
          else
          begin
            if FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded) then
            begin

            end
            else
            begin
              Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
              Insert(i).AddToolBar(aAdvToolBar);
            end;
          end;
          break;
        end;
      end;
     (*
      Allowed:= Items[aAdvToolBar.Row-1].IsAllowed(aAdvToolBar);
      if Allowed then
      begin
       { Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
        Items[aAdvToolBar.Row-1].AddToolBar(aAdvToolBar); }
        MoveToolBarToRow(aAdvToolBar, aAdvToolBar.Row-1);
      end; *)
      ATop := aAdvToolBar.top;

      //showmessage('1: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end
    else if (ATop >= Items[aAdvToolBar.Row].RowRect.Top {+ aAdvToolBar.Height} + 3) and (ATop <= Items[aAdvToolBar.Row].RowRect.Top {+ aAdvToolBar.Height} + 5)
      and (Items[aAdvToolBar.Row].ToolBarList.Count > 1) {and (aAdvToolBar.Row < Count-1)} then
    begin // go down and insert a NewRow

      if FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded) then
      begin

      end
      else
      begin
        Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
        if aAdvToolBar.Row + 1 >= Count then
          Add.AddToolBar(aAdvToolBar)
        else
          Insert(aAdvToolBar.Row + 1).AddToolBar(aAdvToolBar);
      end;
      ATop := aAdvToolBar.top;

      //showmessage('3: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end
    else if (ATop > Items[aAdvToolBar.Row].RowRect.Top {+ aAdvToolBar.Height} + 5) and (aAdvToolBar.Row < Count - 1) then
    begin // go down and add in existing row
      for i := aAdvToolBar.Row + 1 to Count - 1 do
      begin
        if {(ATop > Items[i].RowRect.Top) and }(ATop < Items[i].RowRect.Bottom) then
        begin
          Allowed := Items[i].IsAllowed(aAdvToolBar);
          if Allowed then
          begin
            MoveToolBarToRow(aAdvToolBar, i);
          end
          else
          begin
            if FOwner.LockHeight and not (csDesigning in FOwner.ComponentState) and (FOwner.FPropertiesLoaded) then
            begin

            end
            else
            begin
              Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
              if i + 1 >= Count then
                Add.AddToolBar(aAdvToolBar)
              else
                Insert(i + 1).AddToolBar(aAdvToolBar);
            end;
          end;
          break;
        end;
      end;

     (*
      Allowed:= Items[aAdvToolBar.Row+1].IsAllowed(aAdvToolBar);
      if Allowed then
      begin
       { Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
        Items[aAdvToolBar.Row+1].AddToolBar(aAdvToolBar); }
        MoveToolBarToRow(aAdvToolBar, aAdvToolBar.Row+1);
      end;  *)
      ATop := aAdvToolBar.top;

      //showmessage('4: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end
    else
    begin

      if (csDesigning in aAdvToolBar.ComponentState) and (ATop > Items[aAdvToolBar.Row].RowRect.Top + 5) and (aAdvToolBar.Row = Count - 1) and (Items[aAdvToolBar.Row].ToolBarList.Count > 1) then
      begin
        Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar);
        Add.AddToolBar(aAdvToolBar);
      end;

      ATop := Items[aAdvToolBar.Row].RowRect.Top; // Set Old Top

      //showmessage('5: T:'+inttostr(aAdvToolBar.top)+' L:'+inttostr(aAdvToolBar.Left)+' AT:'+inttostr(ATop)+' AL:'+inttostr(ALeft));
    end;

    //aAdvToolBar.AllowBoundChange:= false;

    if AHeight <> aAdvToolBar.Height then
    begin
      OldValue := aAdvToolBar.AllowBoundChange;
      aAdvToolBar.AllowBoundChange := true;
      aAdvToolBar.Height := AHeight;
      aAdvToolBar.AllowBoundChange := OldValue;
      SetRowsPosition;
    end;
  end
  else
  begin

  end;
end;

//------------------------------------------------------------------------------

procedure TRowCollection.UpdateToolBarVisibility(
  aAdvToolBar: TAdvCustomToolBar);
begin
  if Assigned(aAdvToolBar) then
  begin
    if aAdvToolBar.Visible then
    begin
      if IsToolBarAlreadyAdded(aAdvToolBar) < 0 then
      begin
        with Add do
          AddToolBar(aAdvToolBar);
      end;
    end
    else
    begin
      if (aAdvToolBar.Row >= 0) and (aAdvToolBar.Row < Count) then
        Items[aAdvToolBar.Row].RemoveToolBar(aAdvToolBar, True);
    end;
    {
    if Items[ARowIndex].IsAllowed(aAdvToolBar) then
    begin
      OldIndex := aAdvToolBar.Row;
      Items[OldIndex].RemoveToolBar(aAdvToolBar, false);
      Items[ARowIndex].AddToolBar(aAdvToolBar);
      Self.DeleteMeIfEmpty(Items[OldIndex]);
      //Items[OldIndex].RemoveToolBar(aAdvToolBar);
    end;
    }
  end;

end;

//------------------------------------------------------------------------------

{ TFloatingWindow }

constructor TFloatingWindow.Create(AOwner: TComponent);
begin
  CreateNew(AOwner);
end;

//------------------------------------------------------------------------------

constructor TFloatingWindow.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited;
  FOwner := AOwner;
  FBorderWidth := 2;
  FBorderColor := RGB(109, 109, 109);
end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);

end;

//------------------------------------------------------------------------------

destructor TFloatingWindow.Destroy;
begin
  inherited;
end;

//------------------------------------------------------------------------------

function TFloatingWindow.GetParentWnd: HWnd;
var
  Last, P: HWnd;
begin
  P := GetParent((Owner as TWinControl).Handle);
  Last := P;
  while P <> 0 do
  begin
    Last := P;
    P := GetParent(P);
  end;
  Result := Last;
end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.Loaded;
begin
  inherited;
  FOldCursor := self.Cursor;
end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.CMMouseLeave(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ssLeft in Shift then
  begin
    if (((X >= Width - 5) and (X <= Width)) {or ((X >= 0) and (X <= 5))}) then
    begin
      FResizing := true;
      FResizingClip := rcRight;
      FResizingDir := 0;
      FMouseX := Width;
      FMouseY := Y;
    end
    else if ((Y >= Height - 5) and (Y <= Height)) {or ((Y >= 0) and (Y <= 5))} then
    begin
      FResizing := true;
      FResizingClip := rcBottom;
      FResizingDir := 0;
      FMouseY := Height;
      FMouseX := X;
    end
    else if ((X >= 0) and (X <= 5)) then
    begin
      FResizing := true;
      FResizingClip := rcLeft;
      FResizingDir := 0;
      FMouseX := 0;
      FMouseY := Y;
    end
    else if ((Y >= 0) and (Y <= 5)) then
    begin
      FResizing := true;
      FResizingClip := rcTop;
      FResizingDir := 0;
      FMouseX := X;
      FMouseY := 0;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ax, ay, h, w, OldV: integer;
begin
  inherited;
  if ((X >= Width - 5) and (X <= Width)) or ((X >= 0) and (X <= 5)) then
  begin
    if (Cursor <> crSizeWE) then
      Cursor := crSizeWE;
  end
  else if ((Y >= Height - 5) and (Y <= Height)) or ((Y >= 0) and (Y <= 5)) then
  begin
    if (Cursor <> crSizeNS) then
      Cursor := crSizeNS;
  end
  else
  begin
    if Cursor <> FoldCursor then
      Cursor := FoldCursor;
  end;

  if (ssLeft in Shift) and FResizing then
  begin
    case FResizingClip of
      rcRight:
        begin
          ax := (X - FMouseX);

          if ((ax > 5) {and (ax < 10)} and (FResizingDir in [0])) or ((ax >= 3) and (FResizingDir in [1])) then
          begin
            OldV := AdvCustomToolBar.FloatingRows;
            AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows - 1;
            FMouseX := Width;
            FResizingDir := 1;
            if OldV <> AdvCustomToolBar.FloatingRows then
              Invalidate;
          end
          else
            if ((ax < -5) {and (ax > -10)} and (FResizingDir in [0])) or ((ax <= -3) and (FResizingDir in [2])) then
            begin
              OldV := AdvCustomToolBar.FloatingRows;
              AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows + 1;
              FMouseX := Width;
              FResizingDir := 2;
              if OldV <> AdvCustomToolBar.FloatingRows then
                Invalidate;
          //OutputDebugString(PChar(inttostr(ax)+inttostr(x)));
            end
            else if (FResizingDir = 1) then
            begin
              if AdvCustomToolBar.GetFloatingWindowSizes(AdvCustomToolBar.FloatingRows + 1, h, w) then
              begin
                if X <= (w + BorderWidth * 2) then
                begin
                  AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows + 1;
                  FMouseX := Width;
                  Invalidate;
              //OutputDebugString(PChar(inttostr(ax)+inttostr(x)));
                end;
              end;
            end
            else if (FResizingDir = 2) then
            begin
              if AdvCustomToolBar.GetFloatingWindowSizes(AdvCustomToolBar.FloatingRows - 1, h, w) then
              begin
                if X >= (w + BorderWidth * 2) then
                begin
                  AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows - 1;
                  FMouseX := Width;
                  Invalidate;
              //OutputDebugString(PChar(inttostr(ax)+inttostr(x)));
                end;
              end;
            end;
        end;
      rcBottom:
        begin
          ay := (Y - FMouseY);

          if ((ay > 5) {and (ay < 10)} and (FResizingDir in [0])) or ((ay >= 3) and (FResizingDir in [1])) then
          begin
            OldV := AdvCustomToolBar.FloatingRows;
            AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows + 1;
            FMouseY := Height;
            FResizingDir := 1;
            if OldV <> AdvCustomToolBar.FloatingRows then
              Invalidate;
          //OutputDebugString(PChar(inttostr(ay)+inttostr(y)));
          end
          else
            if ((ay < -5) {and (ay > -10)} and (FResizingDir in [0])) or ((ay <= -3) and (FResizingDir in [2])) then
            begin
              OldV := AdvCustomToolBar.FloatingRows;
              AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows - 1;
              FMouseY := Height;
              FResizingDir := 2;
              if OldV <> AdvCustomToolBar.FloatingRows then
                Invalidate;
          //OutputDebugString(PChar(inttostr(ay)+inttostr(y)));
            end
            else if (FResizingDir = 1) then
            begin
              if AdvCustomToolBar.GetFloatingWindowSizes(AdvCustomToolBar.FloatingRows - 1, h, w) then
              begin
                if (Y <= (h + (BorderWidth + 1) * 2)) then
                begin
                  OldV := AdvCustomToolBar.FloatingRows;
                  AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows - 1;
                  FMouseY := Height;
                  if OldV <> AdvCustomToolBar.FloatingRows then
                    Invalidate;
              //OutputDebugString(PChar(inttostr(ay)+inttostr(y)));
                end;
              end;
            end
            else if (FResizingDir = 2) then
            begin
              if AdvCustomToolBar.GetFloatingWindowSizes(AdvCustomToolBar.FloatingRows + 1, h, w) then
              begin
                if Y >= (H + BorderWidth * 2) then
                begin
                  OldV := AdvCustomToolBar.FloatingRows;
                  AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows + 1;
                  FMouseY := Height;
                  if OldV <> AdvCustomToolBar.FloatingRows then
                    Invalidate;
              //OutputDebugString(PChar(inttostr(ay)+inttostr(y)));
                end;
              end;
            end;
        end;
      rcLeft:
        begin
          ax := (X - FMouseX);

          if ((ax < -5) and (FResizingDir in [0])) or ((ax <= -3) and (FResizingDir in [1])) then
          begin
            w := self.Width;
            OldV := AdvCustomToolBar.FloatingRows;
            AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows - 1;
            Left := Left - (Width - w);
            FMouseX := 0;
            FResizingDir := 1;
            if OldV <> AdvCustomToolBar.FloatingRows then
              Invalidate;
          end
          else
            if ((ax > 5) and (FResizingDir in [0])) or ((ax >= 3) and (FResizingDir in [2])) then
            begin
              w := self.Width;
              OldV := AdvCustomToolBar.FloatingRows;
              AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows + 1;
              Left := Left + w - Width;
              FMouseX := 0;
              FResizingDir := 2;
              if OldV <> AdvCustomToolBar.FloatingRows then
                Invalidate;
          //OutputDebugString(PChar(inttostr(ax)+inttostr(x)));
            end
            else if (FResizingDir = 1) then
            begin
              if AdvCustomToolBar.GetFloatingWindowSizes(AdvCustomToolBar.FloatingRows + 1, h, w) then
              begin
                if X >= (Width - (w + BorderWidth * 2)) then
                begin
                  w := self.Width;
                  AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows + 1;
                  Left := Left + w - Width;
                  FMouseX := 0;
                  Invalidate;
              //OutputDebugString(PChar(inttostr(ax)+inttostr(x)));
                end;
              end;
            end
            else if (FResizingDir = 2) then
            begin
              if AdvCustomToolBar.GetFloatingWindowSizes(AdvCustomToolBar.FloatingRows - 1, h, w) then
              begin
                if X <= (Width - (w + BorderWidth * 2)) then
                begin
                  w := self.Width;
                  AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows - 1;
                  Left := Left - (Width - w);
                  FMouseX := 0;
                  Invalidate;
              //OutputDebugString(PChar(inttostr(ax)+inttostr(x)));
                end;
              end;
            end;
        end;
      rcTop:
        begin
          ay := (Y - FMouseY);

          if ((ay < -5) and (FResizingDir in [0])) or ((ay <= -3) and (FResizingDir in [1])) then
          begin
            h := self.Height;
            OldV := AdvCustomToolBar.FloatingRows;
            AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows + 1;
            Top := Top - (Height - h);
            FMouseY := 0;
            FResizingDir := 1;
            if OldV <> AdvCustomToolBar.FloatingRows then
              Invalidate;
          //OutputDebugString(PChar(inttostr(ay)+inttostr(y)));
          end
          else
            if ((ay > 5) and (FResizingDir in [0])) or ((ay >= 3) and (FResizingDir in [2])) then
            begin
              h := self.Height;
              OldV := AdvCustomToolBar.FloatingRows;
              AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows - 1;
              Top := Top + h - Height;
              FMouseY := 0;
              FResizingDir := 2;
              if OldV <> AdvCustomToolBar.FloatingRows then
                Invalidate;
          //OutputDebugString(PChar(inttostr(ay)+inttostr(y)));
            end
            else if (FResizingDir = 1) then
            begin
              if AdvCustomToolBar.GetFloatingWindowSizes(AdvCustomToolBar.FloatingRows - 1, h, w) then
              begin
                if (Y >= (Height - (h + (BorderWidth + 1) * 2))) then
                begin
                  h := self.Height;
                  OldV := AdvCustomToolBar.FloatingRows;
                  AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows - 1;
                  Top := Top + h - Height;
                  FMouseY := 0;
                  if OldV <> AdvCustomToolBar.FloatingRows then
                    Invalidate;
              //OutputDebugString(PChar(inttostr(ay)+inttostr(y)));
                end;
              end;
            end
            else if (FResizingDir = 2) then
            begin
              if AdvCustomToolBar.GetFloatingWindowSizes(AdvCustomToolBar.FloatingRows + 1, h, w) then
              begin
                if Y <= (Height - (h + BorderWidth * 2)) then
                begin
                  h := self.Height;
                  OldV := AdvCustomToolBar.FloatingRows;
                  AdvCustomToolBar.FloatingRows := AdvCustomToolBar.FloatingRows + 1;
                  Top := Top - (Height - h);
                  FMouseY := 0;
                  if OldV <> AdvCustomToolBar.FloatingRows then
                    Invalidate;
              //OutputDebugString(PChar(inttostr(ay)+inttostr(y)));
                end;
              end;
            end;
        end;

    end;

    {
    ax:= (X - FMouseX);

    if (FResizingDir = 1) and (ax >= 0) then
      FResizingDir:= 0
    else if (FResizingDir = 2) and (ax <= 0) then
      FResizingDir:= 0;

    if (ax > 5) and (ax < 10) and (FResizingDir in [0, 1]) then
    begin
      AdvCustomToolBar.FloatingRows:= AdvCustomToolBar.FloatingRows - 1;
      FMouseX:= Width - 2;
      FResizingDir:= 1;
      Invalidate;
    end
    else
    if (ax < -5) and (ax > -10) and (FResizingDir in [0, 2]) then
    begin
      AdvCustomToolBar.FloatingRows:= AdvCustomToolBar.FloatingRows + 1;
      FMouseX:= Width - 2;
      FResizingDir:= 2;
      Invalidate;
    end;
    }
    //OutputDebugString(PChar('ax: '+inttostr(ax)));
    {
    if (P.X > Left + Width + 5) and (P.X < Left + Width +10) then
      AdvCustomToolBar.FloatingRows:= AdvCustomToolBar.FloatingRows - 1
    else if (P.X < Left + Width -5) and (P.X > Left + Width -10) then
      AdvCustomToolBar.FloatingRows:= AdvCustomToolBar.FloatingRows + 1;
    }
  end;

end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if FResizing then
  begin
    FResizing := false;
    FResizingDir := 0;
    FMouseX := 0;
    FMouseY := 0;
  end;

end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.Paint;
begin
  inherited;
  with Canvas do
  begin
    if BorderColor <> clNone then
    begin
      Pen.Color := BorderColor;
      Pen.Width := BorderWidth;

      Rectangle(1, 1, Width, Height);

      Pixels[BorderWidth, BorderWidth] := BorderColor;
      Pixels[Width - BorderWidth - 1, BorderWidth] := BorderColor;
      Pixels[BorderWidth, Height - BorderWidth - 1] := BorderColor;
      Pixels[Width - BorderWidth - 1, Height - BorderWidth - 1] := BorderColor;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
end;

procedure TFloatingWindow.SetBorderWidth(const Value: integer);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    SetWindowSize;
  end;
end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.SetWindowSize;
begin
  if Assigned(FAdvCustomToolBar) then
  begin
    Height := FAdvCustomToolBar.Height + (BorderWidth + 1) * 2; // .GetVisibleHeight;
    Width := FAdvCustomToolBar.Width + (BorderWidth + 1) * 2;
    FAdvCustomToolBar.Left := BorderWidth + 1;
    FAdvCustomToolBar.Top := BorderWidth + 1;
    Self.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.WMActivate(var Message: TWMActivate);
begin
  inherited;

  if Message.Active = integer(False) then
  begin
  end
  else if Assigned(FAdvCustomToolBar) then
  begin
    //FAdvCustomToolBar.SetFocus;
    //SendMessage(getParentWnd, WM_NCACTIVATE, 1, 0);
  end;
end;

//------------------------------------------------------------------------------

procedure TFloatingWindow.WMNCHitTest(var Message: TWMNCHitTest);
var
  pt: TPoint;
begin
  inherited;
  Exit;

  // Make the hint sizable
  pt := ScreenToClient(Point(Message.XPos, Message.YPos));

  if (pt.X > Width - 10) and (pt.Y > Height - 10) then
    message.Result := HTBOTTOMRIGHT
end;

//------------------------------------------------------------------------------

{ TButtonAppearance }

procedure TButtonAppearance.Assign(Source: TPersistent);
begin
  if Source is TButtonAppearance then
  begin
    FColor := TButtonAppearance(Source).Color;
    FColorTo := TButtonAppearance(Source).ColorTo;
    FColorHot := TButtonAppearance(Source).ColorHot;
    FColorHotTo := TButtonAppearance(Source).ColorHotTo;
    FColorDown := TButtonAppearance(Source).ColorDown;
    FColorDownTo := TButtonAppearance(Source).ColorDownTo;
    FColorChecked := TButtonAppearance(Source).FColorChecked;
    FColorCheckedTo := TButtonAppearance(Source).FColorCheckedTo;
    FCaptionTextColor := TButtonAppearance(Source).FCaptionTextColor;
    FCaptionTextColorHot := TButtonAppearance(Source).FCaptionTextColorHot;
    FCaptionTextColorDown := TButtonAppearance(Source).FCaptionTextColorDown;
    FCaptionTextColorChecked := TButtonAppearance(Source).FCaptionTextColorChecked;
    FGradientDirection := TButtonAppearance(Source).GradientDirection;
    FBorderColor := TButtonAppearance(Source).BorderColor;
    FBorderHotColor := TButtonAppearance(Source).BorderHotColor;
    FBorderDownColor := TButtonAppearance(Source).BorderDownColor;
    FBorderCheckedColor := TButtonAppearance(Source).FBorderCheckedColor;
    inherited Assign(Source);
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(self);
end;

//------------------------------------------------------------------------------

constructor TButtonAppearance.Create;
begin
  inherited;

  FColor := clNone;
  FColorTo := clNone;
  FColorHot := $00D2BDB6;
  FColorHotTo := clNone;
  FColorDown := $00B59285;
  FColorDownTo := clNone;
  FGradientDirection := gdHorizontal;

  FBorderColor := clNone;
  FBorderDownColor := RGB(10, 36, 106);
  FBorderHotColor := RGB(10, 36, 106);
  FBorderCheckedColor := RGB(10, 36, 106);
  
  FColorChecked := $00D8D5D4;
  FColorCheckedTo := clNone;
  FCaptionTextColor := clBlack;
  FCaptionTextColorHot := clBlack;
  FCaptionTextColorDown := clBlack;
  FCaptionTextColorChecked := clBlack;
  FCaptionFont := TFont.Create;
  FGlyphPosition := gpLeft;
  FGradientDirection := gdVertical;
  FGradientDirectionChecked := gdVertical;
  FGradientDirectionDown := gdVertical;
  FGradientDirectionHot := gdVertical;
end;

//------------------------------------------------------------------------------

destructor TButtonAppearance.destroy;
begin
  FCaptionFont.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetBorderCheckedColor(const Value: TColor);
begin
  if FBorderCheckedColor <> Value then
  begin
    FBorderCheckedColor := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetCaptionFont(const Value: TFont);
begin
  FCaptionFont.Assign(Value);
  Change;
end;

procedure TButtonAppearance.SetCaptionTextColor(const Value: TColor);
begin
  if FCaptionTextColor <> Value then
  begin
    FCaptionTextColor := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetCaptionTextColorDown(const Value: TColor);
begin
  if FCaptionTextColorDown <> Value then
  begin
    FCaptionTextColorDown := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetCaptionTextColorHot(const Value: TColor);
begin
  if FCaptionTextColorHot <> Value then
  begin
    FCaptionTextColorHot := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetCaptionTextColorChecked(
  const Value: TColor);
begin
  if FCaptionTextColorChecked <> Value then
  begin
    FCaptionTextColorChecked := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetColorDown(const Value: TColor);
begin
  if FColorDown <> Value then
  begin
    FColorDown := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetColorDownTo(const Value: TColor);
begin
  if FColorDownTo <> Value then
  begin
    FColorDownTo := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetColorHot(const Value: TColor);
begin
  if FColorHot <> Value then
  begin
    FColorHot := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetColorHotTo(const Value: TColor);
begin
  if FColorHotTo <> Value then
  begin
    FColorHotTo := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetColorChecked(const Value: TColor);
begin
  if FColorChecked <> Value then
  begin
    FColorChecked := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetColorCheckedTo(const Value: TColor);
begin
  if FColorCheckedTo <> Value then
  begin
    FColorCheckedTo := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetGradientDirection(
  const Value: TGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetGlyphPosition(const Value: TGlyphPosition);
begin
  if FGlyphPosition <> Value then
  begin
    FGlyphPosition := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TButtonAppearance.SetGradientDirectionChecked(
  const Value: TGradientDirection);
begin
  FGradientDirectionChecked := Value;
end;

procedure TButtonAppearance.SetGradientDirectionDown(
  const Value: TGradientDirection);
begin
  FGradientDirectionDown := Value;
end;

procedure TButtonAppearance.SetGradientDirectionHot(
  const Value: TGradientDirection);
begin
  FGradientDirectionHot := Value;
end;

//------------------------------------------------------------------------------

{ TAdvCustomToolBarButton }

constructor TAdvCustomToolBarButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GlyphChanged;
  FGlyphHot := TBitmap.Create;
  //FGlyphHot.OnChange := GlyphChanged;
  FGlyphDown := TBitmap.Create;
  //FGlyphDown.OnChange := GlyphChanged;
  FGlyphDisabled := TBitmap.Create;
  //FGlyphDisabled.OnChange := GlyphChanged;
  FGlyphChecked := TBitMap.Create;
  //FGlyphChecked.OnChange := GlyphChanged;
  FGlyphShade := TBitmap.Create;

  FDrawPosition := TAdvToolBarButtonDrawPosition.Create;
  FDrawPosition.OnChange := PositionChanged;

  SetBounds(0, 0, 23, 22);
  ControlStyle := [csCaptureMouse, csDoubleClicks];
  ParentFont := True;

  FAppearance:= TButtonAppearance.create;
  FAppearance.OnChange:= OnAppearanceChange;
  
  FGlyphPosition := gpLeft;
  AutoSize := True;

  // make sure to use a Truetype font
  Font.Name := 'Tahoma';

  FSpacing := 4;
  //FMargin := -1;
  FOffSet := 4;
  Flat := True;
  FTransparent := True;
  FShaded := True;

  FDropDownButton := false;
  FStyle := tasButton;
  FGroupIndex := 0;
  FGrouped := true;
  FPosition := daTop;
  FMenuItem := nil;

  //AutoSize := false;
  FImageIndex := -1;

  FPicture := TPicture.Create;
  FPicture.OnChange := GlyphChanged;

  FPictureDisabled := TPicture.Create;
  FPictureDisabled.OnChange := GlyphChanged;

  FParentStyler := true;

  FDropDownSectWidth := 12;

  FInternalTag := 0;

  FUnHotTimer := TTimer.Create(self);
  FUnHotTimer.Interval := 1;
  FUnHotTimer.Enabled := false;
  FUnHotTimer.OnTimer := UnHotTimerOnTime;
end;

//------------------------------------------------------------------------------

destructor TAdvCustomToolBarButton.Destroy;
begin
  FGlyph.Free;
  FGlyphHot.Free;
  FGlyphDown.Free;
  FGlyphDisabled.Free;
  FGlyphChecked.Free;
  FGlyphShade.Free;
  FDrawPosition.Free;
  FAppearance.Free;
  FPicture.Free;
  FPictureDisabled.Free;
  FUnHotTimer.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.Click;
begin
  if Assigned(AdvToolBar) then
    AdvToolBar.HideOptionWindow;
  inherited;
  if Assigned(AdvToolBar) then
    AdvToolBar.UpControlInRUL(self);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.CMDialogChar(var Message: TCMDialogChar);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.CMFontChanged(var Message: TMessage);
begin
  inherited;
  // TODO : here
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if (csDesigning in ComponentState) then
    Exit;

  FMouseInControl := true;
  //FHot := true;
  if Enabled then
  begin
    if Assigned(FAdvToolBar) then
    begin
      //if FAdvToolBar.FInMenuLoop and FAdvToolBar.FMenuFocused then
        Hot := True;
    end;
    InvalidateMe;
  end;
  FUnHotTimer.Enabled := True;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;

  if (csDesigning in ComponentState) then
    exit;

  FUnHotTimer.Enabled := False;
  FMouseInControl := false;
  FHot := false;

  if Assigned(FAdvToolBar) then
    if not (FAdvToolBar.FInMenuLoop and FAdvToolBar.FMenuFocused) then
      Hot := False;

  if Enabled then
    InvalidateMe;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.CMSysColorChange(var Message: TMessage);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.CMTextChanged(var Message: TMessage);
begin
  inherited;
  AdjustSize;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.GlyphChanged(Sender: TObject);
begin
  AdjustSize;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.Loaded;
begin
  inherited;

  if (Down <> FInitialDown) then
    Down := FInitialDown;

  if FShaded then
    GenerateShade;
  AdjustSize;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pt:TPoint;
begin
  inherited;
  
  if (Button <> mbLeft) or not Enabled or (csDesigning in ComponentState) then
    Exit;

  FMouseDownInControl := true;

  if IsMenuButton then
  begin
    InvalidateMe;
    // FF: (Comented) mouse disable after menu show
   { if not (csDesigning in ComponentState) and ((DropdownMenu <> nil) and
       DropdownMenu.AutoPopup or (MenuItem <> nil)) and (FAdvToolBar <> nil) and not(FAdvToolBar.FInMenuLoop) then
      FAdvToolBar.TrackMenu(self)
    else }
      DoDropDown;
  end
  else
  begin
    if Style in [tasButton, tasCheck] then
    begin
      if FDropDownButton and ( ((Self.Position in [daTop, daBottom]) and (X > (Width - FDropDownSectWidth))) or ((Self.Position in [daLeft, daRight]) and (Y > (Height - FDropDownSectWidth))) ) then
      begin
        FState := absUp;
        FMouseInControl := False;
        FMouseDownInControl := False;

        PopupBtnDown;

        if Assigned(FDropDownMenu) then
        begin
          FDown := false;
          FHot := false;
          FMenuSel := true;
          Repaint;
          pt := Point(Left, Top + Height);
          pt := Parent.ClientToScreen(pt);
          if Assigned(AdvToolBar) then
            FDropDownMenu.MenuStyler := AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler;
          FDropDownMenu.Popup(pt.X,pt.Y);
          FMenuSel := false;
          Repaint;
        end;

        InvalidateMe;

        Exit;
      end
      else
      begin
        ButtonDown;

        if not FDown then
        begin
          FState := absDown;
          Invalidate;
        end;

        if Style = tasCheck then
        begin
          FState := absDown;
          Repaint;
        end;

        FDragging := True;
      end;
    end
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.MouseMove(Shift: TShiftState; X,
  Y: Integer);
var
  NewState: TAdvButtonState;
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  if FDragging then
  begin
    if (not FDown) then NewState := absUp
    else NewState := absExclusive;

    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
      if FDown then NewState := absExclusive else NewState := absDown;

    if (Style = tasCheck) and FDown then
    begin
      NewState := absDown;
    end;

    if NewState <> FState then
    begin
      FState := NewState;
      Invalidate;
    end;
  end
  else if not FMouseInControl then
    UpdateTracking;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  DoClick: Boolean;
begin
  inherited;

  if (csDesigning in ComponentState) then
    exit;

  FMouseDownInControl := false;
  InvalidateMe;

  if IsMenuButton then
  begin
    //InvalidateMe;
    //DoDropDown;
  end
  else
  begin
  {  if Style in [tasButton , tasCheck] then
    begin
      if FDropDownButton and (X > (Width - FDropDownSectWidth)) then
      begin
        //PopupBtnDown;
      end
      else
        Click;
    end;  }

    if FDragging then
    begin
      FDragging := False;
      DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
      if FGroupIndex = 0 then
      begin
        // Redraw face in-case mouse is captured
        FState := absUp;
        FMouseInControl := False;
        FHot := false;
        
        if Style = tasCheck then
        begin
          SetDown(not FDown);
          FState := absUp;
        end;

        if DoClick and not (FState in [absExclusive, absDown]) then
          Invalidate;
      end
      else
        if DoClick then
        begin
          SetDown(not FDown);
          if FDown then Repaint;
        end
        else
        begin
          if FDown then
            FState := absExclusive;
          Repaint;
        end;
      if DoClick then Click;
      UpdateTracking;
    end;

  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;

  if not (csDestroying in ComponentState) and (AOperation = opRemove) then
  begin
    if AComponent = DropdownMenu then
      DropdownMenu := nil
    else if AComponent = MenuItem then
      MenuItem := nil;

    if Assigned(FAdvToolBar) and (AComponent = FAdvToolBar.Images) then
      ImageIndex := -1;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.WMLButtonDblClk(var Message: TWMLButtonDown);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.WndProc(var Message: TMessage);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.Paint;
begin
  if not Enabled then
  begin
    FState := absDisabled;
    FDragging := False;
  end
  else
  begin
    if (FState = absDisabled) then
      if FDown and (GroupIndex <> 0) then
        FState := absExclusive
      else
        FState := absUp;
  end;

  if (Style = tasCheck) and (Down) then
  begin
    FState := absDown;
  end;

  inherited;

  DrawButton(Canvas);
end;

//------------------------------------------------------------------------------

// Draw BackGround and border

procedure TAdvCustomToolBarButton.DrawButton(ACanvas: TCanvas);
var
  Clr, ClrTo, BrClr, TxtClr, DwClr, DwClrTo: TColor;
  R, {TextR,} BtnR, DwR: TRect;
  aGlyph: TBitmap;
  GDHoriztl: Boolean;
  AP: TPoint;

  procedure DrawArrow(ArP: TPoint; ArClr: TColor);
  begin
    if Position in [daTop, daBottom] then
    begin
      Canvas.Pen.Color := ArClr;
      Canvas.MoveTo(ArP.X, ArP.Y);
      Canvas.LineTo(ArP.X + 5, ArP.Y);
      Canvas.MoveTo(ArP.X + 1, ArP.Y + 1);
      Canvas.LineTo(ArP.X + 4, ArP.Y + 1);
      Canvas.Pixels[ArP.X + 2, ArP.Y + 2] := ArClr;
    end
    else
    begin
      Canvas.Pen.Color := ArClr;
      Canvas.MoveTo(ArP.X, ArP.Y);
      Canvas.LineTo(ArP.X, ArP.Y + 5);
      Canvas.MoveTo(ArP.X - 1, ArP.Y + 1);
      Canvas.LineTo(ArP.X - 1, ArP.Y + 4);
      Canvas.Pixels[ArP.X - 2, ArP.Y + 2] := ArClr;
    end;
  end;

begin
  R := ClientRect;
  BtnR := R;
  if Position in [daTop, daBottom] then
    DwR := Rect(BtnR.Right - FDropDownSectWidth, BtnR.Top, BtnR.Right, BtnR.Bottom)
  else
    DwR := Rect(BtnR.Left, BtnR.Bottom - FDropDownSectWidth, BtnR.Right, BtnR.Bottom);

  if FDropDownButton and (Style <> tasCheck) then
  begin
    if Position in [daTop, daBottom] then
      BtnR.Right := DwR.Left
    else
      BtnR.Bottom := DwR.Top;
  end;

  aGlyph := nil;
  Clr := clNone;
  ClrTo := clNone;
  BrClr := clNone;
  TxtClr := clNone;
  GDHoriztl := true;
  DwClr := clNone;
  DwClrTo := clNone;

  if Style in [tasButton, tasCheck] then
  begin
    with ACanvas, FAppearance do
    begin
      if (State = absDisabled) or not Enabled then
      begin
        if Transparent then
        begin
          Clr := clNone;
          ClrTo := clNone;
          BrClr := clNone;
        end
        else
        begin
          Clr := Color;
          ClrTo := ColorTo;
          BrClr := BorderColor;
        end;

        DwClr := Clr;
        DwClrTo := ClrTo;
        TxtClr := CaptionTextColor;
        GDHoriztl := GradientDirection = gdHorizontal;
        aGlyph := GlyphDisabled;
      end
      else if State = absDropDown then
      begin

      end
      else if ((State = absDown) or ((FHot or FPropHot) and (State = absExclusive)) or (FMouseDownInControl)) and not((Style = tasCheck) and (State = absDown)) then
      begin
        if ParentStyler and Assigned(AdvToolBar) then
        begin
          with AdvToolBar.FCurrentToolBarStyler.ButtonAppearance do
          begin
            Clr := ColorDown;
            ClrTo := ColorDownTo;
            TxtClr := CaptionTextColorDown;
            BrClr := BorderDownColor;
            DwClr := ColorHot;
            DwClrTo := ColorHotTo;
            GDHoriztl := GradientDirectionDown = gdHorizontal;
            aGlyph := GlyphDown;
          end;
        end
        else
        begin
          Clr := ColorDown;
          ClrTo := ColorDownTo;
          TxtClr := CaptionTextColorDown;
          BrClr := BorderDownColor;
          DwClr := ColorHot;
          DwClrTo := ColorHotTo;
          GDHoriztl := GradientDirectionDown = gdHorizontal;
          aGlyph := GlyphDown;
        end;

      end
      else if (State = absExclusive) or ((Style = tasCheck) and (State = absDown)) then
      begin
        if ParentStyler and Assigned(AdvToolBar) then
        begin
          with AdvToolBar.FCurrentToolBarStyler.ButtonAppearance do
          begin
            Clr := ColorChecked;
            ClrTo := ColorCheckedTo;
            TxtClr := CaptionTextColorChecked;
            BrClr := BorderCheckedColor;
            DwClr := Clr;
            DwClrTo := ClrTo;
            GDHoriztl := GradientDirectionChecked = gdHorizontal;
            aGlyph := GlyphChecked;
          end;
        end
        else
        begin
          Clr := ColorChecked;
          ClrTo := ColorCheckedTo;
          TxtClr := CaptionTextColorChecked;
          BrClr := BorderCheckedColor;
          DwClr := Clr;
          DwClrTo := ClrTo;
          GDHoriztl := GradientDirectionChecked = gdHorizontal;
          aGlyph := GlyphChecked;
        end;
      end
      else // if State = absUp then
      begin
        if (FHot or FPropHot) then
        begin
          if ParentStyler and Assigned(AdvToolBar) then
          begin
            with AdvToolBar.FCurrentToolBarStyler.ButtonAppearance do
            begin
              Clr := ColorHot;
              ClrTo := ColorHotTo;
              TxtClr := CaptionTextColorHot;
              BrClr := BorderHotColor;
              GDHoriztl := GradientDirectionHot = gdHorizontal;
              aGlyph := GlyphHot;
            end;
          end
          else
          begin
            Clr := ColorHot;
            ClrTo := ColorHotTo;
            TxtClr := CaptionTextColorHot;
            BrClr := BorderHotColor;
            GDHoriztl := GradientDirectionHot = gdHorizontal;
            aGlyph := GlyphHot;
          end;

          DwClr := Clr;
          DwClrTo := ClrTo;
        end
        else // Normal Draw
        begin
          if self.Transparent then
          begin
            Clr := clNone;
            ClrTo := clNone;
            BrClr := clNone;
          end
          else
          begin
            Clr := Color;
            ClrTo := ColorTo;
            BrClr := BorderColor;
          end;
          TxtClr := CaptionTextColor;
          DwClr := Clr;
          DwClrTo := ClrTo;
          GDHoriztl := GradientDirection = gdHorizontal;
          aGlyph := Glyph;
        end;
      end;

      // BackGround
      if (Clr <> clNone) and (ClrTo <> clNone) then
      begin
        if FDropDownButton and (Style <> tasCheck) then
          DrawGradient(aCanvas, DwClr, DwClrTo, 40, R, GDHoriztl);

        DrawGradient(aCanvas, Clr, ClrTo, 40, BtnR, GDHoriztl);
      end
      else if (Clr <> clNone) then
      begin
        if FDropDownButton and (Style <> tasCheck) then
        begin
          Brush.Color := DwClr;
          Pen.Color := DwClr;
          Rectangle(R)
        end;
        Brush.Color := Clr;
        Pen.Color := Clr;
        Rectangle(BtnR);
      end;

      // Border
      if BrClr <> clNone then
      begin
        Brush.Style := bsClear;
        Pen.Color := BrClr;
        if FDropDownButton and (Style <> tasCheck) then
          Rectangle(R);
        Rectangle(BtnR);
      end;

      if FMenuSel then
      begin
        if ParentStyler and Assigned(AdvToolBar) then
        begin
          if Assigned(AdvToolBar.FCurrentToolBarStyler) then
            if Assigned(AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler) then
              Pen.Color := AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler.MenuBorderColor
        end;

        Pen.Color := clNavy;
        if Position in [daTop, daBottom] then
        begin
          MoveTo(BtnR.Left, DwR.Bottom);
          LineTo(BtnR.Left, DwR.Top);
          LineTo(DwR.Right - 1, DwR.Top);
          LineTo(DwR.Right - 1, DwR.Bottom);
        end
        else
        begin
          MoveTo(BtnR.Left, DwR.Bottom);
          LineTo(BtnR.Left, BtnR.Top);
          LineTo(DwR.Right - 1, BtnR.Top);
          LineTo(DwR.Right - 1, DwR.Bottom);
        end;
      end;

      if FDropDownButton and (Style <> tasCheck) then
      begin
        if Position in [daTop, daBottom] then
        begin
          AP.X := DwR.Left + ((DwR.Right - DwR.Left - 5) div 2);
          AP.Y := DwR.Top + ((DwR.Bottom - DwR.Top - 3) div 2) + 1;
        end
        else
        begin
          AP.X := DwR.Left + ((DwR.Right - DwR.Left - 3) div 2) + 1;
          AP.Y := DwR.Top + ((DwR.Bottom - DwR.Top - 5) div 2);
        end;
        DrawArrow(AP, clBlack);
      end;

      if Assigned(aGlyph) and (aGlyph.Empty) and not Glyph.Empty then
        aGlyph := Glyph;

      DrawGlyphAndCaption(ACanvas, BtnR, TxtClr, aGlyph);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.DrawGlyphAndCaption(ACanvas: TCanvas; R: TRect; TxtClr: TColor; aGlyph: TBitMap);
var
  GP, CP: TPoint;
  Tw, Th: integer;
  TextR, R2: TRect;
  uFormat: Cardinal;
  aWidth, aHeight: integer;
  sp: integer;
  tf: TFont;
  lf: TLogFont;
  imgidx: Integer;
  images: TCustomImageList;

begin
  TextR := R;
  ACanvas.Font.Assign(Font);

  Tw := 0;
  Th := Height;

  if ShowCaption then
  begin
    if ParentStyler and Assigned(AdvToolBar) and Assigned(AdvToolBar.FCurrentToolBarStyler) then
    begin
      if IsMenuButton then
        ACanvas.Font.Assign(AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.font)
      else
        ACanvas.Font.Assign(AdvToolBar.FCurrentToolBarStyler.ButtonAppearance.CaptionFont);
    end
    else
      ACanvas.Font.Assign(Font);

    R2 := Rect(0,0,1000,100);
    DrawText(ACanvas.Handle,PChar(Caption),Length(Caption), R2, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
    Tw := R2.Right;//ACanvas.TextWidth(Caption);
    Th := R2.Bottom;//ACanvas.TextHeight(Caption);
  end;

  uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
  aWidth := R.Right - R.Left;
  aHeight := R.Bottom - R.Top;

  if Position in [daTop, daBottom] then
    CP := Point(TextR.Left, TextR.Top)
  else
    CP := Point(TextR.Right+1 - (((TextR.Right - TextR.Left) - Th) div 2), TextR.Top + ((TextR.Bottom - TextR.Top) - Tw) div 2);

  if (Tw <= 0) or (Th <= 0) then
    sp := 0
  else
    sp := Spacing;

  images := nil;
  if Assigned(AdvToolBar) then
    images := AdvToolBar.Images;

  imgidx := ImageIndex;

  if (Action is TCustomAction) then
  begin
    if Assigned((Action as TCustomAction).ActionList) then
    begin
      if Assigned((Action as TCustomAction).ActionList.Images) then
        images := (Action as TCustomAction).ActionList.Images;

      imgidx := (Action as TCustomAction).ImageIndex;
    end;
  end;

  if Assigned(AdvToolBar) and not Enabled and Assigned(AdvToolBar.DisabledImages) and (images <> nil) then
    images := AdvToolBar.DisabledImages;

  if (imgidx >= 0) and (images <> nil) then
  begin
    if Position in [daTop, daBottom] then
    begin
      case GlyphPosition of
        gpLeft:
          begin
            GP.X := (aWidth - (Images.Width + Sp + Tw)) div 2;
            GP.Y := (Height - Images.Height) div 2;

            TextR := Rect(GP.X + Images.Width + Sp, R.Top, R.Right, R.Bottom);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_LEFT;
          end;
        gpRight:
          begin
            GP.X := aWidth - ((aWidth - (Images.Width + Sp + Tw)) div 2) - Images.Width;
            GP.Y := (Height - Images.Height) div 2;

            TextR := Rect(((aWidth - (Images.Width + Sp + Tw)) div 2), R.Top, GP.X, R.Bottom);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_RIGHT;
          end;
        gpTop:
          begin
            GP.X := (aWidth - (Images.Width)) div 2;
            GP.Y := (Height - (Images.Height + Sp + Th)) div 2;

            TextR := Rect(R.Left, GP.Y + Images.Height + Sp, R.Right, R.Bottom);
            uFormat := DT_SINGLELINE or DT_TOP or DT_CENTER;
          end;
        gpBottom:
          begin
            GP.X := (aWidth - Images.Width) div 2;
            GP.Y := Height - ((Height - (Images.Height + Sp + Th)) div 2) - Images.Height;

            TextR := Rect(R.Left, GP.Y - Sp - Th, R.Right, GP.Y);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
          end;
      end;
    end
    else // if Position in [daLeft, daRight] then
    begin
      case GlyphPosition of
        gpLeft:
          begin
            GP.X := (aWidth - (Images.Width)) div 2;
            GP.Y := (aHeight - (Images.Height + Sp + Tw)) div 2;

          //TextR := Rect(R.Left , GP.Y + AdvToolBar.Images.Height + Sp, R.Right, R.Bottom);
            TextR := Rect(R.Right - ((aWidth - th) div 2), GP.Y + Images.Height + Sp, R.Right, R.Bottom);
            CP := Point(TextR.Left, TextR.Top);
            uFormat := DT_SINGLELINE or DT_CENTER or DT_TOP;
          end;
        gpRight:
          begin
            GP.X := (aWidth - (Images.Width)) div 2;
            GP.Y := aHeight - ((aHeight - (Images.Height + Sp + Tw)) div 2) - Images.Height;

          //TextR := Rect(R.Left , R.Top, R.Right, GP.Y - Sp);
            TextR := Rect(R.Right - ((aWidth - th) div 2), R.Top + ((aHeight - (Images.Height + Sp + Tw)) div 2), R.Right, GP.Y - Sp);
            CP := Point(TextR.Left, TextR.Top);
            uFormat := DT_SINGLELINE or DT_CENTER or DT_BOTTOM;
          end;
        gpTop:
          begin
            GP.X := aWidth - ((aWidth - (Images.Width + Sp + Th)) div 2) - Images.Width;
            GP.Y := (aHeight - Images.Height) div 2;

          //TextR := Rect(R.Left , R.Top, GP.X - sp, R.Bottom);
            TextR := Rect(R.Left, R.Top + (aHeight - Tw) div 2, GP.X - sp, R.Bottom);
            TextR.Left := TextR.Right - (TextR.Right - TextR.Left - Th) div 2;
            CP := Point(TextR.Left, TextR.Top);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
          end;
        gpBottom:
          begin
            GP.X := (aWidth - (Images.Width + Sp + Th)) div 2;
            GP.Y := (aHeight - Images.Height) div 2;

          //TextR := Rect(GP.X + sp, R.Top, R.Right, R.Bottom);
            TextR := Rect(GP.X + sp + Images.Width, R.Top, R.Right, R.Bottom);
            TextR.Left := TextR.Right - (TextR.Right - TextR.Left - Th) div 2;
            CP := Point(TextR.Left, TextR.Top + (TextR.Bottom - TextR.Top - Tw) div 2);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
          end;
      end;
    end;

    if not AutoSize then
    begin
      if Position in [daTop, daBottom] then
      begin
        if GP.X < 0 then
        begin
          TextR.Left := TextR.Left + Abs(GP.X)+1;
          GP.X := GP.X + Abs(GP.X)+1;
          uFormat := uFormat or DT_END_ELLIPSIS;
        end;
      end
      else  // daLeft, daRight
      begin
        if GP.Y < 0 then
        begin
          TextR.Top := TextR.Top + Abs(GP.Y)+1;
          Cp.Y := Cp.Y + Abs(GP.Y)+1;
          GP.Y := GP.Y + Abs(GP.Y)+1;
          uFormat := uFormat or DT_END_ELLIPSIS;
        end;
      end;
    end;

    if DrawPosition.Enabled then
    begin
      GP.X := DrawPosition.ImageX;
      GP.Y := DrawPosition.ImageY;      
    end;
    
    if FMouseInControl and (FHot or FPropHot) and Shaded and Enabled and (FState = absUp)
      and not FMouseDownInControl and not FGlyphShade.Empty then
    begin
      if FShadedForGlyph then
        GenerateShade;
      FGlyphShade.TransparentMode := tmAuto;
      FGlyphShade.Transparent := True;
      ACanvas.Draw(GP.X + 2, GP.Y + 2, FGlyphShade);
    end;

    if not Enabled and Assigned(AdvToolBar) and Assigned(AdvToolBar.DisabledImages) then
      Images.Draw(ACanvas, GP.X, GP.Y, imgidx, True)
    else
      Images.Draw(ACanvas, GP.X, GP.Y, imgidx, Enabled);
  end
  else if (aGlyph <> nil) and not (aGlyph.Empty) then
  begin
    if Position in [daTop, daBottom] then
    begin
      case GlyphPosition of
        gpLeft:
          begin
            GP.X := (aWidth - (aGlyph.Width + Sp + Tw)) div 2;
            GP.Y := (Height - aGlyph.Height) div 2;

            TextR := Rect(GP.X + aGlyph.Width + Sp, R.Top, R.Right, R.Bottom);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_LEFT;
          end;
        gpRight:
          begin
            GP.X := aWidth - ((aWidth - (aGlyph.Width + Sp + Tw)) div 2) - aGlyph.Width;
            GP.Y := (Height - aGlyph.Height) div 2;

            TextR := Rect(((aWidth - (aGlyph.Width + Sp + Tw)) div 2), R.Top, GP.X, R.Bottom);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_RIGHT;
          end;
        gpTop:
          begin
            GP.X := (aWidth - (aGlyph.Width)) div 2;
            GP.Y := (Height - (aGlyph.Height + Sp + Th)) div 2;

            TextR := Rect(R.Left, GP.Y + aGlyph.Height + Sp, R.Right, R.Bottom);
            uFormat := DT_SINGLELINE or DT_TOP or DT_CENTER;
          end;
        gpBottom:
          begin
            GP.X := (aWidth - aGlyph.Width) div 2;
            GP.Y := Height - ((Height - (aGlyph.Height + Sp + Th)) div 2) - aGlyph.Height;

            TextR := Rect(R.Left, GP.Y - Sp - Th, R.Right, GP.Y);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
          end;
      end;
    end
    else // if Position in [daLeft, daRight] then
    begin

      case GlyphPosition of
        gpLeft:
          begin
            GP.X := (aWidth - (aGlyph.Width)) div 2;
            GP.Y := (aHeight - (aGlyph.Height + Sp + Tw)) div 2;

            //TextR := Rect(R.Left, GP.Y + aGlyph.Height + Sp, R.Right, R.Bottom);
            TextR := Rect(R.Right - ((aWidth - th) div 2), GP.Y + aGlyph.Height + Sp, R.Right, R.Bottom);
            CP := Point(TextR.Left, TextR.Top);
            uFormat := DT_SINGLELINE or DT_CENTER or DT_TOP;
          end;
        gpRight:
          begin
            GP.X := (aWidth - (aGlyph.Width)) div 2;
            GP.Y := aHeight - ((aHeight - (aGlyph.Height + Sp + Tw)) div 2) - aGlyph.Height;

            TextR := Rect(R.Left, R.Top, R.Right, GP.Y - Sp);
            CP := Point(TextR.Left, TextR.Top);
            uFormat := DT_SINGLELINE or DT_CENTER or DT_BOTTOM;
          end;
        gpTop:
          begin
            GP.X := aWidth - ((aWidth - (aGlyph.Width + Sp + Th)) div 2) - aGlyph.Width;
            GP.Y := (aHeight - aGlyph.Height) div 2;

            TextR := Rect(R.Left, R.Top, GP.X - sp, R.Bottom);
            CP := Point(TextR.Left, TextR.Top);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
          end;
        gpBottom:
          begin
            GP.X := (aWidth - (aGlyph.Width + Sp + Th)) div 2;
            GP.Y := (aHeight - aGlyph.Height) div 2;

            TextR := Rect(GP.X + sp + aGlyph.Width, R.Top, R.Right, R.Bottom);
            TextR.Left := TextR.Right - (TextR.Right - TextR.Left - Th) div 2;
            CP := Point(TextR.Left, TextR.Top + (TextR.Bottom - TextR.Top - Tw) div 2);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
          end;
      end;
    end;

    if not AutoSize then
    begin
      if Position in [daTop, daBottom] then
      begin
        if GP.X < 0 then
        begin
          TextR.Left := TextR.Left + Abs(GP.X)+1;
          GP.X := GP.X + Abs(GP.X)+1;
          uFormat := uFormat or DT_END_ELLIPSIS;
        end;
      end
      else  // daLeft, daRight
      begin
        if GP.Y < 0 then
        begin
          TextR.Top := TextR.Top + Abs(GP.Y)+1;
          Cp.Y := Cp.Y + Abs(GP.Y)+1;
          GP.Y := GP.Y + Abs(GP.Y)+1;
          uFormat := uFormat or DT_END_ELLIPSIS;
        end;
      end;
    end;

    if DrawPosition.Enabled then
    begin
      GP.X := DrawPosition.ImageX;
      GP.Y := DrawPosition.ImageY;      
    end;

    if FMouseInControl and (FHot or FPropHot) and Shaded and Enabled and (FState = absUp)
      and not FMouseDownInControl and not FGlyphShade.Empty then
    begin

      if not FShadedForGlyph then
        GenerateShade;

      FGlyphShade.TransparentMode := tmAuto;
      FGlyphShade.Transparent := True;
      ACanvas.Draw(GP.X + 2, GP.Y + 2, FGlyphShade);
    end;

    AGlyph.TransparentMode := tmAuto;
    AGlyph.Transparent := true;
    ACanvas.Draw(GP.X, GP.Y, aGlyph);
  end
  else if Assigned(FPicture.Graphic) and not (FPicture.Graphic.Empty) then
  begin

    if Position in [daTop, daBottom] then
    begin
      case GlyphPosition of
        gpLeft:
          begin
            GP.X := (aWidth - (FPicture.Graphic.Width + Sp + Tw)) div 2;
            GP.Y := (Height - FPicture.Graphic.Height) div 2;

            TextR := Rect(GP.X + FPicture.Graphic.Width + Sp, R.Top, R.Right, R.Bottom);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_LEFT;
          end;
        gpRight:
          begin
            GP.X := aWidth - ((aWidth - (FPicture.Graphic.Width + Sp + Tw)) div 2) - FPicture.Graphic.Width;
            GP.Y := (Height - FPicture.Graphic.Height) div 2;

            TextR := Rect(((aWidth - (FPicture.Graphic.Width + Sp + Tw)) div 2), R.Top, GP.X, R.Bottom);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_RIGHT;
          end;
        gpTop:
          begin
            GP.X := (aWidth - (FPicture.Graphic.Width)) div 2;
            GP.Y := (Height - (FPicture.Graphic.Height + Sp + Th)) div 2;

            TextR := Rect(R.Left, GP.Y + FPicture.Graphic.Height + Sp, R.Right, R.Bottom);
            uFormat := DT_SINGLELINE or DT_TOP or DT_CENTER;
          end;
        gpBottom:
          begin
            GP.X := (aWidth - FPicture.Graphic.Width) div 2;
            GP.Y := Height - ((Height - (FPicture.Graphic.Height + Sp + Th)) div 2) - FPicture.Graphic.Height;

            TextR := Rect(R.Left, GP.Y - Sp - Th, R.Right, GP.Y);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
          end;
      end;
    end
    else // if Position in [daLeft, daRight] then
    begin

      case GlyphPosition of
        gpLeft:
          begin
            GP.X := (aWidth - (FPicture.Graphic.Width)) div 2;
            GP.Y := (aHeight - (FPicture.Graphic.Height + Sp + Tw)) div 2;

            //TextR := Rect(R.Left, GP.Y + FPicture.Graphic.Height + Sp, R.Right, R.Bottom);
            TextR := Rect(R.Right - ((aWidth - th) div 2), GP.Y + FPicture.Graphic.Height + Sp, R.Right, R.Bottom);
            CP := Point(TextR.Left, TextR.Top);
            uFormat := DT_SINGLELINE or DT_CENTER or DT_TOP;
          end;
        gpRight:
          begin
            GP.X := (aWidth - (FPicture.Graphic.Width)) div 2;
            GP.Y := aHeight - ((aHeight - (FPicture.Graphic.Height + Sp + Tw)) div 2) - FPicture.Graphic.Height;

            TextR := Rect(R.Left, R.Top, R.Right, GP.Y - Sp);
            CP := Point(TextR.Left, TextR.Top);
            uFormat := DT_SINGLELINE or DT_CENTER or DT_BOTTOM;
          end;
        gpTop:
          begin
            GP.X := aWidth - ((aWidth - (FPicture.Graphic.Width + Sp + Th)) div 2) - FPicture.Graphic.Width;
            GP.Y := (aHeight - FPicture.Graphic.Height) div 2;

            TextR := Rect(R.Left, R.Top, GP.X - sp, R.Bottom);
            CP := Point(TextR.Left, TextR.Top);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
          end;
        gpBottom:
          begin
            GP.X := (aWidth - (FPicture.Graphic.Width + Sp + Th)) div 2;
            GP.Y := (aHeight - FPicture.Graphic.Height) div 2;

            TextR := Rect(GP.X + sp + FPicture.Graphic.Width, R.Top, R.Right, R.Bottom);
            TextR.Left := TextR.Right - (TextR.Right - TextR.Left - Th) div 2;
            CP := Point(TextR.Left, TextR.Top + (TextR.Bottom - TextR.Top - Tw) div 2);
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
          end;
      end;

    end;

    if not AutoSize then
    begin
      if Position in [daTop, daBottom] then
      begin
        if GP.X < 0 then
        begin
          TextR.Left := TextR.Left + Abs(GP.X)+1;
          GP.X := GP.X + Abs(GP.X)+1;
          uFormat := uFormat or DT_END_ELLIPSIS;
        end;
      end
      else  // daLeft, daRight
      begin
        if GP.Y < 0 then
        begin
          TextR.Top := TextR.Top + Abs(GP.Y)+1;
          Cp.Y := Cp.Y + Abs(GP.Y)+1;
          GP.Y := GP.Y + Abs(GP.Y)+1;
          uFormat := uFormat or DT_END_ELLIPSIS;
        end;
      end;
    end;

    if DrawPosition.Enabled then
    begin
      GP.X := DrawPosition.ImageX;
      GP.Y := DrawPosition.ImageY;      
    end;

    if FMouseInControl and (FHot or FPropHot) and Shaded and Enabled and (FState = absUp)
      and not FMouseDownInControl and not FGlyphShade.Empty then
    begin
      if not FShadedForGlyph then
        GenerateShade;

      FGlyphShade.TransparentMode := tmAuto;
      FGlyphShade.Transparent := True;
      ACanvas.Draw(GP.X + 2, GP.Y + 2, FGlyphShade);
    end;

    //FPicture.Graphic.TransparentMode := tmAuto;

    if Enabled or not (Assigned(FPictureDisabled.Graphic) and not FPictureDisabled.Graphic.Empty) then
    begin
      FPicture.Graphic.Transparent := true;
      ACanvas.Draw(GP.X, GP.Y, FPicture.Graphic);
    end
    else
    begin
      FPictureDisabled.Graphic.Transparent := true;
      ACanvas.Draw(GP.X, GP.Y, FPictureDisabled.Graphic);
    end;
  end;

  if (Caption <> '') and ShowCaption then
  begin
    if ParentStyler and Assigned(AdvToolBar) and Assigned(AdvToolBar.FCurrentToolBarStyler) then
    begin
      if IsMenuButton then
        ACanvas.Font.Assign(AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.font)
      else
        ACanvas.Font.Assign(AdvToolBar.FCurrentToolBarStyler.ButtonAppearance.CaptionFont);
    end
    else
      ACanvas.Font.Assign(Font);

    // Make sure to use a truetype font!
    // Font.Name := 'Tahoma';

    if Position in [daLeft, daRight] then
    begin
      tf := TFont.Create;
      try
{$IFNDEF TMSDOTNET}
        FillChar(lf, SizeOf(lf), 0);
{$ENDIF}
        tf.Assign(aCanvas.Font);
{$IFNDEF TMSDOTNET}
        GetObject(tf.Handle, SizeOf(Lf), @Lf);
{$ENDIF}
{$IFDEF TMSDOTNET}
        GetObject(tf.Handle, Marshal.SizeOf(TypeOf(Lf)), Lf);
{$ENDIF}

        lf.lfEscapement := -900;
        lf.lfOrientation := 30;

        tf.Handle := CreateFontIndirect(Lf);
        aCanvas.Font.Assign(tf);
      finally
        tf.Free;
      end;
    end;

    aCanvas.font.Color := TxtClr;
    aCanvas.Brush.Style := bsClear;
    //DrawText(aCanvas.Handle, PChar(Caption), -1, TextR , DT_SINGLELINE or DT_VCENTER or DT_CENTER);

    with aCanvas do
    begin

      if not AutoSize then
      begin
        if Position in [daTop, daBottom] then
        begin
          if (TextR.Left < 0) then
          begin
            TextR.Left := 1;
            uFormat := DT_SINGLELINE or DT_VCENTER or DT_CENTER or DT_END_ELLIPSIS;
          end;
        end
        else  // daLeft, daRight
        begin
          if (CP.Y < 0) then
          begin
            CP.Y := 1;
            uFormat := uFormat or DT_END_ELLIPSIS;
          end;
        end;
      end;

      if DrawPosition.Enabled then
      begin
        uFormat := DT_SINGLELINE or DT_LEFT or DT_END_ELLIPSIS;
        TextR.Left := DrawPosition.TextX;
        TextR.Top := DrawPosition.TextY;
        TextR.Right := Width;
        TextR.Bottom := Height;
      end;


      if Position in [daTop, daBottom] then
      begin
        if State = absDisabled then
        begin
          OffsetRect(TextR, 1, 1);
          Font.Color := clBtnHighlight;
          DrawText(Handle, PChar(Caption), -1, TextR, uFormat);
          OffsetRect(TextR, -1, -1);
          Font.Color := clBtnShadow;
          DrawText(Handle, PChar(Caption), -1, TextR, uFormat);
        end else
          DrawText(Handle, PChar(Caption), -1, TextR, uFormat);
      end
      else
      begin
        if State = absDisabled then
        begin
          OffsetRect(TextR, 1, 1);
          Font.Color := clBtnHighlight;
       //   TextOut(CP.X, CP.Y, Caption);
          DrawVerticalText(ACanvas, Caption, CP);
               //DrawText(Handle, PChar(Caption), -1, TextR, uFormat);
               //OffsetRect(TextR, -1, -1);
          CP := Point(CP.X - 1, CP.Y - 1);
          Font.Color := clBtnShadow;
               //DrawText(Handle, PChar(Caption), -1, TextR, uFormat);
       //   TextOut(CP.X, CP.Y, Caption);
          DrawVerticalText(ACanvas, Caption, CP);
        end else
       //   TextOut(CP.X {TextR.Right - (((TextR.Right - TextR.Left)- Th) div 2)}, CP.Y, Caption);
          DrawVerticalText(ACanvas, Caption, CP);
               //DrawText(Handle, PChar(Caption), -1, TextR, uFormat);
      end;
    end;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.GenerateShade;
var
  r: TRect;
  bmp, bmp2: TBitmap;
begin
  if (ImageIndex >= 0) and Assigned(AdvToolBar) and (AdvToolBar.Images <> nil) then
  begin
    FShadedForGlyph := false;

    bmp2 := TBitMap.Create;
    bmp2.Width := FAdvToolBar.Images.Width;
    bmp2.Height := FAdvToolBar.Images.Height;
    FAdvToolBar.Images.Draw(bmp2.Canvas, 0, 0, ImageIndex);

    FGlyphShade.Width := bmp2.Width;
    FGlyphShade.Height := bmp2.Height;

    r := Rect(0, 0, FGlyphShade.Width, FGlyphShade.Height);
    FGlyphShade.Canvas.Brush.Color := ColorToRGB(clBlack);
    FGlyphShade.Canvas.BrushCopy(r, bmp2, r, bmp2.Canvas.Pixels[0, bmp2.Height - 1]);
    FGlyphShade.Canvas.CopyMode := cmSrcInvert;
    FGlyphShade.Canvas.CopyRect(r, bmp2.Canvas, r);

    bmp := TBitmap.Create;
    bmp.Width := bmp2.Width;
    bmp.Height := bmp2.Height;
    bmp.Canvas.Brush.Color := ColorToRGB(clGray);
    bmp.Canvas.BrushCopy(r, FGlyphShade, r, ColorToRGB(clBlack));

    FGlyphShade.Canvas.CopyMode := cmSrcCopy;
    FGlyphShade.Canvas.CopyRect(r, bmp.Canvas, r);
    bmp.Free;
    bmp2.Free;
  end
  else if not FGlyph.Empty then
  begin
    FShadedForGlyph := true;

    FGlyphShade.Width := FGlyph.Width;
    FGlyphShade.Height := FGlyph.Height;

    r := Rect(0, 0, FGlyphShade.Width, FGlyphShade.Height);
    FGlyphShade.Canvas.Brush.Color := ColorToRGB(clBlack);
    FGlyphShade.Canvas.BrushCopy(r, FGlyph, r, FGlyph.Canvas.Pixels[0, FGlyph.Height - 1]);
    FGlyphShade.Canvas.CopyMode := cmSrcInvert;
    FGlyphShade.Canvas.CopyRect(r, FGlyph.Canvas, r);

    bmp := TBitmap.Create;
    bmp.Width := FGlyph.Width;
    bmp.Height := FGlyph.Height;
    bmp.Canvas.Brush.Color := ColorToRGB(clGray);
    bmp.Canvas.BrushCopy(r, FGlyphShade, r, ColorToRGB(clBlack));

    FGlyphShade.Canvas.CopyMode := cmSrcCopy;
    FGlyphShade.Canvas.CopyRect(r, bmp.Canvas, r);
    bmp.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.ThemeAdapt;
begin

end;

//------------------------------------------------------------------------------

{$IFNDEF TMSDOTNET}

procedure TAdvCustomToolBarButton.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);

    if Assigned(FAdvToolBar) and not (Parent is TAdvCustomToolBar) then
      FAdvToolBar.Broadcast(Msg)
    else if Assigned(AdvToolBar) and (Parent is TAdvCustomToolBar) and Assigned(AdvToolBar.FOptionWindowPanel) then
      FAdvToolBar.FOptionWindowPanel.Broadcast(Msg);
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

{$IFDEF TMSDOTNET}

procedure TAdvCustomToolBarButton.ButtonPressed(Group: Integer; Button: TAdvCustomToolBarButton);
begin
  if (Group = FGroupIndex) and (Button <> Self) then
  begin
    if Button.Down and FDown then
    begin
      FDown := False;
      FState := absUp;
      if (Action is TCustomAction) then
        TCustomAction(Action).Checked := False;
      Invalidate;
    end;
    FAllowAllUp := Button.AllowAllUp;
  end;
end;

procedure TAdvCustomToolBarButton.UpdateExclusive;
var
  I: Integer;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    for I := 0 to Parent.ControlCount - 1 do
      if Parent.Controls[I] is TSpeedButton then
        TAdvToolButton(Parent.Controls[I]).ButtonPressed(FGroupIndex, Self);
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.UpdateTracking;
var
  P: TPoint;
begin
  if FFlat then
  begin
    if Enabled then
    begin
      GetCursorPos(P);
      FMouseInControl := not (FindDragTarget(P, True) = Self);
      if FMouseInControl then
        Perform(CM_MOUSELEAVE, 0, 0)
      else
        Perform(CM_MOUSEENTER, 0, 0);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetAllowAllUp(Value: Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetAutoThemeAdapt(const Value: Boolean);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetDown(Value: Boolean);
begin
  if (csLoading in ComponentState) then
    FInitialDown := Value;

  if (FGroupIndex = 0) and (Style = tasButton) then
    Value := False;

  if (Style = tasCheck) then
  begin
    FDown := Value;
    if FDown then
      FState := absDown
    else
      FState := absUp;
    Repaint;
    Exit;
  end;

  if Value <> FDown then
  begin
    if FDown and (not FAllowAllUp) then Exit;
    FDown := Value;
    if Value then
    begin
      if FState = absUp then Invalidate;
      FState := absExclusive
    end
    else
    begin
      FState := absUp;
      Repaint;
    end;
    if Value then UpdateExclusive;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetDropDownButton(const Value: Boolean);
begin
  if FDropDownButton <> Value then
  begin
    if (Value and not (Style = tasCheck)) or not Value then
      FDropDownButton := Value;
    AdjustSize;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetFlat(Value: Boolean);
begin
  FFlat := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetGlyph(Value: TBitmap);
var
  x, y: Integer;
  PxlColor: TColor;
  c: byte;
begin
  FGlyph.Assign(Value);
  //if no disabled glyph is given... add this automatically...
  if FGlyphDisabled.Empty then
  begin
    FGlyphDisabled.Assign(Value);
    for x := 0 to FGlyphDisabled.Width - 1 do
      for y := 0 to FGlyphDisabled.Height - 1 do
      begin
        PxlColor := ColorToRGB(FGlyphDisabled.Canvas.Pixels[x, y]);
        c := Round((((PxlColor shr 16) + ((PxlColor shr 8) and $00FF) +
          (PxlColor and $0000FF)) div 3)) div 2 + 96;
        FGlyphDisabled.Canvas.Pixels[x, y] := RGB(c, c, c);
      end;
  end;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetGlyphDisabled(const Value: TBitmap);
begin
  FGlyphDisabled.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetGlyphDown(const Value: TBitmap);
begin
  FGlyphDown.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetGlyphHot(const Value: TBitmap);
begin
  FGlyphHot.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetGlyphPosition(
  const Value: TGlyphPosition);
begin
  if FGlyphPosition <> Value then
  begin
    FGlyphPosition := Value;
    AdjustSize;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetParentStyler(const Value: Boolean);
begin
  if FParentStyler <> Value then
  begin
    FParentStyler := Value;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetShaded(const Value: Boolean);
begin
  FShaded := Value;
  if FShaded then
    if not (csLoading in ComponentState) then
    begin
      GenerateShade;
    end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    AdjustSize;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetState(const Value: TAdvButtonState);
begin
  if FState <> Value then
  begin
    FState := Value;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetStyle(const Value: TAdvToolButtonStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    if (Value = tasCheck) and DropDownButton then
      DropDownButton := false;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBarButton.IsMenuButton: Boolean;
begin
  Result := false;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetRounded(const Value: Boolean);
begin
  FRounded := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.DoDropDown;
begin
  if IsMenuButton then
  begin
    State := absDropDown;
    InvalidateMe;
    CheckMenuDropdown;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetGlyphChecked(const Value: TBitmap);
begin
  FGlyphChecked.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.InvalidateMe;
begin
  invalidate;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBarButton.CheckMenuDropdown: Boolean;
begin
  Result := not (csDesigning in ComponentState) and ((DropdownMenu <> nil) and
    DropdownMenu.AutoPopup or (MenuItem <> nil)) and (FAdvToolBar <> nil) and
    FAdvToolBar.CheckMenuDropdown(Self);
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBarButton.GetIndex: Integer;
begin
  if FAdvToolBar <> nil then
    Result := FAdvToolBar.FATBControls.IndexOf(Self)
  else
    Result := -1;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetGrouped(const Value: Boolean);
begin
  FGrouped := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetMenuItem(const Value: TMenuItem);
begin
  { Copy all appropriate values from menu item }
  if Value <> nil then
  begin
    if FMenuItem <> Value then
      Value.FreeNotification(Self);
    Action := Value.Action;
    Caption := Value.Caption;
    Down := Value.Checked;
    Enabled := Value.Enabled;
    Hint := Value.Hint;
    ImageIndex := Value.ImageIndex;
    Visible := Value.Visible;
  end;
  FMenuItem := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.OnDropDownHide;
begin
  FMouseDownInControl := false;
  FMouseInControl := false;
  FHot := false;
  State := absUp;
  InvalidateMe;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetImageIndex(const Value: integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
   {
    if (FImageIndex >= 0) then
    begin
      if not Assigned(FAdvToolBar) then
        FImageIndex := -1;

      if Assigned(FAdvToolBar) and not Assigned(FAdvToolBar.Images) then
        FImageIndex := -1;
    end;
   }
    AdjustSize;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.ButtonDown;
begin
  //State:= absDown;
//InvalidateMe;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.PopupBtnDown;
begin
  //State:= absDropDown;
  InvalidateMe;
  if Assigned(FOnDropDown) then
    FOnDropDown(self);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetAutoSize(Value: Boolean);
begin
  {$IFNDEF DELPHI6_LVL}
  if Value then
    AdjustSize;
  FAutoSize := Value;
  {$ENDIF}
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.AdjustSize;
var
  ImgS, CS, W, H: integer;
  images: TCustomImageList;
  imgidx: Integer;
  R: TRect;
begin
  if not Assigned(Parent) then
    Exit;

  if AutoSize then
  begin
    ImgS := 0;
    W := 0;
    H := 0;

    images := nil;
    if Assigned(AdvToolBar) then
      images := AdvToolBar.Images;

    imgidx := ImageIndex;

    if (Action is TCustomAction) then
    begin
      if Assigned((Action as TCustomAction).ActionList) then
      begin
        if Assigned((Action as TCustomAction).ActionList.Images) then
          images := (Action as TCustomAction).ActionList.Images;
        imgidx := (Action as TCustomAction).ImageIndex;
      end;
    end;

    if Position in [daTop, daBottom] then
    begin
      if (imgidx >= 0) and (Images <> nil) then
      begin
        ImgS := Images.Width;
        H := Images.Height;
      end
      else
      begin
        if not Glyph.Empty then
        begin
          ImgS := Glyph.Width;
          H := Glyph.Height;
        end;
        if not GlyphHot.Empty then
        begin
          ImgS := max(ImgS, GlyphHot.Width);
          H := Max(H, GlyphHot.Height);
        end;
        if not GlyphDown.Empty then
        begin
          ImgS := max(ImgS, GlyphDown.Width);
          H := Max(H, GlyphDown.Height);
        end;
        if not GlyphChecked.Empty then
        begin
          ImgS := max(ImgS, GlyphChecked.Width);
          H := Max(H, GlyphChecked.Height);
        end;
        if not GlyphDisabled.Empty then
        begin
          ImgS := max(ImgS, GlyphDisabled.Width);
          H := Max(H, GlyphDisabled.Height);
        end;

        // Checking Picture
        if (Glyph.Empty) and (GlyphHot.Empty) and GlyphDown.Empty and GlyphChecked.Empty and Assigned(FPicture) then
        begin
          if Assigned(FPicture.Graphic) and not Fpicture.Graphic.Empty then
          begin
            ImgS := Fpicture.Width;
            H := Fpicture.Height;
          end;
        end;

      end;

      if ParentStyler and Assigned(AdvToolBar) and Assigned(AdvToolBar.FCurrentToolBarStyler) and Assigned(AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler) then
      begin
        if IsMenuButton then
          Canvas.Font.Assign(AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.font)
        else
          Canvas.Font.Assign(AdvToolBar.FCurrentToolBarStyler.ButtonAppearance.CaptionFont);
      end
      else
        Canvas.Font.Assign(Font);

     { if ParentStyler and Assigned(AdvToolBar) and Assigned(AdvToolBar.ToolBarStyler) then
        Canvas.Font.Assign(AdvToolBar.ToolBarStyler.AdvMenuStyler.RootItem.font)
      else
        Canvas.Font.Assign(Font);
      }
      CS := 0;

      if ShowCaption and (Caption <> '') then
      begin
        R := Rect(0,0,1000,100);
        DrawText(Canvas.Handle,PChar(Caption),Length(Caption), R, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
        CS := R.Right;
      end;
      // CS := Canvas.TextWidth(Caption);

      if GlyphPosition in [gpLeft, gpRight] then
      begin
        if (ImgS > 0) and (CS > 0) then
          W := ImgS + Spacing + CS
        else if ImgS > 0 then
          W := ImgS
        else if CS > 0 then
          W := CS;

        W := W + FOffSet * 2;
        H := Max(H, Canvas.TextHeight('gh'));

        H := H + FOffSet * 2;
      end
      else if GlyphPosition in [gpTop, gpBottom] then
      begin
        W := Max(ImgS, CS);
        W := W + FOffSet * 2;
        H := H + Spacing + Canvas.TextHeight('gh') + FOffSet * 2;
      end
      else
      begin
        W := CS + Spacing * 2;
        H := Max(H, Canvas.TextHeight('gh'));
      end;

      //Inc(H, FOffSet*2);

      W := Max(W, MIN_BUTTONSIZE);
      if DropDownButton then
        W := W + FDropDownSectWidth;

      Width := W;

      //if Assigned(FAdvToolBar) then
        //Height := FAdvToolBar.Height - 4;
      if Assigned(FAdvToolBar) then
        if (FAdvToolBar.ToolBarState = tsFloating) then
          H := max(H, FAdvToolBar.FSizeAtDock - 4)
        else
        begin
          H := max(H, FAdvToolBar.Height - 4);
          {EH := 0;
          EW := 0;
          FAdvToolBar.GetMaxExternalControlSize(EW, EH);
          if EH > 0 then
            H := max(H, EH);  }
        end;

      Height := H;
    end
    else // if Position in [daLeft, daRight] then
    begin
      if (imgidx >= 0) and Assigned(Images) then
      begin
        ImgS := Images.Height;
        W := Images.Width;
      end
      else
      begin
        if not Glyph.Empty then
        begin
          ImgS := Glyph.Height;
          W := Glyph.Width;
        end;
        if not GlyphHot.Empty then
        begin
          ImgS := max(ImgS, GlyphHot.Height);
          W := Max(W, GlyphHot.Width);
        end;
        if not GlyphDown.Empty then
        begin
          ImgS := max(ImgS, GlyphDown.Height);
          W := Max(W, GlyphDown.Width);
        end;
        if not GlyphChecked.Empty then
        begin
          ImgS := max(ImgS, GlyphChecked.Height);
          W := Max(W, GlyphChecked.Width);
        end;
        if not GlyphDisabled.Empty then
        begin
          ImgS := max(ImgS, GlyphDisabled.Height);
          W := Max(W, GlyphDisabled.Width);
        end;

        // Checking Picture
        if (Glyph.Empty) and (GlyphHot.Empty) and GlyphDown.Empty and GlyphChecked.Empty and Assigned(FPicture) then
        begin
          if Assigned(FPicture.Graphic) and not Fpicture.Graphic.Empty then
          begin
            ImgS := Fpicture.Height;
            W := Fpicture.Width;
          end;
        end;

      end;

      // Assigning Font
      if ParentStyler and Assigned(AdvToolBar) and Assigned(AdvToolBar.FCurrentToolBarStyler) and Assigned(AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler) then
      begin
        if IsMenuButton then
          Canvas.Font.Assign(AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem.font)
        else
          Canvas.Font.Assign(AdvToolBar.FCurrentToolBarStyler.ButtonAppearance.CaptionFont);
      end
      else
        Canvas.Font.Assign(Font);

      CS := 0;
      if ShowCaption and (Caption <> '') then
      begin
        R := Rect(0,0,1000,100);
        DrawText(Canvas.Handle,PChar(Caption),Length(Caption), R, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
        CS := R.Right;
      end;
      //CS := Canvas.TextWidth(Caption);

      if GlyphPosition in [gpLeft, gpRight] then
      begin
        if (ImgS > 0) and (CS > 0) then
          H := ImgS + Spacing + CS
        else if ImgS > 0 then
          H := ImgS
        else if CS > 0 then
          H := CS;

        H := H + FOffSet * 2;
        W := Max(W, Canvas.TextHeight('gh'));

        W := W + FOffSet * 2;
      end
      else if GlyphPosition in [gpTop, gpBottom] then
      begin
        H := Max(ImgS, CS);
        H := H + FOffSet * 2;
        W := W + Spacing + Canvas.TextHeight('gh') + FOffSet * 2;
      end
      else
      begin
        H := CS + Spacing * 2;
        W := Max(W, Canvas.TextHeight('gh'));
      end;

      //Inc(W, FOffSet*2);

      H := Max(H, MIN_BUTTONSIZE);
      if DropDownButton then
        H := H + FDropDownSectWidth;

      Height := H;
      //if Assigned(FAdvToolBar) then
        //Width := FAdvToolBar.Width - 4;
      if Assigned(FAdvToolBar) then
        if (FAdvToolBar.ToolBarState = tsFloating) then
          W := Max(W, FAdvToolBar.FSizeAtDock - 4)
        else
        begin
          W := Max(W, FAdvToolBar.Width - 4);
          {EH := 0;
          EW := 0;
          FAdvToolBar.GetMaxExternalControlSize(EW, EH);
          if EW > 0 then
            W := max(W, EW);}
        end;

      Width := W;
    end;
  end;
end;

//------------------------------------------------------------------------------

{$IFNDEF TMSDOTNET}

procedure TAdvCustomToolBarButton.CMButtonPressed(var Message: TMessage);
var
  Sender: TAdvCustomToolBarButton;
begin
  if Message.WParam = FGroupIndex then
  begin
    Sender := TAdvCustomToolBarButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
        FState := absUp;
        if (Action is TCustomAction) then
          TCustomAction(Action).Checked := False;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

{$IFDEF DELPHI6_LVL}

procedure TAdvCustomToolBarButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if CheckDefaults or (Self.GroupIndex = 0) then
        Self.GroupIndex := GroupIndex;
      Self.ImageIndex := ImageIndex;
    end;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBarButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TAdvToolBarButtonActionLink;
end;
{$ENDIF}

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetAppearance(
  const Value: TButtonAppearance);
begin
  FAppearance.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.OnAppearanceChange(Sender: TObject);
begin
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetShowCaption(const Value: Boolean);
begin
  FShowCaption := Value;
  AdjustSize;
  Invalidate;
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBarButton.GetAutoSize: Boolean;
begin
  {$IFNDEF DELPHI6_LVL}
  Result := FAutoSize;
  {$ELSE}
  Result := inherited AutoSize;
  {$ENDIF}
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBarButton.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

function TAdvCustomToolBarButton.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

function TAdvCustomToolBarButton.GetHot: Boolean;
begin
  Result := FPropHot;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetHot(const Value: Boolean);
var
  OldV: Boolean;
begin
  OldV := FPropHot;
  FPropHot := Value;
  if (State <> absUp) then
    FPropHot := false;

  if Assigned(FAdvToolBar) then
    FAdvToolBar.UpdateButtonHot(self)
  else
    FPropHot := false;
  if OldV <> FPropHot then
    InvalidateMe;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetPicture(const Value: TPicture);
begin
  FPicture.Assign(Value);
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetPictureDisabled(const Value: TPicture);
begin
  FPictureDisabled.Assign(Value);
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.UnHotTimerOnTime(Sender: TObject);
var
  CurP: TPoint;
begin
  GetCursorPos(CurP);
  CurP := ScreenToClient(CurP);
  if not PtInRect(ClientRect, CurP) then
  begin
    FUnHotTimer.Enabled := False;
    FMouseInControl := false;
    FHot := false;

    if Assigned(FAdvToolBar) then
      if not (FAdvToolBar.FInMenuLoop and FAdvToolBar.FMenuFocused) then
        Hot := False;

    if Enabled then
      InvalidateMe;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarButton.SetDrawPosition(
  const Value: TAdvToolBarButtonDrawPosition);
begin
  FDrawPosition.Assign(Value);
end;

procedure TAdvCustomToolBarButton.PositionChanged(Sender: TObject);
begin
  Invalidate;
end;

{ TAdvCustomToolBarControl }

constructor TAdvCustomToolBarControl.Create(AOwner: TComponent);
begin
  inherited;
  FPosition := daTop;
end;

//------------------------------------------------------------------------------

destructor TAdvCustomToolBarControl.Destroy;
begin

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarControl.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TAdvToolBar then
    AdvToolBar := TAdvToolBar(Reader.Parent);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarControl.SetAdvToolBar(
  const Value: TAdvCustomToolBar);
begin
  if FAdvToolBar <> Value then
  begin
    if FAdvToolBar <> nil then
      FAdvToolBar.RemoveControl(self);

    Parent := Value;

    if Value <> nil then
      Value.InsertControl(self);

    if (Value <> nil) and (FAdvToolBar = nil) then
      raise exception.Create('AdvToolBar not set');
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomToolBarControl.SetPosition(const Value: TDockAlign);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    AdjustSize;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

{ TAdvToolBarSeparator }

procedure TAdvToolBarSeparator.AdjustSize;
begin
  if AutoSize then
  begin
    if Position in [daTop, daBottom] then
    begin
      Width := DEFAULT_SEPARATORWIDTH;
      if Assigned(FAdvToolBar) then
        Height := FAdvToolBar.Height - 4;
    end
    else // if Position in [daLeft, daRight] then
    begin
      Height := DEFAULT_SEPARATORWIDTH;
      if Assigned(FAdvToolBar) then
        Width := FAdvToolBar.Width - 4;
    end;
  end;
end;

//------------------------------------------------------------------------------

constructor TAdvToolBarSeparator.Create(AOwner: TComponent);
begin
  inherited;
  AutoSize := true;
  FLineColor := clBtnShadow;
  FSeparatorStyle := ssOffice2003;
  SetBounds(0, 0, DEFAULT_SEPARATORWIDTH, 22);
end;

//------------------------------------------------------------------------------

destructor TAdvToolBarSeparator.Destroy;
begin

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarSeparator.Paint;
var
  R: TRect;

  procedure DrawSepLine(FromPoint, ToPoint: TPoint; Embossed: Boolean);
  begin
    with Canvas do
    begin
      if Embossed then
        Pen.Color := clWhite
      else
        Pen.Color := FLineColor; //clBtnShadow;

      MoveTo(FromPoint.X, FromPoint.Y);
      LineTo(ToPoint.X, ToPoint.Y);

      if Embossed then
        Pen.Color := FLineColor //clBtnShadow
      else
        Pen.Color := clWhite;

      MoveTo(FromPoint.X + 1, FromPoint.Y + 1);
      LineTo(ToPoint.X + 1, ToPoint.Y + 1);
    end;
  end;

begin
  inherited;
  R := ClientRect;

  case FSeparatorStyle of
    ssOffice2003:
      begin
        if Position in [daTop, daBottom] then
          DrawSepLine(Point(R.Left + ((R.Right - R.Left) div 2), R.Top + 3), Point(R.Left + ((R.Right - R.Left) div 2), R.Bottom - 3), false)
        else
        begin
          DrawSepLine(Point(R.Left + 3, R.Top + ((R.Bottom - R.Top) div 2)), Point(R.Right - 3, R.Top + ((R.Bottom - R.Top) div 2)), false)
        end;
      end;
    ssBlank:
      begin
      // do nothing
      end;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvToolBarSeparator.SetLineColor(const Value: TColor);
begin
  if FLineColor <> Value then
  begin
    FLineColor := Value;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarSeparator.SetSeparatorStyle(
  const Value: TAdvSeparatorStyle);
begin
  if FSeparatorStyle <> Value then
  begin
    FSeparatorStyle := Value;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

{ TAdvToolBarMenuButton }

constructor TAdvToolBarMenuButton.Create(AOwner: TComponent);
begin
  inherited;
  ParentStyler := true;
end;

//------------------------------------------------------------------------------

destructor TAdvToolBarMenuButton.Destroy;
begin

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarMenuButton.DrawButton(aCanvas: TCanvas);
var
  Clr, ClrTo, BrClr, TxtClr: TColor;
  BtnR: TRect;
  aGlyph: TBitmap;
  GDHoriztl: Boolean;
begin
  BtnR := ClientRect;
  aGlyph := nil;

  Clr := clNone;
  ClrTo := clNone;
  TxtClr := clNone;
  BrClr := clNone;
  GDHoriztl := true;

  with aCanvas, FAppearance do
  begin
    if (State = absDisabled) or not Enabled then
    begin
      if Transparent then
      begin
        Clr := clNone;
        ClrTo := clNone;
        BrClr := clNone;
      end
      else
      begin
        Clr := Color;
        ClrTo := ColorTo;
        BrClr := BorderColor;
      end;
      TxtClr := CaptionTextColor;
      GDHoriztl := GradientDirection = gdHorizontal;
      aGlyph := GlyphDisabled;
    end
    else if (State = absDropDown) and false then
    begin

    end
    else if (State = absDown) or ((FHot or FPropHot) and (State = absExclusive)) or (FMouseDownInControl) or (State = absDropDown) then
    begin
      if ParentStyler and Assigned(AdvToolBar) then
      begin
        with AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem do
        begin
          Clr := SelectedColor;
          ClrTo := SelectedColorTo;
          TxtClr := SelectedTextColor;
          BrClr := SelectedBorderColor;
          GDHoriztl := SelectedGradientDirection = AdvMenus.gdHorizontal;
          aGlyph := GlyphDown;
        end;
      end
      else
      begin
        Clr := ColorDown;
        ClrTo := ColorDownTo;
        TxtClr := CaptionTextColorDown;
        BrClr := BorderDownColor;
        GDHoriztl := GradientDirectionDown = gdHorizontal;
        aGlyph := GlyphDown;
      end;

    end
    else if State = absExclusive then
    begin
      Clr := ColorChecked;
      ClrTo := ColorCheckedTo;
      TxtClr := CaptionTextColorChecked;
      BrClr := BorderCheckedColor;
      GDHoriztl := GradientDirectionChecked = gdHorizontal;
      aGlyph := GlyphChecked;
    end
    else //if State = absUp then
    begin
      if (FHot or FPropHot) then
      begin
        if ParentStyler and Assigned(AdvToolBar) then
        begin
          with AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem do
          begin
            Clr := HoverColor;
            ClrTo := HoverColorTo;
            TxtClr := HoverTextColor;
            BrClr := HoverBorderColor;
            GDHoriztl := HoverGradientDirection = AdvMenus.gdHorizontal;
            aGlyph := GlyphHot;
          end;
        end
        else
        begin
          Clr := ColorHot;
          ClrTo := ColorHotTo;
          TxtClr := CaptionTextColorHot;
          BrClr := BorderHotColor;
          GDHoriztl := GradientDirectionHot = gdHorizontal;
          aGlyph := GlyphHot;
        end;
      end
      else // Normal draw
      begin
        if Transparent then
        begin
          Clr := clNone;
          ClrTo := clNone;
          BrClr := clNone;
        end
        else
        begin
          if ParentStyler and Assigned(AdvToolBar) then
          begin
            with AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler.RootItem do
            begin
              Clr := Color;
              ClrTo := ColorTo;
              BrClr := BorderColor;
              GDHoriztl := GradientDirection = AdvMenus.gdHorizontal;
            end;
          end
          else
          begin
            Clr := Color;
            ClrTo := ColorTo;
            BrClr := BorderColor;
            GDHoriztl := GradientDirection = gdHorizontal;
          end;
        end;
        TxtClr := CaptionTextColor;
        aGlyph := Glyph;
      end;
    end;

    // BackGround
    if (Clr <> clNone) and (ClrTo <> clNone) then
      DrawGradient(aCanvas, Clr, ClrTo, 40, BtnR, GDHoriztl)
    else if (Clr <> clNone) then
    begin
      Brush.Color := Clr;
      Pen.Color := Clr;
      Rectangle(BtnR);
    end;

    // Border
    if BrClr <> clNone then
    begin
      Brush.Style := bsClear;
      Pen.Color := BrClr;
      Rectangle(BtnR);
    end;

    if Assigned(aGlyph) and (aGlyph.Empty) and not Glyph.Empty then
      aGlyph := Glyph;

    DrawGlyphAndCaption(aCanvas, BtnR, TxtClr, aGlyph);

  end;

end;

//------------------------------------------------------------------------------

function TAdvToolBarMenuButton.IsMenuButton: Boolean;
begin
  Result := true;
end;

//------------------------------------------------------------------------------

{ TOptionSelectorWindow }

constructor TOptionSelectorWindow.Create(AOwner: TComponent);
begin
  inherited;
  FHideOnDeActivate := true;
  FHideTimer := TTimer.Create(self);
  FHideTimer.Interval := 1;
  FHideTimer.Enabled := false;
  FHideTimer.OnTimer := HideTimerOnTime;
end;

//------------------------------------------------------------------------------

constructor TOptionSelectorWindow.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited;
  FOwner := AOwner;
  FHideOnDeActivate := true;
  FHideTimer := TTimer.Create(self);
  FHideTimer.Interval := 1;
  FHideTimer.Enabled := false;
  FHideTimer.OnTimer := HideTimerOnTime;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorWindow.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited CreateParams(Params);
  // FF: D2005
  Params.Style := Params.Style or WS_POPUP;
  Params.Style := Params.Style - WS_CHILD;
  //Params.ExStyle := Params.ExStyle or WS_EX_NOPARENTNOTIFY;

  //Params.Style := Params.Style - WS_BORDER;
  {
  if (Win32Platform = VER_PLATFORM_WIN32_NT) and
     ((Win32MajorVersion > 5) or
      ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1))) then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;

  Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST; }
end;

//------------------------------------------------------------------------------

destructor TOptionSelectorWindow.Destroy;
begin
  FHideTimer.Free;
  inherited;
end;

//------------------------------------------------------------------------------

function TOptionSelectorWindow.GetParentWnd: HWnd;
var
  Last, P: HWnd;
begin
  P := GetParent((Owner as TWinControl).Handle);
  Last := P;
  while P <> 0 do
  begin
    Last := P;
    P := GetParent(P);
  end;
  Result := Last;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorWindow.HideTimerOnTime(Sender: TObject);
begin
  Hide;
  FHideTimer.Enabled := false;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorWindow.Paint;
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TOptionSelectorWindow.SetWindowSize;
begin
  if Assigned(FOptionsPanel) then
  begin
    Height := FOptionsPanel.GetVisibleHeight;
    Width := FOptionsPanel.Width;
  end;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorWindow.WMActivate(var Message: TWMActivate);
begin
  if Message.Active = integer(False) then
  begin
    if HideOnDeActivate and Visible then
    begin
      FHideTimer.Enabled := true;
    end;
  end
  else if Assigned(FOptionsPanel) then
  begin
    if Self.Visible then
    begin
      FOptionsPanel.SetFocus;
      SendMessage(getParentWnd, WM_NCACTIVATE, 1, 0);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorWindow.WMNCHitTest(var Message: TWMNCHitTest);
var
  pt: TPoint;
begin
  // Make the hint sizable
  pt := ScreenToClient(Point(Message.XPos, Message.YPos));

  if (pt.X > Width - 10) and (pt.Y > Height - 10) then
    message.Result := HTBOTTOMRIGHT
end;

//------------------------------------------------------------------------------

{ TOptionSelectorPanel }

constructor TOptionSelectorPanel.Create(AOwner: TComponent);
begin
  inherited;
  FOwner := AOwner;
  BevelOuter := bvNone;
  BevelWidth := 1;
  Color := $00F7F8F9;
  FColorTo := clNone;
  FWindowBorderColor := clGray;
  FGradientDirection := gdHorizontal;
  FMarginX := 3;
  FMarginY := 3;
end;

//------------------------------------------------------------------------------

function TOptionSelectorPanel.GetVisibleHeight: integer;
begin
  Result := Height;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TOptionSelectorPanel.Paint;
var
  R: TRect;
begin
  inherited;
  R := Rect(0, 0, Width, Height);

  if ColorTo <> clNone then
    DrawGradient(Canvas, Color, ColorTo, 40, R, FGradientDirection = gdHorizontal);

  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := FWindowBorderColor;

  Canvas.MoveTo(0, 0);
  Canvas.LineTo(0, Height);

  //if TSelectorDropDownWindow(FOwner).ShowFullBorder then
  //begin
  Canvas.MoveTo(0, 0);
  Canvas.LineTo(Width - 1, 0);
  Canvas.MoveTo(0, Height - 1);
  Canvas.LineTo(Width - 1, Height - 1);
{  end
  else
  begin

  end;
  }
  Canvas.MoveTo(Width - 1, Height);
  Canvas.LineTo(Width - 1, {0} -1);
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorPanel.SetColorTo(const Value: TColor);
begin
  FColorTo := Value;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorPanel.SetGradientDirection(
  const Value: TGradientDirection);
begin
  FGradientDirection := Value;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorPanel.SetMarginX(const Value: Integer);
begin
  FMarginX := Value;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorPanel.SetMarginY(const Value: Integer);
begin
  FMarginY := Value;
end;

//------------------------------------------------------------------------------

procedure TOptionSelectorPanel.SetWindowBorderColor(const Value: TColor);
begin
  FWindowBorderColor := Value;
end;

//------------------------------------------------------------------------------

{$IFDEF DELPHI6_LVL}

{ TAdvToolBarButtonActionLink }

procedure TAdvToolBarButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TAdvCustomToolBarButton;
end;

//------------------------------------------------------------------------------

function TAdvToolBarButtonActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked {and (FClient.GroupIndex <> 0) and
    FClient.AllowAllUp} and (FClient.Down = (Action as TCustomAction).Checked);
end;

//------------------------------------------------------------------------------

function TAdvToolBarButtonActionLink.IsGroupIndexLinked: Boolean;
begin
  Result := (FClient is TAdvCustomToolBarButton) and
    (TAdvCustomToolBarButton(FClient).GroupIndex = (Action as TCustomAction).GroupIndex);
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarButtonActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then TAdvCustomToolBarButton(FClient).Down := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarButtonActionLink.SetGroupIndex(Value: Integer);
begin
  if IsGroupIndexLinked then TAdvCustomToolBarButton(FClient).GroupIndex := Value;
end;

{$ENDIF}

//------------------------------------------------------------------------------

{ TGradientBackground }

procedure TGradientBackground.Assign(Source: TPersistent);
begin
  if (Source is TGradientBackground) then
  begin
    FColor := (Source as TGradientBackground).Color;
    FColorTo := (Source as TGradientBackground).ColorTo;
    FDirection := (Source as TGradientBackground).Direction;
    FSteps := (Source as TGradientBackground).Steps;
  end;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.Changed;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

//------------------------------------------------------------------------------

constructor TGradientBackground.Create;
begin
  inherited;
  Color := clWhite;
  ColorTo := clBtnFace;
  Steps := 64;
  Direction := gdHorizontal;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.SetColor(const Value: TColor);
begin
  FColor := Value;
  Changed;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.SetColorTo(const Value: TColor);
begin
  FColorTo := Value;
  Changed;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.SetDirection(
  const Value: TGradientDirection);
begin
  FDirection := Value;
  Changed;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.SetSteps(const Value: Integer);
begin
  FSteps := Value;
  Changed;
end;


//------------------------------------------------------------------------------

{ TPersistence }

procedure TPersistence.Assign(Source: TPersistent);
begin
  if Source is TPersistence then
  begin
    FLocation:= TPersistence(Source).Location;
    FKey:= TPersistence(Source).Key;
    FSection:= TPersistence(Source).Section;
    FEnabled:= TPersistence(Source).Enabled;
    inherited Assign(Source);
  end;
end;

//------------------------------------------------------------------------------

constructor TPersistence.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner:= AOwner;
end;

//------------------------------------------------------------------------------

destructor TPersistence.Destroy;
begin

  inherited;
end;

//------------------------------------------------------------------------------

procedure TPersistence.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(self);
end;

//------------------------------------------------------------------------------

procedure TPersistence.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TPersistence.SetKey(const Value: string);
begin
  if FKey <> Value then
  begin
    FKey := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TPersistence.SetLocation(const Value: TPersistenceLocation);
begin
  if FLocation <> Value then
  begin
    FLocation := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

procedure TPersistence.SetSection(const Value: string);
begin
  if FSection <> Value then
  begin
    FSection := Value;
    Change;
  end;
end;

//------------------------------------------------------------------------------

{ TControlSelectorPanel }

constructor TControlSelectorPanel.Create(AOwner: TComponent);
begin
  inherited;
  FControlList := TDbgList.Create;
  FAddAndRemoveBtn := TSelectorItem.Create;
  FAddAndRemoveBtn.Caption := 'Add or Remove Buttons';
  FAddAndRemoveBtn.Width := 130;
  FItemColorHot := $00D2BDB6;
  FItemColorHotTo := clNone;
  FItemColorDown := clGray;
  FItemColorDownTo := clNone;
  FItemTextColorHot := clWhite;
  FItemTextColor := clBlack;
  FItemTextColorDown := clBlack;

  FSeparatorSize := 8;
  FShowAddAndRemoveBtn := True;

  FOptionsMenu := nil;
  FOptionsBtn := TSelectorItem.Create;
  FOptionsBtn.Caption := 'Options';
  FOptionsBtn.Width := 130;

  FTimer := TTimer.Create(self);
  FTimer.Interval := 1;
  FTimer.Enabled := false;
  FTimer.OnTimer := TimerOnTime;
end;

//------------------------------------------------------------------------------

destructor TControlSelectorPanel.destroy;
begin
  FControlList.Free;
  FAddAndRemoveBtn.Free;
  FOptionsBtn.Free;
  FTimer.Free;
  inherited;
end;

//------------------------------------------------------------------------------

function TControlSelectorPanel.AddControl(AControl: TControl): Integer;
begin
  Result := -1;
  if Assigned(AControl) then
  begin
    AControl.Parent := self;
    Result := FControlList.IndexOf(AControl);
    if Result < 0 then
    begin
      Result := FControlList.Add(AControl);
      //ArrangeControls;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.ArrangeControls;
var
  i, j, W, H, L, T: Integer;
begin
  W := FAddAndRemoveBtn.Width;
  for i := 0 to ControlList.Count -1 do
  begin
    if (TObject(ControlList[i]) is TControl) then
    begin
      W := Max(W, TControl(ControlList[i]).Width);
    end;
  end;

  L := MarginX;
  T := MarginY;
  j := 0;
  for i := 0 to ControlList.Count -1 do
  begin
    if (TObject(ControlList[i]) is TControl) then
    begin
      if TControl(ControlList[i]).Width > (W - L) then
      begin
        L := MarginX;
        T := T + j;
        j := 0;
      end;
      TControl(ControlList[i]).Left := L;
      TControl(ControlList[i]).Top := T;
      L := L + TControl(ControlList[i]).Width;
      j := Max(j, TControl(ControlList[i]).Height);
     { if L >= W then
      begin
        L := MarginX;
        T := j;
        j := 0;
      end; }
    end;
  end;
  //w := Max(w, );
  if FShowAddAndRemoveBtn then
    H := T + j + FAddAndRemoveBtn.Height
  else
    H := T + j;

  if ShowOptionsBtn then
    H := H + FOptionsBtn.Height;  

  if (ControlList.Count > 0) and (FShowAddAndRemoveBtn or ShowOptionsBtn)then
    H := H + FSeparatorSize;
    
  self.Width := w + MarginX*2;
  self.Height := H + MarginY;

  FAddAndRemoveBtn.BRect := Rect(0, 0, 0, 0);
  if FShowAddAndRemoveBtn then
    FAddAndRemoveBtn.BRect := Rect(MarginX, Height-MarginY - FAddAndRemoveBtn.Height, Width - MarginX, Height-MarginY);


  FOptionsBtn.BRect := Rect(0, 0, 0, 0);  
  if ShowOptionsBtn then
  begin
    if FShowAddAndRemoveBtn then
      FOptionsBtn.BRect := Rect(MarginX, FAddAndRemoveBtn.BRect.Top - FOptionsBtn.Height, Width - MarginX, FAddAndRemoveBtn.BRect.Top)
    else
      FOptionsBtn.BRect := Rect(MarginX, Height-MarginY - FOptionsBtn.Height, Width - MarginX, Height-MarginY);
  end;
  
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.CMControlChange(
  var Message: TCMControlChange);
begin
  inherited;
 {
  with Message do
    if Inserting then
      InsertControl(Control)
    else
      RemoveControl(Control);
   }
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if PtInRect(FAddAndRemoveBtn.BRect, Point(X, Y)) then
  begin
    if not FAddAndRemoveBtnHot and not (ssLeft in Shift) then
    begin
      FAddAndRemoveBtnHot := True;
      FAddAndRemoveBtnDown := True;
      Invalidate;

      ShowAddAndRemovePopup;
    end;
  end
  else if FAddAndRemoveBtnHot then
  begin
    FAddAndRemoveBtnHot := False;
    FAddAndRemoveBtnDown := False;
    Invalidate;
    //HideAddAndRemovePopup
  end;

  if PtInRect(FOptionsBtn.BRect, Point(X, Y)) then
  begin
    if not FOptionsBtnHot and not (ssLeft in Shift) then
    begin
      FOptionsBtnHot := True;
      FOptionsBtnDown := True;
      Invalidate;

      ShowOptionsBtnPopup;
    end;
  end
  else if FOptionsBtnHot then
  begin
    FOptionsBtnHot := False;
    FOptionsBtnDown := False;
    Invalidate;
    //HideOptionsBtnPopup
  end;

end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.RemoveControl(AControl: TControl);
begin
  if FControlList.IndexOf(AControl) >= 0 then
  begin
    FControlList.Remove(AControl);
    ArrangeControls;
  end;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.Paint;
var
  TextR: TRect;
  ArClr, Clr, ClrTo: TColor;
begin
  inherited;

  with Canvas do
  begin
    if FShowAddAndRemoveBtn or ShowOptionsBtn then
    begin
      if ShowOptionsBtn then
      begin
        pen.Color := clGray;
        MoveTo(0, FOptionsBtn.BRect.top - 4);
        LineTo(Width, FOptionsBtn.BRect.top - 4);
      end
      else
      begin
        pen.Color := clGray;
        MoveTo(0, FAddAndRemoveBtn.BRect.top - 4);
        LineTo(Width, FAddAndRemoveBtn.BRect.top - 4);
      end;
    end;

    if FShowAddAndRemoveBtn then
    begin
      {pen.Color := clGray;
      MoveTo(0, FAddAndRemoveBtn.BRect.top - 4);
      LineTo(Width, FAddAndRemoveBtn.BRect.top - 4);
      }
      Clr := clNone;
      ClrTo := clNone;
      if FAddAndRemoveBtnDown then
      begin
        Clr := ItemColorDown;
        ClrTo := ItemColorDownTo;
        Pen.Color := clBlack;
        Font.Color := ItemTextColorDown;
      end
      else if FAddAndRemoveBtnHot then
      begin
        Clr := ItemColorHot;
        ClrTo := ItemColorHotTo;
        Pen.Color := clBlack;
        Font.Color := ItemTextColorHot;
      end
      else
      begin
        Font.Color := ItemTextColor;
      end;

      if (Clr <> clNone) and (ClrTo <> clNone) then
      begin
        DrawGradient(Canvas, Clr, ClrTo, 40, FAddAndRemoveBtn.BRect, False);
        Brush.Style := bsClear;
        Pen.Color := clBlack;
        Rectangle(FAddAndRemoveBtn.BRect);
      end
      else if (Clr <> clNone) then
      begin
        Brush.Color := Clr;
        Rectangle(FAddAndRemoveBtn.BRect);
      end;

      TextR := FAddAndRemoveBtn.BRect;
      TextR.Right := TextR.Right - 8;
      Canvas.Brush.Style := bsClear;
      DrawText(Canvas.Handle, PChar(FAddAndRemoveBtn.Caption), -1, TextR, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

      ArClr := Font.Color;
      Pen.Color := ArClr;
      moveto(FAddAndRemoveBtn.BRect.Right - 9, FAddAndRemoveBtn.BRect.Bottom - 10);
      LineTo(FAddAndRemoveBtn.BRect.Right - 4, FAddAndRemoveBtn.BRect.Bottom - 10);
      moveto(FAddAndRemoveBtn.BRect.Right - 8, FAddAndRemoveBtn.BRect.Bottom - 9);
      LineTo(FAddAndRemoveBtn.BRect.Right - 5, FAddAndRemoveBtn.BRect.Bottom - 9);
      Pixels[FAddAndRemoveBtn.BRect.Right - 7, FAddAndRemoveBtn.BRect.Bottom - 8] := ArClr;

    end;

    if ShowOptionsBtn then
    begin
      Clr := clNone;
      ClrTo := clNone;
      if FOptionsBtnDown then
      begin
        Clr := ItemColorDown;
        ClrTo := ItemColorDownTo;
        Pen.Color := clBlack;
        Font.Color := ItemTextColorDown;
      end
      else if FOptionsBtnHot then
      begin
        Clr := ItemColorHot;
        ClrTo := ItemColorHotTo;
        Pen.Color := clBlack;
        Font.Color := ItemTextColorHot;
      end
      else
      begin
        Font.Color := ItemTextColor;
      end;

      if (Clr <> clNone) and (ClrTo <> clNone) then
      begin
        DrawGradient(Canvas, Clr, ClrTo, 40, FOptionsBtn.BRect, False);
        Brush.Style := bsClear;
        Pen.Color := clBlack;
        Rectangle(FOptionsBtn.BRect);
      end
      else if (Clr <> clNone) then
      begin
        Brush.Color := Clr;
        Rectangle(FOptionsBtn.BRect);
      end;

      TextR := FOptionsBtn.BRect;
      TextR.Right := TextR.Right - 8;
      Canvas.Brush.Style := bsClear;
      DrawText(Canvas.Handle, PChar(FOptionsBtn.Caption), -1, TextR, DT_SINGLELINE or DT_VCENTER or DT_CENTER);

      ArClr := Font.Color;
      Pen.Color := ArClr;
      moveto(FOptionsBtn.BRect.Right - 8, FOptionsBtn.BRect.Top + 7);
      LineTo(FOptionsBtn.BRect.Right - 8, FOptionsBtn.BRect.Top + 12);
      moveto(FOptionsBtn.BRect.Right - 7, FOptionsBtn.BRect.Top + 8);
      LineTo(FOptionsBtn.BRect.Right - 7, FOptionsBtn.BRect.Top + 11);
      Pixels[FOptionsBtn.BRect.Right - 6, FOptionsBtn.BRect.Top + 9] := ArClr;
    end;

  end;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetItemColorDown(const Value: TColor);
begin
  FItemColorDown := Value;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetItemColorHot(const Value: TColor);
begin
  FItemColorHot := Value;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.CMMouseLeave(var Message: TMessage);
begin
  if FAddAndRemoveBtnHot or FAddAndRemoveBtnDown then
  begin
    FAddAndRemoveBtnHot := False;
    FAddAndRemoveBtnDown := False;
    if Assigned(FAddAndRemovePopup) and FAddAndRemovePopup.Visible then
      FAddAndRemoveBtnDown := True;
    Invalidate;
  end;

  if FOptionsBtnHot or FOptionsBtnDown then
  begin
    FOptionsBtnHot := False;
    FOptionsBtnDown := False;
    //if Assigned(FOptionsMenu) and FOptionsBtnPopup.Visible then
      //FOptionsBtnDown := True;
    Invalidate;
  end;

end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetItemColorDownTo(const Value: TColor);
begin
  FItemColorDownTo := Value;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetItemColorHotTo(const Value: TColor);
begin
  FItemColorHotTo := Value;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetItemTextColor(const Value: TColor);
begin
  FItemTextColor := Value;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetItemTextColorHot(const Value: TColor);
begin
  FItemTextColorHot := Value;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetItemTextColorDown(const Value: TColor);
begin
  FItemTextColorDown := Value;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.ShowAddAndRemovePopup;
var
  I: Integer;
  P : TPoint;
  R: TRect;
begin
  if Assigned(FAddAndRemovePopup) and FAddAndRemovePopup.Visible then
    Exit;

  if not FShowAddAndRemoveBtn then
    Exit;

  if not Assigned(FAddAndRemovePopup) then
  begin
    FAddAndRemovePopup:= TATBPopupWindow.CreateNew(self{TOptionSelectorWindow(Parent).AdvToolBar});
    FAddAndRemovePopup.CreateItems;
    FAddAndRemovePopup.BorderIcons := [];
    FAddAndRemovePopup.BorderStyle := bsNone;
    FAddAndRemovePopup.Ctl3D := false;
    FAddAndRemovePopup.FormStyle := fsStayOnTop;
    FAddAndRemovePopup.Visible := False;
    FAddAndRemovePopup.Width := 10;
    FAddAndRemovePopup.Height := 10;
    FAddAndRemovePopup.AutoScroll := False;
    FAddAndRemovePopup.BorderWidth := 0;
    FAddAndRemovePopup.AdvToolBar := TOptionSelectorWindow(Parent).AdvToolBar;
    FAddAndRemovePopup.OnHide := OnAddAndRemoveWindowHide;
    FAddAndRemovePopup.OnDeActivateHide := OnAARWindowDeActivateHide;
  end;

  FAddAndRemovePopup.PopupPanel.Items.Clear;
  FAddAndRemovePopup.PopupPanel.ShowIconBar := True;
  FAddAndRemovePopup.PopupPanel.AdvMenuStyler := TOptionSelectorWindow(Parent).AdvToolBar.FCurrentToolBarStyler.CurrentAdvMenuStyler;

  if Assigned(TOptionSelectorWindow(Parent).AdvToolBar) then
  begin
    with FAddAndRemovePopup.PopupPanel.Items.Add do
    begin
      Caption := TOptionSelectorWindow(Parent).AdvToolBar.Caption;
      for I:= 0 to TOptionSelectorWindow(Parent).AdvToolBar.FATBControls.Count -1 do
      begin
        if not (TObject(TOptionSelectorWindow(Parent).AdvToolBar.FATBControls[i]) is TAdvToolBarSeparator) then
        with Add do
        begin
          AutoCheck := True;
          Checked := TControl(TOptionSelectorWindow(Parent).AdvToolBar.FATBControls[I]).Visible;
          Objects := TControl(TOptionSelectorWindow(Parent).AdvToolBar.FATBControls[I]);
          if TControl(TOptionSelectorWindow(Parent).AdvToolBar.FATBControls[I]) is TAdvCustomToolBarButton then
            Caption := TAdvCustomToolBarButton(TOptionSelectorWindow(Parent).AdvToolBar.FATBControls[I]).Caption
          else
            Caption := TControl(TOptionSelectorWindow(Parent).AdvToolBar.FATBControls[I]).Name;
        end;
      end;
    end;
  end;
  FAddAndRemovePopup.PopupPanel.ArrangeItems;
  FAddAndRemovePopup.SetWindowSize;

  TOptionSelectorWindow(Parent).HideOnDeActivate := False;
  // Positioning Window

  //P := ClientToScreen(Point(Left, Top));

{$IFNDEF TMSDOTNET}
  SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
{$ENDIF}
{$IFDEF TMSDOTNET}
  SystemParametersInfo(SPI_GETWORKAREA, 0, R, 0);
{$ENDIF}

  P := ClientToScreen(Point(FAddAndRemoveBtn.BRect.Right, FAddAndRemoveBtn.BRect.Top));

  if R.Bottom < (P.Y + FAddAndRemovePopup.Height + 2) then
    P.Y := P.Y - ((P.Y + FAddAndRemovePopup.Height + 2) - R.Bottom);

  if (R.Right < P.X + FAddAndRemovePopup.Width) then
    P.X := ClientToScreen(Point(FAddAndRemoveBtn.BRect.Left, FAddAndRemoveBtn.BRect.Top)).X - FAddAndRemovePopup.Width;

  FAddAndRemovePopup.Left := P.X;
  FAddAndRemovePopup.Top := P.Y;
  FAddAndRemovePopup.Visible := True;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.HideAddAndRemovePopup;
begin
  if Assigned(FAddAndRemovePopup) and FAddAndRemovePopup.Visible then
  begin
    FAddAndRemovePopup.PopupPanel.BeforeHide;
    FAddAndRemovePopup.Hide;
  end;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.OnAddAndRemoveWindowHide(Sender: TObject);
begin
  if Assigned(Parent) and (Parent is TOptionSelectorWindow) then
    TOptionSelectorWindow(Parent).HideOnDeActivate := True;

  FAddAndRemoveBtnDown := False;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.OnAARWindowDeActivateHide(Sender: TObject);
begin
  TOptionSelectorWindow(Parent).Hide;
  FAddAndRemoveBtnDown := False;
  FAddAndRemoveBtnHot := False;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetShowAddAndRemoveBtn(
  const Value: Boolean);
begin
  if FShowAddAndRemoveBtn <> Value then
  begin
    FShowAddAndRemoveBtn := Value;
  end;
end;

//------------------------------------------------------------------------------

function TControlSelectorPanel.IsEmpty: Boolean;
begin
  Result := (FControlList.Count <= 0) and not FShowAddAndRemoveBtn and not ShowOptionsBtn;
end;

//------------------------------------------------------------------------------

function TControlSelectorPanel.GetShowOptionsBtn: Boolean;
begin
  Result := Assigned(FOptionsMenu);
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetOptionsMenu(const Value: TPopupMenu);
begin
  FOptionsMenu := Value;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.ShowOptionsBtnPopup;
var
  APoint, cp: TPoint;
  MenuWidth, J, K: Integer;
  MeasureItemStruct: TMeasureItemStruct;
  R: TRect;
begin
  if Assigned(FOptionsMenu) then
  begin
    if ShowAddAndRemoveBtn then
    begin
      HideAddAndRemovePopup;
      FTimer.Enabled := True;
    end;

    // correct popup point coordinates
    MenuWidth := 0;
    j := 0;
    for k := 0 to FOptionsMenu.Items.Count - 1 do
    begin
      if MenuWidth < Canvas.TextWidth(FOptionsMenu.Items[k].Caption) then
      begin
        MenuWidth := Canvas.TextWidth(FOptionsMenu.Items[k].Caption);
        j := k;
      end;
    end;

    if FOptionsMenu.Items.Count > 0 then
    begin
      with MeasureItemStruct do
      begin
        CtlType := ODT_MENU;
        itemID := FOptionsMenu.Items[j].Command;
        itemWidth := 10;
        itemHeight := 10;
      end;
      SendMessage(PopupList.Window, WM_MEASUREITEM, 0, lParam(@MeasureItemStruct));
      MenuWidth := MeasureItemStruct.itemWidth; //+ TriangleSize;
    end;

    APoint := Point(FOptionsBtn.BRect.Right, FOptionsBtn.BRect.Top);
    {$IFNDEF TMSDOTNET}
      SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
    {$ENDIF}
    {$IFDEF TMSDOTNET}
      SystemParametersInfo(SPI_GETWORKAREA, 0, R, 0);
    {$ENDIF}

    APoint := ClientToScreen(APoint);
    if (APoint.X + MenuWidth > R.Right) then
      APoint := ClientToScreen(Point(FOptionsBtn.BRect.Left - MenuWidth, FOptionsBtn.BRect.top));
      
   (* if (GetSystemMetrics(SM_CYMENU) * FOptionsMenu.Items.Count) + APoint.Y + 10 >
    {$IFDEF DELPHI6_LVL}
      Screen.MonitorFromPoint(APoint).Height then
    {$ELSE}
      Screen.Height then
    {$ENDIF}
      //Dec(APoint.Y, Button.Height);
      Dec(APoint.Y, (GetSystemMetrics(SM_CYMENU) * FOptionsMenu.Items.Count) + FOptionsBtn.Height + 4);
    *)

    FOptionsMenu.Popup(APoint.X, APoint.Y);
    FOptionsBtnHot := False;
    FOptionsBtnDown := False;
    FTimer.Enabled := False;
    if ShowAddAndRemoveBtn then
    begin
      GetCursorPos(CP);
      CP := ScreenToClient(CP);
      if not PtInRect(FAddAndRemoveBtn.BRect, CP) then
        TOptionSelectorWindow(Parent).Hide;
    end
    else
    begin
      GetCursorPos(CP);
      CP := ScreenToClient(CP);
      if not PtInRect(ClientRect, CP) then
        TOptionSelectorWindow(Parent).Hide;
    end;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.HideOptionsBtnPopup;
begin

end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.TimerOnTime(Sender: TObject);
var
 cp: TPoint;
begin
  GetCursorPos(CP);
  CP := ScreenToClient(CP);
  if PtInRect(FAddAndRemoveBtn.BRect, CP) then
  begin
    FTimer.Enabled := False;
    PostMessage(Handle, WM_LBUTTONDOWN, MK_LBUTTON, Longint(PointToSmallPoint(ScreenToClient(Cp))));
    PostMessage(Handle, WM_LBUTTONUP, MK_LBUTTON, Longint(PointToSmallPoint(ScreenToClient(Cp))));
    //mouse_event( MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0 );
    //mouse_event( MOUSEEVENTF_LEFTUP, 0, 0, 0, 0 );
  end;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetTextAutoOptionMenu(const Value: String);
begin
  if FAddAndRemoveBtn.Caption <> Value then
  begin
    FAddAndRemoveBtn.Caption := Value;
    ReSetButtonSize;
  end;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.SetTextOptionMenu(const Value: String);
begin
  if FOptionsBtn.Caption <> Value then
  begin
    FOptionsBtn.Caption := Value;
    ReSetButtonSize;
  end;
end;

//------------------------------------------------------------------------------

procedure TControlSelectorPanel.ReSetButtonSize;
var
  W: Integer;
  R: TRect;
begin
  W := 130;

  if ShowAddAndRemoveBtn then
  begin
    R := Rect(0,0,1000,100);
    DrawText(Canvas.Handle,PChar(FAddAndRemoveBtn.Caption),Length(FAddAndRemoveBtn.Caption), R, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
    W := Max(W, R.Right + 15);
  end;

  if ShowOptionsBtn then
  begin
    R := Rect(0,0,1000,100);
    DrawText(Canvas.Handle,PChar(FOptionsBtn.Caption),Length(FOptionsBtn.Caption), R, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
    W := Max(W, R.Right + 15);
  end;

  FAddAndRemoveBtn.Width := W;
  FOptionsBtn.Width := W;
end;

//------------------------------------------------------------------------------

function TControlSelectorPanel.GetTextAutoOptionMenu: String;
begin
  Result := FAddAndRemoveBtn.Caption;
end;

//------------------------------------------------------------------------------

function TControlSelectorPanel.GetTextOptionMenu: String;
begin
  Result := FOptionsBtn.Caption;
end;

//------------------------------------------------------------------------------

{ TSelectorItem }

constructor TSelectorItem.Create;
begin
  inherited;
  FHeight := DEFAULT_ITEMHEIGHT;
  FWidth := 30;
  FCaption := '';
end;

//------------------------------------------------------------------------------

destructor TSelectorItem.destroy;
begin

  inherited;
end;

//------------------------------------------------------------------------------

procedure TSelectorItem.SetCaption(const Value: TCaption);
begin
  FCaption := Value;
end;

//------------------------------------------------------------------------------

procedure TSelectorItem.SetHeight(const Value: Integer);
begin
  FHeight := Value;
end;

//------------------------------------------------------------------------------

procedure TSelectorItem.SetWidth(const Value: Integer);
begin
  FWidth := Value;
end;

//------------------------------------------------------------------------------

{ TATBPopupWindow }

constructor TATBPopupWindow.Create(AOwner: TComponent);
begin
  inherited;
  FHideOnDeActivate := true;
  FHideTimer := TTimer.Create(self);
  FHideTimer.Interval := 1;
  FHideTimer.Enabled := false;
  FHideTimer.OnTimer := HideTimerOnTime;
end;

//------------------------------------------------------------------------------

constructor TATBPopupWindow.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited;
  FOwner := AOwner;
  FHideOnDeActivate := true;
  FHideTimer := TTimer.Create(self);
  FHideTimer.Interval := 1;
  FHideTimer.Enabled := false;
  FHideTimer.OnTimer := HideTimerOnTime;

  CreatePopupPanel;
end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.CreatePopupPanel;
begin
  FPopupPanel := TATBPopupPanel.Create(self);
  FPopupPanel.Parent := Self;
end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.CreateItems;
begin
  FItems := TATBMenuItem.Create;
  FPopupPanel.Items := FItems;
end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited CreateParams(Params);
  //Params.Style := Params.Style - WS_BORDER;
  {
  if (Win32Platform = VER_PLATFORM_WIN32_NT) and
     ((Win32MajorVersion > 5) or
      ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1))) then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;

  Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST; }
end;

//------------------------------------------------------------------------------

destructor TATBPopupWindow.Destroy;
begin
  FHideTimer.Free;
  if Assigned(FItems) then
    FItems.Free;
  inherited;
end;

//------------------------------------------------------------------------------

function TATBPopupWindow.GetParentWnd: HWnd;
var
  Last, P: HWnd;
begin
  P := GetParent((Owner as TWinControl).Handle);
  if Assigned(AdvToolBar) then
    P := GetParent(AdvToolBar.Handle);   // Set to avoid DeActivate of Form

  Last := P;
  while P <> 0 do
  begin
    Last := P;
    P := GetParent(P);
  end;
  Result := Last;
end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.HideTimerOnTime(Sender: TObject);
begin
 { if Assigned(FPopupPanel) then
    FPopupPanel.BeforeHide;
  }
  Hide;
  FHideTimer.Enabled := false;
  if Assigned(OnDeActivateHide) then
    FOnDeActivateHide(Self);
end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.Paint;
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.SetPopupPanel(const Value: TATBPopupPanel);
begin
  //FPopupPanel := Value;
end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.SetWindowSize;
begin
  if Assigned(FPopupPanel) then
  begin
    Height := FPopupPanel.GetVisibleHeight;
    Width := FPopupPanel.Width;
  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.WMActivate(var Message: TWMActivate);
begin
  if Message.Active = integer(False) then
  begin
    if HideOnDeActivate and Visible then
    begin
      FHideTimer.Enabled := true;
    end;
  end
  else if Assigned(FPopupPanel) then
  begin
    FPopupPanel.SetFocus;
    SendMessage(getParentWnd, WM_NCACTIVATE, 1, 0);
  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.WMNCHitTest(var Message: TWMNCHitTest);
var
  pt: TPoint;
begin
  // Make the hint sizable
  pt := ScreenToClient(Point(Message.XPos, Message.YPos));

  if (pt.X > Width - 10) and (pt.Y > Height - 10) then
    message.Result := HTBOTTOMRIGHT
end;

//------------------------------------------------------------------------------

procedure TATBPopupWindow.Hide;
begin
  if Assigned(FPopupPanel) then
    FPopupPanel.BeforeHide;

  inherited Hide;
end;

//------------------------------------------------------------------------------

{ TATBCustomPopupPanel }

constructor TATBCustomPopupPanel.Create(AOwner: TComponent);
begin
  inherited;
  FOwner := AOwner;
  BevelOuter := bvNone;
  BevelWidth := 1;
  Color := $00F7F8F9;
  FColorTo := clNone;
  FWindowBorderColor := clGray;
  FGradientDirection := gdHorizontal;
  FMarginX := 2;
  FMarginY := 2;
end;

//------------------------------------------------------------------------------

function TATBCustomPopupPanel.GetVisibleHeight: integer;
begin
  Result := Height;
end;

//------------------------------------------------------------------------------

procedure TATBCustomPopupPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TATBCustomPopupPanel.Paint;
var
  R: TRect;
begin
  inherited;
  R := Rect(0, 0, Width, Height);

  if ColorTo <> clNone then
    DrawGradient(Canvas, Color, ColorTo, 40, R, FGradientDirection = gdHorizontal);

  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := FWindowBorderColor;

  Canvas.MoveTo(0, 0);
  Canvas.LineTo(0, Height);

  //if TSelectorDropDownWindow(FOwner).ShowFullBorder then
  //begin
  Canvas.MoveTo(0, 0);
  Canvas.LineTo(Width - 1, 0);
  Canvas.MoveTo(0, Height - 1);
  Canvas.LineTo(Width - 1, Height - 1);
{  end
  else
  begin

  end;
  }
  Canvas.MoveTo(Width - 1, Height);
  Canvas.LineTo(Width - 1, {0} -1);
end;

//------------------------------------------------------------------------------

procedure TATBCustomPopupPanel.SetColorTo(const Value: TColor);
begin
  FColorTo := Value;
end;

//------------------------------------------------------------------------------

procedure TATBCustomPopupPanel.SetGradientDirection(
  const Value: TGradientDirection);
begin
  FGradientDirection := Value;
end;

//------------------------------------------------------------------------------

procedure TATBCustomPopupPanel.SetMarginX(const Value: Integer);
begin
  FMarginX := Value;
end;

//------------------------------------------------------------------------------

procedure TATBCustomPopupPanel.SetMarginY(const Value: Integer);
begin
  FMarginY := Value;
end;

//------------------------------------------------------------------------------

procedure TATBCustomPopupPanel.SetWindowBorderColor(const Value: TColor);
begin
  FWindowBorderColor := Value;
end;

//------------------------------------------------------------------------------

{ TATBMenuItem }

constructor TATBMenuItem.Create;
begin
  inherited;
  FItems := TDbgList.Create;
  FObjects := nil;
  FEnabled := True;
  FVisible := True;
end;

//------------------------------------------------------------------------------

destructor TATBMenuItem.destroy;
  procedure FreeAllItems(AItem: TATBMenuItem);
  var
    I: Integer;
  begin
    for I:= 0 to AItem.Count-1 do
    begin
      FreeAllItems(AItem.Items[I]);
    end;
    AItem.Free;
  end;

var
  I: Integer;
begin
  for I:= 0 to FItems.Count-1 do
    TATBMenuItem(FItems.Items[I]).Free;
    //FreeAllItems(FItems.Items[I]);

  FItems.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.Clear;
{  procedure FreeAllItems(AItem: TATBMenuItem);
  var
    I: Integer;
  begin
    for I:= 0 to AItem.Count-1 do
    begin
      FreeAllItems(AItem.Items[I]);
    end;
    AItem.Free;
  end;
}
var
  I: Integer;
begin
  for I:= 0 to FItems.Count-1 do
    TATBMenuItem(FItems.Items[I]).Free;
    //FreeAllItems(FItems.Items[I]);
  FItems.Clear;
end;

//------------------------------------------------------------------------------

function TATBMenuItem.GetCount: integer;
begin
  Result := FItems.Count;
end;

//------------------------------------------------------------------------------

function TATBMenuItem.GetItem(Index: Integer): TATBMenuItem;
begin
  Result := FItems.Items[Index];
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.SetCaption(const Value: TCaption);
begin
  FCaption := Value;
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.SetChecked(const Value: Boolean);
begin
  FChecked := Value;
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.SetFParentItem(const Value: TATBMenuItem);
begin
  FParentItem := Value;
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.SetHeight(const Value: Integer);
begin
  FHeight := Value;
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.SetWidth(const Value: Integer);
begin
  FWidth := Value;
end;

//------------------------------------------------------------------------------

function TATBMenuItem.HasChildren: Boolean;
begin
  Result := FItems.Count > 0;
end;

//------------------------------------------------------------------------------

function TATBMenuItem.Add: TATBMenuItem;
begin
  Result := TATBMenuItem.Create;
  Result.ParentItem := Self;
  FItems.Add(Result);
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.SetAutoCheck(const Value: Boolean);
begin
  FAutoCheck := Value;
end;

//------------------------------------------------------------------------------

procedure TATBMenuItem.RemoveItem(ItemIndex: Integer);
begin

end;

//------------------------------------------------------------------------------

{ TATBPopupPanel }

constructor TATBPopupPanel.Create(AOwner: TComponent);
begin
  inherited;
  FItemHeight := 24;
  ImageBarSize := 20;
  FImageBarColor := clGray;
  FImageBarColorTo := clNone;
  FHotItem := -1;
  FPopupItem := -1;
end;

//------------------------------------------------------------------------------

destructor TATBPopupPanel.destroy;
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.ArrangeItems;
var
  i, L, T, W: integer;
begin
  L := MarginX;
  T := MarginY;

  w := 0;
  for i:= 0 to FItems.Count-1 do
  begin
    w := max(w, Canvas.TextWidth(FItems.Items[i].Caption)+ {4}7);
    if FItems.Items[i].HasChildren then
      inc(w, 30);

    if not ShowImageBar and (FItems.Items[i].Objects <> nil) then
    begin
      if (TControl(FItems.Items[i].Objects) is TAdvCustomToolBarButton) then
      begin
        if (TAdvCustomToolBarButton(FItems.Items[i].Objects).ImageIndex >= 0) or not (TAdvCustomToolBarButton(FItems.Items[i].Objects).Glyph.Empty) then
          ShowImageBar := True;
      end;
    end;
  end;

  if Assigned(AdvMenuStyler) then
    if ShowIconBar then
      W := w + AdvMenuStyler.IconBar.Size;

  if ShowImageBar then
    w := w + ImageBarSize;

  w := Max(w, MIN_POPUPWINDOWSIZE);
  
  for i:= 0 to FItems.Count-1 do
  begin
    FItems.Items[i].BoundRect := Rect(L, T, L + W, T + ItemHeight);
    inc(T, ItemHeight + MarginY);
  end;

  Width := w + MarginX * 2;
  Height := T;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if FPopupItem < 0 then
    HotItem := -1;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
begin
  inherited;
  i := IndexOfItemAt(X, Y);
  if (i >= 0) then
  begin
    if (i <> HotItem) and not (ssLeft in Shift) then
    begin
      HotItem := i;
      ShowItemPopup;
    end
    else
    begin
      //ShowItemPopup;
    end;

  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  i: Integer;
begin
  inherited;
  i := IndexOfItemAt(X, Y);
  if (i >= 0) then
  begin
    ItemClick(i);
  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.Paint;
var
  R, R2: TRect;
begin
  inherited;

  R := ClientRect;
  R := Rect(R.Left + MarginX, R.Top + MarginY, R.Right - MarginX, R.Bottom - MarginY);
  R2 := R;
  R2.Right := R.Left;

  if Assigned(AdvMenuStyler) and ShowIconBar then
  begin
    R2.Right := R2.Right + AdvMenuStyler.IconBar.Size;
    
    if ShowImageBar then
      R2.Right := R2.Right + ImageBarSize;
      
    with AdvMenuStyler.IconBar do
    begin
      if (AdvMenuStyler.IconBar.Color <> clNone) and (AdvMenuStyler.IconBar.ColorTo <> clNone) then
        DrawGradient(Canvas, AdvMenuStyler.IconBar.Color, AdvMenuStyler.IconBar.ColorTo, 40, R2, True)
      else
      begin
        Canvas.Brush.Color := AdvMenuStyler.IconBar.Color;
        Canvas.Pen.Color := AdvMenuStyler.IconBar.Color;
        Canvas.Rectangle(R2);
      end;
      // ToDO:
      ImageBarColor := AdvMenuStyler.IconBar.ColorTo;
    end;
  end;

  if ShowImageBar and not ShowIconBar then
  begin
    ImageBarColor := AdvMenuStyler.IconBar.Color;
    ImageBarColorTo := AdvMenuStyler.IconBar.ColorTo;

    R2.Right := R2.Right + ImageBarSize;

    if (ImageBarColor <> clNone) and (ImageBarColorTo <> clNone) then
      DrawGradient(Canvas, ImageBarColor, ImageBarColorTo, 40, R2, True)
    else
    begin
      Canvas.Brush.Color := ImageBarColor;
      Canvas.Pen.Color := ImageBarColor;
      Canvas.Rectangle(R2);
    end;
  end;

  DrawAllItems;  
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.SetAdvMenuStyler(
  const Value: TCustomAdvMenuStyler);
begin
  FAdvMenuStyler := Value;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.SetItems(const Value: TATBMenuItem);
begin
  FItems := Value;
  ArrangeItems;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.SetItemHeight(const Value: Integer);
begin
  FItemHeight := Value;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.SetHotItem(const Value: Integer);
var
  I: Integer;
begin
  if FHotItem <> Value then
  begin
    if (FHotItem >= 0) then
    begin
      I := FHotItem;
      HideItemPopup;
      FHotItem := -1;
      InvalidateItem(I);
    end;
    FHotItem := Value;
    if FHotItem >= 0 then
      InvalidateItem(FHotItem);
  end;
end;

//------------------------------------------------------------------------------

function TATBPopupPanel.IndexOfItemAt(X, Y: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;

  for i:= 0 to FItems.Count-1 do
  begin
    if PtInRect(FItems.Items[i].BoundRect, Point(X, Y)) then
    begin
      Result := i;
      Break;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.ToggleCheck(ItemIndex: Integer);
begin
  if (ItemIndex >= 0) and (ItemIndex < FItems.Count) then
  begin
    if FItems.Items[ItemIndex].Objects <> nil then
    begin
      TControl(FItems.Items[ItemIndex].Objects).Visible := not TControl(FItems.Items[ItemIndex].Objects).Visible;
      FItems.Items[ItemIndex].Checked := TControl(FItems.Items[ItemIndex].Objects).Visible;
      InvalidateItem(ItemIndex);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.SetShowImageBar(const Value: Boolean);
begin
  FShowImageBar := Value;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.DrawAllItems;
var
  i: Integer;
begin
  for I:= 0 to FItems.Count-1 do
    DrawItem(I);
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.DrawItem(ItemIndex: Integer);
var
  CapR, R, R2: TRect;

  procedure DrawCheck(R: TRect);
  var
    Glyph: TBitMap;
  begin
    if FItems.Items[ItemIndex].Checked then
    begin
      if FItems.Items[ItemIndex].Enabled then
      begin
        Glyph := TBitmap.Create;
        try
          begin
            if (HotItem = ItemIndex) then
              with AdvMenuStyler.SelectedItem do
              begin
                if (CheckColorTo <> clNone) then
                  DrawGradient(Canvas, CheckColor, CheckColorTo, 16, R, True)
                else if CheckColor <> clNone then
                begin
                  Canvas.Brush.Color := CheckColor;
                  Canvas.Pen.Color := CheckColor;
                  Canvas.Rectangle(R);
                end;
                if BorderColor <> clNone then
                begin
                  Canvas.Brush.Color := BorderColor;
                  Canvas.FrameRect(R);
                end;
              end
            else
              with AdvMenuStyler.IconBar do
              begin
                if (CheckColorTo <> clNone) then
                  DrawGradient(Canvas, CheckColor, CheckColorTo, 16, R, True)
                else if CheckColor <> clNone then
                begin
                  Canvas.Brush.Color := CheckColor;
                  Canvas.Pen.Color := CheckColor;
                  Canvas.Rectangle(R);
                end;
                if CheckBorder <> clNone then
                begin
                  Canvas.Brush.Color := CheckBorder;
                  Canvas.FrameRect(R);
                end;
              end;
            Glyph.Assign(AdvMenuStyler.Glyphs.Check);
          end;

          // restore selection rectangle
          if (HotItem = ItemIndex) then
          begin
            Canvas.Brush.Color := AdvMenuStyler.SelectedItem.BorderColor;
            Canvas.FrameRect(R);
          end;

          //OldFontColor := Canvas.Font.Color;
          //Canvas.Font.Color := clBtnText;
          Canvas.Draw(R.Left + ((R.Right-R.Left) - Glyph.Width) div 2, R.Top + ((R.Bottom - R.Top) - Glyph.Height) div 2, Glyph);
          //Canvas.Font.Color := OldFontColor;
        finally
          FreeAndNil(Glyph);
        end;

      end
      else
      begin

      end;
    end;
  end;

  procedure DrawImage(R: TRect);
  var
    tbmp: TBitMap;
    imgidx: Integer;
    images: TCustomImageList;
  begin
    if TControl(FItems.Items[ItemIndex].Objects) is TAdvCustomToolBarButton then
    begin
      images := nil;
      if (Parent is TATBPopupWindow) and Assigned(TATBPopupWindow(Parent).AdvToolBar) and Assigned(TATBPopupWindow(Parent).AdvToolBar.Images) then
        images := TATBPopupWindow(Parent).AdvToolBar.Images;

      imgidx := TAdvCustomToolBarButton(FItems.Items[ItemIndex].Objects).ImageIndex;

      if (TAdvCustomToolBarButton(FItems.Items[ItemIndex].Objects).Action is TCustomAction) then
      begin
        if Assigned((TAdvCustomToolBarButton(FItems.Items[ItemIndex].Objects).Action as TCustomAction).ActionList) then
        begin
          if Assigned((TAdvCustomToolBarButton(FItems.Items[ItemIndex].Objects).Action as TCustomAction).ActionList.Images) then
            images := (TAdvCustomToolBarButton(FItems.Items[ItemIndex].Objects).Action as TCustomAction).ActionList.Images;

          imgidx := (TAdvCustomToolBarButton(FItems.Items[ItemIndex].Objects).Action as TCustomAction).ImageIndex;
        end;
      end;

      if (imgidx >= 0) and (images <> nil) then
      begin
        tbmp := TBitmap.Create;
        tbmp.Width := images.Width;
        tbmp.Height := images.Height;
        tbmp.Transparent := true;
        if (tbmp.Width <= R.Right - R.Left) and (tbmp.Height <= R.Bottom - R.Top) then
        begin
          Images.Draw(tbmp.Canvas, 0, 0, ImgIdx);
          Canvas.Draw(R.left+(R.Right-R.Left-tbmp.width) div 2 , R.Top+(R.Bottom-R.Top-tbmp.height) div 2, tbmp);
        end
        else
        begin
          Images.Draw(tbmp.Canvas, 0, 0, ImgIdx);
          Canvas.StretchDraw(R, tbmp);
        end;
        tbmp.Free;
      end
      else if not TAdvCustomToolBarButton(FItems.Items[ItemIndex].Objects).Glyph.Empty then
      begin
        tbmp := TAdvCustomToolBarButton(FItems.Items[ItemIndex].Objects).Glyph;
        if (tbmp.Width <= R.Right - R.Left) and (tbmp.Height <= R.Bottom - R.Top) then
        begin
          Canvas.Draw(R.left+(R.Right-R.Left-tbmp.width) div 2 , R.Top+(R.Bottom-R.Top-tbmp.height) div 2, tbmp);
        end
        else
          Canvas.StretchDraw(R, TAdvCustomToolBarButton(FItems.Items[ItemIndex].Objects).Glyph);
      end;
    end;
  end;

  procedure DrawSubmenuTriangle(ARect: TRect);
  var
    R: TRect;
    DY: Integer;
  begin
    DY:= (ARect.Top + ARect.Bottom - 5) div 2;
    // Default submenu triangle has 4x7 size
    //if Alignment <> paRight then
      R := Rect(ARect.Right - 8, DY, ARect.Right - 5, DY + 6);
    //else
      //R := Rect(ARect.Left + 5, DY, ARect.Left + 8, DY + 6);

    with AdvMenuStyler.Glyphs do
    begin
      CenterRect(R, SubMenu.Width, SubMenu.Height);
      //OldFontColor := ACanvas.Font.Color;
      //ACanvas.Font.Color := TriangleColor;
      Canvas.Draw(R.Left, R.Top, AdvMenuStyler.Glyphs.SubMenu);
      //Canvas.Font.Color := OldFontColor;
     end;
  end;

begin
  R := FItems.Items[ItemIndex].BoundRect;
  CapR := R;
  if HotItem = ItemIndex then
  begin
    with AdvMenuStyler.SelectedItem do
    begin
      if (Color <> clNone) and (ColorTo <> clNone) then
        DrawGradient(Canvas, Color, ColorTo, 40, R, AdvMenuStyler.SelectedItem.GradientDirection = AdvMenus.gdHorizontal)
      else
      begin
        Canvas.Brush.Color := Color;
        Canvas.Pen.Color := Color;
        Canvas.Rectangle(R);
      end;
      if AdvMenuStyler.SelectedItem.BorderColor <> clNone then
      begin
        Canvas.Brush.Style := bsClear;
        Canvas.Pen.Color := AdvMenuStyler.SelectedItem.BorderColor;
        Canvas.Rectangle(R);
      end;
    end;
  end;

  if ShowIconBar then
  begin
    R.Right := R.Left + AdvMenuStyler.IconBar.Size;
    CapR.Left := R.Right;
    R2 := Rect(R.Left+1, R.Top+1, R.Right-2, R.Bottom-1);
    if FItems.Items[ItemIndex].AutoCheck then
    begin
      DrawCheck(R2);
    end
    else if not ShowImageBar then
    begin
      DrawImage(R);
    end;
  end;

  if ShowImageBar then
  begin
    R.Left := R.Right;
    R.Right := R.Left + ImageBarSize;
    CapR.Left := R.Right;
    DrawImage(R);
  end;

  // Draw Caption
  CapR.Left := CapR.Left + 4{Text Margin};
  //R.Right := FItems.Items[ItemIndex].BoundRect.Right;
  Canvas.Brush.Style := bsClear;
  DrawText(Canvas.Handle, PChar(FItems.Items[ItemIndex].Caption), -1, CapR, DT_SINGLELINE or DT_VCENTER or DT_LEFT);

  if FItems.Items[ItemIndex].HasChildren then
    DrawSubmenuTriangle(FItems.Items[ItemIndex].BoundRect);
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.InvalidateItem(ItemIndex: Integer);
var
  R: TRect;
begin
  if (ItemIndex >= 0) and (ItemIndex < FItems.Count) then
  begin
    R := FItems.Items[ItemIndex].BoundRect;
    InvalidateRect(Handle, @R, True);
  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.SetShowIconBar(const Value: Boolean);
begin
  FShowIconBar := Value;
end;

//------------------------------------------------------------------------------

function TATBPopupPanel.IsAnyAutoCheckItem: Boolean;
begin
  Result := True;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.SetImageBarSize(const Value: Integer);
begin
  FImageBarSize := Value;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.ShowItemPopup;
var
  P : TPoint;
  R: TRect;
begin
  if (FPopupItem <> HotItem) and (HotItem >= 0) then
  begin
    HideItemPopup;
    if (HotItem >= 0) and FItems.Items[HotItem].HasChildren then
    begin
      if not Assigned(FItemPopup) then
      begin
        FItemPopup:= TATBPopupWindow.CreateNew(self{TOptionSelectorWindow(Parent).AdvToolBar});
        FItemPopup.BorderIcons := [];
        FItemPopup.BorderStyle := bsNone;
        FItemPopup.Ctl3D := false;
        FItemPopup.FormStyle := fsStayOnTop;
        FItemPopup.Visible := False;
        FItemPopup.Width := 10;
        FItemPopup.Height := 10;
        FItemPopup.AutoScroll := False;
        FItemPopup.BorderWidth := 0;
        FItemPopup.AdvToolBar := TATBPopupWindow(Parent).AdvToolBar;
        FItemPopup.OnHide := OnItemPopupHide;
        FItemPopup.OnDeActivateHide := OnItemPopupDeActivateHide;
      end;

      //FItemPopup.PopupPanel.Items.Clear;
      FItemPopup.PopupPanel.Items := FItems.Items[HotItem];
      FItemPopup.PopupPanel.ShowIconBar := True;
      FItemPopup.PopupPanel.AdvMenuStyler := AdvMenuStyler;

      FPopupItem := FHotItem;

      FItemPopup.PopupPanel.ArrangeItems;
      FItemPopup.SetWindowSize;

      TOptionSelectorWindow(Parent).HideOnDeActivate := False;

      // Positioning Window

      //P := ClientToScreen(Point(Left, Top));

    {$IFNDEF TMSDOTNET}
      SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
    {$ENDIF}
    {$IFDEF TMSDOTNET}
      SystemParametersInfo(SPI_GETWORKAREA, 0, R, 0);
    {$ENDIF}

      P := ClientToScreen(Point(FItems.Items[HotItem].BoundRect.Right+2, FItems.Items[HotItem].BoundRect.Top));

      if R.Bottom < (P.Y + FItemPopup.Height + 2) then
        P.Y := P.Y - ((P.Y + FItemPopup.Height + 2) - R.Bottom);

      if (R.Right < P.X + FItemPopup.Width) then
        P.X := ClientToScreen(Point(FItems.Items[HotItem].BoundRect.Left, FItems.Items[HotItem].BoundRect.Top)).X - FItemPopup.Width;

      FItemPopup.Left := P.X;
      FItemPopup.Top := P.Y;
      FItemPopup.Visible := True;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.HideItemPopup;
begin
  if Assigned(FItemPopup) and FItemPopup.Visible then
  begin
    FItemPopup.Hide;
  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.OnItemPopupDeActivateHide(Sender: TObject);
begin
  TATBPopupWindow(Parent).Hide;
    if Assigned(TATBPopupWindow(Parent).OnDeActivateHide) then
      TATBPopupWindow(Parent).FOnDeActivateHide(TATBPopupWindow(Parent));
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.OnItemPopupHide(Sender: TObject);
begin
  if Assigned(Parent) and (Parent is TATBPopupWindow) then
    TATBPopupWindow(Parent).HideOnDeActivate := True;
  FPopupItem := -1;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.ItemClick(ItemIndex: Integer);
begin
  if (ItemIndex >= 0) and (ItemIndex < FItems.Count) then
  begin
    if FItems.Items[ItemIndex].AutoCheck then
    begin
      ToggleCheck(ItemIndex);
    end
    else
    begin

    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TATBPopupPanel.BeforeHide;
begin
  HideItemPopup;
  FHotItem := -1;
  FPopupItem := -1;
end;

//------------------------------------------------------------------------------

{ TAdvToolBarButtonDrawPosition }

procedure TAdvToolBarButtonDrawPosition.Assign(Source: TPersistent);
begin
  if (Source is TAdvToolBarButtonDrawPosition) then
  begin
    FTextX := (Source as TAdvToolBarButtonDrawPosition).TextX;
    FTextY := (Source as TAdvToolBarButtonDrawPosition).TextY;
    FImageX := (Source as TAdvToolBarButtonDrawPosition).ImageX;
    FImageY := (Source as TAdvToolBarButtonDrawPosition).ImageY;
    FEnabled := (Source as TAdvToolBarButtonDrawPosition).Enabled;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarButtonDrawPosition.Changed;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

//------------------------------------------------------------------------------

constructor TAdvToolBarButtonDrawPosition.Create;
begin
  inherited;
  FTextX := 0;
  FTextY := 0;
  FEnabled := False;
  FImageX := 0;
  FImageY := 0;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarButtonDrawPosition.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarButtonDrawPosition.SetImageX(const Value: integer);
begin
  if FImageX <> Value then
  begin
    FImageX := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarButtonDrawPosition.SetImageY(const Value: Integer);
begin
  if FImageY <> Value then
  begin
    FImageY := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarButtonDrawPosition.SetTextX(const Value: integer);
begin
  if FTextX <> Value then
  begin
    FTextX := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvToolBarButtonDrawPosition.SetTextY(const Value: integer);
begin
  if FTextY <> Value then
  begin
    FTextY := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

{ TDbgList }

function TDbgList.GetItemsEx(Index: Integer): Pointer;
begin
  if (Index >= Count) then
  begin
    raise Exception.Create('Index out of bounds in list read access');
  end;

  if Index < Count then
    Result := inherited Items[Index]
  else
    Result := nil;
end;

//------------------------------------------------------------------------------

procedure TDbgList.SetItemsEx(Index: Integer; const Value: Pointer);
begin
  if (Index >= Count) then
  begin
    raise Exception.Create('Index out of bounds in list write access');
  end;
  if Index < Count then
    inherited Items[Index] := value;
end;

//------------------------------------------------------------------------------

{ TDBATBButtonDataLink }

constructor TDBATBButtonDataLink.Create;
begin
  inherited Create;
  FOnEditingChanged := nil;
  FOnDataSetChanged := nil;
  FOnActiveChanged := nil;
end;

//------------------------------------------------------------------------------

procedure TDBATBButtonDataLink.ActiveChanged;
begin
  if Assigned(FOnActiveChanged) then FOnActiveChanged(Self);
end;

//------------------------------------------------------------------------------

procedure TDBATBButtonDataLink.DataSetChanged;
begin
  if Assigned(FOnDataSetChanged) then FOnDataSetChanged(Self);
end;

//------------------------------------------------------------------------------

procedure TDBATBButtonDataLink.EditingChanged;
begin
  if Assigned(FOnEditingChanged) then FOnEditingChanged(Self);
end;

//------------------------------------------------------------------------------

{ TDBAdvToolBarButton }

constructor TDBAdvToolBarButton.Create(AOwner: TComponent);
begin
  inherited;
  FAutoDisable := True;
  FDBButtonType := dbtCustom;
  FDisableControls := [];
  FDataLink := TDBATBButtonDataLink.Create;
  with FDataLink do
  begin
    OnEditingChanged := OnDataSetEvents;
    OnDataSetChanged := OnDataSetEvents;
    OnActiveChanged := OnDataSetEvents;
  end;
  FConfirmActionString := '';  
end;

//------------------------------------------------------------------------------

destructor TDBAdvToolBarButton.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.CalcDisableReasons;
begin
  case FDBButtonType of
    dbtPrior:    FDisableControls := [drBOF, drEditing, drEmpty];
    dbtNext:     FDisableControls := [drEOF, drEditing, drEmpty];
    dbtFirst:    FDisableControls := [drBOF, drEditing, drEmpty];
    dbtLast:     FDisableControls := [drEOF, drEditing, drEmpty];
    dbtInsert,
    dbtAppend:   FDisableControls := [drReadonly, drEditing];
    dbtEdit:     FDisableControls := [drReadonly, drEditing, drEmpty];
    dbtCancel:   FDisableControls := [drNotEditing];
    dbtPost:     FDisableControls := [drNotEditing];
    dbtRefresh:  FDisableControls := [drEditing];
    dbtDelete:   FDisableControls := [drReadonly, drEditing, drEmpty];
  end;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.Click;
begin
  inherited;
  DoAction;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if (not FInProcUpdateEnabled) and
     (not (csLoading in ComponentState)) and
     (not (csDestroying in ComponentState)) then
  begin
    UpdateEnabled;
  end;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.DoAction;
var
  DoAction: Boolean;
  ShowException: Boolean;
begin
  if not DoConfirmAction then
    Exit;

  DoAction := (FDBButtonType <> dbtCustom);
  try
    DoBeforeAction(DoAction);
    if DoAction and (DataSource <> nil) and (DataSource.State <> dsInactive) then
    begin
      with DataSource.DataSet do
      begin
        case FDBButtonType of
          dbtPrior: Prior;
          dbtNext: Next;
          dbtFirst: First;
          dbtLast: Last;
          dbtInsert: Insert;
          dbtAppend: Append;
          dbtEdit: Edit;
          dbtCancel: Cancel;
          dbtPost: Post;
          dbtRefresh:Refresh;
          dbtDelete: Delete;
        end;
      end;
    end;
    ShowException := false;
  except
    ShowException := true;
    if Assigned(FOnAfterAction) then
      FOnAfterAction(self, ShowException);
    if ShowException then
      raise;
    ShowException := true;
  end;
  if not ShowException and DoAction and Assigned(FOnAfterAction) then
    FOnAfterAction(self, ShowException);
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.DoBeforeAction(var DoAction: Boolean);
begin
  if (not (csDesigning in ComponentState)) and Assigned(FOnBeforeAction) then
    FOnBeforeAction(self, DoAction);
end;

//------------------------------------------------------------------------------

function TDBAdvToolBarButton.DoConfirmAction: Boolean;
var
  Question: string;
  QuestionButtons: TMsgDlgButtons;
  QuestionHelpCtx: Longint;
  QuestionResult: Longint;
begin
  DoGetQuestion(Question, QuestionButtons, QuestionHelpCtx);
  if (Question <> '') then
  begin
    QuestionResult := MessageDlg(Question, mtConfirmation, QuestionButtons, QuestionHelpCtx);
    Result := (QuestionResult = idOk) or (QuestionResult = idYes);
  end
  else
    Result := true;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.DoGetQuestion(var Question: string;
  var Buttons: TMsgDlgButtons; var HelpCtx: Integer);
begin
  Question := '';
  if FConfirmAction then
  begin
    Question := FConfirmActionString;
    Buttons := mbOKCancel;
    HelpCtx := 0;
    if Assigned(FOnGetConfirm) then
      FOnGetConfirm(self, Question, Buttons, HelpCtx);
  end;
end;

//------------------------------------------------------------------------------

function TDBAdvToolBarButton.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AOperation = opRemove) and (FDataLink <> nil) and (AComponent = DataSource) then
    DataSource := nil;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.SetDataSource(const Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if not (csLoading in ComponentState) then
    UpdateEnabled;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.SetDBButtonType(const Value: TDBButtonType);
begin
  if (Value = FDBButtonType) then
    Exit;

  if (Value = dbtDelete) and (FConfirmActionString = ''){and ConfirmAction} then
    FConfirmActionString := SDeleteRecordQuestion; //'Delete Record?';

  if (csReading in ComponentState) or (csLoading in ComponentState) then
  begin
    FDBButtonType := Value;
    CalcDisableReasons;
    exit;
  end;

  FDBButtonType := Value;
  LoadGlyph;
  CalcDisableReasons;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.UpdateEnabled;
var
  PossibleDisableReasons: TDBBDisableControls;
  GetEnable: Boolean;
  WasEnabled: Boolean;
begin
  if (csDesigning in ComponentState) or (csDestroying in ComponentState) or not FAutoDisable then
    Exit;

  FInProcUpdateEnabled := true;
  try
   WasEnabled := Enabled;
   if FDataLink.Active then
   begin
     PossibleDisableReasons := [];
     if FDataLink.DataSet.BOF then
       Include(PossibleDisableReasons, drBOF);
     if FDataLink.DataSet.EOF then
       Include(PossibleDisableReasons, drEOF);
     if not FDataLink.DataSet.CanModify then
       Include(PossibleDisableReasons, drReadonly);
     if FDataLink.DataSet.BOF and FDataLink.DataSet.EOF then
       Include(PossibleDisableReasons, drEmpty);
     if FDataLink.Editing then
       Include(PossibleDisableReasons, drEditing)
     else
       Include(PossibleDisableReasons, drNotEditing);

     GetEnable := ((FDisableControls - [drEvent])* PossibleDisableReasons = []);
     if (drEvent in FDisableControls) and (Assigned(FOnGetEnabled)) then
       FOnGetEnabled(Self, GetEnable);
     Enabled := GetEnable;
   end
   else
     Enabled := false;

   if (WasEnabled <> Enabled) and Assigned(FOnEnabledChanged) then
     FOnEnabledChanged(self);
  finally
    FInProcUpdateEnabled := false;
  end;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.Loaded;
begin
  inherited;
  if Glyph.Empty then
    LoadGlyph;
    
  UpdateEnabled;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.OnDataSetEvents(Sender: TObject);
begin
  UpdateEnabled;
end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.LoadGlyph;
begin
  if (csLoading in ComponentState) then
    Exit;

  case FDBButtonType of
    dbtPrior:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNPRIOR');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNPRIORD');
    end;
    dbtNext:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNNEXT');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNNEXTD');
    end;
    dbtFirst:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNFIRST');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNFIRSTD');
    end;
    dbtLast:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNLAST');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNLASTD');
    end;
    dbtInsert:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNINSERT');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNINSERTD');
    end;
    dbtAppend:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNINSERT');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNINSERTD');
    end;
    dbtEdit:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNEDIT');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNEDITD');
    end;
    dbtCancel:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNCANCEL');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNCANCELD');
    end;
    dbtPost:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNPOST');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNPOSTD');
    end;
    dbtRefresh:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNREFRESH');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNREFRESHD');
    end;
    dbtDelete:
    begin
      Glyph.LoadFromResourceName(HInstance, 'DBBTNDELETE');
      GlyphDisabled.LoadFromResourceName(HInstance, 'DBBTNDELETED');
    end;
  end;

end;

//------------------------------------------------------------------------------

procedure TDBAdvToolBarButton.SetConfirmActionString(const Value: String);
begin
  if FConfirmActionString <> Value then
  begin
    FConfirmActionString := Value;
  end;
end;

{$IFDEF FREEWARE}
{$I TRIAL.INC}
{$ENDIF}


end.
