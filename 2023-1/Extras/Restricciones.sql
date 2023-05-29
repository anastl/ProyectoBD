-- Constraint: Personaje_check_EstadoMarital
-- ALTER TABLE IF EXISTS "Proyecto Fase 2"."Personaje" DROP CONSTRAINT IF EXISTS "Personaje_check_EstadoMarital";
ALTER TABLE IF EXISTS "Proyecto Fase 2"."Personaje"
    ADD CONSTRAINT "Personaje_check_EstadoMarital" CHECK ("EstadoMarital" = ANY (ARRAY['Soltero', 'Casado', 'Viudo', 'Divorciado']));

-- Constraint: Personaje_check_Sexo
-- ALTER TABLE IF EXISTS "Proyecto Fase 2"."Personaje" DROP CONSTRAINT IF EXISTS "Personaje_check_Sexo";
ALTER TABLE IF EXISTS "Proyecto Fase 2"."Personaje"
    ADD CONSTRAINT "Personaje_check_Sexo" CHECK ("Sexo" = ANY (ARRAY['M', 'F', 'Desc', 'Otro']));

