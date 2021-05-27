function GUI()
    global fh rbg rbg_score text score_text choix b1 b2 count score rb 
    close all
    fh = figure('Position',[300 150 1400 900],'MenuBar','none','color','w');
    set(0, 'DefaultUicontrolUnits','normalized')
    set(fh,'NumberTitle', 'off', 'name' , 'Quiz Game');
    fond = get(fh,'color');
    text = uicontrol(fh,'style','text','String','Quiz Game',...
        'position',[0.1 0.55 0.8 0.2],'back',fond,'FontSize',50,'FontWeight','bold');
    score_text = uicontrol(fh,'style','text','String','',...
        'position',[0.1 0.45 0.8 0.1],'back',fond,'FontSize',70,'Visible','off');
    rbg  = uibuttongroup('parent',fh, 'position',[0.02 0.3 0.9 0.5],...
         'Title','','Visible','off');
     rbg_score = uibuttongroup('parent',fh, 'position',[0.83 0.03 0.15 0.22],...
         'Title','','Visible','off','back',fond);
    rbs = uicontrol(rbg_score,'style','text','Posit',[0.01 0.6 0.95 0.3],'String','SCORE','back',fond,...
        'FontSize',30);
    rb = uicontrol(rbg_score,'style','text','Posit',[0.01 0.2 0.95 0.3],'back',fond);
    rb1 = uicontrol(rbg,'style','radiobutton','position',[0.1 0.7 0.8 0.2]);
    rb4 = uicontrol(rbg,'style', 'radiobutton','position', [0.1 0.1 0.8 0.2]);
    rb3 = uicontrol(rbg,'style', 'radiobutton','position',[0.1 0.3 0.8 0.2]);
    rb2 = uicontrol(rbg,'style', 'radiobutton','position',[0.1 0.5 0.8 0.2]);
    choix = [rb1 rb2 rb3 rb4];
    count = 0;
    score = 0;
    b1 = uicontrol(fh,'style','pushbutton','Posit',[0.1 0.15 0.8 0.1],'String',...
        'Start','callback',@choose);
    b2 = uicontrol(fh,'style','pushbutton','Posit',[0.1 0.02 0.8 0.1],...
        'String','EXIT','callback',@quitter);
end

function choose(obj,event)
global b1 fh b2 text variable variable1 variables
    set(b1,'Visible','off')
    set(b2,'Visible','off')
    set(text,'Visible','off')
    categories = dir('data/csv/*.csv');
    names = {categories.name};
    variables = [];
    for k=1:11
        my_field = strcat('categorie',num2str(k));
        row_1 = names(1:11);
        row_2 = names(12:22);
        pos = k/13;
        name = strrep(row_1{k},'.csv','');
        name1 = strrep(row_2{k},'.csv','');
        variable.(my_field) = uicontrol(fh,'style','pushbutton','Posit',[0.1 pos 0.37 0.05],'String',...
            name,'callback',@Next,'FontSize',15);
        variable1.(my_field) = uicontrol(fh,'style','pushbutton','Posit',[0.5 pos 0.37 0.05],'String',...
            name1,'callback',@Next,'FontSize',15);
        variables(k) = variable.(my_field);
        variables(k+11) = variable1.(my_field);
    end
end
function Next(obj,event)
    global rbg rbg_score b1 b2 text score_text count score variable variable1 variables str stat
    for j=1:22 
        st = variables(j);
        value = get(st,'Value');
        if value == 1
            str = get(st,'String');
            if strcmp(str,'country-capital')
                    stat = true;
            else
                    stat = false;
            end  
        end
    end
    test(1)
    for k=1:11
        num = strcat('categorie',num2str(k));
        a = variable.(num);
        b = variable1.(num);
        set(a,'Visible','off')
        set(b,'Visible','off')
    end
    set(text,'Visible','on')
    set(b1,'Visible','on')
    set(b2,'Visible','on')
    butt = [rbg b1 rbg_score];
    count = count + 1;
    if count > 10
        for i=1:3
            set(butt(i),'Visible','off');
        end
        set(text,'String','Your Score is : ','Posit',[0.1 0.55 0.8 0.2],'FontSize',50)
        set(score_text,'Visible','on','String',score,'ForegroundColor','r')
        set(b2,'Pos',[0.1 0.02 0.8 0.1]);
    end
end
function test(i,obj,event)
    global fh b1 b2 choix score data text rbg rbg_score rb str stat
    if stat
        data = getdata(10);
        set(text,'String',['What is the capital of : ',data{2,i}],...
        'position',[0.01 0.59 0.91 0.37],'FontSize',20);
    else
         data = getdata1(str,'data/csv',10); 
         set(text,'String',data{2,i},...
         'position',[0.01 0.59 0.91 0.37],'FontSize',20);
    end
    set(b1,'String','Next','Posit',[0.01 0.15 0.8 0.1]);
    set(b2,'Posit',[0.01 0.02 0.8 0.1])
    
    set(rbg,'Visible','on','back','w');
    set(rbg_score,'Visible','on');
    set(rb,'String',[num2str(score),'/10'],'FontSize',30)
    capital = data{1,i};
    for j=1:4
        set(choix(j),'back','w','String',capital{j},'FontSize',15)
    end
    set(b1,'callback',@Next1)
end
function Next1(obj,event)
    Check(1)
end

function Check(i,obj,event)
    global rbg data choix b1 correct1 actuel score
    actuel_hndl = get(rbg,'SelectedObject');
    actuel_str = get(actuel_hndl,'string');
    correct = data{3,i};
    index = find(strcmp(correct,data{1,i}));
    index1 = find(strcmp(actuel_str,data{1,i}));
    correct1 = choix(index);
    actuel = choix(index1);
    if ~strcmp(actuel_str,correct)
        set(correct1,'back','g')
        set(actuel,'back','r')
    else
        score = score + 1;
        set(actuel,'back','g')
    end
    set(b1,'callback',@Next)
end

function quitter(obj,event)
    delete(gcf)
end