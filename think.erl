-module(think).
-export( [superiorTask/0, selection/1] ).

actual_distribution( Ns ) -> lists:foldl( fun first_digit_count/2, dict:new(), Ns ).
%figures out the distribution of the first digit of the fibnocci sequence and adds it to a dictionary

distribution( N ) -> math:log10( 1 + (1 / N) ).
%benfords law formula

superiorTask() ->
    io:fwrite("in order to select a dataset, call the function selection and either type
        f for the Fibonacci sequence
        r for the last digit of 1000 numbers
        i for 2009 Iranian presidential election data
        u for the 2008 american presidential election").

%explanation of the data set

%selection options
selection(f) when f=='f'->
    fiboTask();
selection(r) when r=='r'->
    falseTask();
selection(i) when i=='i'->
    iranTask();
selection(u)  when u=='u'->
    usaTask();
selection(_)->
    io:fwrite("you messed up somehow ~n"),
    superiorTask().

%usa benfords law test

usaTask()->
    Usdata = usa(),
	Utotal =length(Usdata),
    Usddata = actual_distribution(Usdata),
	Usdddata = lists:sort( dict:fetch_keys(Usddata)),
    io:fwrite( "USA	Number	Actual	                Benfords expected~n" ),
	[io:fwrite("~p	~p	~p	~p~n", ["USA", X, dict:fetch(X, Usddata) / Utotal, distribution(X)]) || X <- Usdddata].

%usa 2008 presidential election first digit information sourced from https://github.com/midnightradio/cse140-data-programming
usa()->
	[8,1,6,4,4,3,1,1,3,1,1,1,1,1,1,1,1,3,2,4,6,1,4,4,3,1,8,5,1,6,3,3,5,1,1,1,1,6,2,5,9,6,1,3,9,2,2,1,2,1,6,3,5,2,1,9,5,1,4,4,2,1,7,2,6,1,2,1,2,1,2,6,3,1,3,1,1,9,2,4,7,3,4,3,2,3,1,8,1,1,1,1,9,2,1,8,9,8,6,8,4,4,1,7,5,6,1,6,4,3,3,7,1,1,5,4,7,1,6,2,9,1,2,1,5,1,2,1,1,5,1,1,1,9,1,9,3,4,9,1,1,2,1,4,6,1,2,2,3,2,1,8,1,1,1,3,9,6,5,1,5,7,4,2,2,1,4,1,1,1,1,8,8,2,2,3,1,1,2,1,1,1,1,9,1,3,1,1,1,1,6,3,7,1,1,8,1,3,5,4,6,4,3,1,6,3,3,3,2,2,4,3,2,1,2,8,3,3,2,4,3,5,2,1,1,4,2,4,1,6,1,8,2,2,1,2,1,1,1,1,4,1,1,2,2,4,1,1,8,7,5,9,1,7,1,7,7,4,1,3,2,4,1,1,2,1,4,1,6,7,1,8,1,5,7,6,4,1,2,4,1,1,1,1,1,8,8,2,2,3,4,5,5,5,8,2,3,5,8,6,1,9,2,2,9,3,1,5,6,1,1,1,1,1,7,2,6,1,1,2,1,9,3,1,3,3,7,2,2,8,1,1,1,8,5,4,8,8,1,2,1,1,1].

%iran Benfords law test

iranTask()->
    Idata = iran(),
	Itotal = length(Idata),
	Iddata = actual_distribution(Idata),
	Idddata = lists:sort( dict:fetch_keys(Iddata)),
    io:fwrite( "Iran		Number	Actual      	Benfords expected~n" ),
	[io:fwrite("~p	~p	~p	~p~n", ["Iran", X, dict:fetch(X, Iddata) / Itotal, distribution(X)]) || X <- Idddata].

%irans 2009 presidential election first digit information sourced from https://github.com/midnightradio/cse140-data-programming

iran()->
	[1,1,7,8,2,1,1,2,6,1,2,6,1,2,1,1,3,6,2,3,6,4,6,8,1,5,1,7,2,2,2,2,1,5,7,9,3,3,3,3,2,7,3,1,4,6,4,5,3,1,6,3,7,1,7,8,3,2,4,1,4,2,4,5,2,3,9,9,3,1,3,2,4,1,8,3,2,3,3,4,2,1,4,3,4,1,1,1,5,2,2,2,2,4,7,2,1,5,5,5,6,2,4,2,7,3,3,3,4,4,6,1,5,9,5,9,1,1,2,1,7,2,1,2,2,4,7,2,1,6,6,6,7,4,1,2,1,5,9,5,6,3,7,1,2,6,1,5,9,1,1,4,3,1,1,1,1,5,1,1,3,9,1,9,1,2,8,4,9,3,2,3,4,5,5,1,3,8,1,8,1,9,1,7,4,1,1,1,1,6,1,4,2,9,8,9,1,1,1,1,5,1,1,1,1,5,1,4,1,7,7,7,8,4,7,5,2,7,5,7,9,7,1,1,2,1,9,1,1,3,8,2,2,6,5,6,6].

%last digit benfords law test ie benfords law doesn't apply so the percentages don't match up as expected

falseTask() ->
	Ending = lister(),
    Total =length(Ending),
	Lastdigit = actual_distribution(Ending),
	Endpoint = lists:sort( dict:fetch_keys(Lastdigit)),
    io:fwrite( "Random		Number	Actual	Benfords expected~n" ),
	[io:fwrite("~p	~p	~p	~p~n", ["Random", X, dict:fetch(X, Lastdigit) / Total, distribution(X)]) || X <- Endpoint].

%list of 1000 random digits

lister() ->
    [rand:uniform(9) || _ <- lists:seq(1,1000)].

%fibonacci benfords law test, matches perfectly almost

fiboTask() ->
    Numbers = fibo(),
	Total = length(Numbers),
	Actual_dict = actual_distribution( Numbers ),
	Keys = lists:sort( dict:fetch_keys( Actual_dict) ),
    io:fwrite( "Fibonacci	Number	Actual            	Benfords expected~n" ),
	[io:fwrite("~p	~p	~p	~p~n", ["Fibonacci", X, dict:fetch(X, Actual_dict) / Total, distribution(X)]) || X <- Keys].

%recursively creates the fibonacci sequence up to 1000 times

fibo()->
    Total = 1000,
    fib( Total ).
fib( N ) -> fib( N, 0, 1, [] ).
fib( 0, Current, _, Acc ) -> lists:reverse( [Current | Acc] );
fib( N, Current, Next, Acc ) -> fib( N-1, Next, Current+Next, [Current | Acc] ). 

%adds information to a dictionary with the key being 1-9 and the value being the amount of times that digit appears in the list

first_digit_count( 0, Dict ) -> Dict;
first_digit_count( N, Dict ) ->
	[Key | _] = erlang:integer_to_list( N ),
	dict:update_counter( Key - 48, 1, Dict ).