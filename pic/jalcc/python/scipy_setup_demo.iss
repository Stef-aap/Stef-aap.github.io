; Setup file for SciPy

#define public base "D:\...."
#define public website "http://.../"
#define public version "v0_1"
#define public application "Portable SciPy"
;#define public prog_name "Portable SciPy"

; define the locations of the programs (and Python.DLL) on the source PC
#define public base_Python      "P:\Program Files\Python"
#define public base_PyScripter  "P:\Program Files\PyScripter"
#define public Python_DLL       "P:\Program Files\Python\BackUp\Python24.dll";


[Setup]
AppName={#application}
OutputBaseFilename={#application}_{#version}
AppVerName={#application}  {#version}
AppCopyright=Copyright (C) 2007 My Name
AppPublisher=My Name
AppPublisherURL={#website}
AppSupportURL={#website}
AppUpdatesURL={#website}
DefaultDirName=C:\Python
DefaultGroupName=Python
AllowNoIcons=yes
LicenseFile={#base}\License.txt
MinVersion=4,4.0

[Messages]
BeveledLabel={#application} (test version)

; define the desktop shortcuts (which the end-user can select)
[Tasks]
Name: "desktopicon_Python"; \
  Description:      "Create a &desktop icon for Python"; \
  GroupDescription: "Additional icons:"; MinVersion: 4,4
Name: "desktopicon_PyScripter"; \
  Description:      "Create a &desktop icon for PyScripter"; \
  GroupDescription: "Additional icons:"; MinVersion: 4,4
Name: "desktopicon_SWB"; \
  Description:      "Create a &desktop icon for Signal WorkBench"; \
  GroupDescription: "Additional icons:"; MinVersion: 4,4

[Types]
Name: "full";   Description: "Full Installation"
Name: "custom"; Description: "Custom Installation"; Flags: iscustom

; define which components the end-user can (de-)select
[Components]
Name: "Python";           Description: "Python compiler {#version}";     Flags: fixed; Types: full custom;
Name: "SciPy";            Description: "SciPy, Scientific Libraries";                  Types: full custom;
Name: "PyScripter";       Description: "PyScripter, Python IDE";                       Types: full custom;
Name: "Signal WorkBench"; Description: "Signal WorkBench, calculator for time series"; Types: full custom;

; which source files should be copied to which destination
[Files]
Source: "{#base_Python}\*.*";          DestDir: "{app}"; \
  Flags: ignoreversion; Components:Python;
Source: "{#base_PyScripter}\*.*";      DestDir: "{app}\IDE"; \
  Flags: ignoreversion recursesubdirs; Components:PyScripter;

; and here we'll make extra copies of the Python-dll,
; to prevent editing the windows registry
Source: "{#Python_DLL}"; DestDir: "{app}";     Components:Python;
Source: "{#Python_DLL}"; DestDir: "{app}\IDE"; Components:PyScripter;


; create a program group
[Icons]
Name: "{group}\Python";     Filename: "{app}\Python.exe";
Name: "{group}\PyScripter"; Filename: "{app}\IDE\PyScripter.exe";

; create desktop shortcuts
Name: "{userdesktop}\Python"; \
  Filename: "{app}\Python.exe"; \
  WorkingDir: "{app}"; \
  MinVersion: 4,4; \
  Tasks: desktopicon_Python

Name: "{userdesktop}\PyScripter"; \
  Filename: "{app}\IDE\PyScripter.exe"; \
  WorkingDir: "{app}"; \
  MinVersion: 4,4; \
  Tasks: desktopicon_Python


[Run]
Filename: "{app}\Python.exe"; \
  Description: "Launch Python"; Flags: postinstall skipifsilent;
Filename: "{app}\IDE\PyScripter.exe"; \
  Description: "Launch PyScripter"; Flags: postinstall skipifsilent;
  
  ;Parameters: "--PYTHON24 --PYTHONPATHDLL {app} %1 %2 %3 %4 %5"; \

;SET PYTHONHOME=E:\PortablePython
;PyScripter --PYTHON25 --PYTHONPATHDLL "E:\PortablePython" %1 %2 %3 %4 %5









