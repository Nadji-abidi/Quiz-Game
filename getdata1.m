function out = getdata1(categorie,path,n)
a = readtable([path,'/',categorie,'.csv'],'Format','%q%q%q%q%q%q%q%q','ReadvariableName',0) ;
a(1,:) = [];
a.Properties.VariableNames(2:4) = {'questions','a','answer'};
Question = a.questions;answer = a.answer;
Question1 = Question(randperm(length(Question)));
out = {};
for i=1:n
    fi = cell2mat(Question1(i));
    index = find(strcmp(fi,Question(:)));
    Choix = a{index,5:8};
    Choix = Choix(randperm(length(Choix)));
    correct = answer(index);
    out{1,i} = Choix;
    out{2,i} = fi;
    if length(size(correct)) == 1
        out{3,i} = correct;
    else
        correct = correct{1};
        out{3,i} = correct;
    end
end
end