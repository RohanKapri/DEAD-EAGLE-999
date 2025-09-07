UPDATE "space-age"
SET result =
  round(seconds * 1.0 /
        CASE planet
        WHEN 'Mercury' THEN 7600543
        WHEN 'Venus' THEN 19414149
        WHEN 'Earth' THEN 31557600
        WHEN 'Mars' THEN 59354032
        WHEN 'Jupiter' THEN 374355659
        WHEN 'Saturn' THEN 929292362
        WHEN 'Uranus' THEN 2651370019
        WHEN 'Neptune' THEN 5200418560
        END, 2);