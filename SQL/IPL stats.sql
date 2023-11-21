use ipl;
select *from  statistics;
select *from matches;
describe statistics;
describe matches;
select *from statistics where batting_team='Mumbai Indians';
select *from statistics order by total_runs desc;
SELECT batting_team, COUNT(*) FROM statistics GROUP BY batting_team;
ALTER TABLE matches RENAME COLUMN match_id TO id;
select * from statistics as s
join matches as m on s.match_id=m.match_id;
select * from statistics as s
inner join matches as m on s.match_id=m.match_id;
select * from statistics as s
left join matches as m on s.match_id=m.match_id;
select * from statistics as s
right join matches as m on s.match_id=m.match_id;
SELECT *
FROM statistics
WHERE match_id IN (SELECT match_id FROM matches WHERE city = 'Mumbai');
select bowling_team as team,count(*) as total_matches from statistics group by bowling_team;
SELECT batting_team, COUNT(*) AS total_matches
FROM statistics
where noball_runs=0
GROUP BY batting_team
HAVING COUNT(*) > 1000;
SELECT team1, team2, sum(win_by_runs) AS sum_win_margin, avg(win_by_wickets) as avg_wickets_win
FROM matches
WHERE player_of_match IS NOT NULL
GROUP BY team1,team2;
SELECT team1, team2, win_by_runs,
ROW_NUMBER() OVER (PARTITION BY team1, team2 ORDER BY win_by_runs DESC) AS rank1
FROM matches
WHERE winner IS NOT NULL;

SELECT player_dismissed,
       CASE
           WHEN dismissal_kind = 'caught' THEN 'Caught Out'
           WHEN dismissal_kind = 'bowled' THEN 'Bowled Out'
           when dismissal_kind = 'caught and bowled' then 'Caught and Bowled Out'
           ELSE 'Not Out'
       END AS dismissal_type
FROM statistics;
SELECT * FROM statistics WHERE batsman LIKE 'G%';
SELECT * FROM statistics WHERE batsman LIKE 'J__e%';
SELECT * FROM statistics WHERE wide_runs BETWEEN 2 AND 4;
#null values
SELECT * FROM statistics WHERE player_dismissed IS NULL;

#handle null values with coalesce

SELECT COALESCE(player_dismissed, 'Not Applicable') AS dismissal_status FROM statistics;

#aggregations

SELECT batting_team, SUM(total_runs) AS total_runs, round(AVG(total_runs),2) AS avg_runs,
       MIN(total_runs) AS min_runs, MAX(total_runs) AS max_runs
FROM statistics
GROUP BY batting_team;

#More about coalesce function

SELECT player_dismissed, COALESCE(player_dismissed, 'Not Available') AS adjusted_name
FROM statistics;














