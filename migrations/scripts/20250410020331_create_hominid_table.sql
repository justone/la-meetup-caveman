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
CREATE TABLE prehistoric.hominid (
    id uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    "name" text,
    cave_id uuid REFERENCES prehistoric.cave (id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

CREATE TRIGGER set_prehistoric_hominid_updated_at
BEFORE UPDATE ON prehistoric.hominid
FOR EACH ROW
EXECUTE PROCEDURE prehistoric.set_current_timestamp_updated_at();

CREATE INDEX prehistoric_hominid_cave_id_idx
ON prehistoric.hominid
USING btree (cave_id);


-- //@UNDO
-- SQL to undo the change goes here.

DROP TABLE prehistoric.hominid;

