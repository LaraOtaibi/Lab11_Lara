% ARTI 401 - Lab 9: IO Stream and Database Manipulation
% Lab Activity: The Name Game

:- dynamic letter/1.

% Starting set of letters.
letter(a).
letter(b).
letter(c).

% Start the game.
start :-
    nl,
    writeln('Hi. This is the "Name Game".'),
    writeln('You will be given a set of English letters in which you will'),
    writeln('add, delete or move to create your name.'),
    menu.

% Keep displaying the menu until the user chooses Exit.
menu :-
    nl,
    writeln('Choose from the following:'),
    writeln('1- Display the current set of letters'),
    writeln('2- Add a letter'),
    writeln('3- Add a letter at the top'),
    writeln('4- Add a letter at the bottom'),
    writeln('5- Delete a letter'),
    writeln('6- Delete all letters'),
    writeln('7- Exit'),
    write('Enter your choice: '),
    read(Choice),
    ( Choice == 7 ->
        writeln('Goodbye!')
    ;
        process_choice(Choice),
        menu
    ).

% Display the database contents in their current order.
process_choice(1) :-
    !,
    findall(X, letter(X), Letters),
    write('Current set of letters: '),
    writeln(Letters).

% assert/1 adds a fact (normally at the end).
process_choice(2) :-
    !,
    ask_letter(X),
    assert(letter(X)),
    writeln('Letter added.').

% asserta/1 inserts a fact at the beginning.
process_choice(3) :-
    !,
    ask_letter(X),
    asserta(letter(X)),
    writeln('Letter added at the top.').

% assertz/1 inserts a fact at the end.
process_choice(4) :-
    !,
    ask_letter(X),
    assertz(letter(X)),
    writeln('Letter added at the bottom.').

% retract/1 removes the first matching occurrence.
process_choice(5) :-
    !,
    ask_letter(X),
    ( retract(letter(X)) ->
        writeln('Letter deleted.')
    ;
        writeln('Letter not found.')
    ).

% retractall/1 removes all letters.
process_choice(6) :-
    !,
    retractall(letter(_)),
    writeln('All letters deleted.').

process_choice(_) :-
    writeln('Invalid choice. Please choose a number from 1 to 7.').

% read/1 requires a full stop, e.g. a.
ask_letter(Letter) :-
    write('Enter one lowercase English letter (e.g. l.): '),
    read(Input),
    ( valid_letter(Input) ->
        Letter = Input
    ;
        writeln('Invalid letter. Please enter a single letter from a to z.'),
        ask_letter(Letter)
    ).

valid_letter(X) :-
    atom(X),
    atom_codes(X, [Code]),
    Code >= 97,
    Code =< 122.
