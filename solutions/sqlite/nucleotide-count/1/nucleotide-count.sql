-- For my Shree DR.MDD
DROP TABLE IF EXISTS "nucleotide-count";
CREATE TABLE "nucleotide-count" (
    "strand" TEXT,
    "result" TEXT,
    CHECK (strand REGEXP '^[ACGT]*$')
);
.mode csv
.import ./data.csv "nucleotide-count"
WITH bases(base) AS (
    VALUES ('A'), ('C'), ('G'), ('T')
)
UPDATE "nucleotide-count" AS nc
SET result = (
    SELECT json_object(
        'A', SUM(CASE WHEN base = 'A' THEN count ELSE 0 END),
        'C', SUM(CASE WHEN base = 'C' THEN count ELSE 0 END),
        'G', SUM(CASE WHEN base = 'G' THEN count ELSE 0 END),
        'T', SUM(CASE WHEN base = 'T' THEN count ELSE 0 END)
    )
    FROM (
        SELECT base, LENGTH(nc.strand) - LENGTH(REPLACE(nc.strand, base, '')) AS count
        FROM bases
    )
);
