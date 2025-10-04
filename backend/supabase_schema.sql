create table cities ( id serial primary key, name text not null );
create table agents ( id serial primary key, name text not null, city_id int references cities(id), phone text, balance int default 0 );
create table users ( id serial primary key, name text, phone text, language text default 'en', role text default 'user' );
create table pools ( id serial primary key, item_name text, sector text, target int, collected int default 0, city_id int references cities(id), status text default 'open', admin_share int default 0, agent_share int default 0 );
create table contributions ( id serial primary key, user_id int references users(id), pool_id int references pools(id), amount int, created_at timestamptz default now() );
create table draws ( id serial primary key, pool_id int references pools(id), winner_id int references users(id), admin_share int, agent_share int, created_at timestamptz default now() );
create or replace function increment_pool_collected(p_pool_id int, p_amount int) returns void language plpgsql as $$ begin update pools set collected = coalesce(collected,0) + p_amount where id = p_pool_id; end; $$;
create or replace function select_filled_pools() returns table(id int, item_name text, target int, collected int) language sql as $$ select id,item_name,target,collected from pools where collected >= target and status='open'; $$;
