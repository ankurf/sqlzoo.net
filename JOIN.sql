--Table game (id, mdate, stadium, team1, team2)
--Table goal (matchid, teamid, player, gtime)
--Table eteam (id, teamname, coach)

--1. The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
--Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player name FROM goal 
WHERE teamid = 'GER'

--2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
--Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
--Show id, stadium, team1, team2 for just game 1012
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;

--3. show the player, teamid, stadium and mdate and for every German goal.
SELECT goal.player, goal.teamid, game.stadium, game.mdate
FROM game 
JOIN goal 
ON (game.id=goal.matchid)
where goal.teamid='GER';

--4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT game.team1, game.team2, goal.player
FROM game
JOIN goal
ON goal.matchid = game.id
WHERE goal.player LIKE 'Mario%';

--5. The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
--Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT goal.player, goal.teamid, eteam.coach, goal.gtime
FROM goal 
JOIN eteam
ON eteam.id=goal.teamid
WHERE goal.gtime<=10;

--6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT game.mdate, eteam.teamname
FROM game
JOIN eteam
ON eteam.id = game.team1
WHERE eteam.coach = 'Fernando Santos';

--7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT goal.player
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw';

--8. show the name of all players who scored a goal against Germany.
SELECT DISTINCT goal.player
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE goal.teamid != 'GER'
AND (game.team1 = 'GER' OR game.team2 = 'GER';

--9. Show teamname and the total number of goals scored.
SELECT eteam.teamname, COUNT(gtime)
FROM eteam
JOIN goal
ON eteam.id = goal.teamid
GROUP BY eteam.teamname;

--10. Show the stadium and the number of goals scored in each stadium.
SELECT game.stadium, COUNT(gtime)
FROM game
JOIN goal
ON game.id = goal.matchid
GROUP BY game.stadium;

--11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT goal.matchid, game.mdate, COUNT(gtime)
FROM game JOIN goal ON goal.matchid = game.id 
WHERE (game.team1 = 'POL' OR game.team2 = 'POL')
GROUP BY goal.matchid, game.mdate;

--12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT game.id, game.mdate, COUNT(gtime)
FROM game
JOIN goal
ON goal.matchid = game.id
WHERE goal.teamid = 'GER'
GROUP BY game.id, game.mdate;

