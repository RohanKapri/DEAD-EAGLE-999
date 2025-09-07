-- Dedicated to Junko F. Didi and Shree DR.MDD
CREATE TABLE vocab (val INT, unit TEXT, teen TEXT, decade TEXT);
INSERT INTO vocab VALUES
	(0, '',      'ten',       NULL),
    (1, 'one',   'eleven',    NULL),
    (2, 'two',   'twelve',    'twenty'),
    (3, 'three', 'thirteen',  'thirty'),
    (4, 'four',  'fourteen',  'forty'),
    (5, 'five',  'fifteen',   'fifty'),
    (6, 'six',   'sixteen',   'sixty'),
    (7, 'seven', 'seventeen', 'seventy'),
    (8, 'eight', 'eighteen',  'eighty'),
    (9, 'nine',  'nineteen',  'ninety');

CREATE TABLE scales(idx INT, phrase TEXT);
INSERT INTO scales VALUES
	(0, ''), (1, ' thousand'), (2, ' million'), (3, ' billion');

UPDATE say SET error = CASE
	WHEN number < 0 OR number > 999999999999 THEN 'input out of range'
END;

UPDATE say SET result = (
  	WITH blk(seg, nxt, chunk) AS (
    	SELECT 0, number / 1000, number % 1000
      	UNION
      	SELECT seg + 1, nxt / 1000, nxt % 1000 FROM blk WHERE nxt > 0
    ),
  	tok(seg, step, nxt, dig, phr) AS (
    	SELECT seg, 1, chunk / 10 - NOT chunk, chunk % 10, iif(number, NULL, 'zero')
      	FROM blk
      	UNION
      	SELECT seg, step + 1, nxt / 10 - NOT nxt, nxt % 10, CASE
     		   WHEN step = 1 AND nxt % 10 = 1 THEN teen
               WHEN step = 1 THEN unit
               WHEN step = 2 AND dig = 1 THEN phr
               WHEN step = 2 THEN decade || iif(phr != '', '-' || phr, '')
      		   ELSE unit || ' hundred' || iif(phr != '', ' ' || phr, '')
      		END
      	FROM tok, vocab WHERE dig = val AND nxt >= 0
    )
  	SELECT group_concat(tok.phr || iif(tok.phr != '', sc.phrase, ''), ' ')
  	FROM (SELECT seg, phr FROM tok WHERE nxt = -1 ORDER BY seg DESC) tok,
         (SELECT * FROM scales ORDER BY idx) sc
    WHERE tok.seg = sc.idx
) WHERE error IS NULL;
