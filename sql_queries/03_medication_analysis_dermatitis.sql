SELECT 
    c.DESCRIPTION as illness_name,
    MAX(DATE_DIFF(m.stop, m.START, DAY)) as treatment_time,
    m.ENCOUNTER,
    COALESCE(STRING_AGG(DISTINCT m.DESCRIPTION, " + "), 'No medication prescribed') as medication_combination
FROM `steel-signifier-477914-a0.Patient_Records.raw_conditions` AS c
LEFT JOIN `steel-signifier-477914-a0.Patient_Records.raw_medications` AS m
ON c.ENCOUNTER = m.ENCOUNTER
WHERE c.DESCRIPTION IN ('Viral sinusitis (disorder)', 'Acute viral pharyngitis (disorder)', 'Otitis media', 'Contact dermatitis')
GROUP BY illness_name, m.ENCOUNTER
ORDER BY treatment_time DESC;


-- Analysis revealed that while respiratory infections are heavily medicated,
-- skin conditions like Contact dermatitis frequently show no 
-- linked pharmacological treatment in the dataset, suggesting non-drug interventions
-- or data recording gaps.