--
--    Copyright 2010-2023 the original author or authors.
--
--    Licensed under the Apache License, Version 2.0 (the "License");
--    you may not use this file except in compliance with the License.
--    You may obtain a copy of the License at
--
--       https://www.apache.org/licenses/LICENSE-2.0
--
--    Unless required by applicable law or agreed to in writing, software
--    distributed under the License is distributed on an "AS IS" BASIS,
--    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--    See the License for the specific language governing permissions and
--    limitations under the License.
--

-- // The MyBatis parent POM.
-- Migration SQL that makes the change goes here.

-- // cave insert trigger
CREATE OR REPLACE FUNCTION prehistoric_cave_insert_function ()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO proletarian.job(
        job_type, payload
    )
    VALUES (
        ':prehistoric.cave/insert', row_to_json(NEW)
    );
    return NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prehistoric_cave_insert_trigger
AFTER INSERT ON prehistoric.cave
FOR EACH ROW
EXECUTE PROCEDURE prehistoric_cave_insert_function();

-- //@UNDO
-- SQL to undo the change goes here.

DROP TRIGGER prehistoric_cave_insert_trigger ON prehistoric.cave;
DROP FUNCTION prehistoric_cave_insert_function;

