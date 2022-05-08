unit Cube;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TMainForm = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    timer: TTimer;
    SpinEdit1: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure timerTimer(Sender: TObject);

  private
    { Private declarations }
    DC: HDC; // контекст пристрою
    hrc: HGLRC; // контекст відтворення
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

var
  k: integer;

procedure SetDCPixelFormat(HDC: HDC);
var
  pfd: TPixelFormatDescriptor; // об’єкт структури формату пікселя
  nPixelFormat: integer;
begin
  FillChar(pfd, SizeOf(pfd), 0);
  // Встановлення значень прапорців: підтримка OpenGL та подвійна буферизація
  pfd.dwFlags := PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  // Спроба підібрати найближчий формат пікселя по заданих критеріях
  nPixelFormat := ChoosePixelFormat(HDC, @pfd);
  // Встановлення формату пікселя контексту пристрою
  SetPixelFormat(HDC, nPixelFormat, @pfd);
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  glEnable(GL_LIGHTING); // встановлення властивостей освітлення
  glEnable(GL_LIGHT0);
  glEnable(GL_DEPTH_TEST);
  // встановлення режиму перевірки глибини зображення та оновлення буферу глибини
  glEnable(GL_COLOR_MATERIAL); // встановлення властивостей кольору
  timer.enabled := true;

end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  timer.enabled := false;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DC := GetDC(Handle); // отримання контексту пристрою (форми)
  SetDCPixelFormat(DC); // встановлення формату пікселя
  hrc := wglCreateContext(DC); // створення нового контексту відтворення
  wglMakeCurrent(DC, hrc); // задання поточного контексту відтворення
  glClearColor(180, 0, 189, 0.3); // задання кольору фону у форматі RGBA
  // Встановлення поточної матриці перетворення координат для побудови об’ємного зображення
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity; // ініціалізація матриці
  glFrustum(-1, 1, -1, 1, 3, 40); // множення матриці на матрицю перспективи
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  glTranslatef(0.0, 0.0, -8.0); // множення матрицю на матрицю перетворення

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0, 0); // звільнення поточного контексту відтворення
  wglDeleteContext(hrc); // знищення контексту відтворення
  ReleaseDC(Handle, DC); // звільнення контексту пристрою
  DeleteDC(DC);
  // видалення вказаного контексту пристрою для його використання іншими додатками

end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // очищення буфера

  glBegin(GL_QUADS); // початок примітива (грані куба)
  glNormal3f(0.0, 0.0, 1.0);
  glVertex3f(-1.0, -1.0, 1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glColor(0, 120, 88, 0.3); // морська
  glend;

  glBegin(GL_QUADS);
  glNormal3f(-1.0, 0.0, 0.0);
  glVertex3f(-1.0, -1.0, -1.0);
  glVertex3f(-1.0, 1.0, -1.0);
  glVertex3f(1.0, 1.0, -1.0);
  glVertex3f(1.0, -1.0, -1.0);
  glColor(0, 255, 0, 0.3);
  glend;

  glBegin(GL_QUADS);
  glNormal3f(1.0, 0.0, -1.0);
  glVertex3f(-1.0, 1.0, -1.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(1.0, 1.0, -1.0);
  glColor(0, 250, 0.3); // синя
  glend;

  glBegin(GL_QUADS);
  glNormal3f(0.0, 0.0, -1.0);
  glVertex3f(-1.0, -1.0, -1.0);
  glVertex3f(1.0, -1.0, -1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glVertex3f(-1.0, -1.0, 1.0);
  glColor(60, 120, 0, 0.3);
  glend;

  glBegin(GL_QUADS);
  glNormal3f(0.0, 0.0, -1.0);
  glVertex3f(1.0, -1.0, -1.0);
  glVertex3f(1.0, 1.0, -1.0);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glColor(40, 160, 0, 0.3);
  glend;

  glBegin(GL_QUADS);
  glVertex3f(-1.0, -1.0, -1.0);
  glVertex3f(-1.0, -1.0, 1.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glVertex3f(-1.0, 1.0, -1.0);
  glColor(0, 40, 120, 0.3);
  glend
end;

procedure TMainForm.timerTimer(Sender: TObject);

begin
  k := SpinEdit1.Value;
  glRotatef(-1.0, -1.0, 1.0, 1.0); // повертання матриці проти годинникової
  glRotatef(k * 1.0, k * -1.0, k * 1.0, 0.0);
  // стрілки на кут навколо вектора від
  glRotatef(1.0, 1.0, -1.0, 1.0); // початкової точки
  SwapBuffers(DC); // обмін фронтального і зворотного буферів
  InvalidateRect(Handle, nil, false); // перемальовування форми.
end;

end.
