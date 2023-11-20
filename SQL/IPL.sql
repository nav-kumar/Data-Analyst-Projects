create database IPL;
use ipl;
select *from matches;
select count(*)from deliveries; 
drop table deliveries;
create table Statistics(
    match_id int,
    inning int,
    batting_team text,
    bowling_team text,
	over_count int,
    ball int,
    batsmen text,
    non_striker text,
    bowler text,
    is_super_over int,
    wide_runs int,
    legbye_runs int,
    bye_runs int,
    noball_runs int,
    penalty_runs int,
    batsmen_runs int,
    extra_runs int,
    total_runs int,
    player_dismissed text,
    dismissal_kind text,
    fielder text);
    
    select *from statistics;
    load data local infile 'C:/Program Files/MySQL/MySQL Server 8.0/statistics.csv' into table statistics;
  

