CREATE DATABASE pbsacct;
USE pbsacct;
CREATE TABLE Jobs (
  jobid        VARCHAR(64) PRIMARY KEY,
  system       VARCHAR(32),
  username     VARCHAR(32),
  groupname    VARCHAR(32),
  account      VARCHAR(32),
  submithost   VARCHAR(32),
  jobname      TINYTEXT,
  nproc        INT UNSIGNED DEFAULT 1,
  mppe         INT UNSIGNED,
  mppssp       INT UNSIGNED,
  nodes        TEXT,
  nodect       INT UNSIGNED DEFAULT 0,
  feature      TINYTEXT,
  gattr        TINYTEXT,
  gres         TINYTEXT,
  queue        TINYTEXT,
  qos          TINYTEXT,
  submit_ts    INT,
  submit_date  DATE,
  start_ts     INT,
  start_date   DATE,
  end_ts       INT,
  end_date     DATE,
  cput_req     TIME DEFAULT '00:00:00',
  cput_req_sec BIGINT UNSIGNED DEFAULT 0,
  cput         TIME DEFAULT '00:00:00',
  cput_sec     BIGINT UNSIGNED DEFAULT 0,
  walltime_req TIME DEFAULT '00:00:00',
  walltime_req_sec BIGINT UNSIGNED DEFAULT 0,
  walltime     TIME DEFAULT '00:00:00',
  walltime_sec BIGINT UNSIGNED DEFAULT 0,
  mem_req      TINYTEXT,
  mem_kb       INT UNSIGNED,
  vmem_req     TINYTEXT,
  vmem_kb      INT UNSIGNED,
  energy       INT UNSIGNED DEFAULT 0,
  software     TINYTEXT,
  hostlist     TEXT,
  exit_status  INT,
  script       MEDIUMTEXT,
  sw_app       TINYTEXT,
  contact      TINYTEXT
);
CREATE INDEX system_jobs ON Jobs (system);
CREATE INDEX user_jobs ON Jobs (username);
CREATE INDEX group_jobs ON Jobs (groupname);
CREATE INDEX account_jobs ON Jobs (account);
CREATE INDEX queue_jobs ON Jobs (queue(16));
CREATE INDEX submit_jobs ON Jobs (submit_date);
CREATE INDEX start_jobs ON Jobs (start_date);
CREATE INDEX end_jobs ON Jobs (end_date);
CREATE INDEX start_end_jobs ON Jobs (start_date,end_date);
CREATE INDEX system_start_jobs ON Jobs (system,start_date);
CREATE INDEX system_end_jobs ON Jobs (system,end_date);
CREATE INDEX system_start_end_jobs ON Jobs (system,start_date,end_date);
CREATE INDEX sw_app_jobs ON Jobs (sw_app(32));
GRANT INSERT,UPDATE,SELECT ON Jobs TO 'pbsacct'@'localhost' IDENTIFIED BY 'pbsRroxor';
GRANT SELECT ON Jobs TO 'webapp'@'localhost';
GRANT SELECT ON Jobs TO 'cmdline'@'localhost';
CREATE TABLE Software (
  package VARCHAR(32) PRIMARY KEY
);
GRANT INSERT,UPDATE,SELECT ON Software TO 'pbsacct'@'localhost' IDENTIFIED BY 'pbsRroxor';
GRANT SELECT ON Software TO 'webapp'@'localhost';
GRANT SELECT ON Software TO 'cmdline'@'localhost';
CREATE TABLE Config (
  row_number   SERIAL PRIMARY KEY,
  system       VARCHAR(8),
  nproc        INT UNSIGNED DEFAULT 0,
  start        DATE DEFAULT NULL,
  end          DATE DEFAULT NULL
);
CREATE INDEX system_config ON Config (system);
GRANT SELECT ON Config TO 'webapp'@'localhost';

