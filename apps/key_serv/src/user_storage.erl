-module(user_storage).

-export([create_table/0,all_users/0,user_key/1,user_key/2]).

-record(users,{name,key}).

create_table() ->
    mnesia:create_table(users,[{disc_copies,[node()]},{attributes,record_info(fields,users)}]).

all_users() ->
    {atomic, UserRecordList} = mnesia:transaction(fun() ->
							  lists:map(fun(Key) ->
									    mnesia:read(users,Key,read)
								    end,mnesia:all_keys(users))
						    end),
    
    lists:map(fun([UserRecord]) ->
    		      UserRecord#users.name
    	      end,UserRecordList).

user_key(Username) ->
    {atomic,UserKeyList} = mnesia:transaction(fun() ->
						      mnesia:read(users,Username,read)
					      end),
    lists:map(fun(UserRecord) ->
		      UserRecord#users.key
	      end,UserKeyList).

user_key(Username,Key) ->
    mnesia:transaction(fun() ->
			       mnesia:write(#users{name=Username,key=Key})
		       end).
