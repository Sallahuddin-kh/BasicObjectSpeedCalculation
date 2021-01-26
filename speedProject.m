function varargout = speedProject(varargin)
% SPEEDPROJECT MATLAB code for speedProject.fig
%      SPEEDPROJECT, by itself, creates a new SPEEDPROJECT or raises the existing
%      singleton*.
%
%      H = SPEEDPROJECT returns the handle to a new SPEEDPROJECT or the handle to
%      the existing singleton*.
%
%      SPEEDPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEEDPROJECT.M with the given input arguments.
%
%      SPEEDPROJECT('Property','Value',...) creates a new SPEEDPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before speedProject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to speedProject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help speedProject

% Last Modified by GUIDE v2.5 01-Dec-2019 13:09:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @speedProject_OpeningFcn, ...
                   'gui_OutputFcn',  @speedProject_OutputFcn, ...
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


% --- Executes just before speedProject is made visible.
function speedProject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to speedProject (see VARARGIN)

% Choose default command line output for speedProject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes speedProject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = speedProject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%Show Video Button

obj = VideoReader('1.mp4');

i=1;
figure();
while hasFrame(obj)     
  this_frame = readFrame(obj);  
  imshow(this_frame);
  if(i == 15)
      imwrite(this_frame,'frame1.jpg');
      frame1 = imread('frame1.jpg');
      imshow(frame1,'Parent',handles.axes2);
  elseif(i==30)
      imwrite(this_frame,'frame2.jpg');
      frame2 = imread('frame2.jpg');
      imshow(frame2,'Parent',handles.axes3);
    elseif(i==45)
       imwrite(this_frame,'frame3.jpg');
       frame3 = imread('frame3.jpg'); 
  end
  i=i+1;
end

set(handles.text7,'String',i);
bwframe1 = im2bw(frame1,0.7);
imshow(bwframe1);

bwframe2=im2bw(frame2,0.7);
imshow(bwframe2);

bwframe3=im2bw(frame3,0.7);
imshow(bwframe3);


 Ibw1 = imfill(bwframe1,'holes');
 Ilabel1 = bwlabel(Ibw1);
 stat1 = regionprops(Ilabel1,'centroid');
 centroids1=cat(1,stat1.Centroid);
 
 Ibw2 = imfill(bwframe2,'holes');
 Ilabel2= bwlabel(Ibw2);
 stat2 = regionprops(Ilabel2,'centroid');
 centroids2=cat(1,stat2.Centroid);
 
 Ibw3 = imfill(bwframe3,'holes');
 Ilabel3= bwlabel(Ibw3);
 stat3 = regionprops(Ilabel3,'centroid');
 centroids3=cat(1,stat3.Centroid);
 
 distance = (centroids1(1)-centroids2(1))^2 + (centroids1(2)-centroids2(2))^2  ;
 distance= sqrt(distance);
 
  distance1 = (centroids2(1)-centroids3(1))^2 + (centroids2(2)-centroids3(2))^2  ;
 distance1= sqrt(distance1);
 
 % the testing video has 72.73 fps and  i took 30 frames which gives the
 % time as 30/72.73= 0.41 seconds
 
 
 %suppose 1 meter covers 100 pixels. So, distance in meters = distace/100 
scale=1/100;
 
distanceinmeter=distance*scale;
distanceinmeter1=distance1*scale;

speed=distanceinmeter/0.206;
speed1=distanceinmeter1/0.206;

avgSpeed = (speed1+speed)/2;
disp(avgSpeed);
set(handles.text9  ,'String',avgSpeed);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
pointA = str2num(get(handles.edit1,'String'));
pointB = str2num(get(handles.edit2,'String'));
distFct = str2num(get(handles.edit3,'String'));
obj = VideoReader('1.mp4');
i=1;
figure();
while hasFrame(obj)     
  this_frame = readFrame(obj);  
  imshow(this_frame);
  if(i == pointA)
      imwrite(this_frame,'frame1.jpg');
      frame1 = imread('frame1.jpg');
      imshow(frame1,'Parent',handles.axes2);
  elseif(i==pointB)
      imwrite(this_frame,'frame2.jpg');
      frame2 = imread('frame2.jpg');
      imshow(frame2,'Parent',handles.axes3);
%    elseif(i==45)
%       imwrite(this_frame,'frame3.jpg');
%       frame3 = imread('frame3.jpg'); 
  end
  i=i+1;
end
bwframe1 = im2bw(frame1,0.7);
imshow(bwframe1);

bwframe2=im2bw(frame2,0.7);
imshow(bwframe2);
 Ibw1 = imfill(bwframe1,'holes');
 Ilabel1 = bwlabel(Ibw1);
 stat1 = regionprops(Ilabel1,'centroid');
 centroids1=cat(1,stat1.Centroid);
 
 Ibw2 = imfill(bwframe2,'holes');
 Ilabel2= bwlabel(Ibw2);
 stat2 = regionprops(Ilabel2,'centroid');
 centroids2=cat(1,stat2.Centroid);
 distance = (centroids1(1)-centroids2(1))^2 + (centroids1(2)-centroids2(2))^2  ;
 distance= sqrt(distance);
scale=1/distFct;
 
distanceinmeter=distance*scale;
difference =pointB -  pointA ;
time = difference/72.73;
speed=distanceinmeter/time;
disp(speed);
set(handles.text12  ,'String',speed);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
