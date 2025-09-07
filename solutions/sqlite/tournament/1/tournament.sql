-- Dedicated to Junko F. Didi and Shree DR.MDD  

UPDATE tournament SET result = (
    WITH scanner(idx, rownum, colnum, ch) AS (
        SELECT 2, 0, 0, substr(input, 1, 1)
        UNION ALL
        SELECT idx + 1, rownum + (ch = char(10)), (colnum + (ch in (';', char(10)))) % 3, substr(input, idx, 1)
        FROM scanner WHERE idx <= length(input)
    ),
    matches(t1, t2, outcome) AS (
        SELECT group_concat(ch, '') FILTER (WHERE colnum = 0),
               group_concat(ch, '') FILTER (WHERE colnum = 1),
               group_concat(ch, '') FILTER (WHERE colnum = 2)
        FROM scanner WHERE ch NOT IN (';', char(10), '') GROUP BY rownum
    ),
    scores(team, pts) AS (
        SELECT t1, CASE outcome WHEN 'win' THEN 3 WHEN 'draw' THEN 1 ELSE 0 END FROM matches
        UNION ALL
        SELECT t2, CASE outcome WHEN 'win' THEN 0 WHEN 'draw' THEN 1 ELSE 3 END FROM matches
    ),
    standings(team, mp, w, d, l, pts) AS (
        SELECT team,
               count(*),
               count(pts) FILTER (WHERE pts = 3),
               count(pts) FILTER (WHERE pts = 1),
               count(pts) FILTER (WHERE pts = 0),
               sum(pts)
        FROM scores GROUP BY team
    ),
    lines(txt) AS (
        SELECT 'Team                           | MP |  W |  D |  L |  P'
        UNION ALL
        SELECT format('%-31s|% 3u |% 3u |% 3u |% 3u |% 3u', team, mp, w, d, l, pts)
        FROM (SELECT * FROM standings ORDER BY pts DESC, team)
    )
    SELECT group_concat(txt, char(10)) FROM lines
);
