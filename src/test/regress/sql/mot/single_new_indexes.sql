
-- BUG 92

create foreign table test_new_index (x float4 not null, y float8 not null, z varchar(1) not null);

create index idx1 on test_new_index (x);
create index idx2 on test_new_index (y);
create index idx3 on test_new_index (z);

insert into test_new_index values (1,1,'1');
select * from test_new_index where z = 49;

-- CRASH
drop foreign table test_new_index;

-- BUG 91
create foreign table test_new_index (x int not null, y int not null, z int not null, primary key(x,y,z));
create index idx1 on test_new_index (x);
create index idx2 on test_new_index (y);
create index idx3 on test_new_index (z);

insert into test_new_index (y,x,z) values (generate_series(10,20), generate_series(10,20), generate_series(10,20));

delete from test_new_index where y > x;

drop foreign table test_new_index;

-- BUG 90
create foreign table test_new_index (x int not null, y int not null, z int not null, primary key(x,y,z));
create index idx1 on test_new_index (x);
create index idx2 on test_new_index (y);
create index idx3 on test_new_index (z);

insert into test_new_index (y,x,z) values (generate_series(10,20), generate_series(10,20), generate_series(10,20));

select * from test_new_index where x = 9;

drop foreign table test_new_index;

-- BUG 89
create foreign table test_new_index (i integer not null, i2 int2 not null, i4 int4 not null, i8 int8 not null, n numeric not null, f4 float4 not null, f8 float8 not null, s serial not null, c char not null, v varchar(10) not null, vchar varchar(1020) not null, d date not null, t time not null, ts timestamp not null, intrvl interval not null, b boolean not null);

create index idx1 on test_new_index (i);
create index idx2 on test_new_index (i2);
create index idx3 on test_new_index (i4);
create index idx4 on test_new_index (i8);
create index idx5 on test_new_index (i,i2,i4);
create index idx6 on test_new_index (f4,f8);
create index idx7 on test_new_index (c,v);
create index idx8 on test_new_index (d,t,ts);
create index idx9 on test_new_index (intrvl);
create index idx10 on test_new_index (b);

insert into test_new_index (i, i2, i4) values (generate_series(1,100), generate_series(1,100), generate_series(1,100));
select * from test_new_index order by i limit 10;

drop foreign table test_new_index;

-- BUG 87
create foreign table test_new_index (f1 float4 not null, f2 float8 not null, primary key (f1, f2)) ;

create index idx1 on test_new_index (f1);
create index idx2 on test_new_index (f2);

insert into test_new_index values (0.0, 0.1);
insert into test_new_index values (0.0, -0.1);
insert into test_new_index values (-0.10, 0.1);
insert into test_new_index values (0.101, 0.1);
insert into test_new_index values (1.0, 0.1);
insert into test_new_index values (-1.10000001, 0.1);

select * from test_new_index order by f1;
select * from test_new_index where f1 > -10.2 order by f1, f2;

drop foreign table test_new_index;

-- BUG 86
create foreign table test_new_index (v1 varchar(4) not null, v2 varchar(4) not null, primary key (v1, v2));
create index idx on test_new_index (v1);
create index idx2 on test_new_index (v2);

insert into test_new_index values ('aaaa','aaaa');
insert into test_new_index values ('aaaa','bbbb');
insert into test_new_index values ('bbbb','bbbb');
insert into test_new_index values ('bbbb','aaaa');

select * from test_new_index order by 1,2;

select * from test_new_index where v1 = 'aaa';
select * from test_new_index where v1 = 'bb';

drop foreign table test_new_index;

-- BUG 85
create foreign table test_new_index (x int not null, y int not null, z int not null, primary key(x,y,z));

create unique index udx1 on test_new_index (x,y,z);
create index udx1 on test_new_index (x,y,z);
create index idx1 on test_new_index (x);
create index idx2 on test_new_index (y);
create index idx3 on test_new_index (z);

insert into test_new_index values (1,2,3);
insert into test_new_index values (2,3,4);
insert into test_new_index values (3,4,5);
insert into test_new_index values (4,5,6);
insert into test_new_index values (5,6,7);
insert into test_new_index values (6,7,8);

select * from test_new_index where x > 4 and x = 5 order by x,y,z;

drop foreign table test_new_index;

-- BUG 84
CREATE FOREIGN TABLE func_index_heap (f1 varchar(100) not null, f2 varchar(100) not null) ;
CREATE UNIQUE INDEX func_index_index on func_index_heap ((f1 || f2) text_ops);

drop foreign table func_index_heap;
drop index func_index_index;

-- BUG 83
CREATE FOREIGN TABLE func_index_heap (f1 varchar(100) not null, f2 varchar(100) not null); 
CREATE UNIQUE INDEX func_index_index on func_index_heap (textcat(f1,f2));

drop foreign table func_index_heap;
drop index func_index_index;

-- BUG 82
create foreign table test_new_index (i int not null, i2 int2 not null, i4 int4 not null, i8 int8 not null, primary key (i));
create index idx1 on test_new_index (i, i2, i4, i8);
insert into test_new_index values (generate_series(1,100), generate_series(1,100), generate_series(1,100), generate_series(1,100));

select * from test_new_index where i = i2 and i2 = i4 and i4 = i8 and i8 = i order by i,i2,i4,i8 limit 10;

drop foreign table test_new_index;

-- BUG 81
create foreign table test_new_index (v1 varchar(1) not null, v2 varchar(1) not null, primary key (v1, v2));
create index idx on test_new_index (v1);
create index idx2 on test_new_index (v2);

insert into test_new_index values ('a','a');
insert into test_new_index values ('a','b');
insert into test_new_index values ('b','b');
insert into test_new_index values ('b','a');

select * from test_new_index order by 1,2;

select * from test_new_index where v1 = 'a' order by v1,v2;
select * from test_new_index where v1 = 'ab';
select * from test_new_index where v1 = 'abc';
select * from test_new_index where v1 = 'abcd';

drop foreign table test_new_index;

--BUG in MAX_KEY_LEN
create foreign table test_new_index (i varchar(8) not null, j varchar(244) not null);
create index tx on test_new_index (j);
create index tx2 on test_new_index (i);
create index tx3 on test_new_index (i,j);
create index tx4 on test_new_index (j,i);
create index tx7 on test_new_index (j);
create index tx8 on test_new_index (i);

drop foreign table test_new_index;--







