function choix = getdata(n)
a = readtable('country-capitals/data/country-list.csv','Format','%s%s%s');
a.type= [];
country = a.country;
random_country = country(randperm(length(country)));
choix = {};
for i=1:n
    state = cell2mat(random_country(i));
    index = find(strcmp(state,country(:)));
    correct_capital = a{index,2};
    wrong_capital = a.capital;
    wrong_capital(index) = [];
    wrong_capital = wrong_capital(randperm(length(wrong_capital)));
    wrong_capital = wrong_capital(randperm(3));
    answer = {};
    answer(1) = correct_capital;
    answer(2:4) = wrong_capital;
    answer1 = answer(randperm(4));
    choix{1,i} = answer1;
    choix{2,i} = state;
    choix{3,i} = correct_capital;
end
end