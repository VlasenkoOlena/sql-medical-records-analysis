SELECT 
    c.DESCRIPTION as illness_name,
    DATE_DIFF(m.stop, m.START, DAY) as treatment_time,
    m.ENCOUNTER,
    STRING_AGG(DISTINCT m.DESCRIPTION, " + ") as medication_combination
FROM `steel-signifier-477914-a0.Patient_Records.raw_conditions` AS c
JOIN `steel-signifier-477914-a0.Patient_Records.raw_medications` AS m
  ON c.ENCOUNTER = m.ENCOUNTER
WHERE c.DESCRIPTION IN ('Viral sinusitis (disorder)', 'Acute viral pharyngitis (disorder)')
  AND m.stop IS NOT NULL
  -- Exclude non-relevant long-term medications (noise)
  AND m.DESCRIPTION NOT LIKE '%28 Day Pack%'
  AND m.DESCRIPTION NOT LIKE '%Mirena%'
  AND m.DESCRIPTION NOT LIKE '%Implanon%'
  AND m.DESCRIPTION NOT LIKE '%Levora%'
  AND m.DESCRIPTION NOT LIKE '%Diazepam%'
GROUP BY illness_name, treatment_time, m.ENCOUNTER;


--I discovered a discrepancy where respiratory infections were linked to 
--long-term hormonal treatments. This is a common feature of clinical 
--databases where active chronic medications are recorded alongside 
--acute prescriptions during a single patient encounter. To ensure the 
--integrity of my recovery analysis, I implemented a 'Black-list' filter 
--to isolate only relevant acute treatments.
