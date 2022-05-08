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
    DC: HDC; // �������� ��������
    hrc: HGLRC; // �������� ����������
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
  pfd: TPixelFormatDescriptor; // �ᒺ�� ��������� ������� ������
  nPixelFormat: integer;
begin
  FillChar(pfd, SizeOf(pfd), 0);
  // ������������ ������� ���������: �������� OpenGL �� ������� �����������
  pfd.dwFlags := PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
  // ������ ������� ���������� ������ ������ �� ������� ��������
  nPixelFormat := ChoosePixelFormat(HDC, @pfd);
  // ������������ ������� ������ ��������� ��������
  SetPixelFormat(HDC, nPixelFormat, @pfd);
end;

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  glEnable(GL_LIGHTING); // ������������ ������������ ���������
  glEnable(GL_LIGHT0);
  glEnable(GL_DEPTH_TEST);
  // ������������ ������ �������� ������� ���������� �� ��������� ������ �������
  glEnable(GL_COLOR_MATERIAL); // ������������ ������������ �������
  timer.enabled := true;

end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  timer.enabled := false;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DC := GetDC(Handle); // ��������� ��������� �������� (�����)
  SetDCPixelFormat(DC); // ������������ ������� ������
  hrc := wglCreateContext(DC); // ��������� ������ ��������� ����������
  wglMakeCurrent(DC, hrc); // ������� ��������� ��������� ����������
  glClearColor(180, 0, 189, 0.3); // ������� ������� ���� � ������ RGBA
  // ������������ ������� ������� ������������ ��������� ��� �������� �ᒺ����� ����������
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity; // ����������� �������
  glFrustum(-1, 1, -1, 1, 3, 40); // �������� ������� �� ������� �����������
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  glTranslatef(0.0, 0.0, -8.0); // �������� ������� �� ������� ������������

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  wglMakeCurrent(0, 0); // ��������� ��������� ��������� ����������
  wglDeleteContext(hrc); // �������� ��������� ����������
  ReleaseDC(Handle, DC); // ��������� ��������� ��������
  DeleteDC(DC);
  // ��������� ��������� ��������� �������� ��� ���� ������������ ������ ���������

end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT); // �������� ������

  glBegin(GL_QUADS); // ������� �������� (���� ����)
  glNormal3f(0.0, 0.0, 1.0);
  glVertex3f(-1.0, -1.0, 1.0);
  glVertex3f(1.0, -1.0, 1.0);
  glVertex3f(1.0, 1.0, 1.0);
  glVertex3f(-1.0, 1.0, 1.0);
  glColor(0, 120, 88, 0.3); // �������
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
  glColor(0, 250, 0.3); // ����
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
  glRotatef(-1.0, -1.0, 1.0, 1.0); // ���������� ������� ����� �����������
  glRotatef(k * 1.0, k * -1.0, k * 1.0, 0.0);
  // ������ �� ��� ������� ������� ��
  glRotatef(1.0, 1.0, -1.0, 1.0); // ��������� �����
  SwapBuffers(DC); // ���� ������������ � ���������� ������
  InvalidateRect(Handle, nil, false); // ���������������� �����.
end;

end.
