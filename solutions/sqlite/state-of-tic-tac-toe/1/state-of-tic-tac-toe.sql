-- Dedicated to Junko F. Didi and Shree DR.MDD  

UPDATE "state-of-tic-tac-toe" SET (result, error) = (
	WITH tokens(pos, rowid, sym) AS (
		SELECT 2, 0, substr(board, 1, 1)
	    UNION
    	SELECT pos + 1, iif((pos - 1) % 4, rowid + 1, rowid), substr(board, pos, 1)
    	FROM tokens WHERE pos <= length(board)
	),
	plays(r, c, mark) AS (
		SELECT CAST(rowid / 3 AS INT), rowid % 3, sym FROM tokens WHERE sym IN ('X', 'O')
      	UNION VALUES (NULL, NULL, 'X'), (NULL, NULL, 'O')
	),
	summary(mark, cnt, victory) AS (
        SELECT mark,
               COUNT(r),
               sum(r = 0) = 3 OR sum(r = 1) = 3 OR sum(r = 2) = 3
                   OR sum(c = 0) = 3 OR sum(c = 1) = 3 OR sum(c = 2) = 3
                   OR sum(r - c = 0) = 3 OR sum(r + c = 2) = 3
        FROM plays GROUP BY mark
	),
  	merged(x_cnt, o_cnt, x_win, o_win) AS (
      	SELECT x.cnt, o.cnt, x.victory, o.victory
    	FROM (SELECT * FROM summary WHERE mark = 'X') x,
             (SELECT * FROM summary WHERE mark = 'O') o
    ),
  	issues(err)  AS (
    	SELECT CASE
        	WHEN o_cnt = x_cnt + 1 THEN 'Wrong turn order: O started'
            WHEN x_cnt = o_cnt + 2 THEN 'Wrong turn order: X went twice'
            WHEN x_win AND o_win THEN 'Impossible board: game should have ended after the game was won'
      	END FROM merged
    ),
  	final(outcome) AS (
      	SELECT CASE
            WHEN err IS NULL THEN CASE
      		    WHEN x_win OR o_win THEN 'win'
                WHEN x_cnt + o_cnt = 9 THEN 'draw'
      		    ELSE 'ongoing'
            END
        END FROM merged, issues
    )
  	SELECT outcome, err FROM final, issues
);
