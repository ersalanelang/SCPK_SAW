function varargout = Responsi_Saw_2(varargin)
% RESPONSI_SAW_2 MATLAB code for Responsi_Saw_2.fig
%      RESPONSI_SAW_2, by itself, creates a new RESPONSI_SAW_2 or raises the existing
%      singleton*.
%
%      H = RESPONSI_SAW_2 returns the handle to a new RESPONSI_SAW_2 or the handle to
%      the existing singleton*.
%
%      RESPONSI_SAW_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSI_SAW_2.M with the given input arguments.
%
%      RESPONSI_SAW_2('Property','Value',...) creates a new RESPONSI_SAW_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Responsi_Saw_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Responsi_Saw_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Responsi_Saw_2

% Last Modified by GUIDE v2.5 25-Jun-2021 23:52:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Responsi_Saw_2_OpeningFcn, ...
                   'gui_OutputFcn',  @Responsi_Saw_2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Responsi_Saw_2 is made visible.
function Responsi_Saw_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Responsi_Saw_2 (see VARARGIN)

% Choose default command line output for Responsi_Saw_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Responsi_Saw_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Responsi_Saw_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable1,'data','');
set(handles.uitable2,'data','');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%untuk menampilkan dalam tabel memerlukan kolom no 1
opts = detectImportOptions('DATA RUMAH.xlsx'); %untuk mendeteksi file yang ditunjuk
opts.SelectedVariableNames = ([1,3:8]); %Menunjuk variabel 1 & 3-8
data = readmatrix('DATA RUMAH.xlsx',opts); %membaca file .xlsx
data1 = data(1:20,:); %menampilkan jumlah baris dan kolom dengan spesific
set(handles.uitable1,'data',data1); %menampilkan data dalam uitabel1

%untuk perhitungannya tidak memerlukan kolom 1 
opts = detectImportOptions('DATA RUMAH.xlsx'); %untuk mendeteksi file yang ditunjuk
opts.SelectedVariableNames = ([3:8]); %Menunjuk variabel 1 & 3-8
data4 = readmatrix('DATA RUMAH.xlsx',opts); %membaca file .xlsx
data5 = data4(1:20,:); %menampilkan jumlah baris dan kolom dengan spesific
k =[0,1,1,1,1,1]; %nilai atribut, dimana 0= acost &1= benefit
w =[0.30,0.20,0.23,0.10,0.07,0.10] ; %mengubah data menjadi matrix

%tahapan 1. normalisasi matriks
[m n]=size (data5); %matriks m x n dengan ukuran sebanyak variabel data1(input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=data5(:,j)./max(data5(:,j)); %data / dengan data tertinggi
    else
        R(:,j)=min(data5(:,j))./data5(:,j); %data terendah / dengan data
    end;
end;

%tahapan kedua, proses perangkingan
for i=1:m,
    V(i)= sum(w.*R(i,:)); %menjumlahkan dari perkalian antara bobot kriteria dengan data kriteria
end;

Vtranspose=V.'; 
Vtranspose=num2cell(Vtranspose); %menkonversi array V ke cell
opts = detectImportOptions('DATA RUMAH.xlsx'); %untuk mendeteksi file yang ditunjuk
opts.SelectedVariableNames = (2); %Menunjuk variabel 2
data3 = readtable('DATA RUMAH.xlsx',opts); %membaca file .xlsx

data2 = data3(1:20,:); %variabel baru menunjuk data3 dari kolom 1-20 dengan baris semua 
data2 = table2cell(data2); %menkonversi tabel data2 ke array
data2 = [data2 Vtranspose]; %mengkalikan matriks data2 dan Vtranspose
data2 = sortrows(data2,-2); %untuk men sort data2 dari besar ke kecil
data2 = data2(1:20,1); %menunjuk data2 dari kolom 1-20

set(handles.uitable2,'data',data2); %menampilkan data dalam uitabel2
