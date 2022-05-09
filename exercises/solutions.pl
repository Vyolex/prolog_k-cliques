%------------
% Exercise 2:
%------------
isKiller('Butch').
isKiller(Suspect) :- kills(Suspect,_).

areMarried('Mia','Marcellus').

isDead('Zed').
isDead(Victim) :- kills(_,Victim).

givesMassage(_,_) :- false.
givesMassage('Matthias','Mia').

kills(_,_) :- false.
kills('Marcellus',Massager) :- givesMassage(Massager,'Mia').

%------------
% Exercise 3:
%------------
word(article,a).
word(article,every).
word(noun,criminal).
word(noun,'big kahuna burger').
word(verb,eats).
word(verb,likes).
sentence(Word1,Word2,Word3,Word4,Word5) :- word(article,Word1),
					   word(noun,Word2),
					   word(verb,Word3),
					   word(article,Word4),
					   word(noun,Word5).

% List all sentences with "sentence(W1, W2, W3, W4, W5).", use ";" to get more options.

%------------
% Exercise 4:
%------------
%book(ISBN, title, pages)
book(1,'The art of Prolog',400).
book(23,'The mistery of Strawberries',42).
%person(name)
person('Statler').
person('Waldorf').
%author(person, ISBN)
author('Statler',1).
author('Waldorf',23).
%hates(person, ISBN)
hates('Statler',1).
%owns(person, ISBN)
owns('Waldorf',23).

% -- 4.a
isbn(Book, ISBN) :- book(ISBN,Book,_).

% -- 4.b
hatedByAuthor(Book) :-  book(ISBN,Book,_),
			author(Author,ISBN),
			hates(Author,ISBN).

% -- 4.c
booksByAuthor :- author(Author, ISBN),
			book(ISBN, Title, _),
			write('The book '),
			write(Title),
			write(' is written by '),
			write(Author).

% -- 4.d
proud_author(Author) :- author(Author, ISBN), owns(Author, ISBN).

%------------
% Exercise 5:
%------------
word(abalone,a,b,a,l,o,n,e).
word(abandon,a,b,a,n,d,o,n).
word(enhance,e,n,h,a,n,c,e).
word(anagram,a,n,a,g,r,a,m).
word(connect,c,o,n,n,e,c,t).
word(elegant,e,l,e,g,a,n,t).
croswd(Word1, Word2, Word3, Word4, Word5, Word6) :-
							word(Word1, _, A, _, B, _, C, _),
							word(Word2, _, D, _, E, _, F, _),
							word(Word3, _, G, _, H, _, I, _),
							word(Word4, _, A, _, D, _, G, _),
							word(Word5, _, B, _, E, _, H, _),
							word(Word6, _, C, _, F, _, I, _).

%------------
% Exercise 6:
%------------
numeral(0).
numeral(succ(X)) :- numeral(X).

addition(0, Y, Y) :- numeral(Y).
addition(X, 0, X) :- numeral(X).
addition(succ(X), Y, Z) :- numeral(X), numeral(Y), addition(X,succ(Y),Z).

greater_than(X, 0) :- numeral(X).
greater_than(succ(X),succ(Y)) :- numeral(X), numeral(Y), greater_than(X,Y).

%------------
% Exercise 7:
%------------
leaf(_).
tree(leaf(B1), leaf(B2)) :- leaf(B1), leaf(B2).
tree(leaf(B1), tree(_,_)) :- leaf(B1).
tree(tree(_,_), leaf(B1)) :- leaf(B1).
tree(tree(_,_), tree(_,_)).

swap(leaf(X), leaf(X)) :- leaf(X).
swap(tree(B1, B2), tree(B2s, B1s)) :- swap(B1, B1s), swap(B2, B2s).
