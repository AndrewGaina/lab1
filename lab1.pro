accessories(accessory1, keyboard, peripheral, brand1, '2022-01-01').
accessories(accessory2, mouse, peripheral, brand1, '2022-02-01').
accessories(accessory3, monitor, display, brand1, '2022-03-01').
accessories(accessory4, processor, component, brand1, '2022-04-01').
accessories(accessory5, memory, component, brand1, '2022-05-01').
accessories(accessory6, storage, component, brand1, '2022-06-01').
accessories(accessory7, keyboard, peripheral, brand2, '2022-01-01').
accessories(accessory8, mouse, peripheral, brand2, '2022-02-01').
accessories(accessory9, monitor, display, brand2, '2022-03-01').
accessories(accessory10, processor, component, brand2, '2022-04-01').
accessories(accessory11, memory, component, brand2, '2022-05-01').
accessories(accessory12, storage, component, brand2, '2022-06-01').

connection_interface(keyboard, usb).
connection_interface(mouse, usb).
connection_interface(monitor, hdmi).
connection_interface(processor, socket).
connection_interface(memory, socket).
connection_interface(storage, sata).

product(accessory1, 50).
product(accessory2, 30).
product(accessory3, 200).
product(accessory4, 300).
product(accessory5, 150).
product(accessory6, 100).
product(accessory7, 500).
product(accessory8, 300).
product(accessory9, 2000).
product(accessory10, 3000).
product(accessory11, 1500).
product(accessory12, 1000).

compatible(A, B) :-
    accessories(A, _, _, Brand, _),
    accessories(B, _, _, Brand, _).

build_computer(Accessories) :-
    all_same_brand(Accessories),
    Accessories \= [].

all_same_brand([]).
all_same_brand([_]).
all_same_brand([Accessory1, Accessory2 | Rest]) :-
    accessories(Accessory1, _, _, Brand, _),
    accessories(Accessory2, _, _, Brand, _),
    all_same_brand([Accessory2 | Rest]).

available_accessories(Type) :-
    accessories(ID, Name, Type, Brand, ManufactureDate),
    format('ID: ~w, Name: ~w, Brand: ~w, Manufacture Date: ~w~n', [ID, Name, Brand, ManufactureDate]).

total_cost([], 0).
total_cost([Accessory | Rest], TotalCost) :-
    product(Accessory, Price),
    total_cost(Rest, RemainingCost),
    TotalCost is Price + RemainingCost.

% Я не понял как проверить совместимость, сделал тупо: если от одной фирмы, то всё ок 
% (я особо и не разбираюсь в компьютерах и том как вообще определяется совместимость)
% примеры запросов:
% совместимы ли А и В compatible(accessory1, accessory2)
% можно ли строить пк из данных компонентов build_computer([accessory6, accessory5, accessory3])
% список всех комплектующих такого-то типа available_accessories(keyboard)
% сумма total_cost([accessory1, accessory2, ...], TotalCost)
