begin;

update skiplocked_t1 set info = 'two2' where id = 2;

select pg_sleep(5);

end;
