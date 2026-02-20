SELECT 
    c.DESCRIPTION as illness_name,
    -- Categorize conditions based on duration (1 year threshold)
    CASE 
      WHEN DATE_DIFF(c.STOP, c.START, day) > 365 THEN 'Chronic'
      ELSE 'Acute (Short-term)'
      END as condition_type,
    ROUND(AVG(DATE_DIFF(c.STOP, c.START, day)), 0) as avg_recovery_days,
    -- Calculate total treatment duration in days
    COUNT(*) as total_cases
FROM `steel-signifier-477914-a0.Patient_Records.raw_encounters` AS e
JOIN `steel-signifier-477914-a0.Patient_Records.raw_conditions` AS c
ON c.ENCOUNTER = e.ID
WHERE c.STOP IS NOT NULL
AND c.START != c.STOP
GROUP BY illness_name, condition_type
ORDER BY avg_recovery_days DESC;