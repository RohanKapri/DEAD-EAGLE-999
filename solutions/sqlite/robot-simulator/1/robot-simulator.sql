UPDATE "robot-simulator" SET result = input WHERE property = 'create';
UPDATE "robot-simulator" SET result = (
  	WITH ds(dir, d) AS ( VALUES ('east', 0), ('south', 1), ('west', 2), ('north', 3) ),
  	ms(n, ins, x, y, dir) AS (
    	SELECT 1, 'START', input ->> '$.position.x', input ->> '$.position.y', d
      	FROM (SELECT d FROM ds WHERE ds.dir = input ->> 'direction')
      	UNION ALL
      	SELECT n + 1, substr(input ->> 'instructions', n, 1),
      		   iif(ins = 'A' AND dir in (0, 2), x + iif(dir = 0, 1, -1), x),
      		   iif(ins = 'A' AND dir in (1, 3), y + iif(dir = 3, 1, -1), y),
      		   CASE ins
      		       WHEN 'L' THEN iif(dir = 0, 3, dir - 1)
                   WHEN 'R' THEN (dir + 1) % 4
                   ELSE dir
               END
      	FROM ms WHERE ins != ''
    )
	SELECT json_object('position', json_object('x', x, 'y', y), 'direction', ds.dir)
  	FROM ms, ds WHERE ins = '' AND ms.dir = ds.d
) WHERE property = 'move';