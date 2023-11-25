select *from dbo.ipl_ball_by_ball_2008_2022
select *from dbo.ipl_matches_2008_2022;
select count(*)from dbo.ipl_matches_2008_2022 as total where team1='Deccan Chargers' 
use IPL_Database;
select *from dbo.ipl_ball_by_ball_2008_2022 ;
select *from dbo.ipl_matches_2008_2022;
describe dbo.ipl_ball_by_ball_2008_2022;
describe dbo.ipl_matches_2008_2022;
select *from dbo.ipl_ball_by_ball_2008_2022 where batting_team='Mumbai Indians';
select *from dbo.ipl_ball_by_ball_2008_2022 order by total_run desc;
SELECT batting_team, COUNT(*) FROM dbo.ipl_ball_by_ball_2008_2022 GROUP BY batting_team;

select * from dbo.ipl_ball_by_ball_2008_2022 as s
join dbo.ipl_matches_2008_2022 as m on s.id=m.id;
select * from dbo.ipl_ball_by_ball_2008_2022 as s
inner join dbo.ipl_matches_2008_2022 as m on s.id=m.id;
select * from dbo.ipl_ball_by_ball_2008_2022 as s
left join dbo.ipl_matches_2008_2022 as m on s.id=m.id;
select * from dbo.ipl_ball_by_ball_2008_2022 as s
right join dbo.ipl_matches_2008_2022 as m on s.id=m.id;
SELECT *
FROM dbo.ipl_ball_by_ball_2008_2022
WHERE id IN (SELECT id FROM dbo.ipl_matches_2008_2022 WHERE city = 'Mumbai');
select team1 count(*) as total_dbo.ipl_matches_2008_2022 from dbo.ipl_ball_by_ball_2008_2022 group by team2;
SELECT team2 COUNT(*) AS total_dbo.ipl_matches_2008_2022
FROM dbo.ipl_ball_by_ball_2008_2022
where noball_runs=0
GROUP BY batting_team
HAVING COUNT(*) > 1000;
SELECT team1, team2, sum(won_by) AS sum_win_margin, avg(margin) as avg_wickets_win
FROM dbo.ipl_matches_2008_2022
WHERE player_of_match IS NOT NULL
GROUP BY team1,team2;
SELECT team1, team2, won_by,
ROW_NUMBER() OVER (PARTITION BY team1, team2 ORDER BY win_by_runs DESC) AS rank1
FROM dbo.ipl_matches_2008_2022
WHERE winning_team IS NOT NULL;

SELECT player_out,
       CASE
           WHEN dismisal_kind = 'caught' THEN 'Caught Out'
           WHEN dismisal_kind = 'bowled' THEN 'Bowled Out'
           when dismisal_kind = 'caught and bowled' then 'Caught and Bowled Out'
           ELSE 'Not Out'
       END AS dismissal_type
FROM dbo.ipl_ball_by_ball_2008_2022;
SELECT * FROM dbo.ipl_ball_by_ball_2008_2022 WHERE batter LIKE 'G%';
SELECT * FROM dbo.ipl_ball_by_ball_2008_2022 WHERE batter LIKE 'J__e%';
SELECT * FROM dbo.ipl_ball_by_ball_2008_2022 WHERE extras_run BETWEEN 2 AND 4;
#nullvalues
SELECT * FROM dbo.ipl_ball_by_ball_2008_2022 WHERE player_out IS NULL;

#handle null values with coalesce

SELECT COALESCE(player_out, 'Not Applicable') AS dismissal_status FROM dbo.ipl_ball_by_ball_2008_2022;

#aggregations

SELECT batting_team, SUM(total_run) AS total_runs, round(AVG(total_run),2) AS avg_runs,
       MIN(total_run) AS min_runs, MAX(total_run) AS max_runs
FROM dbo.ipl_ball_by_ball_2008_2022
GROUP BY batting_team;

#More about coalesce function

SELECT player_out, COALESCE(player_dismissed, 'Not Available') AS adjusted_name
FROM dbo.ipl_ball_by_ball_2008_2022;
